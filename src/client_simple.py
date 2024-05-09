from __future__ import print_function
import logging
import copy
import grpc
import time
import argparse
from pathlib import Path
import pickle
from collections import defaultdict
import MocapExchange_pb2
import MocapExchange_pb2_grpc

data = {}

# how to generate grpc files
# pip install grpcio grpcio-tools
#  python -m grpc_tools.protoc -I./ --python_out=. --grpc_python_out=. ./MocapExchange.proto


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

    frames = []
    actors_models = {}
    try:
        frm_cnt = 0
        for response in responses:
            # Commented code doesn't work in Windows
            #if response is not None:
                #ts_ms = time.clock_gettime_ns(time.CLOCK_REALTIME) / 1000000
                #dt = ts_ms - response.mocapServerTimestamp
                #print(f'stream latency: {response.mocapServerTimestamp}, {ts_ms}, {dt}')
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


def export_data(actor_models, frames, out_path):
    print(f'exported data to file path: {out_path}')
    with open(out_path, 'wb') as file:
        pickle.dump({"actors_structures": actor_models, "frames_poses": frames}, file)


def run(args):
    out_path = Path(args.out_file)
    print('start trying to connect to ip: ' + args.ip)
    actor_models = None
    actor_frames = None
    while True:
        try:
            print(f'start creating grpc channel')
            with grpc.insecure_channel(f'{args.ip}:54321') as channel:
                print(f'Created data channel')
                stub = MocapExchange_pb2_grpc.MocapServerStub(channel)
                print("-------------- get_mocap_stream --------------")
                actor_models, actor_frames = get_mocap_stream(stub)
                export_data(actor_models, actor_frames, out_path)
                break
        except Exception as exp:
            print(f'failed to connect to IP {args.ip}. exp = {exp}. reconnecting...')
            time.sleep(1)
            continue
        except KeyboardInterrupt:
            # quit
            if out_path:
                print(f'exported streaming data to file {out_path}')
                export_data(actor_models, actor_frames, out_path)
            print('quitting')
            return


def parse_args():
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('--ip', type=str, default='0.0.0.0')
    parser.add_argument('--out_file', type=str, default='', help='record stream data')
    return parser.parse_args()
    
if __name__ == '__main__':
    logging.basicConfig()
    run(parse_args())

