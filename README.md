# RealTime-MoveAI python client

Welcome to `Real-Time Streaming Protocol of the MoveAI Markerless Motion Capture`!
 
This project aims to demonstrate capabilities of real-time streaming protocol 
provided bythe real-time markerless MoveAI system.


The project consists of two main components.

## Server
A python server that implement the gRPC real-time protocol to replay the motion data recorded from the real real-time system.
Please refer to the specification __service MocapServer__ in the file __MocapExchange.proto__ for more detail information about the
services provided by the server

## Clients
Multiple types of clients that illustrates how to open a gRPC connection to the python or real real-time server to receive
the motion capture data.  The 3rd developers can follow the implementation of these clients to implement their own clients
in Unity, UE or any 3rd applications.


# Getting Started

## Install
```
conda create -n mvai-rt python=3.8
conda activate mvai-rt
pip install PySide6 PySide6-Addons grpcio grpcio-tools pyyaml open3d
```

## Generate proto files
```
cd ./src
python -m grpc_tools.protoc -I./ --python_out=. --pyi_out=. --grpc_python_out=. ./MocapExchange.proto
```

## Run replay mocap server
this is a mock server that is used to re-stream data recorded from the real real-time system
```
python ./server_replay.py -i ../data/grpc_mocap_data_1.pkl
```

## Run clients.
There 3 different types of clients that can be run to illustrate the protocol

### Option 1: simple client
This is the most simple client that just receive and print out the data to the console.
```
python ./client_simple.py
```
### Option 2: qml 3D client
This client extends the simple client to render the motion capture 3D in the MoveAI rig.
```
python ./client_qml_3d.py
```

### Option 3: open3D client
This client extends the simple client to render the motion capture using Open3D. It also shows how to run foward kinemaitics
to achieve 3D global joint transformations from the per-frame local joint transformations.
```
python ./client_open_3d.py
```
