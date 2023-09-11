import QtQuick
import QtQuick3D
Node {
    id: rootNode
    property alias jRoot: hips
    property alias jLHip: leftUpLeg
    property alias jRHip: rightUpLeg
    property alias jLKnee: leftLeg
    property alias jRKnee: rightLeg
    property alias jLAnkle: leftFoot
    property alias jRAnkle: rightFoot
    property alias jSpine0: spine2
    property alias jNeckBottom: neck_base
    property alias jHeadBottom: neck
    property alias jLShoulder: leftArm
    property alias jRShoulder: rightArm
    property alias jLElbow: leftForeArm
    property alias jRElbow: rightForeArm

    Model {
        id: m_ca01
        skeleton: qmlskeleton
        inverseBindPoses: [
            Qt.matrix4x4(0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0.01, -0.196244, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0.01, -0.364758, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533272, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0.01, -0.6185, 0, 0, 0, 1),
            Qt.matrix4x4(),
            Qt.matrix4x4(),
            Qt.matrix4x4(0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.17526, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.175259, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.463658, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.463658, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.745459, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.769711, 0, 0.01, 0, 0.017121, 0, 0, 0.01, -0.527077, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.789965, 0, 0.01, 0, 0.040379, 0, 0, 0.01, -0.509228, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.814534, 0, 0.01, 0, 0.068591, 0, 0, 0.01, -0.498545, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.774958, 0, 0.01, 0, 0.022116, 0, 0, 0.01, -0.521769, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.834924, 0, 0.01, 0, 0.032566, 0, 0, 0.01, -0.53552, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.875204, 0, 0.01, 0, 0.032566, 0, 0, 0.01, -0.53552, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.900679, 0, 0.01, 0, 0.032566, 0, 0, 0.01, -0.53552, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.776579, 0, 0.01, 0, 0.008366, 0, 0, 0.01, -0.527043, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.835718, 0, 0.01, 0, 0.009803, 0, 0, 0.01, -0.536631, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.880007, 0, 0.01, 0, 0.009803, 0, 0, 0.01, -0.536631, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.910037, 0, 0.01, 0, 0.009803, 0, 0, 0.01, -0.536631, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.77921, 0, 0.01, 0, -0.011253, 0, 0, 0.01, -0.529414, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.832548, 0, 0.01, 0, -0.011324, 0, 0, 0.01, -0.533989, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.875899, 0, 0.01, 0, -0.011324, 0, 0, 0.01, -0.533989, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.904487, 0, 0.01, 0, -0.011324, 0, 0, 0.01, -0.533989, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.77955, 0, 0.01, 0, -0.031933, 0, 0, 0.01, -0.52782, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.828017, 0, 0.01, 0, -0.031046, 0, 0, 0.01, -0.526949, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.86353, 0, 0.01, 0, -0.031046, 0, 0, 0.01, -0.526949, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.883785, 0, 0.01, 0, -0.031046, 0, 0, 0.01, -0.526949, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.17526, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.175259, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.463658, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.463658, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.745459, 0, 0.01, 0, 0, 0, 0, 0.01, -0.533273, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.774958, 0, 0.01, 0, 0.022116, 0, 0, 0.01, -0.521769, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.834924, 0, 0.01, 0, 0.032566, 0, 0, 0.01, -0.53552, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.875204, 0, 0.01, 0, 0.032566, 0, 0, 0.01, -0.53552, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.900679, 0, 0.01, 0, 0.032566, 0, 0, 0.01, -0.53552, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.776579, 0, 0.01, 0, 0.008366, 0, 0, 0.01, -0.527043, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.835718, 0, 0.01, 0, 0.009803, 0, 0, 0.01, -0.536631, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.880007, 0, 0.01, 0, 0.009803, 0, 0, 0.01, -0.536631, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.910037, 0, 0.01, 0, 0.009803, 0, 0, 0.01, -0.536631, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.77921, 0, 0.01, 0, -0.011253, 0, 0, 0.01, -0.529414, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.832548, 0, 0.01, 0, -0.011324, 0, 0, 0.01, -0.533989, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.875899, 0, 0.01, 0, -0.011324, 0, 0, 0.01, -0.533989, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.904487, 0, 0.01, 0, -0.011324, 0, 0, 0.01, -0.533989, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.77955, 0, 0.01, 0, -0.031933, 0, 0, 0.01, -0.52782, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.828017, 0, 0.01, 0, -0.031046, 0, 0, 0.01, -0.526949, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.86353, 0, 0.01, 0, -0.031046, 0, 0, 0.01, -0.526949, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.883785, 0, 0.01, 0, -0.031046, 0, 0, 0.01, -0.526949, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.769711, 0, 0.01, 0, 0.017121, 0, 0, 0.01, -0.527077, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.789965, 0, 0.01, 0, 0.040379, 0, 0, 0.01, -0.509228, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.814534, 0, 0.01, 0, 0.068591, 0, 0, 0.01, -0.498545, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0.405726, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0.851933, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.109652, 0, 0.01, 0, 0.104626, 0, 0, 0.01, 0.921711, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0.405726, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, 0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0.405726, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0.851933, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.109652, 0, 0.01, 0, 0.104626, 0, 0, 0.01, 0.921711, 0, 0, 0, 1),
            Qt.matrix4x4(0.01, 0, 0, -0.109652, 0, 0.01, 0, 0, 0, 0, 0.01, 0.405726, 0, 0, 0, 1)
        ]
        source: "meshes/m_ca01.mesh"

        DefaultMaterial {
            id: fbx_Default_Material_0_material
            diffuseColor: "#ffb8b8b8"
        }
        materials: [
            fbx_Default_Material_0_material
        ]
    }
    Node {
        id: root
        y: 0
        z: 0
        scale.x: 1
        scale.y: 1
        scale.z: 1
        Skeleton {
            id: qmlskeleton
            Joint {
                id: hips
                y: -0.087399
                z: 0.905091
                index: 0
                skeletonRoot: qmlskeleton
                Joint {
                    id: spine2
                    z: 0.196244
                    index: 1
                    skeletonRoot: qmlskeleton
                    Joint {
                        id: spine_002
                        z: 0.168514
                        index: 2
                        skeletonRoot: qmlskeleton
                        Joint {
                            id: neck_base
                            z: 0.168514
                            index: 3
                            skeletonRoot: qmlskeleton
                            Joint {
                                id: neck
                                z: 0.085228
                                index: 4
                                skeletonRoot: qmlskeleton
                            }
                        }
                        Joint {
                            id: breast_L
                            x: 0.08737
                            y: 0.041135
                            z: 0.014028
                            index: 5
                            skeletonRoot: qmlskeleton
                        }
                        Joint {
                            id: breast_R
                            x: -0.08737
                            y: 0.041135
                            z: 0.014028
                            index: 6
                            skeletonRoot: qmlskeleton
                        }
                        Joint {
                            id: leftShoulder
                            z: 0.168515
                            index: 7
                            skeletonRoot: qmlskeleton
                            Joint {
                                id: leftArm
                                x: 0.17526
                                index: 8
                                skeletonRoot: qmlskeleton
                                Joint {
                                    id: upperarm_twist_L
                                    index: 9
                                    skeletonRoot: qmlskeleton
                                }
                                Joint {
                                    id: leftForeArm
                                    x: 0.288398
                                    index: 10
                                    skeletonRoot: qmlskeleton
                                    Joint {
                                        id: lowerarm_twist_L
                                        index: 11
                                        skeletonRoot: qmlskeleton
                                    }
                                    Joint {
                                        id: leftHand
                                        x: 0.281801
                                        index: 12
                                        skeletonRoot: qmlskeleton
                                        Joint {
                                            id: leftHandThumb1
                                            x: 0.024252
                                            y: -0.017121
                                            z: -0.006196
                                            index: 13
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: leftHandThumb2
                                                x: 0.020254
                                                y: -0.023258
                                                z: -0.017849
                                                index: 14
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: leftHandThumb3
                                                    x: 0.024569
                                                    y: -0.028212
                                                    z: -0.010683
                                                    index: 15
                                                    skeletonRoot: qmlskeleton
                                                }
                                            }
                                        }
                                        Joint {
                                            id: leftHandIndex
                                            x: 0.029499
                                            y: -0.022116
                                            z: -0.011504
                                            index: 16
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: leftHandIndex1
                                                x: 0.059966
                                                y: -0.01045
                                                z: 0.013751
                                                index: 17
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: leftHandIndex2
                                                    x: 0.04028
                                                    index: 18
                                                    skeletonRoot: qmlskeleton
                                                    Joint {
                                                        id: leftHandIndex3
                                                        x: 0.025475
                                                        index: 19
                                                        skeletonRoot: qmlskeleton
                                                    }
                                                }
                                            }
                                        }
                                        Joint {
                                            id: leftHandMiddle
                                            x: 0.03112
                                            y: -0.008366
                                            z: -0.00623
                                            index: 20
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: leftHandMiddle1
                                                x: 0.059139
                                                y: -0.001437
                                                z: 0.009588
                                                index: 21
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: leftHandMiddle2
                                                    x: 0.044289
                                                    index: 22
                                                    skeletonRoot: qmlskeleton
                                                    Joint {
                                                        id: leftHandMiddle3
                                                        x: 0.03003
                                                        index: 23
                                                        skeletonRoot: qmlskeleton
                                                    }
                                                }
                                            }
                                        }
                                        Joint {
                                            id: leftHandRing
                                            x: 0.033751
                                            y: 0.011253
                                            z: -0.003859
                                            index: 24
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: leftHandRing1
                                                x: 0.053338
                                                y: 7.1e-05
                                                z: 0.004575
                                                index: 25
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: leftHandRing2
                                                    x: 0.043351
                                                    index: 26
                                                    skeletonRoot: qmlskeleton
                                                    Joint {
                                                        id: leftHandRing3
                                                        x: 0.028588
                                                        index: 27
                                                        skeletonRoot: qmlskeleton
                                                    }
                                                }
                                            }
                                        }
                                        Joint {
                                            id: leftHandPinky
                                            x: 0.034091
                                            y: 0.031933
                                            z: -0.005453
                                            index: 28
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: leftHandPinky1
                                                x: 0.048467
                                                y: -0.000887
                                                z: -0.000871
                                                index: 29
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: leftHandPinky2
                                                    x: 0.035513
                                                    index: 30
                                                    skeletonRoot: qmlskeleton
                                                    Joint {
                                                        id: leftHandPinky3
                                                        x: 0.020255
                                                        index: 31
                                                        skeletonRoot: qmlskeleton
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Joint {
                            id: rightShoulder
                            z: 0.168515
                            index: 32
                            skeletonRoot: qmlskeleton
                            Joint {
                                id: rightArm
                                x: -0.17526
                                index: 33
                                skeletonRoot: qmlskeleton
                                Joint {
                                    id: upperarm_twist_R
                                    index: 34
                                    skeletonRoot: qmlskeleton
                                }
                                Joint {
                                    id: rightForeArm
                                    x: -0.288398
                                    index: 35
                                    skeletonRoot: qmlskeleton
                                    Joint {
                                        id: lowerarm_twist_R
                                        index: 36
                                        skeletonRoot: qmlskeleton
                                    }
                                    Joint {
                                        id: rightHand
                                        x: -0.281801
                                        index: 37
                                        skeletonRoot: qmlskeleton
                                        Joint {
                                            id: rightHandIndex
                                            x: -0.029499
                                            y: -0.022116
                                            z: -0.011504
                                            index: 38
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: rightHandIndex1
                                                x: -0.059966
                                                y: -0.01045
                                                z: 0.013751
                                                index: 39
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: rightHandIndex2
                                                    x: -0.04028
                                                    index: 40
                                                    skeletonRoot: qmlskeleton
                                                    Joint {
                                                        id: rightHandIndex3
                                                        x: -0.025475
                                                        index: 41
                                                        skeletonRoot: qmlskeleton
                                                    }
                                                }
                                            }
                                        }
                                        Joint {
                                            id: rightHandMiddle
                                            x: -0.03112
                                            y: -0.008366
                                            z: -0.00623
                                            index: 42
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: rightHandMiddle1
                                                x: -0.059139
                                                y: -0.001437
                                                z: 0.009588
                                                index: 43
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: rightHandMiddle2
                                                    x: -0.044289
                                                    index: 44
                                                    skeletonRoot: qmlskeleton
                                                    Joint {
                                                        id: rightHandMiddle3
                                                        x: -0.03003
                                                        index: 45
                                                        skeletonRoot: qmlskeleton
                                                    }
                                                }
                                            }
                                        }
                                        Joint {
                                            id: rightHandRing
                                            x: -0.033751
                                            y: 0.011253
                                            z: -0.003859
                                            index: 46
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: rightHandRing1
                                                x: -0.053338
                                                y: 7.1e-05
                                                z: 0.004575
                                                index: 47
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: rightHandRing2
                                                    x: -0.043351
                                                    index: 48
                                                    skeletonRoot: qmlskeleton
                                                    Joint {
                                                        id: rightHandRing3
                                                        x: -0.028588
                                                        index: 49
                                                        skeletonRoot: qmlskeleton
                                                    }
                                                }
                                            }
                                        }
                                        Joint {
                                            id: rightHandPinky
                                            x: -0.034091
                                            y: 0.031933
                                            z: -0.005453
                                            index: 50
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: rightHandPinky1
                                                x: -0.048467
                                                y: -0.000887
                                                z: -0.000871
                                                index: 51
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: rightHandPinky2
                                                    x: -0.035513
                                                    index: 52
                                                    skeletonRoot: qmlskeleton
                                                    Joint {
                                                        id: rightHandPinky3
                                                        x: -0.020255
                                                        index: 53
                                                        skeletonRoot: qmlskeleton
                                                    }
                                                }
                                            }
                                        }
                                        Joint {
                                            id: rightHandThumb1
                                            x: -0.024252
                                            y: -0.017121
                                            z: -0.006196
                                            index: 54
                                            skeletonRoot: qmlskeleton
                                            Joint {
                                                id: rightHandThumb2
                                                x: -0.020254
                                                y: -0.023258
                                                z: -0.017849
                                                index: 55
                                                skeletonRoot: qmlskeleton
                                                Joint {
                                                    id: rightHandThumb3
                                                    x: -0.024569
                                                    y: -0.028212
                                                    z: -0.010683
                                                    index: 56
                                                    skeletonRoot: qmlskeleton
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Joint {
                    id: rightUpLeg
                    x: -0.109652
                    index: 57
                    skeletonRoot: qmlskeleton
                    Joint {
                        id: rightLeg
                        z: -0.405726
                        index: 58
                        skeletonRoot: qmlskeleton
                        Joint {
                            id: rightFoot
                            z: -0.446207
                            index: 59
                            skeletonRoot: qmlskeleton
                            Joint {
                                id: rightToeBase
                                y: -0.104626
                                z: -0.069778
                                index: 60
                                skeletonRoot: qmlskeleton
                            }
                        }
                        Joint {
                            id: calf_twist_R
                            index: 61
                            skeletonRoot: qmlskeleton
                        }
                    }
                    Joint {
                        id: thigh_twist_R
                        index: 62
                        skeletonRoot: qmlskeleton
                    }
                }
                Joint {
                    id: leftUpLeg
                    x: 0.109652
                    index: 63
                    skeletonRoot: qmlskeleton
                    Joint {
                        id: thigh_twist_L
                        index: 64
                        skeletonRoot: qmlskeleton
                    }
                    Joint {
                        id: leftLeg
                        z: -0.405726
                        index: 65
                        skeletonRoot: qmlskeleton
                        Joint {
                            id: leftFoot
                            z: -0.446207
                            index: 66
                            skeletonRoot: qmlskeleton
                            Joint {
                                id: leftToeBase
                                y: -0.104626
                                z: -0.069778
                                index: 67
                                skeletonRoot: qmlskeleton
                            }
                        }
                        Joint {
                            id: calf_twist_L
                            index: 68
                            skeletonRoot: qmlskeleton
                        }
                    }
                }
            }
        }
    }
}
