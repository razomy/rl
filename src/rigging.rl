
#
Animation, Rigging, Armature, Pose, F-Curves, Drivers & NLA
#

SlotHandle     { Value Int }
ActionLayerMix "Replace" | "Add" | "Subtract" | "Multiply"

BezTripleKeyframeType "Keyframe" | "Breakdown" | "MovingHold" | "Extreme" | "Jitter" | "Generated"
BezTripleHandle       "Free" | "Auto" | "Vect" | "Align" | "AutoClamp"
BezTripleInterp       "Constant" | "Linear" | "Bezier" | "Back" | "Bounce" | "Circ" | "Cubic" | "Elastic" | "Expo" | "Quad" | "Quart" | "Quint" | "Sine"

BezTriple {
  Vec       (Float3, Float3, Float3)
  Tilt      Float
  Weight    Float
  Radius    Float
  Ipo       BezTripleInterp
  H1        BezTripleHandle
  H2        BezTripleHandle
  KeyType   BezTripleKeyframeType
  Easing    Int
  Back      Float
  Amplitude Float
  Period    Float
}

FModifierType "Null" | "Generator" | "FnGenerator" | "Envelope" | "Cycles" | "Noise" | "Limits" | "Step"

FModifier {
  Name      String
  Type      FModifierType
  Flag      Int
  Influence Float
  Start     Float
  End       Float
  BlendIn   Float
  BlendOut  Float
}

DriverVarType "SingleProp" | "RotDiff" | "LocDiff" | "TransformChannel" | "ContextProp"
DriverType    "Average" | "Sum" | "Scripted" | "Min" | "Max"

DriverTarget {
  Id            Option(ID)
  IdType        IDType
  RnaPath       String
  PchanName     String
  TransChan     Int
  RotationMode  Int
  FallbackValue Float
}

DriverVar {
  Name    String
  Type    DriverVarType
  Targets List(DriverTarget)
}

ChannelDriver {
  Variables  List(DriverVar)
  Expression String
  Type       DriverType
  Influence  Float
  Curval     Float
  Flag       Int
}

BoneColor {
  PaletteIndex Int
  Regular      Color4b
  Select       Color4b
  Active       Color4b
  Flag         Int
}

bActionGroup {
  Name      String
  Channels  List(FCurve)
  Color     BoneColor
  Flag      Int
  CustomCol Int
}

FCurve {
  RnaPath       String
  ArrayIndex    Int
  Flag          Int
  Extend        Int
  AutoSmoothing Int
  ColorMode     Int
  Color         Float3
  Curval        Float
  Bezt          List(BezTriple)
  Driver        Option(ChannelDriver)
  Modifiers     List(FModifier)
  Group         Option(bActionGroup)
}

ActionSlot {
  Handle     SlotHandle
  IdType     IDType
  Identifier String
  Flags      Int
}

ActionChannelbag {
  SlotHandle    SlotHandle
  FCurves       List(FCurve)
  ChannelGroups List(bActionGroup)
}

ActionStripKeyframeData {
  Channelbags List(ActionChannelbag)
}

ActionStrip {
  StripType   "Keyframe"
  FrameStart  Float
  FrameEnd    Float
  FrameOffset Float
  DataIndex   Int
}

ActionLayer {
  Name    String
  Flags   Int
  MixMode ActionLayerMix
  Strips  List(ActionStrip)
}

Action3D ID & {
  Type              "AC"
  Layers            List(ActionLayer)
  Slots             List(ActionSlot)
  StripKeyframeData List(ActionStripKeyframeData)
  ActiveSlotHandle  SlotHandle
}

NlaStripType   "Clip" | "Transition" | "Meta" | "Sound"
NlaBlendMode   "Replace" | "Combine" | "Add" | "Subtract" | "Multiply"
NlaExtrapolate "Hold" | "HoldForward" | "Nothing"

