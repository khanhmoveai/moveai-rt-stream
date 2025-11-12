#!/usr/bin/env python3
"""
Synthetic replay server for MoveAI RT stream.

Streams poses where exactly one joint at a time rotates about a chosen axis,
using quaternions so existing clients render correctly.
Keeps using the input .pkl only for skeleton/structures.

Usage examples:
  uv run python ./server_replay_synthetic.py -i ../data/new_klm_take_0.pkl \
    --axis z --amplitude 30 --seconds-per-joint 1.25 --fps 60

  # Only selected joints by IDs and ranges:
  uv run python ./server_replay_synthetic.py -i ../data/new_klm_take_0.pkl \
    --joints 0,3,7,10-12 --axis y --amplitude 30

  # Unidirectional negative axis (ramp 0 -> -25°):
  uv run python ./server_replay_synthetic.py -i ../data/new_klm_take_0.pkl \
    --axis -y --one-direction --amplitude 25
"""

from concurrent import futures
from pathlib import Path
from typing import Set
import argparse
import logging
import math
import time
import grpc

# Reuse proto + resources from the repo
import MocapExchange_pb2
import MocapExchange_pb2_grpc
import MocapExchange_resources

# Import the existing server so we inherit the same gRPC methods/behavior
from server_replay import MocapServerServicer as BaseServicer


def _parse_axis_with_sign(axis: str):
    """
    Returns (base_axis, sign), where base_axis in {'x','y','z'} and sign in {+1,-1}.
    Accepts 'x','y','z','-x','-y','-z'.
    """
    a = (axis or "z").strip().lower()
    sgn = -1 if a.startswith("-") else 1
    base = a.lstrip("-")
    if base not in ("x", "y", "z"):
        base = "z"
    return base, sgn


def _axis_angle_to_quat(axis: str, angle_rad: float):
    """
    Quaternion [x, y, z, w] for a pure axis rotation.
    Honors signed axes: '-x','-y','-z' flip the rotation direction (right-hand rule).
    """
    base, sign = _parse_axis_with_sign(axis)
    ang = angle_rad * sign
    s = math.sin(ang * 0.5)
    c = math.cos(ang * 0.5)
    if base == "x":
        print(f"rv: {[s, 0.0, 0.0, c]}")
        return [s, 0.0, 0.0, c]
    if base == "y":
        print(f"rv: {[0.0, s, 0.0, c]}")
        return [0.0, s, 0.0, c]
    print(f"rv: {[0.0, 0.0, s, c]}")
    return [0.0, 0.0, s, c]  # 'z'


def _token_to_ids(tok: str):
    """Return a list of linkIds parsed from a token that may be a single int or an int range."""
    tok = tok.strip()
    if "-" in tok:
        a, b = tok.split("-", 1)
        try:
            a_i, b_i = int(a), int(b)
            if a_i <= b_i:
                return list(range(a_i, b_i + 1))
            return list(range(b_i, a_i + 1))
        except ValueError:
            return []
    try:
        return [int(tok)]
    except ValueError:
        return []


def _resolve_selected_link_ids(
    structure: MocapExchange_pb2.Structure, joints_arg: str
) -> Set[int]:
    """
    Build a set of linkIds from a comma-separated string containing:
      - integers or integer ranges (e.g. 0,3,7,10-12)
      - names (best-effort; if name fields exist in the proto)
    """
    if not joints_arg:
        return set()

    # Collect name fields if they exist in your proto (robust to unknown fields)
    name_fields = ["name", "linkName", "jointName"]
    linkid_by_name = {}
    for j in structure.joints:
        for f in name_fields:
            if hasattr(j, f):
                val = getattr(j, f)
                if isinstance(val, str) and val:
                    linkid_by_name[val.lower()] = j.linkId

    selected: Set[int] = set()
    for raw_tok in joints_arg.split(","):
        tok = raw_tok.strip()
        if not tok:
            continue
        # 1) try numeric(s)
        ids = _token_to_ids(tok)
        if ids:
            selected.update(ids)
            continue
        # 2) try by name
        lk = linkid_by_name.get(tok.lower())
        if lk is not None:
            selected.add(lk)

    return selected


