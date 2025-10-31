import QtQuick
import QtQuick3D

Node {
    id: node
    property alias jRoot: hips
    property alias jLHip: leftUpLeg
    property alias jRHip: rightUpLeg
    property alias jLKnee: leftLeg
    property alias jRKnee: rightLeg
    property alias jLAnkle: leftFoot
    property alias jRAnkle: rightFoot
    property alias jSpine0: spine
    property alias jSpine1: spine1

    property alias jNeck: head

    property alias jLShoulderClavicle: leftShoulder
    property alias jLShoulder: leftArm
    property alias jLElbow: leftForeArm
    property alias jLWrist: leftHand

    property alias jRShoulderClavicle: rightShoulder
    property alias jRShoulder: rightArm
    property alias jRElbow: rightForeArm
    property alias jRWrist: rightHand

    // Left hand fingers
    property alias jLHandBase: leftHand
    property alias jLHandThumb1: leftHandThumb1
    property alias jLHandThumb2: leftHandThumb2
    property alias jLHandThumb3: leftHandThumb3
    property alias jLHandIndex1: leftHandIndex1
    property alias jLHandIndex2: leftHandIndex2
    property alias jLHandIndex3: leftHandIndex3
    property alias jLHandMiddle1: leftHandMiddle1
    property alias jLHandMiddle2: leftHandMiddle2
    property alias jLHandMiddle3: leftHandMiddle3
    property alias jLHandRing1: leftHandRing1
    property alias jLHandRing2: leftHandRing2
    property alias jLHandRing3: leftHandRing3
    property alias jLHandPinky1: leftHandPinky1
    property alias jLHandPinky2: leftHandPinky2
    property alias jLHandPinky3: leftHandPinky3

    // Right hand fingers
    property alias jRHandBase: rightHand
    property alias jRHandThumb1: rightHandThumb1
    property alias jRHandThumb2: rightHandThumb2
    property alias jRHandThumb3: rightHandThumb3
    property alias jRHandIndex1: rightHandIndex1
    property alias jRHandIndex2: rightHandIndex2
    property alias jRHandIndex3: rightHandIndex3
    property alias jRHandMiddle1: rightHandMiddle1
    property alias jRHandMiddle2: rightHandMiddle2
    property alias jRHandMiddle3: rightHandMiddle3
    property alias jRHandRing1: rightHandRing1
    property alias jRHandRing2: rightHandRing2
    property alias jRHandRing3: rightHandRing3
    property alias jRHandPinky1: rightHandPinky1
    property alias jRHandPinky2: rightHandPinky2
    property alias jRHandPinky3: rightHandPinky3

    // Resources
    PrincipledMaterial {
        id: material_002_material
        baseColor: "#ff6e6e6e"
        metalness: 0.609929084777832
        roughness: 0.5
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
        transmissionFactor: 0.6312059760093689
        indexOfRefraction: 1.4500000476837158
    }
    Skin {
        id: skin
        joints: [
            root,
            hips,
            rightUpLeg,
            rightLeg,
            calf_twist_R,
            rightFoot,
            rightFoot_scale_horizontal,
            rightFoot_scale_horizontal_dummy,
            rightToeBase,
            thigh_twist_R,
            leftUpLeg,
            leftLeg,
            calf_twist_L,
            leftFoot,
            leftFoot_scale_horizontal,
            leftToeBase,
            leftFoot_scale_horizontal_dummy,
            thigh_twist_L,
            spine,
            spine1,
            leftShoulder,
            leftArm,
            leftForeArm,
            leftHand,
            leftHandThumb1,
            leftHandThumb2,
            leftHandThumb3,
            leftHandIndex,
            leftHandIndex1,
            leftHandIndex2,
            leftHandIndex3,
            leftHandMiddle,
            leftHandMiddle1,
            leftHandMiddle2,
            leftHandMiddle3,
            leftHandRing,
            leftHandRing1,
            leftHandRing2,
            leftHandRing3,
            leftHandPinky,
            leftHandPinky1,
            leftHandPinky2,
            leftHandPinky3,
            lowerarm_twist_L,
            upperarm_twist_L,
            rightShoulder,
            rightArm,
            rightForeArm,
            rightHand,
            rightHandThumb1,
            rightHandThumb2,
            rightHandThumb3,
            rightHandIndex,
            rightHandIndex1,
            rightHandIndex2,
            rightHandIndex3,
            rightHandMiddle,
            rightHandMiddle1,
            rightHandMiddle2,
            rightHandMiddle3,
            rightHandRing,
            rightHandRing1,
            rightHandRing2,
            rightHandRing3,
            rightHandPinky,
            rightHandPinky1,
            rightHandPinky2,
            rightHandPinky3,
            lowerarm_twist_R,
            upperarm_twist_R,
            neck_base,
            head,
            breast_L,
            breast_R
        ]
        inverseBindPoses: [
            Qt.matrix4x4(1, 0, 0, 7.93851e-09, 0, 0, -1, -0.0873992, 0, 1, 0, -0.0544005, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -3.64153e-14, 0, 0, -1, -2.6077e-08, 0, 1, 0, -0.959491, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.112593, 0, 0, -1, -4.09782e-08, 0, 1, 0, -0.959491, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.112593, 0, 0, -1, 7.33882e-07, 0, 1, 0, -0.514262, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.112593, 0, 0, -1, 7.63685e-07, 0, 1, 0, -0.514262, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.112593, 0, 0, -1, 7.63685e-07, 0, 1, 0, -0.0800127, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.112593, 0, 0, -1, -0.000900444, 0, 1, 0, -1.90586e-05, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.112593, 0, 0, -1, -0.000900399, 0, 1, 0, -1.90839e-05, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.112593, 0, 0, -1, 0.122021, 0, 1, 0, 0.00136598, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.112593, 0, 0, -1, 6.74278e-07, 0, 1, 0, -0.959491, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.112593, 0, 0, -1, -4.09782e-08, 0, 1, 0, -0.959491, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.112593, 0, 0, -1, 7.33882e-07, 0, 1, 0, -0.514262, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.112593, 0, 0, -1, 7.63685e-07, 0, 1, 0, -0.514262, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.112593, 0, 0, -1, 7.63685e-07, 0, 1, 0, -0.0800127, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.112593, 0, 0, -1, -0.000900444, 0, 1, 0, -1.90586e-05, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.112593, 0, 0, -1, 0.122021, 0, 1, 0, 0.00136598, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.112593, 0, 0, -1, -0.000900399, 0, 1, 0, -1.90839e-05, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.112593, 0, 0, -1, 6.74278e-07, 0, 1, 0, -0.959491, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 4.75206e-09, 0, 0, -1, -2.6077e-08, 0, 1, 0, -1.16629, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -5.73244e-11, 0, 0, -1, 3.72529e-09, 0, 1, 0, -1.30499, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -3.20747e-09, 0, 0, -1, 2.6077e-08, 0, 1, 0, -1.44369, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.178899, 0, 0, -1, 6.16275e-05, 0, 1, 0, -1.44339, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.434272, 0, 0, -1, 6.16871e-05, 0, 1, 0, -1.44339, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.704115, 0, 0, -1, 6.16871e-05, 0, 1, 0, -1.44339, 0, 0, 0, 1),
            Qt.matrix4x4(0.59155, -0.453447, 0.666674, 0.199443, 0.666674, 0.740119, -0.0881481, -1.53999, -0.453447, 0.496599, 0.740119, -0.398024, 0, 0, 0, 1),
            Qt.matrix4x4(0.591533, -0.453457, 0.666683, 0.169076, 0.666683, 0.740113, -0.0881308, -1.53999, -0.453457, 0.496598, 0.740113, -0.39799, 0, 0, 0, 1),
            Qt.matrix4x4(0.591511, -0.45346, 0.6667, 0.141291, 0.6667, 0.740098, -0.0881288, -1.53999, -0.45346, 0.496618, 0.740098, -0.397991, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.732472, 0, 0, -1, 0.0121743, 0, 1, 0, -1.43225, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.792218, 0, 0, -1, 0.0207466, 0, 1, 0, -1.43819, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.825213, 0, 0, -1, 0.0207466, 0, 1, 0, -1.43819, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.847401, 0, 0, -1, 0.0207466, 0, 1, 0, -1.43819, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.734089, 0, 0, -1, -0.00490545, 0, 1, 0, -1.43718, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.798781, 0, 0, -1, -0.0032969, 0, 1, 0, -1.44192, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.830517, 0, 0, -1, -0.0032969, 0, 1, 0, -1.44192, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.85379, 0, 0, -1, -0.0032969, 0, 1, 0, -1.44192, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.736649, 0, 0, -1, -0.0261305, 0, 1, 0, -1.43928, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.785856, 0, 0, -1, -0.0266125, 0, 1, 0, -1.43944, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.814699, 0, 0, -1, -0.0266126, 0, 1, 0, -1.43944, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.839486, 0, 0, -1, -0.0266126, 0, 1, 0, -1.43944, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.736922, 0, 0, -1, -0.0427995, 0, 1, 0, -1.43759, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.772907, 0, 0, -1, -0.0431487, 0, 1, 0, -1.43345, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.794019, 0, 0, -1, -0.0431487, 0, 1, 0, -1.43345, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.812964, 0, 0, -1, -0.0431487, 0, 1, 0, -1.43345, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.434272, 0, 0, -1, 6.16573e-05, 0, 1, 0, -1.44309, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.178899, 0, 0, -1, 6.16573e-05, 0, 1, 0, -1.44339, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 3.20747e-09, 0, 0, -1, 2.6077e-08, 0, 1, 0, -1.44369, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.178899, 0, 0, -1, 6.16275e-05, 0, 1, 0, -1.44339, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.434272, 0, 0, -1, 6.16871e-05, 0, 1, 0, -1.44339, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.704115, 0, 0, -1, 6.16871e-05, 0, 1, 0, -1.44339, 0, 0, 0, 1),
            Qt.matrix4x4(0.512579, 0.541117, 0.666675, -0.416629, 0.666675, -0.740118, 0.0881481, 1.53999, 0.541116, 0.399273, -0.740118, -0.156914, 0, 0, 0, 1),
            Qt.matrix4x4(0.512577, 0.541109, 0.666682, -0.41343, 0.666683, -0.740113, 0.0881307, 1.53999, 0.541109, 0.399292, -0.740113, -0.126723, 0, 0, 0, 1),
            Qt.matrix4x4(0.512554, 0.54111, 0.6667, -0.410532, 0.666699, -0.740099, 0.0881286, 1.53999, 0.541111, 0.399318, -0.740097, -0.0991056, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.732472, 0, 0, -1, 0.0121743, 0, 1, 0, -1.43225, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.792218, 0, 0, 1, -0.0207466, 0, 1, 0, -1.43819, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.825213, 0, 0, 1, -0.0207466, 0, 1, 0, -1.43819, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.847401, 0, 0, 1, -0.0207466, 0, 1, 0, -1.43819, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.734089, 0, 0, -1, -0.00490545, 0, 1, 0, -1.43718, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.798781, 0, 0, 1, 0.0032969, 0, 1, 0, -1.44192, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.830517, 0, 0, 1, 0.0032969, 0, 1, 0, -1.44192, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.85379, 0, 0, 1, 0.0032969, 0, 1, 0, -1.44192, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.736649, 0, 0, -1, -0.0261305, 0, 1, 0, -1.43928, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.785856, 0, 0, 1, 0.0266125, 0, 1, 0, -1.43944, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.814699, 0, 0, 1, 0.0266126, 0, 1, 0, -1.43944, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.839486, 0, 0, 1, 0.0266126, 0, 1, 0, -1.43944, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.736922, 0, 0, -1, -0.0427995, 0, 1, 0, -1.43759, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.772907, 0, 0, 1, 0.0431487, 0, 1, 0, -1.43345, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.794019, 0, 0, 1, 0.0431487, 0, 1, 0, -1.43345, 0, 0, 0, 1),
            Qt.matrix4x4(-1, 0, 0, -0.812964, 0, 0, 1, 0.0431487, 0, 1, 0, -1.43345, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.434272, 0, 0, -1, 6.16573e-05, 0, 1, 0, -1.44309, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.178899, 0, 0, -1, 6.16573e-05, 0, 1, 0, -1.44339, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -3.20755e-09, 0, 0, -1, 2.6077e-08, 0, 1, 0, -1.44369, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -5.37116e-09, 0, 0, -1, 3.35276e-08, 0, 1, 0, -1.53895, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, -0.0873697, 0, 0, -1, -0.0411352, 0, 1, 0, -1.31654, 0, 0, 0, 1),
            Qt.matrix4x4(1, 0, 0, 0.0873697, 0, 0, -1, -0.0411352, 0, 1, 0, -1.31654, 0, 0, 0, 1)
        ]
    }

    // Nodes:
    Node {
        id: moveai_male
        position: Qt.vector3d(0, 0, 0.03163)
        Model {
            id: m_ca01
            source: "meshes/mblab_human_male_001_mesh.mesh"
            skin: skin
            materials: [
                material_002_material
            ]
        }
        Node {
            id: root
            position: Qt.vector3d(-7.93851e-09, 0.0544005, -0.119029)
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            scale: Qt.vector3d(1, 1, 1)
            Node {
                id: hips
                position: Qt.vector3d(7.93855e-09, -0.0873992, 0.90509)
                Node {
                    id: rightUpLeg
                    position: Qt.vector3d(-0.112593, 1.49012e-08, -2.38419e-07)
                    Node {
                        id: rightLeg
                        position: Qt.vector3d(-2.01166e-07, -7.7486e-07, -0.445229)
                        Node {
                            id: calf_twist_R
                            position: Qt.vector3d(-7.45058e-09, -2.98023e-08, 5.96046e-08)
                        }
                        Node {
                            id: rightFoot
                            position: Qt.vector3d(2.98023e-08, -2.98023e-08, -0.434249)
                            Node {
                                id: rightFoot_scale_horizontal
                                position: Qt.vector3d(0, 0.000901207, -0.0799937)
                                scale: Qt.vector3d(1, 1, 1)
                                Node {
                                    id: rightFoot_scale_horizontal_dummy
                                    position: Qt.vector3d(0, -4.46453e-08, 2.53058e-08)
                                }
                                Node {
                                    id: rightToeBase
                                    position: Qt.vector3d(4.47035e-08, -0.122922, -0.00138504)
                                }
                            }
                        }
                    }
                    Node {
                        id: thigh_twist_R
                        position: Qt.vector3d(-1.93715e-07, -7.15256e-07, 5.96046e-08)
                    }
                }
                Node {
                    id: leftUpLeg
                    position: Qt.vector3d(0.112593, 1.49012e-08, -2.38419e-07)
                    Node {
                        id: leftLeg
                        position: Qt.vector3d(2.01166e-07, -7.7486e-07, -0.445229)
                        Node {
                            id: calf_twist_L
                            position: Qt.vector3d(7.45058e-09, -2.98023e-08, 5.96046e-08)
                        }
                        Node {
                            id: leftFoot
                            position: Qt.vector3d(-2.98023e-08, -2.98023e-08, -0.434249)
                            Node {
                                id: leftFoot_scale_horizontal
                                position: Qt.vector3d(0, 0.000901207, -0.0799937)
                                scale: Qt.vector3d(1, 1, 1)
                                Node {
                                    id: leftToeBase
                                    position: Qt.vector3d(-4.47035e-08, -0.122922, -0.00138504)
                                }
                                Node {
                                    id: leftFoot_scale_horizontal_dummy
                                    position: Qt.vector3d(0, -4.46453e-08, 2.53058e-08)
                                }
                            }
                        }
                    }
                    Node {
                        id: thigh_twist_L
                        position: Qt.vector3d(1.93715e-07, -7.15256e-07, 5.96046e-08)
                    }
                }
                Node {
                    id: spine
                    position: Qt.vector3d(-4.7521e-09, 0, 0.206802)
                    Node {
                        id: spine1
                        position: Qt.vector3d(4.80938e-09, -2.98023e-08, 0.138699)
                        Node {
                            id: leftShoulder
                            position: Qt.vector3d(3.15014e-09, -2.23517e-08, 0.138698)
                            Node {
                                id: leftArm
                                position: Qt.vector3d(0.178899, -6.16014e-05, -0.000299692)
                                Node {
                                    id: leftForeArm
                                    position: Qt.vector3d(0.255372, -5.96046e-08, 0)
                                    Node {
                                        id: leftHand
                                        position: Qt.vector3d(0.269843, 0, 2.38419e-06)
                                        Node {
                                            id: leftHandThumb1
                                            position: Qt.vector3d(0.0240954, -0.0258118, -0.0155212)
                                            rotation: Qt.quaternion(0.737614, 0.501698, 1.01009e-08, -0.451913)
                                            Node {
                                                id: leftHandThumb2
                                                position: Qt.vector3d(0.030393, 1.41468e-06, -2.53469e-05)
                                                rotation: Qt.quaternion(1, 3.06591e-06, -4.71622e-06, -9.60846e-06)
                                                scale: Qt.vector3d(1, 1, 1)
                                                Node {
                                                    id: leftHandThumb3
                                                    position: Qt.vector3d(0.0278056, 1.40537e-06, -2.34433e-05)
                                                    rotation: Qt.quaternion(1, -6.97188e-06, -1.05239e-05, -9.24058e-06)
                                                    scale: Qt.vector3d(1, 1, 1)
                                                }
                                            }
                                        }
                                        Node {
                                            id: leftHandIndex
                                            position: Qt.vector3d(0.0283569, -0.0121126, -0.0111477)
                                            Node {
                                                id: leftHandIndex1
                                                position: Qt.vector3d(0.0597462, -0.00857229, 0.00594926)
                                                Node {
                                                    id: leftHandIndex2
                                                    position: Qt.vector3d(0.0329947, -1.49012e-08, -1.19209e-07)
                                                    Node {
                                                        id: leftHandIndex3
                                                        position: Qt.vector3d(0.0221887, -3.72529e-09, 1.19209e-07)
                                                    }
                                                }
                                            }
                                        }
                                        Node {
                                            id: leftHandMiddle
                                            position: Qt.vector3d(0.0299744, 0.00496714, -0.00621736)
                                            Node {
                                                id: leftHandMiddle1
                                                position: Qt.vector3d(0.0646919, -0.00160855, 0.00473952)
                                                Node {
                                                    id: leftHandMiddle2
                                                    position: Qt.vector3d(0.0317359, 0, 2.38419e-07)
                                                    Node {
                                                        id: leftHandMiddle3
                                                        position: Qt.vector3d(0.0232731, 0, 0)
                                                    }
                                                }
                                            }
                                        }
                                        Node {
                                            id: leftHandRing
                                            position: Qt.vector3d(0.0325339, 0.0261922, -0.00411105)
                                            Node {
                                                id: leftHandRing1
                                                position: Qt.vector3d(0.0492074, 0.000482008, 0.000155091)
                                                scale: Qt.vector3d(1, 1, 1)
                                                Node {
                                                    id: leftHandRing2
                                                    position: Qt.vector3d(0.0288431, 5.58794e-09, 0)
                                                    Node {
                                                        id: leftHandRing3
                                                        position: Qt.vector3d(0.0247866, 1.86265e-09, 0)
                                                    }
                                                }
                                            }
                                        }
                                        Node {
                                            id: leftHandPinky
                                            position: Qt.vector3d(0.0328075, 0.0428612, -0.00580001)
                                            Node {
                                                id: leftHandPinky1
                                                position: Qt.vector3d(0.0359852, 0.000349201, -0.00413883)
                                                scale: Qt.vector3d(1, 1, 1)
                                                Node {
                                                    id: leftHandPinky2
                                                    position: Qt.vector3d(0.0211114, 0, -2.38419e-07)
                                                    Node {
                                                        id: leftHandPinky3
                                                        position: Qt.vector3d(0.0189454, 0, 1.19209e-07)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    Node {
                                        id: lowerarm_twist_L
                                        position: Qt.vector3d(-2.08616e-07, 2.98023e-08, -0.000300527)
                                    }
                                }
                                Node {
                                    id: upperarm_twist_L
                                    position: Qt.vector3d(-4.47035e-08, -2.98023e-08, 0)
                                }
                            }
                        }
                        Node {
                            id: rightShoulder
                            position: Qt.vector3d(-3.26479e-09, -2.23517e-08, 0.138698)
                            Node {
                                id: rightArm
                                position: Qt.vector3d(-0.178899, -6.16014e-05, -0.000299692)
                                Node {
                                    id: rightForeArm
                                    position: Qt.vector3d(-0.255372, -5.96046e-08, 0)
                                    Node {
                                        id: rightHand
                                        position: Qt.vector3d(-0.269843, 0, 2.38419e-06)
                                        Node {
                                            id: rightHandThumb1
                                            position: Qt.vector3d(-0.0240955, -0.0258118, -0.0155213)
                                            rotation: Qt.quaternion(0.675223, -0.548055, -8.8274e-08, -0.49367)
                                            scale: Qt.vector3d(1, 1, 1)
                                            Node {
                                                id: rightHandThumb2
                                                position: Qt.vector3d(-0.00319002, -9.42033e-07, -0.0302249)
                                                rotation: Qt.quaternion(1, 9.54419e-06, 4.79072e-06, 2.46149e-06)
                                                scale: Qt.vector3d(1, 1, 1)
                                                Node {
                                                    id: rightHandThumb3
                                                    position: Qt.vector3d(-0.00291804, -1.89152e-06, -0.027652)
                                                    rotation: Qt.quaternion(1, 7.95163e-06, 1.29081e-05, -7.20099e-06)
                                                }
                                            }
                                        }
                                        Node {
                                            id: rightHandIndex
                                            position: Qt.vector3d(-0.0283569, -0.0121126, -0.0111477)
                                            Node {
                                                id: rightHandIndex1
                                                position: Qt.vector3d(-0.0597462, -0.00857229, 0.00594926)
                                                rotation: Qt.quaternion(0, 0, 0, 1)
                                                Node {
                                                    id: rightHandIndex2
                                                    position: Qt.vector3d(0.0329947, 7.45058e-09, -1.19209e-07)
                                                    Node {
                                                        id: rightHandIndex3
                                                        position: Qt.vector3d(0.0221887, 1.86265e-09, 1.19209e-07)
                                                    }
                                                }
                                            }
                                        }
                                        Node {
                                            id: rightHandMiddle
                                            position: Qt.vector3d(-0.0299744, 0.00496714, -0.00621736)
                                            Node {
                                                id: rightHandMiddle1
                                                position: Qt.vector3d(-0.0646919, -0.00160855, 0.00473952)
                                                rotation: Qt.quaternion(0, 0, 0, 1)
                                                Node {
                                                    id: rightHandMiddle2
                                                    position: Qt.vector3d(0.0317359, 0, 2.38419e-07)
                                                    Node {
                                                        id: rightHandMiddle3
                                                        position: Qt.vector3d(0.0232731, 0, 0)
                                                    }
                                                }
                                            }
                                        }
                                        Node {
                                            id: rightHandRing
                                            position: Qt.vector3d(-0.0325339, 0.0261922, -0.00411105)
                                            Node {
                                                id: rightHandRing1
                                                position: Qt.vector3d(-0.0492074, 0.000482008, 0.000155091)
                                                rotation: Qt.quaternion(0, 0, 0, 1)
                                                Node {
                                                    id: rightHandRing2
                                                    position: Qt.vector3d(0.0288431, -1.11759e-08, 0)
                                                    Node {
                                                        id: rightHandRing3
                                                        position: Qt.vector3d(0.0247866, 0, 0)
                                                    }
                                                }
                                            }
                                        }
                                        Node {
                                            id: rightHandPinky
                                            position: Qt.vector3d(-0.0328075, 0.0428612, -0.00580001)
                                            Node {
                                                id: rightHandPinky1
                                                position: Qt.vector3d(-0.0359852, 0.000349201, -0.00413883)
                                                rotation: Qt.quaternion(0, 0, 0, 1)
                                                Node {
                                                    id: rightHandPinky2
                                                    position: Qt.vector3d(0.0211114, 0, -2.38419e-07)
                                                    Node {
                                                        id: rightHandPinky3
                                                        position: Qt.vector3d(0.0189454, 0, 1.19209e-07)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    Node {
                                        id: lowerarm_twist_R
                                        position: Qt.vector3d(2.08616e-07, 2.98023e-08, -0.000300527)
                                    }
                                }
                                Node {
                                    id: upperarm_twist_R
                                    position: Qt.vector3d(4.47035e-08, -2.98023e-08, 0)
                                }
                            }
                        }
                        Node {
                            id: neck_base
                            position: Qt.vector3d(3.15022e-09, -2.23517e-08, 0.138698)
                            Node {
                                id: head
                                position: Qt.vector3d(2.16361e-09, -7.45058e-09, 0.0952601)
                            }
                        }
                        Node {
                            id: breast_L
                            position: Qt.vector3d(0.0873697, 0.0411352, 0.0115459)
                        }
                        Node {
                            id: breast_R
                            position: Qt.vector3d(-0.0873697, 0.0411352, 0.0115459)
                        }
                    }
                }
            }
        }
    }

    // Animations:
}
