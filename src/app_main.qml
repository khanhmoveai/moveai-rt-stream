import QtQuick 2.15
import QtQuick.Window 2.14
import QtQuick3D
import QtQuick3D.Helpers
import com.mocap

Window {
    id: window
    width: 1280
    height: 720
    visible: true

    property Component rigComponent

    View3D {
        id: view
        anchors.fill: parent

        environment: SceneEnvironment {
            clearColor: "skyblue"
            antialiasingMode: SceneEnvironment.MSAA
            antialiasingQuality: SceneEnvironment.VeryHigh
            lightProbe: Texture {source: "OpenfootageNET_garage-1024.hdr"}
            backgroundMode: SceneEnvironment.SkyBox
        }

        //visual actors
        Node {
            id: mocapNodes
            eulerRotation:  Qt.vector3d(-90, 0, 0)
            Node {
                id: actorsRoot;
            }
        }

        Node {
            id: lightsRoot;
            PointLight {
                x: 10
                y: 10
                z: 10
                ambientColor: "#202020"
                brightness: 1
            }
        }

        DirectionalLight {
            id: light1
            color: Qt.rgba(1.0, 1.0, 1.0, 1.0)
            ambientColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
            position: Qt.vector3d(0, 200, 0)
            rotation: Quaternion.fromEulerAngles(0, 0, 0)
            visible: true
            brightness: 1
       }

       Node {
            id: originNode
            PerspectiveCamera {
                id: cameraNode
                y: 100
                x: 100
                z: 100
            }
        }

        WasdController {
            controlledObject: cameraNode
        }

        Model {
            scale: Qt.vector3d(100, 100, 100)
            eulerRotation:  Qt.vector3d(-90, 0, 0)
            geometry: GridGeometry {
                horizontalLines: 50
                verticalLines: 50
            }
            materials: [ DefaultMaterial {
                lighting: DefaultMaterial.NoLighting
                diffuseColor: '#202634'
            } ]
        }
    }

    ActorsDrawDataPuller{
        id: puller
    }

    Timer{
        id: pullTimer
        interval: 60;
        repeat: true
        onTriggered: {
            const frm = puller.tryPull()
            if (frm === undefined){
                return;
            };
            // console.log("pulled new frame: n_rig_nodes = ", d.rigNodes.length, ", respose = ", frm)
            for(let i=0; i < d.rigNodes.length; i++){
                let node = d.rigNodes[i]
                const subjectId = node.actorModelID.toString()
                const joints_translations = frm[subjectId]["joints_translations"]
                const joints_quaternions = frm[subjectId]["joints_rotations"]
                node.update(joints_translations, joints_quaternions, puller)
            }
        }
    }


    function onNewActorCreated(subjectId) {
        console.log("mew actor created: ", subjectId)
        let com = Qt.createComponent("RigNode.qml");
        if (com.status == Component.Error){
             console.log("Error loading component:", com.errorString());
             return;
        }
        const rignode = com.createObject(actorsRoot, {trackID: -1, actorModelID: subjectId, scaleFactor: 50})
        if(rignode === null){
            console.log("onSkinnableActorTrackCreated: Error: failed to create rig node for track ", subjectId)
        }else{
            console.log("onSkinnableActorTrackCreated: Created a new rig node. ", subjectId)
            const modelJointsIdxs = puller.getModelsJointsIndex(subjectId)
            rignode.initialize(modelJointsIdxs)
            d.rigNodes.push(rignode)
        }
    }

    Component.onCompleted: {
        puller.newActorCreated.connect(onNewActorCreated)
        pullTimer.interval = 1000.0/puller.getPollFps()
        puller.start()
        pullTimer.start()
    }


    QtObject{
        id: d
        property var rigNodes: []
    }
}