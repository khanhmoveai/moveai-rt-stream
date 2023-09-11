import QtQuick3D
import QtQuick3D.Helpers
import QtQml

Node{
    property int  trackID
    property int  actorModelID
    property real scaleFactor

    scale: Qt.vector3d(scaleFactor, scaleFactor, scaleFactor)
    RigMoveAIUrdf {
        id: rignode
    }

    Model {
        id: rigMarker
        position: Qt.vector3d(0, 0, 0)
        scale: Qt.vector3d(0.001, 0.001, 0.001)
        source: "#Sphere"
        materials: [ DefaultMaterial {
                diffuseColor: "blue"
            }
        ]
    }

    function initialize(jointsIndices){
        console.log("RigNode ", actorModelID, " initialized: ", jointsIndices["R"])
        mapping.rootIdx = jointsIndices["R"]
        mapping.lHipIdx = jointsIndices["L_Hip"]
        mapping.rHipIdx = jointsIndices["R_Hip"]
        mapping.lKneeIdx = jointsIndices["L_Knee"]
        mapping.rKneeIdx = jointsIndices["R_Knee"]
        mapping.lAnkleIdx = jointsIndices["L_Ankle"]
        mapping.rAnkleIdx = jointsIndices["R_Ankle"]
        mapping.neckBottomIdx = jointsIndices["Chest"]
        mapping.headBottomIdx = jointsIndices["Neck"]
        mapping.midSpineIdx = jointsIndices["Spine"]
        mapping.lShoulderIdx = jointsIndices["L_Shoulder"]
        mapping.rShoulderIdx = jointsIndices["R_Shoulder"]
        mapping.lElbowIdx = jointsIndices["L_Elbow"]
        mapping.rElbowIdx = jointsIndices["R_Elbow"]
    }

    function update(jointTrans, jointRots, puller){
            const p = jointTrans[mapping.rootIdx]
            let r = jointRots[mapping.rootIdx]
            rignode.jRoot.position = Qt.vector3d(p.x, p.y, p.z)
            rignode.jRoot.rotation = Qt.quaternion(-r.scalar, -r.x, -r.y, -r.z)

            r = jointRots[mapping.midSpineIdx]
            rignode.jSpine0.rotation = Qt.quaternion(-r.scalar, -r.x, -r.y, -r.z)

            r = jointRots[mapping.headBottomIdx]
            rignode.jHeadBottom.rotation = Qt.quaternion(r.scalar, r.x, r.y, r.z)

            r = jointRots[mapping.lShoulderIdx]
            rignode.jLShoulder.rotation = Qt.quaternion(-r.scalar, r.z, -r.y, -r.x)

            r = jointRots[mapping.rShoulderIdx]
            rignode.jRShoulder.rotation = Qt.quaternion(r.scalar, r.z, r.y, -r.x)

            r = jointRots[mapping.lElbowIdx]
            rignode.jLElbow.rotation = Qt.quaternion(r.scalar, r.y, r.z, r.x)


            r = jointRots[mapping.rElbowIdx]
            rignode.jRElbow.rotation = Qt.quaternion(-r.scalar, r.y, r.z, r.x)

            r = jointRots[mapping.lHipIdx]
            rignode.jLHip.rotation  = Qt.quaternion(-r.scalar, -r.x, -r.y, -r.z)

            r = jointRots[mapping.rHipIdx]
            rignode.jRHip.rotation = Qt.quaternion(-r.scalar, -r.x, -r.y, -r.z)

            r = jointRots[mapping.lKneeIdx]
            rignode.jLKnee.rotation = Qt.quaternion(r.scalar, r.x, -r.y, r.z)
            r = jointRots[mapping.rKneeIdx]
            rignode.jRKnee.rotation = Qt.quaternion(r.scalar, r.x, -r.y, r.z)

            r = jointRots[mapping.lAnkleIdx]
            rignode.jLAnkle.rotation = Qt.quaternion(-r.scalar, -r.x, r.y, r.z)

            r = jointRots[mapping.rAnkleIdx]
            rignode.jRAnkle.rotation = Qt.quaternion(-r.scalar, -r.z, -r.x, -r.y)
    }

    Component.onCompleted: {
        console.log("New Actor Rig node is created. id = ", actorModelID)
    }

    QtObject{
        id: mapping
        property int rootIdx:0;
        property int lHipIdx:0;
        property int rHipIdx:0;
        property int lKneeIdx:0;
        property int rKneeIdx:0;
        property int lAnkleIdx:0;
        property int rAnkleIdx:0;
        property int midSpineIdx:0;
        property int neckBottomIdx:0
        property int headBottomIdx:0
        property int lShoulderIdx:0;
        property int rShoulderIdx:0;
        property int lElbowIdx:0;
        property int rElbowIdx:0;
    }
}