class MocapServerServicer(BaseServicer):
    """
    Drop-in replacement that keeps the same RPC methods as server_replay.MocapServerServicer,
    but replaces self.mocap_stream with a synthetic sweep.
    """

    def __init__(
        self,
        data_path: Path,
        fps: int = 60,
        axis: str = "z",
        amplitude_deg: float = 45.0,
        seconds_per_joint: float = 1.0,
        one_direction: bool = False,
        joints: str = "",
    ):
        # Let the base class load structures & defaults (incl. repeat_count, etc.)
        super().__init__(data_path, fps=fps)

        # Build synthetic frames using the loaded skeleton
        if not getattr(self, "id_2_structures", None):
            raise RuntimeError("Failed to load structures from input .pkl")

        subject_id, structure = next(iter(self.id_2_structures.items()))

        # Resolve selection (optional)
        selected = _resolve_selected_link_ids(structure, joints)
        self._selected_links = selected  # keep for debugging/logging

        if selected:
            logging.info(
                "Synthetic sweep limited to joints (linkIds): %s", sorted(selected)
            )
        else:
            logging.info(
                "Synthetic sweep over ALL joints in the structure (no --joints filter)."
            )

        self.mocap_stream = self._build_one_axis_sweep(
            subject_id=subject_id,
            structure=structure,
            axis=axis,
            amplitude_deg=amplitude_deg,
            seconds_per_joint=seconds_per_joint,
            one_direction=one_direction,
            selected_links=selected,
        )

    def _build_one_axis_sweep(
        self,
        subject_id: int,
        structure: MocapExchange_pb2.Structure,
        axis: str,
        amplitude_deg: float,
        seconds_per_joint: float,
        one_direction: bool,
        selected_links: Set[int],
    ):
        """Return a list of MocapStreamResponse frames composing the sweep."""
        frames = []
        fps = max(1, int(self.fps))
        frames_per_joint = max(1, int(seconds_per_joint * fps))
        amp_rad = math.radians(amplitude_deg)

        link_ids = [j.linkId for j in structure.joints]
        if not link_ids:
            return frames
        joint_count = max(link_ids) + 1

        # Iterate only selected links if provided; else all joints in structure
        for jmeta in structure.joints:
            active_link = jmeta.linkId
            if selected_links and active_link not in selected_links:
                continue

            for f in range(frames_per_joint):
                # progress 0..1 across this joint's window
                t = f / (frames_per_joint - 1) if frames_per_joint > 1 else 1.0

                if one_direction:
                    # Unidirectional: ramp 0 -> amplitude (no sign change here).
                    angle = amp_rad * t
                else:
                    # Bidirectional (legacy): sine swing about 0.
                    angle = amp_rad * math.sin(2.0 * math.pi * (f / frames_per_joint))

                joints = []
                for k in range(joint_count):
                    rv = (
                        _axis_angle_to_quat(axis, angle)
                        if k == active_link
                        else [0.0, 0.0, 0.0, 1.0]
                    )
                    joints.append(
                        MocapExchange_pb2.Joint(
                            jointId=k,
                            transform=MocapExchange_pb2.Transform(
                                translation=MocapExchange_pb2.Translation(
                                    x=0.0, y=0.0, z=0.0
                                ),
                                orientation=MocapExchange_pb2.Orientation(
                                    rotationType=MocapExchange_pb2.Orientation.QUATERNION,
                                    rotationValues=rv,
                                ),
                            ),
                        )
                    )

                now = time.time()
                pose = MocapExchange_pb2.Pose(
                    subjectId=subject_id,
                    timestamp=int(now * 1000),
                    joints=joints,
                )
                frames.append(
                    MocapExchange_pb2.MocapStreamResponse(
                        poses=[pose],
                        serverTime=now,
                        mocapServerTimestamp=int(now * 1000),
                    )
                )
        return frames


def serve(args):
    print("Starting Synthetic gRPC server")
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    MocapExchange_pb2_grpc.add_MocapServerServicer_to_server(
        MocapServerServicer(
            data_path=Path(args.input),
            fps=args.fps,
            axis=args.axis,
            amplitude_deg=args.amplitude,
            seconds_per_joint=args.seconds_per_joint,
            one_direction=args.one_direction,
            joints=args.joints or "",
        ),
        server,
    )
    server.add_insecure_port(f"{args.ip}:54321")
    server.start()
    server.wait_for_termination()


def parse_args():
    p = argparse.ArgumentParser("server_replay_synthetic")
    p.add_argument(
        "-i", "--input", required=True, help="Path to .pkl with actors_structures"
    )
    p.add_argument("--ip", type=str, default="0.0.0.0")
    p.add_argument("--fps", type=int, default=60)
    p.add_argument(
        "--axis",
        choices=["x", "y", "z", "-x", "-y", "-z"],
        default="z",
        help="Axis for the rotation sweep (right-hand rule). Use negative forms (-x,-y,-z) to flip direction.",
    )
    p.add_argument("--amplitude", type=float, default=45.0, help="Degrees")
    p.add_argument("--seconds-per-joint", type=float, default=1.0)
    p.add_argument(
        "--one-direction",
        action="store_true",
        help="Rotate in a single direction (0 -> amplitude ramp) for each active joint.",
    )
    p.add_argument(
        "--joints",
        type=str,
        default="",
        help=(
            "Comma-separated joint selectors. "
            "Accepts linkIds and ranges (e.g. '0,3,7,10-12') and, if available "
            "in your proto, joint names (e.g. 'Head,LeftKnee'). "
            "If omitted, all joints are swept."
        ),
    )
    return p.parse_args()


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    serve(parse_args())
