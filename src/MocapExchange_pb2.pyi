from google.protobuf.internal import containers as _containers
from google.protobuf.internal import enum_type_wrapper as _enum_type_wrapper
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from typing import ClassVar as _ClassVar, Iterable as _Iterable, Mapping as _Mapping, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class StructureType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = []
    HUMAN: _ClassVar[StructureType]
    BALL: _ClassVar[StructureType]
    BIKE: _ClassVar[StructureType]
HUMAN: StructureType
BALL: StructureType
BIKE: StructureType

class Translation(_message.Message):
    __slots__ = ["x", "y", "z"]
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    Z_FIELD_NUMBER: _ClassVar[int]
    x: float
    y: float
    z: float
    def __init__(self, x: _Optional[float] = ..., y: _Optional[float] = ..., z: _Optional[float] = ...) -> None: ...

class Orientation(_message.Message):
    __slots__ = ["rotationType", "rotationValues"]
    class RotationType(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
        __slots__ = []
        QUATERNION: _ClassVar[Orientation.RotationType]
        MATRIX: _ClassVar[Orientation.RotationType]
        EULER_XYZ: _ClassVar[Orientation.RotationType]
        EULER_XZY: _ClassVar[Orientation.RotationType]
        EULER_YXZ: _ClassVar[Orientation.RotationType]
        EULER_YZX: _ClassVar[Orientation.RotationType]
        EULER_ZXY: _ClassVar[Orientation.RotationType]
        EULER_ZYX: _ClassVar[Orientation.RotationType]
        EULER_XY: _ClassVar[Orientation.RotationType]
        EULER_YX: _ClassVar[Orientation.RotationType]
        EULER_XZ: _ClassVar[Orientation.RotationType]
        EULER_ZX: _ClassVar[Orientation.RotationType]
        EULER_YZ: _ClassVar[Orientation.RotationType]
        EULER_ZY: _ClassVar[Orientation.RotationType]
        EULER_X: _ClassVar[Orientation.RotationType]
        EULER_Y: _ClassVar[Orientation.RotationType]
        EULER_Z: _ClassVar[Orientation.RotationType]
    QUATERNION: Orientation.RotationType
    MATRIX: Orientation.RotationType
    EULER_XYZ: Orientation.RotationType
    EULER_XZY: Orientation.RotationType
    EULER_YXZ: Orientation.RotationType
    EULER_YZX: Orientation.RotationType
    EULER_ZXY: Orientation.RotationType
    EULER_ZYX: Orientation.RotationType
    EULER_XY: Orientation.RotationType
    EULER_YX: Orientation.RotationType
    EULER_XZ: Orientation.RotationType
    EULER_ZX: Orientation.RotationType
    EULER_YZ: Orientation.RotationType
    EULER_ZY: Orientation.RotationType
    EULER_X: Orientation.RotationType
    EULER_Y: Orientation.RotationType
    EULER_Z: Orientation.RotationType
    ROTATIONTYPE_FIELD_NUMBER: _ClassVar[int]
    ROTATIONVALUES_FIELD_NUMBER: _ClassVar[int]
    rotationType: Orientation.RotationType
    rotationValues: _containers.RepeatedScalarFieldContainer[float]
    def __init__(self, rotationType: _Optional[_Union[Orientation.RotationType, str]] = ..., rotationValues: _Optional[_Iterable[float]] = ...) -> None: ...

class Transform(_message.Message):
    __slots__ = ["translation", "orientation"]
    TRANSLATION_FIELD_NUMBER: _ClassVar[int]
    ORIENTATION_FIELD_NUMBER: _ClassVar[int]
    translation: Translation
    orientation: Orientation
    def __init__(self, translation: _Optional[_Union[Translation, _Mapping]] = ..., orientation: _Optional[_Union[Orientation, _Mapping]] = ...) -> None: ...

class Link(_message.Message):
    __slots__ = ["name", "linkId", "parentLinkId", "offset", "mass", "linkSize", "inertialMatrix"]
    NAME_FIELD_NUMBER: _ClassVar[int]
    LINKID_FIELD_NUMBER: _ClassVar[int]
    PARENTLINKID_FIELD_NUMBER: _ClassVar[int]
    OFFSET_FIELD_NUMBER: _ClassVar[int]
    MASS_FIELD_NUMBER: _ClassVar[int]
    LINKSIZE_FIELD_NUMBER: _ClassVar[int]
    INERTIALMATRIX_FIELD_NUMBER: _ClassVar[int]
    name: str
    linkId: int
    parentLinkId: int
    offset: Transform
    mass: float
    linkSize: _containers.RepeatedScalarFieldContainer[float]
    inertialMatrix: _containers.RepeatedScalarFieldContainer[float]
    def __init__(self, name: _Optional[str] = ..., linkId: _Optional[int] = ..., parentLinkId: _Optional[int] = ..., offset: _Optional[_Union[Transform, _Mapping]] = ..., mass: _Optional[float] = ..., linkSize: _Optional[_Iterable[float]] = ..., inertialMatrix: _Optional[_Iterable[float]] = ...) -> None: ...

class JointMeta(_message.Message):
    __slots__ = ["jointId", "linkId", "name"]
    JOINTID_FIELD_NUMBER: _ClassVar[int]
    LINKID_FIELD_NUMBER: _ClassVar[int]
    NAME_FIELD_NUMBER: _ClassVar[int]
    jointId: int
    linkId: int
    name: str
    def __init__(self, jointId: _Optional[int] = ..., linkId: _Optional[int] = ..., name: _Optional[str] = ...) -> None: ...

class Structure(_message.Message):
    __slots__ = ["structureId", "structureType", "name", "links", "joints"]
    STRUCTUREID_FIELD_NUMBER: _ClassVar[int]
    STRUCTURETYPE_FIELD_NUMBER: _ClassVar[int]
    NAME_FIELD_NUMBER: _ClassVar[int]
    LINKS_FIELD_NUMBER: _ClassVar[int]
    JOINTS_FIELD_NUMBER: _ClassVar[int]
    structureId: int
    structureType: StructureType
    name: str
    links: _containers.RepeatedCompositeFieldContainer[Link]
    joints: _containers.RepeatedCompositeFieldContainer[JointMeta]
    def __init__(self, structureId: _Optional[int] = ..., structureType: _Optional[_Union[StructureType, str]] = ..., name: _Optional[str] = ..., links: _Optional[_Iterable[_Union[Link, _Mapping]]] = ..., joints: _Optional[_Iterable[_Union[JointMeta, _Mapping]]] = ...) -> None: ...

class Joint(_message.Message):
    __slots__ = ["jointId", "transform"]
    JOINTID_FIELD_NUMBER: _ClassVar[int]
    TRANSFORM_FIELD_NUMBER: _ClassVar[int]
    jointId: int
    transform: Transform
    def __init__(self, jointId: _Optional[int] = ..., transform: _Optional[_Union[Transform, _Mapping]] = ...) -> None: ...

class Pose(_message.Message):
    __slots__ = ["subjectId", "timestamp", "joints", "globalJoints"]
    SUBJECTID_FIELD_NUMBER: _ClassVar[int]
    TIMESTAMP_FIELD_NUMBER: _ClassVar[int]
    JOINTS_FIELD_NUMBER: _ClassVar[int]
    GLOBALJOINTS_FIELD_NUMBER: _ClassVar[int]
    subjectId: int
    timestamp: int
    joints: _containers.RepeatedCompositeFieldContainer[Joint]
    globalJoints: _containers.RepeatedCompositeFieldContainer[Joint]
    def __init__(self, subjectId: _Optional[int] = ..., timestamp: _Optional[int] = ..., joints: _Optional[_Iterable[_Union[Joint, _Mapping]]] = ..., globalJoints: _Optional[_Iterable[_Union[Joint, _Mapping]]] = ...) -> None: ...

class MocapStreamRequest(_message.Message):
    __slots__ = ["fps"]
    FPS_FIELD_NUMBER: _ClassVar[int]
    fps: float
    def __init__(self, fps: _Optional[float] = ...) -> None: ...

class MocapStreamResponse(_message.Message):
    __slots__ = ["poses", "serverTime", "mocapServerTimestamp"]
    POSES_FIELD_NUMBER: _ClassVar[int]
    SERVERTIME_FIELD_NUMBER: _ClassVar[int]
    MOCAPSERVERTIMESTAMP_FIELD_NUMBER: _ClassVar[int]
    poses: _containers.RepeatedCompositeFieldContainer[Pose]
    serverTime: float
    mocapServerTimestamp: int
    def __init__(self, poses: _Optional[_Iterable[_Union[Pose, _Mapping]]] = ..., serverTime: _Optional[float] = ..., mocapServerTimestamp: _Optional[int] = ...) -> None: ...

class StructureRequest(_message.Message):
    __slots__ = ["structureId"]
    STRUCTUREID_FIELD_NUMBER: _ClassVar[int]
    structureId: _containers.RepeatedScalarFieldContainer[int]
    def __init__(self, structureId: _Optional[_Iterable[int]] = ...) -> None: ...

class StructureResponse(_message.Message):
    __slots__ = ["structures"]
    STRUCTURES_FIELD_NUMBER: _ClassVar[int]
    structures: _containers.RepeatedCompositeFieldContainer[Structure]
    def __init__(self, structures: _Optional[_Iterable[_Union[Structure, _Mapping]]] = ...) -> None: ...

class ActorStateFrame(_message.Message):
    __slots__ = ["pose"]
    POSE_FIELD_NUMBER: _ClassVar[int]
    pose: Pose
    def __init__(self, pose: _Optional[_Union[Pose, _Mapping]] = ...) -> None: ...

class ActorStateFramesRecord(_message.Message):
    __slots__ = ["trackID", "actorModel", "frames"]
    TRACKID_FIELD_NUMBER: _ClassVar[int]
    ACTORMODEL_FIELD_NUMBER: _ClassVar[int]
    FRAMES_FIELD_NUMBER: _ClassVar[int]
    trackID: int
    actorModel: Structure
    frames: _containers.RepeatedCompositeFieldContainer[Pose]
    def __init__(self, trackID: _Optional[int] = ..., actorModel: _Optional[_Union[Structure, _Mapping]] = ..., frames: _Optional[_Iterable[_Union[Pose, _Mapping]]] = ...) -> None: ...
