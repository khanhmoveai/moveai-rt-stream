import sys
from PySide6.QtGui import QGuiApplication, QVector3D, QQuaternion
from PySide6.QtQml import QQmlApplicationEngine, QmlElement
from PySide6.QtCore import QObject, Slot, Signal
import grpc
import MocapExchange_pb2
import MocapExchange_pb2_grpc
import threading
import queue
from datetime import datetime
import time
import argparse

QML_IMPORT_NAME = "com.mocap"
QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_MINOR_VERSION = 0  # Optional

@QmlElement
class ActorsDrawDataPuller(QObject):
    newActorCreated = Signal(str, arguments=['subjectId'])
    fps = 60

    @Slot()
    def start(self):
        print('start receive thread')
        self._receive_thread = threading.Thread(target=self._receive)
        self._receive_thread.start()
        self._pose_queue = queue.Queue()

    @Slot(result='QVariant')
    def readDebug(self):
        filepath = "./q_order.txt"
        ret = [0,1,2,1,1,1,1]
        with open(filepath, 'rt') as file:
            l = file.readline()
            l = l.strip()
            elms = l.split(',')
            if len(elms) == 7:
                ret = [int(v) for v in elms]
        return ret

    @Slot(str, result='QVariant')
    def getModelsJointsIndex(self, subjectId):
        subjectId = int(subjectId)
        if subjectId not in self._actors_models: return None
        model = self._actors_models[subjectId]
        n = len(model.joints)
        m_joints = {}
        for j_idx in range(n):
            m_joints[model.joints[j_idx].name] = j_idx
        return m_joints

    @Slot(result='QVariant')
    def getPollFps(self):
        return self.fps
    @Slot(result='QVariant')
    def tryPull(self):
        try:
            response_poses = self._pose_queue.get_nowait()
            if response_poses is not None:
                ts_ms = time.clock_gettime_ns(time.CLOCK_REALTIME) / 1000000
                dt = ts_ms - response_poses.mocapServerTimestamp
                print(f'stream latency: {response_poses.mocapServerTimestamp}, {ts_ms}, {dt}')
            data = {}
            for p in response_poses.poses:
                trans = []
                rots = []
                s_id = str(p.subjectId)
                for j in p.joints:
                    j_trans = j.transform
                    t = j_trans.translation
                    t_1 = [t.x if t.x else 0, t.y if t.y else 0, t.z if t.z else 0]
                    r = [v for v in j_trans.orientation.rotationValues]
                    r = [0, 0, 0, 1] if len(r) == 0 else r
                    assert len(r) == 4, f"invalid rotation values len. len = {len(r)}"
                    trans.append(QVector3D(t_1[0], t_1[1], t_1[2]))
                    rots.append(QQuaternion(r[3], r[0], r[1], r[2]))
                data[s_id] = {}
                data[s_id]["joints_translations"] = trans
                data[s_id]["joints_rotations"] = rots
            if len(data) > 0:
                return data
        except Exception as exp:
            pass
        # print(f'return None frame')
        return None

    def _receive(self):
        print(f'start receiving thread')
        while True:
            try:
                with grpc.insecure_channel(f'{args.ip}:54321') as channel:
                    print(f'Created data channel')
                    stub = MocapExchange_pb2_grpc.MocapServerStub(channel)
                    print("-------------- get_mocap_stream --------------")
                    request = MocapExchange_pb2.MocapStreamRequest(fps=60)
                    responses = stub.GetMocapStream(request)
                    frm_cnt = 0
                    self._actors_models = {}
                    for response in responses:
                        # print(f"Received frame {frm_cnt}. n_poses = {len(response.poses)}")
                        frm_cnt += 1
                        for pose in response.poses:
                            subjectId = pose.subjectId
                            if subjectId not in self._actors_models:
                                model = self._get_structure(stub, subjectId)
                                if model is not None:
                                    # print(f'Queried actor model: {model}')
                                    self._actors_models[subjectId] = model
                                    self.newActorCreated.emit(str(subjectId))
                        self._pose_queue.put(response)
            except grpc.FutureTimeoutError:
                print('Failed to connect, retrying...')
                time.sleep(2)
            except Exception as e:
                print(f'Error: {e}, retrying...')
                time.sleep(2)

    def _get_structure(self, stub, actor_id):
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


def parse_args():
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('--ip', type=str, default='0.0.0.0')
    parser.add_argument('--fps', type=int, default=int)
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    ActorsDrawDataPuller.fps = args.fps
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.load('app_main.qml')
    sys.exit(app.exec())
