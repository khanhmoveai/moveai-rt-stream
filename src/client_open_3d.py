import open3d as o3d
import numpy as np
from scipy.spatial.transform import Rotation as R

import grpc

import MocapExchange_pb2
import MocapExchange_pb2_grpc

import argparse

def get_structure(stub, actor_id):
    try:
        request = MocapExchange_pb2.StructureRequest(
            structureId=[actor_id]
        )
        response = stub.GetStructure(request)
        if len(response.structures) == 1:
            return response.structures[0]
    except Exception as exp:
        print(f'failed to query strucutre: {exp}')
    return None

def get_mocap_stream(stub):
    request = MocapExchange_pb2.MocapStreamRequest(fps=60)
    responses = stub.GetMocapStream(request)
    # print('responses', responses)
    
    frames = []
    actors_models = {}
    try:
        frm_cnt = 0
        for response in responses:
            print(f"Received frame {frm_cnt}. n_poses = {len(response.poses)}")
            frm_cnt += 1
            for pose in response.poses:
                actor_id = pose.subjectId
                if actor_id not in actors_models:
                    model = get_structure(stub, actor_id)
                    if model is not None:
                        print(f'Queried actor model: {model}')
                        actors_models[actor_id] = model.SerializeToString()
                frames.append(response.SerializeToString())

    except Exception as exp:
        print(f'connection error: {exp}')
    except KeyboardInterrupt:
        pass
    return actors_models, frames

# quat + translation -> 4x4 matrix
def orientation_to_np_scipy(rv):
  if len(rv) == 0:  return np.eye(3)
  # scipy quat is in (x, y, z, w) order
  return R.from_quat((rv[0], rv[1], rv[2], rv[3])).as_matrix()

def translation_to_np_scipy(t):
  return (t.x if t.x else 0, t.y if t.y else 0, t.z if t.z else 0)

def transformation_to_np_scipy(t):
  T = np.eye(4)
  T[:3,:3] = orientation_to_np_scipy(t.orientation.rotationValues)
  T[0:3,3] = translation_to_np_scipy(t.translation)
  return T

def orientation_to_np(rv):
  if len(rv) == 0:  return np.eye(3)
  # open3d quaternion order is w, x, y, z (Eigen)
  # "Warning: Operations interpreting the quaternion as rotation have undefined behavior if the quaternion is not normalized."
  return o3d.geometry.get_rotation_matrix_from_quaternion((rv[3], rv[0], rv[1], rv[2]))

def translation_to_np(t):
  return (t.x if t.x else 0, t.y if t.y else 0, t.z if t.z else 0)
  
def transformation_to_np(t, apply_orientation=True, apply_translation=True):
  T = np.eye(4)
  if apply_orientation: T[:3,:3] = orientation_to_np(t.orientation.rotationValues)
  if apply_translation: T[0:3,3] = translation_to_np(t.translation)
  return T