NlaStrip {
  Name             String
  Type             NlaStripType
  BlendMode        NlaBlendMode
  Extrapolation    NlaExtrapolate
  Flag             Int
  Start            Float
  End              Float
  ActStart         Float
  ActEnd           Float
  Repeat           Float
  Scale            Float
  BlendIn          Float
  BlendOut         Float
  Influence        Float
  StripTime        Float
  Action           Option(Action3D)
  ActionSlotHandle SlotHandle
  ActionSlotIdent  String
  Fcurves          List(FCurve)
  Modifiers        List(FModifier)
  Strips           List(NlaStrip)
}

NlaTrack {
  Name   String
  Index  Int
  Flag   Int
  Strips List(NlaStrip)
}

AnimData {
  Action             Option(Action3D)
  SlotHandle         SlotHandle
  LastSlotIdentifier String
  TmpAction          Option(Action3D)
  TmpSlotHandle      SlotHandle
  TmpLastSlotIdent   String
  Drivers            List(FCurve)
  NlaTracks          List(NlaTrack)
  ActTrack           Option(NlaTrack)
  ActStrip           Option(NlaStrip)
  ActBlendmode       NlaBlendMode
  ActExtendmode      NlaExtrapolate
  ActInfluence       Float
  Flag               Int
}

Bone {
  Name         String
  Parent       Option(Bone)
  Children     List(Bone)
  Roll         Float
  Head         Float3
  Tail         Float3
  BoneMat      Float3x3
  Flag         Int
  ArmHead      Float3
  ArmTail      Float3
  ArmMat       Float4x4
  ArmRoll      Float
  Length       Float
  RadHead      Float
  RadTail      Float
  Segments     Int
  Color        BoneColor
  InheritScale Int
}

BoneCollection {
  Name       String
  Bones      List(Bone)
  Flags      Int
  ChildIndex Int
  ChildCount Int
  ColorSet   Int
}

bArmature ID & {
  Type                  "AR"
  Bonebase              List(Bone)
  ActiveBone            Option(Bone)
  Collections           List(BoneCollection)
  ActiveCollectionIndex Int
  Drawtype              Int
  Flag                  Int
  AxesPosition          Float
}

ConstraintType
  "Null" | "ChildOf" | "TrackTo" | "Ik" | "FollowPath" | "RotLimit" | "LocLimit"
  | "SizeLimit" | "SameVol" | "RotLike" | "LocLike" | "SizeLike" | "Python"
  | "Action" | "LockTrack" | "DistLimit" | "StretchTo" | "MinMax" | "RigidBodyJoint"
  | "ClampTo" | "Transform" | "Shrinkwrap" | "DampTrack" | "SplineIk" | "Pivot"
  | "FollowTrack" | "CameraSolver" | "ObjectSolver" | "TransformCache" | "Armature" | "GeometryAttribute"

bConstraint {
  Name     String
  Type     ConstraintType
  Flag     Int
  OwnSpace Int
  TarSpace Int
  Enforce  Float
  Headtail Float
  LinError Float
  RotError Float
  Data     Any
}

bPoseChannel {
  Name        String
  Bone        Option(Bone)
  Parent      Option(bPoseChannel)
  Child       Option(bPoseChannel)
  Constraints List(bConstraint)
  Loc         Float3
  Size        Float3
  Eul         Float3
  Quat        Quaternion
  RotAxis     Float3
  RotAngle    Float
  RotMode     Int
  ChanMat     Float4x4
  PoseMat     Float4x4
  ConstMatrix Float4x4
  PoseHead    Float3
  PoseTail    Float3
  Custom      Option(Object3D)
  Color       BoneColor
  Flag        Int
}

bPose {
  Channels     List(bPoseChannel)
  ChanHash     Map(String, bPoseChannel)
  ActionGroups List(bActionGroup)
  ActiveGroup  Int
  Flag         Int
  Ctime        Float
}
