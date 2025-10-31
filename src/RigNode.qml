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

    function initialize(jointsIndices){
        initBodyJointMapping(jointsIndices)
        initLeftHandJointMapping(jointsIndices)
        initRightHandJointMapping(jointsIndices)
        console.log("RigNode ", actorModelID, " initialized: ", mapping)
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


    function updateLeftHandJoints(jointTrans, jointRots){
        // Early exit if left hand joints are not available
        if(mapping.lHandThumb1Idx < 0){
            return;
        }

        // if(mapping.lHandBaseIdx >= 0){
        //    let r = jointRots[mapping.lHandBaseIdx]
        //    rignode.jLWrist.rotation = r
        // }

        //Left hand - only update if indices are valid
        if(mapping.lHandThumb1Idx >= 0){
            let r = jointRots[mapping.lHandThumb1Idx]
            rignode.jLHandThumb1.rotation = r
            console.log("l thumnb ", r)
        }

        if(mapping.lHandThumb2Idx >= 0){
            let r = jointRots[mapping.lHandThumb2Idx]
            rignode.jLHandThumb2.rotation = r
        }
        if(mapping.lHandThumb3Idx >= 0){
            let r = jointRots[mapping.lHandThumb3Idx]
            rignode.jLHandThumb3.rotation = r
        }

        if(mapping.lHandIndex1Idx >= 0){
            let r = jointRots[mapping.lHandIndex1Idx]
            rignode.jLHandIndex1.rotation = r
        }
        if(mapping.lHandIndex2Idx >= 0){
            let r = jointRots[mapping.lHandIndex2Idx]
            rignode.jLHandIndex2.rotation = r
        }
        if(mapping.lHandIndex3Idx >= 0){
            let r = jointRots[mapping.lHandIndex3Idx]
            rignode.jLHandIndex3.rotation = r
        }
        if(mapping.lHandMiddle1Idx >= 0){
            let r = jointRots[mapping.lHandMiddle1Idx]
            rignode.jLHandMiddle1.rotation = r
        }
        if(mapping.lHandMiddle2Idx >= 0){
            let r = jointRots[mapping.lHandMiddle2Idx]
            rignode.jLHandMiddle2.rotation = r
        }
        if(mapping.lHandMiddle3Idx >= 0){
            let r = jointRots[mapping.lHandMiddle3Idx]
            rignode.jLHandMiddle3.rotation = r
        }
        if(mapping.lHandRing1Idx >= 0){
            let r = jointRots[mapping.lHandRing1Idx]
            rignode.jLHandRing1.rotation = r
        }
        if(mapping.lHandRing2Idx >= 0){
            let r = jointRots[mapping.lHandRing2Idx]
            rignode.jLHandRing2.rotation = r
        }
        if(mapping.lHandRing3Idx >= 0){
            let r = jointRots[mapping.lHandRing3Idx]
            rignode.jLHandRing3.rotation = r
        }
        if(mapping.lHandPinky1Idx >= 0){
            let r = jointRots[mapping.lHandPinky1Idx]
            rignode.jLHandPinky1.rotation = r
        }
        if(mapping.lHandPinky2Idx >= 0){
            let r = jointRots[mapping.lHandPinky2Idx]
            rignode.jLHandPinky2.rotation = r
        }
        if(mapping.lHandPinky3Idx >= 0){
            let r = jointRots[mapping.lHandPinky3Idx]
            rignode.jLHandPinky3.rotation = r
        }
    }

    function updateRightHandJoints(jointTrans, jointRots){
        // Early exit if right hand joints are not available
        if(mapping.rHandThumb1Idx < 0){
            return;
        }

        //if(mapping.rHandBaseIdx >= 0){
        //    let r = jointRots[mapping.rHandBaseIdx]
        //    rignode.jRWrist.rotation = r
        //}

        // Right hand - only update if indices are valid
        if(mapping.rHandThumb1Idx >= 0){
            let r = jointRots[mapping.rHandThumb1Idx]
            rignode.jRHandThumb1.rotation = r
        }
        if(mapping.rHandThumb2Idx >= 0){
            let r = jointRots[mapping.rHandThumb2Idx]
            rignode.jRHandThumb2.rotation = r
        }
        if(mapping.rHandThumb3Idx >= 0){
            let r = jointRots[mapping.rHandThumb3Idx]
            rignode.jRHandThumb3.rotation = r
        }
        // if(mapping.rHandIndex1Idx >= 0){
        //     let r = jointRots[mapping.rHandIndex1Idx]
        //     rignode.jRHandIndex1.rotation = r
        //
        // }
        // if(mapping.rHandIndex2Idx >= 0){
        //     let r = jointRots[mapping.rHandIndex2Idx]
        //     rignode.jRHandIndex2.rotation = r
        // }
        // if(mapping.rHandIndex3Idx >= 0){
        //     let r = jointRots[mapping.rHandIndex3Idx]
        //     rignode.jRHandIndex3.rotation = r
        // }
        // if(mapping.rHandMiddle1Idx >= 0){
        //     let r = jointRots[mapping.rHandMiddle1Idx]
        //     rignode.jRHandMiddle1.rotation = r
        // }
        // if(mapping.rHandMiddle2Idx >= 0){
        //     let r = jointRots[mapping.rHandMiddle2Idx]
        //     rignode.jRHandMiddle2.rotation = r
        // }
        // if(mapping.rHandMiddle3Idx >= 0){
        //     let r = jointRots[mapping.rHandMiddle3Idx]
        //     rignode.jRHandMiddle3.rotation = r
        // }
        // if(mapping.rHandRing1Idx >= 0){
        //     let r = jointRots[mapping.rHandRing1Idx]
        //     rignode.jRHandRing1.rotation = r
        // }
        // if(mapping.rHandRing2Idx >= 0){
        //     let r = jointRots[mapping.rHandRing2Idx]
        //     rignode.jRHandRing2.rotation = r
        // }
        // if(mapping.rHandRing3Idx >= 0){
        //     let r = jointRots[mapping.rHandRing3Idx]
        //     rignode.jRHandRing3.rotation = r
        // }
        // if(mapping.rHandPinky1Idx >= 0){
        //     let r = jointRots[mapping.rHandPinky1Idx]
        //     rignode.jRHandPinky1.rotation = r
        // }
        // if(mapping.rHandPinky2Idx >= 0){
        //     let r = jointRots[mapping.rHandPinky2Idx]
        //     rignode.jRHandPinky2.rotation = r
        // }
        // if(mapping.rHandPinky3Idx >= 0){
        //     let r = jointRots[mapping.rHandPinky3Idx]
        //     rignode.jRHandPinky3.rotation = r
        // }

        console.log("rignode.jRHandIndex1.rotation: ", rignode.jRHandIndex1.rotation, rignode.jRHandIndex1.rotation.toEulerAngles())

    }

    function updateBodyJoints(jointTrans, jointRots){
        // Root (hips)
        let p = jointTrans[mapping.rootIdx]
        // Swizzle translation: (x, y, z) -> (x, z, -y)
        rignode.jRoot.position = Qt.vector3d(p.x, p.y, p.z)
        let r = jointRots[mapping.rootIdx]
        rignode.jRoot.rotation = r

        // Left leg
        r = jointRots[mapping.lHipIdx]
        rignode.jLHip.rotation = r
        r = jointRots[mapping.lKneeIdx]
        rignode.jLKnee.rotation = r
        r = jointRots[mapping.lAnkleIdx]
        rignode.jLAnkle.rotation = r
        // No jLToe alias in RigMoveMoIdentity

        // Right leg
        r = jointRots[mapping.rHipIdx]
        rignode.jRHip.rotation = r
        r = jointRots[mapping.rKneeIdx]
        rignode.jRKnee.rotation = r
        r = jointRots[mapping.rAnkleIdx]
        rignode.jRAnkle.rotation = r
        // No jRToe alias in RigMoveMoIdentity

        // Spine
        // No jSpine1 alias, only jSpine0 and jSpine1
        r = jointRots[mapping.spine1Idx]
        rignode.jSpine0.rotation = r
        r = jointRots[mapping.spine2Idx]
        rignode.jSpine1.rotation = r

        // Left arm
        // No jLClavicle alias in RigMoveMoIdentity
        r =  jointRots[mapping.lShoulderClavicleIdx]
        rignode.jLShoulderClavicle.rotation = r

        r = jointRots[mapping.lShoulderIdx]
        rignode.jLShoulder.rotation = r

        r = jointRots[mapping.lElbowIdx]
        rignode.jLElbow.rotation = r
        r = jointRots[mapping.lWristIdx]
        rignode.jLWrist.rotation = r

        // No jNeck alias in RigMoveMoIdentity

        // Right arm
        // No jRClavicle alias in RigMoveMoIdentity
        r =  jointRots[mapping.rShoulderClavicleIdx]
        rignode.jRShoulderClavicle.rotation = r

        r = jointRots[mapping.rShoulderIdx]
        rignode.jRShoulder.rotation = r

        r = jointRots[mapping.rElbowIdx]
        rignode.jRElbow.rotation = r
        r = jointRots[mapping.rWristIdx]
        rignode.jRWrist.rotation = r
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