class GRPCProcessor:

    def __init__(self, ip="127.0.0.1"):
        # GRPC connection
        self.ip = ip
        self.port = 54321
        self.channel = grpc.insecure_channel(f'{self.ip}:{self.port}')
        self.stub = MocapExchange_pb2_grpc.MocapServerStub(self.channel)
        request = MocapExchange_pb2.MocapStreamRequest(fps=60)
        self.responses = self.stub.GetMocapStream(request)
        # mocap data
        self.processed_actor_model = None
        self.joint_id_by_name = None
        self.actor_frame = None
        
        chain_N  = ["R", "Spine", "Chest","Neck"]
        chain_LH = ["R", "Spine", "Chest", "L_Shoulder_prism", "L_Shoulder", "L_Elbow", "L_Wrist", "L_hand1"]
        chain_RH = ["R", "Spine", "Chest", "R_Shoulder_prism", "R_Shoulder", "R_Elbow", "R_Wrist", "R_hand1"]
        chain_LF = ["R", "L_Hip", "L_Knee", "L_Ankle", "L_Foot_Pinky"]
        chain_RF = ["R", "R_Hip", "R_Knee", "R_Ankle", "R_Foot_Pinky"]
        self.chains = [chain_LH, chain_RH, chain_LF, chain_RF, chain_N]
        
        # global joint positions
        self.global_joint_chains = []
        self.scale = 1

        
    def process_grpc(self, response):
        if not self.processed_actor_model:
            self.actor_model = None

            for pose in response.poses:
                actor_id = pose.subjectId
                model = get_structure(self.stub, actor_id)
                if model is not None:
                    self.actor_model = model
                    self.joint_id_by_name = {joint.name : joint.linkId for joint in self.actor_model.joints}
                    
            print('processed actor model')

            self.processed_actor_model = True
        
        self.actor_frame = response

    def get_chain_positions(self, chain, pose):
        # global chain transformation (gets updated per joint)
        chain_global_matrix = np.eye(4)
        global_joint_positions = np.zeros((len(chain), 3))
        
        for i, joint_name in enumerate(chain):
            joint_id = self.joint_id_by_name[joint_name]
            # get current joint offsets (and initial pose) from structures
            offset = self.actor_model.links[joint_id].offset
            # convert it to 4x4 mat
            # TODO: check order of quaternion components
            joint_offset_matrix = transformation_to_np(offset)
            # get the current mocap stream joint data and convert it to 4x4 mat 
            joint_pose_matrix = transformation_to_np(pose.joints[joint_id].transform)
            # accumulate transformations along the kinematic chain (local to global)
            # R remove orientation
            # if i == 0:    per_frame_T[:3, :3] = local_T[:3, :3] = np.eye(3)
            # prepend pose 
            chain_global_matrix = chain_global_matrix @ joint_offset_matrix @ joint_pose_matrix
            # extract global position
            global_joint_positions[i] = chain_global_matrix[0:3, 3]

        return global_joint_positions
        
    def update_forward_kinematics(self):
        pose = self.actor_frame.poses[0]
        # TODO: make this np
        self.global_joint_chains = [self.get_chain_positions(chain, pose) for chain in self.chains]

    def update(self):
        response = self.responses.next()
        if response is not None:
            self.process_grpc(response)
            self.update_forward_kinematics()
        
        

class GRPCMocapVis:

    def __init__(self, window_title="move.ai mocap vis", width=1280, height=720, ip="127.0.0.1"):
        self.width  = width
        self.height = height
        self.vis = o3d.visualization.VisualizerWithKeyCallback()
        self.vis.create_window(window_title, self.width, self.height)
        # ESC to exit
        self.vis.register_key_callback(256, self.on_escape)
        self.is_running = True
        self.frame_count = 0
        self.grpc = GRPCProcessor(ip)
        self.line_sets = []

    def on_escape(self, vis):
        self.is_running = False
    
    def get_line_set(self, points, lines):
        return o3d.geometry.LineSet(
                    points=o3d.utility.Vector3dVector(points),
                    lines=o3d.utility.Vector2iVector(lines),
                )

    def create_square_grid(self, size = 9, subdivions = 9):
        half_size = size * 0.5
        d = np.linspace(-half_size, half_size, subdivions)
        z = np.zeros(subdivions)
        H = np.ones(subdivions) * half_size
        x = np.dstack((-H, d, z, H, d, z)).reshape(subdivions * 2, 3)
        y = np.dstack(( d,-H, z, d, H, z)).reshape(subdivions * 2, 3)
        points = np.vstack((x, y))
        lines  = np.arange(0, subdivions * 4, 1).reshape(subdivions * 2, 2)
        return o3d.geometry.LineSet(
                    points=o3d.utility.Vector3dVector(points),
                    lines=o3d.utility.Vector2iVector(lines),
                )
    
    def update_geometries(self):
        self.grpc.update()

        if self.frame_count == 0:
            for i in range(len(self.grpc.chains)):
                line_set = o3d.geometry.LineSet()
                self.vis.add_geometry(line_set)  
                self.line_sets.append(line_set)
            self.vis.add_geometry(o3d.geometry.TriangleMesh.create_coordinate_frame(0.3), reset_bounding_box=False)
            self.vis.add_geometry(self.create_square_grid(6, 12))
        else:
            for index, chain_pos in enumerate(self.grpc.global_joint_chains):
                num_joints = len(chain_pos) 
                
                line_set = self.line_sets[index]
                line_set.points = o3d.utility.Vector3dVector(chain_pos)
                line_set.lines  = o3d.utility.Vector2iVector(np.column_stack((np.arange(0, num_joints-1, 1),np.arange(1, num_joints, 1))))
                self.vis.update_geometry(line_set)

            
    def update(self):
        self.update_geometries()

        self.vis.poll_events()
        self.vis.update_renderer()

        self.frame_count += 1

    def start_update_loop(self):
        while self.is_running:
            self.update()

def parse_args():
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('--ip', type=str, default='192.168.0.153')
    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()

    vis = GRPCMocapVis(ip=args.ip)
    vis.start_update_loop()
