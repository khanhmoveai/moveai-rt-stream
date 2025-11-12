import QtQuick3D
import QtQuick3D.Helpers
import QtQml

Node{
    property int  trackID
    property int  actorModelID
    property real scaleFactor

    scale: Qt.vector3d(50, 50, 50)
// RigMoveAIUrdf {
    //     id: rignode
    // }

    Node {
        eulerRotation:  Qt.vector3d(90, 0, 0)
        RigMoveMoIdentity{
            id: rignode
        }
        // RigMoveMoFBX{
        //     scale: Qt.vector3d(0.001, 0.001, 0.001)
        //     id: rignode
        // }
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

    // ------------------------------
    // Quaternion helpers
    // ------------------------------
    function qmul(a, b) {                // Hamilton product: a * b
        const w = a.scalar*b.scalar - a.x*b.x - a.y*b.y - a.z*b.z
        const x = a.scalar*b.x + a.x*b.scalar + a.y*b.z - a.z*b.y
        const y = a.scalar*b.y - a.x*b.z + a.y*b.scalar + a.z*b.x
        const z = a.scalar*b.z + a.x*b.y - a.y*b.x + a.z*b.scalar
        return Qt.quaternion(w, x, y, z)
    }
    function qnorm(q) {
        const len = Math.sqrt(q.scalar*q.scalar + q.x*q.x + q.y*q.y + q.z*q.z) || 1
        return Qt.quaternion(q.scalar/len, q.x/len, q.y/len, q.z/len)
    }
    // Deep-copy pack/unpack so we never hold live references
    function qpack(q) { return [q.scalar, q.x, q.y, q.z] }
    function qunpack(a) { return Qt.quaternion(a[0], a[1], a[2], a[3]) }

    // Compose with cached bind * delta. Flip order if your source is pre-multiplied.
    function compose(aliasName, deltaQ) {
        const basePacked = cache.rot[aliasName]
        const base = qunpack(basePacked)
        return qnorm(qmul(base, deltaQ))
    }

    // ------------------------------
    // Cache bind/original rotations once
    // ------------------------------
    function cacheBindRotations() {
        // Body
        cache.rot.jRoot              = qpack(rignode.jRoot.rotation)
        cache.rot.jLHip              = qpack(rignode.jLHip.rotation)
        cache.rot.jLKnee             = qpack(rignode.jLKnee.rotation)
        cache.rot.jLAnkle            = qpack(rignode.jLAnkle.rotation)
        cache.rot.jLToe              = qpack(rignode.jLToe.rotation)
        cache.rot.jRHip              = qpack(rignode.jRHip.rotation)
        cache.rot.jRKnee             = qpack(rignode.jRKnee.rotation)
        cache.rot.jRAnkle            = qpack(rignode.jRAnkle.rotation)
        cache.rot.jRToe              = qpack(rignode.jRToe.rotation)
        cache.rot.jSpine0            = qpack(rignode.jSpine0.rotation)
        cache.rot.jSpine1            = qpack(rignode.jSpine1.rotation)
        cache.rot.jLShoulderClavicle = qpack(rignode.jLShoulderClavicle.rotation)
        cache.rot.jLShoulder         = qpack(rignode.jLShoulder.rotation)
        cache.rot.jLElbow            = qpack(rignode.jLElbow.rotation)
        cache.rot.jLWrist            = qpack(rignode.jLWrist.rotation)
        cache.rot.jNeck              = qpack(rignode.jNeck.rotation)
        cache.rot.jRShoulderClavicle = qpack(rignode.jRShoulderClavicle.rotation)
        cache.rot.jRShoulder         = qpack(rignode.jRShoulder.rotation)
        cache.rot.jRElbow            = qpack(rignode.jRElbow.rotation)
        cache.rot.jRWrist            = qpack(rignode.jRWrist.rotation)

        // Left hand
        cache.rot.jLHandBase   = qpack(rignode.jLHandBase.rotation)
        cache.rot.jLHandThumb1 = qpack(rignode.jLHandThumb1.rotation)
        cache.rot.jLHandThumb2 = qpack(rignode.jLHandThumb2.rotation)
        cache.rot.jLHandThumb3 = qpack(rignode.jLHandThumb3.rotation)
        cache.rot.jLHandIndex1 = qpack(rignode.jLHandIndex1.rotation)
        cache.rot.jLHandIndex2 = qpack(rignode.jLHandIndex2.rotation)
        cache.rot.jLHandIndex3 = qpack(rignode.jLHandIndex3.rotation)
        cache.rot.jLHandMiddle1= qpack(rignode.jLHandMiddle1.rotation)
        cache.rot.jLHandMiddle2= qpack(rignode.jLHandMiddle2.rotation)
        cache.rot.jLHandMiddle3= qpack(rignode.jLHandMiddle3.rotation)
        cache.rot.jLHandRing1  = qpack(rignode.jLHandRing1.rotation)
        cache.rot.jLHandRing2  = qpack(rignode.jLHandRing2.rotation)
        cache.rot.jLHandRing3  = qpack(rignode.jLHandRing3.rotation)
        cache.rot.jLHandPinky1 = qpack(rignode.jLHandPinky1.rotation)
        cache.rot.jLHandPinky2 = qpack(rignode.jLHandPinky2.rotation)
        cache.rot.jLHandPinky3 = qpack(rignode.jLHandPinky3.rotation)

        // Right hand
        cache.rot.jRHandBase   = qpack(rignode.jRHandBase.rotation)
        cache.rot.jRHandThumb1 = qpack(rignode.jRHandThumb1.rotation)
        cache.rot.jRHandThumb2 = qpack(rignode.jRHandThumb2.rotation)
        cache.rot.jRHandThumb3 = qpack(rignode.jRHandThumb3.rotation)
        cache.rot.jRHandIndex1 = qpack(rignode.jRHandIndex1.rotation)
        cache.rot.jRHandIndex2 = qpack(rignode.jRHandIndex2.rotation)
        cache.rot.jRHandIndex3 = qpack(rignode.jRHandIndex3.rotation)
        cache.rot.jRHandMiddle1= qpack(rignode.jRHandMiddle1.rotation)
        cache.rot.jRHandMiddle2= qpack(rignode.jRHandMiddle2.rotation)
        cache.rot.jRHandMiddle3= qpack(rignode.jRHandMiddle3.rotation)
        cache.rot.jRHandRing1  = qpack(rignode.jRHandRing1.rotation)
        cache.rot.jRHandRing2  = qpack(rignode.jRHandRing2.rotation)
        cache.rot.jRHandRing3  = qpack(rignode.jRHandRing3.rotation)
        cache.rot.jRHandPinky1 = qpack(rignode.jRHandPinky1.rotation)
        cache.rot.jRHandPinky2 = qpack(rignode.jRHandPinky2.rotation)
        cache.rot.jRHandPinky3 = qpack(rignode.jRHandPinky3.rotation)

        // lock it down to avoid accidental writes
        Object.freeze(cache.rot)
        _bindCached = true
    }

    function initialize(jointsIndices){
        initBodyJointMapping(jointsIndices)
        initLeftHandJointMapping(jointsIndices)
        initRightHandJointMapping(jointsIndices)
        cacheBindRotations()
        console.log("RigNode ", actorModelID, " initialized (bind rotations cached)")
    }

    // ------------------------------
    // Per-frame update helpers
    // ------------------------------
    function setIfValid(idx, alias, nodeRef, jointRots){
        if (!_bindCached) return
        if (typeof idx === "number" && idx >= 0) {
            const delta = jointRots[idx]
            nodeRef.rotation = compose(alias, delta)   // final = bind * delta
        }
    }


        function initBodyJointMapping(jointsIndices){
        mapping.rootIdx = jointsIndices["R"]
        mapping.lHipIdx = jointsIndices["L_Hip"]
        mapping.lKneeIdx = jointsIndices["L_Knee"]
        mapping.lAnkleIdx = jointsIndices["L_Ankle"]
        mapping.lToeIdx = jointsIndices["L_Toe"]
        mapping.rHipIdx = jointsIndices["R_Hip"]
        mapping.rKneeIdx = jointsIndices["R_Knee"]
        mapping.rAnkleIdx = jointsIndices["R_Ankle"]
        mapping.rToeIdx = jointsIndices["R_Toe"]
        mapping.spine1Idx = jointsIndices["Spine1"]
        mapping.spine2Idx = jointsIndices["Spine2"]
        mapping.lShoulderClavicleIdx = jointsIndices["L_Clavicle"]
        mapping.lShoulderIdx = jointsIndices["L_Shoulder"]
        mapping.lElbowIdx = jointsIndices["L_Elbow"]
        mapping.lWristIdx = jointsIndices["L_Wrist"]
        mapping.neckIdx = jointsIndices["Neck"]
        mapping.rShoulderClavicleIdx = jointsIndices["R_Clavicle"]
        mapping.rShoulderIdx = jointsIndices["R_Shoulder"]
        mapping.rElbowIdx = jointsIndices["R_Elbow"]
        mapping.rWristIdx = jointsIndices["R_Wrist"]
    }

    function initLeftHandJointMapping(jointsIndices){
        // Left hand joints
        mapping.lHandBaseIdx = jointsIndices["L_Hand_Base"] || -1
        mapping.lHandThumb1Idx = jointsIndices["L_Hand_Thumb1"] || -1
        mapping.lHandThumb2Idx = jointsIndices["L_Hand_Thumb2"] || -1
        mapping.lHandThumb3Idx = jointsIndices["L_Hand_Thumb3"] || -1
        mapping.lHandIndex1Idx = jointsIndices["L_Hand_Index1"] || -1
        mapping.lHandIndex2Idx = jointsIndices["L_Hand_Index2"] || -1
        mapping.lHandIndex3Idx = jointsIndices["L_Hand_Index3"] || -1
        mapping.lHandMiddle1Idx = jointsIndices["L_Hand_Middle1"] || -1
        mapping.lHandMiddle2Idx = jointsIndices["L_Hand_Middle2"] || -1
        mapping.lHandMiddle3Idx = jointsIndices["L_Hand_Middle3"] || -1
        mapping.lHandRing1Idx = jointsIndices["L_Hand_Ring1"] || -1
        mapping.lHandRing2Idx = jointsIndices["L_Hand_Ring2"] || -1
        mapping.lHandRing3Idx = jointsIndices["L_Hand_Ring3"] || -1
        mapping.lHandPinky1Idx = jointsIndices["L_Hand_Pinky1"] || -1
        mapping.lHandPinky2Idx = jointsIndices["L_Hand_Pinky2"] || -1
        mapping.lHandPinky3Idx = jointsIndices["L_Hand_Pinky3"] || -1
    }

    function initRightHandJointMapping(jointsIndices){
        // Right hand joints
        mapping.rHandBaseIdx = jointsIndices["R_Hand_Base"] || -1
        mapping.rHandThumb1Idx = jointsIndices["R_Hand_Thumb1"] || -1
        mapping.rHandThumb2Idx = jointsIndices["R_Hand_Thumb2"] || -1
        mapping.rHandThumb3Idx = jointsIndices["R_Hand_Thumb3"] || -1
        mapping.rHandIndex1Idx = jointsIndices["R_Hand_Index1"] || -1
        mapping.rHandIndex2Idx = jointsIndices["R_Hand_Index2"] || -1
        mapping.rHandIndex3Idx = jointsIndices["R_Hand_Index3"] || -1
        mapping.rHandMiddle1Idx = jointsIndices["R_Hand_Middle1"] || -1
        mapping.rHandMiddle2Idx = jointsIndices["R_Hand_Middle2"] || -1
        mapping.rHandMiddle3Idx = jointsIndices["R_Hand_Middle3"] || -1
        mapping.rHandRing1Idx = jointsIndices["R_Hand_Ring1"] || -1
        mapping.rHandRing2Idx = jointsIndices["R_Hand_Ring2"] || -1
        mapping.rHandRing3Idx = jointsIndices["R_Hand_Ring3"] || -1
        mapping.rHandPinky1Idx = jointsIndices["R_Hand_Pinky1"] || -1
        mapping.rHandPinky2Idx = jointsIndices["R_Hand_Pinky2"] || -1
        mapping.rHandPinky3Idx = jointsIndices["R_Hand_Pinky3"] || -1
    }

    QtObject { id: cache; property var rot: ({}) }
    property bool _bindCached: false

        function updateLeftHandJoints(jointTrans, jointRots){
        if(mapping.lHandThumb1Idx < 0) return;

        setIfValid(mapping.lHandBaseIdx,   "jLHandBase",   rignode.jLHandBase,   jointRots)
        setIfValid(mapping.lHandThumb1Idx, "jLHandThumb1", rignode.jLHandThumb1, jointRots)
        setIfValid(mapping.lHandThumb2Idx, "jLHandThumb2", rignode.jLHandThumb2, jointRots)
        setIfValid(mapping.lHandThumb3Idx, "jLHandThumb3", rignode.jLHandThumb3, jointRots)

        setIfValid(mapping.lHandIndex1Idx, "jLHandIndex1", rignode.jLHandIndex1, jointRots)
        setIfValid(mapping.lHandIndex2Idx, "jLHandIndex2", rignode.jLHandIndex2, jointRots)
        setIfValid(mapping.lHandIndex3Idx, "jLHandIndex3", rignode.jLHandIndex3, jointRots)

        setIfValid(mapping.lHandMiddle1Idx,"jLHandMiddle1",rignode.jLHandMiddle1,jointRots)
        setIfValid(mapping.lHandMiddle2Idx,"jLHandMiddle2",rignode.jLHandMiddle2,jointRots)
        setIfValid(mapping.lHandMiddle3Idx,"jLHandMiddle3",rignode.jLHandMiddle3,jointRots)

        setIfValid(mapping.lHandRing1Idx,  "jLHandRing1",  rignode.jLHandRing1,  jointRots)
        setIfValid(mapping.lHandRing2Idx,  "jLHandRing2",  rignode.jLHandRing2,  jointRots)
        setIfValid(mapping.lHandRing3Idx,  "jLHandRing3",  rignode.jLHandRing3,  jointRots)

        setIfValid(mapping.lHandPinky1Idx, "jLHandPinky1", rignode.jLHandPinky1, jointRots)
        setIfValid(mapping.lHandPinky2Idx, "jLHandPinky2", rignode.jLHandPinky2, jointRots)
        setIfValid(mapping.lHandPinky3Idx, "jLHandPinky3", rignode.jLHandPinky3, jointRots)
    }

    function updateRightHandJoints(jointTrans, jointRots){
        if(mapping.rHandThumb1Idx < 0) return;

        setIfValid(mapping.rHandBaseIdx,   "jRHandBase",   rignode.jRHandBase,   jointRots)
        setIfValid(mapping.rHandThumb1Idx, "jRHandThumb1", rignode.jRHandThumb1, jointRots)
        setIfValid(mapping.rHandThumb2Idx, "jRHandThumb2", rignode.jRHandThumb2, jointRots)
        setIfValid(mapping.rHandThumb3Idx, "jRHandThumb3", rignode.jRHandThumb3, jointRots)

        setIfValid(mapping.rHandIndex1Idx, "jRHandIndex1", rignode.jRHandIndex1, jointRots)
        setIfValid(mapping.rHandIndex2Idx, "jRHandIndex2", rignode.jRHandIndex2, jointRots)
        setIfValid(mapping.rHandIndex3Idx, "jRHandIndex3", rignode.jRHandIndex3, jointRots)

        setIfValid(mapping.rHandMiddle1Idx,"jRHandMiddle1",rignode.jRHandMiddle1,jointRots)
        setIfValid(mapping.rHandMiddle2Idx,"jRHandMiddle2",rignode.jRHandMiddle2,jointRots)
        setIfValid(mapping.rHandMiddle3Idx,"jRHandMiddle3",rignode.jRHandMiddle3,jointRots)

        setIfValid(mapping.rHandRing1Idx,  "jRHandRing1",  rignode.jRHandRing1,  jointRots)
        setIfValid(mapping.rHandRing2Idx,  "jRHandRing2",  rignode.jRHandRing2,  jointRots)
        setIfValid(mapping.rHandRing3Idx,  "jRHandRing3",  rignode.jRHandRing3,  jointRots)

        setIfValid(mapping.rHandPinky1Idx, "jRHandPinky1", rignode.jRHandPinky1, jointRots)
        setIfValid(mapping.rHandPinky2Idx, "jRHandPinky2", rignode.jRHandPinky2, jointRots)
        setIfValid(mapping.rHandPinky3Idx, "jRHandPinky3", rignode.jRHandPinky3, jointRots)

        // debug example:
        // console.log("R index1 euler: ", rignode.jRHandIndex1.rotation.toEulerAngles())
    }

    function updateBodyJoints(jointTrans, jointRots){
        // Root position stays absolute as before:
        let p = jointTrans[mapping.rootIdx]
        rignode.jRoot.position = Qt.vector3d(p.x, p.y, p.z)

        setIfValid(mapping.rootIdx,               "jRoot",              rignode.jRoot,              jointRots)

        setIfValid(mapping.lHipIdx,               "jLHip",              rignode.jLHip,              jointRots)
        setIfValid(mapping.lKneeIdx,              "jLKnee",             rignode.jLKnee,             jointRots)
        setIfValid(mapping.lAnkleIdx,             "jLAnkle",            rignode.jLAnkle,            jointRots)
        setIfValid(mapping.lToeIdx,               "jLToe",              rignode.jLToe,              jointRots)

        setIfValid(mapping.rHipIdx,               "jRHip",              rignode.jRHip,              jointRots)
        setIfValid(mapping.rKneeIdx,              "jRKnee",             rignode.jRKnee,             jointRots)
        setIfValid(mapping.rAnkleIdx,             "jRAnkle",            rignode.jRAnkle,            jointRots)
        setIfValid(mapping.rToeIdx,               "jRToe",              rignode.jRToe,              jointRots)

        setIfValid(mapping.spine1Idx,             "jSpine0",            rignode.jSpine0,            jointRots)
        setIfValid(mapping.spine2Idx,             "jSpine1",            rignode.jSpine1,            jointRots)

        setIfValid(mapping.lShoulderClavicleIdx,  "jLShoulderClavicle", rignode.jLShoulderClavicle, jointRots)
        setIfValid(mapping.lShoulderIdx,          "jLShoulder",         rignode.jLShoulder,         jointRots)
        setIfValid(mapping.lElbowIdx,             "jLElbow",            rignode.jLElbow,            jointRots)
        setIfValid(mapping.lWristIdx,             "jLWrist",            rignode.jLWrist,            jointRots)

        setIfValid(mapping.neckIdx,               "jNeck",              rignode.jNeck,              jointRots)

        setIfValid(mapping.rShoulderClavicleIdx,  "jRShoulderClavicle", rignode.jRShoulderClavicle, jointRots)
        setIfValid(mapping.rShoulderIdx,          "jRShoulder",         rignode.jRShoulder,         jointRots)
        setIfValid(mapping.rElbowIdx,             "jRElbow",            rignode.jRElbow,            jointRots)
        setIfValid(mapping.rWristIdx,             "jRWrist",            rignode.jRWrist,            jointRots)
    }

    function update(jointTrans, jointRots, puller){
        updateBodyJoints(jointTrans, jointRots)
        updateLeftHandJoints(jointTrans, jointRots)
        updateRightHandJoints(jointTrans, jointRots)
    }

    QtObject{
        id: mapping
        property int rootIdx: -1
        property int lHipIdx: -1
        property int lKneeIdx: -1
        property int lAnkleIdx: -1
        property int lToeIdx: -1
        property int rHipIdx: -1
        property int rKneeIdx: -1
        property int rAnkleIdx: -1
        property int rToeIdx: -1
        property int spine1Idx: -1
        property int spine2Idx: -1
        property int lShoulderClavicleIdx: -1
        property int lShoulderIdx: -1
        property int lElbowIdx: -1
        property int lWristIdx: -1
        property int neckIdx: -1
        property int rShoulderClavicleIdx: -1
        property int rShoulderIdx: -1
        property int rElbowIdx: -1
        property int rWristIdx: -1

        // Left hand joints
        property int lHandBaseIdx: -1
        property int lHandThumb1Idx: -1
        property int lHandThumb2Idx: -1
        property int lHandThumb3Idx: -1
        property int lHandIndex1Idx: -1
        property int lHandIndex2Idx: -1
        property int lHandIndex3Idx: -1
        property int lHandMiddle1Idx: -1
        property int lHandMiddle2Idx: -1
        property int lHandMiddle3Idx: -1
        property int lHandRing1Idx: -1
        property int lHandRing2Idx: -1
        property int lHandRing3Idx: -1
        property int lHandPinky1Idx: -1
        property int lHandPinky2Idx: -1
        property int lHandPinky3Idx: -1

        // Right hand joints
        property int rHandBaseIdx: -1
        property int rHandThumb1Idx: -1
        property int rHandThumb2Idx: -1
        property int rHandThumb3Idx: -1
        property int rHandIndex1Idx: -1
        property int rHandIndex2Idx: -1
        property int rHandIndex3Idx: -1
        property int rHandMiddle1Idx: -1
        property int rHandMiddle2Idx: -1
        property int rHandMiddle3Idx: -1
        property int rHandRing1Idx: -1
        property int rHandRing2Idx: -1
        property int rHandRing3Idx: -1
        property int rHandPinky1Idx: -1
        property int rHandPinky2Idx: -1
        property int rHandPinky3Idx: -1
    }
}