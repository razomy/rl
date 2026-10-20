_ primitive
_ structure
_ math
_ space
_ ui
_ gpu
_ rendering
_ thing
_ enumeration
_ intangible

#
1. Core Data-Blocks (ID), Main Database, Undo & RNA Reflection
#

SessionUID { Value Int }
SubFrame   { Frame Int, Subframe Float }

IDType
  "SCE" | "LI" | "OB" | "ME" | "CU_LEGACY" | "MB" | "MA" | "TE" | "IM" | "LT"
  | "LA" | "CA" | "KE" | "WO" | "SCR" | "VF" | "TXT" | "SPK" | "LP" | "SO"
  | "GR" | "AR" | "AC" | "NT" | "BR" | "PA" | "GD_LEGACY" | "WM" | "MC" | "MSK"
  | "LS" | "PAL" | "PC" | "CF" | "WS" | "CV" | "PT" | "VO" | "GP"

IDPropertyType "STRING" | "INT" | "FLOAT" | "ARRAY" | "GROUP" | "ID" | "DOUBLE" | "IDPARRAY" | "BOOLEAN" | "ENUM"

IDProperty {
  Name    String
  Type    IDPropertyType
  Subtype String
  Flag    Int
  Value   Any
  UiData  Option(Any)
}

IDOverrideLibraryPropertyOperation {
  Operation      Int
  Flag           Int
  SubitemRefName Option(String)
  SubitemLocName Option(String)
  SubitemRefIdx  Int
  SubitemLocIdx  Int
}

IDOverrideLibraryProperty {
  RnaPath    String
  Operations List(IDOverrideLibraryPropertyOperation)
  Tag        Int
}

IDOverrideLibrary {
  Reference     Option(ID)
  Properties    List(IDOverrideLibraryProperty)
  HierarchyRoot Option(ID)
  Flag          Int
}

PackedFile {
  Size        Int
  Seek        Int
  Data        Any
  SharingInfo Option(ImplicitSharingInfo)
}

PreviewImage {
  Width     Int
  Height    Int
  RectByte  List(Byte)
  RectFloat List(Float)
  IconId    Int
  Flag      Int
}

AssetTag { Name String }

AssetMetaData {
  Properties        Option(IDProperty)
  CatalogId         String
  CatalogSimpleName String
  Author            String
  Description       String
  Copyright         String
  License           String
  Tags              List(AssetTag)
  ActiveTag         Int
}

Library ID & {
  Filepath          String
  FilepathAbs       String
  Parent            Option(Library)
  PackedFile        Option(PackedFile)
  VersionFile       Int
  SubversionFile    Int
  ArchivedLibraries List(Library)
}

ID Identifiable & {
  Name             String
  Type             IDType
  Flag             Int
  Tag              Int
  Users            Int
  SessionUid       SessionUID
  Library          Option(Library)
  LibraryWeakRef   Option(String)
  OverrideLibrary  Option(IDOverrideLibrary)
  Properties       Option(IDProperty)
  SystemProperties Option(IDProperty)
  AssetData        Option(AssetMetaData)
  Preview          Option(PreviewImage)
  AnimData         Option(AnimData)
}

// RNA Reflection & Access
PointerRNA {
  OwnerId   Option(ID)
  Type      Option(StructRNA)
  Data      Any
  Ancestors List(PointerRNA)
}

PropertyRNA {
  Identifier         String
  Name               String
  Description        String
  TranslationContext String
  Type               "Boolean" | "Int" | "Float" | "String" | "Enum" | "Pointer" | "Collection"
  Subtype            String
  Flag               Int
  OverrideFlag       Int
  ArrayDimension     Int
  IsEditable         Bool
  IsAnimatable       Bool
}

FunctionRNA {
  Identifier  String
  Description String
  Flag        Int
  Parameters  List(PropertyRNA)
  ReturnProp  Option(PropertyRNA)
}

StructRNA {
  Identifier         String
  Name               String
  Description        String
  TranslationContext String
  Icon               Int
  Base               Option(StructRNA)
  NameProperty       Option(PropertyRNA)
  IteratorProperty   Option(PropertyRNA)
  Properties         List(PropertyRNA)
  Functions          List(FunctionRNA)
}

Main {
  Filepath          String
  VersionFile       Int
  SubversionFile    Int
  MinVersionFile    Int
  MinSubversionFile Int
  IsGlobalMain      Bool
  Scenes            List(Scene3D)
  Libraries         List(Library)
  Objects           List(Object3D)
  Meshes            List(Mesh3D)
  Materials         List(Material3D)
  Lights            List(Light3D)
  Cameras           List(Camera3D)
  Shapekeys         List(Key)
  Worlds            List(World3D)
  Collections       List(Collection3D)
  Armatures         List(bArmature)
  Actions           List(Action3D)
  Nodetrees         List(bNodeTree)
  Brushes           List(Brush)
  Particles         List(ParticleSettings)
  GreasePencils     List(GreasePencil)
  HairCurves        List(Curves)
  Pointclouds       List(PointCloud)
  Volumes           List(Volume3D)
}

UndoType {
  Identifier String
  Flags      Int
  StepSize   Int
}

UndoStep {
  Name            String
  Type            UndoType
  DataSize        Int
  Skip            Bool
  UseMemfileStep  Bool
  UseOldBmainData Bool
  IsApplied       Bool
}

UndoStack {
  Steps             List(UndoStep)
  StepActive        Option(UndoStep)
  StepActiveMemfile Option(UndoStep)
  StepInit          Option(UndoStep)
  GroupLevel        Int
}

#
2. Attributes, Fields, MultiFunctions, LazyFunctions & Geometry Set
#

AttrStorageType "Array" | "Single"
AttrType        "Bool" | "Int8" | "Int16_2D" | "Int32" | "Int32_2D" | "Float" | "Float2" | "Float3" | "Float4" | "Float4x4" | "ColorByte" | "ColorFloat" | "Quaternion" | "String"
AttrDomain      "Point" | "Edge" | "Face" | "Corner" | "Curve" | "Instance" | "Layer"

Attribute {
  Name        String
  Domain      AttrDomain
  DataType    AttrType
  StorageType AttrStorageType
  Data        GList
}

AttributeStorage {
  Attributes List(Attribute)
}

// Multi-Function & Lazy-Function Graphs
MFDataType  { Category "Single" | "Vector", BaseType AttrType }
MFParamType { Category "SingleInput" | "VectorInput" | "SingleOutput" | "VectorOutput" | "SingleMutable" | "VectorMutable", DataType MFDataType }
MFParamInfo { Name String, Type MFParamType, Flag "None" | "SupportsUnusedOutput" }
MFSignature { FunctionName String, Params List(MFParamInfo) }
MultiFunction { Signature MFSignature }

LFValueUsage "Used" | "Maybe" | "Unused"
LFInput      { DebugName String, Type AttrType, Usage LFValueUsage }
LFOutput     { DebugName String, Type AttrType }
LazyFunction { DebugName String, Inputs List(LFInput), Outputs List(LFOutput), AllowMissingRequestedInputs Bool }

GeometryOwnershipType "Owned" | "Editable" | "ReadOnly"
GeometryComponentType "Mesh" | "PointCloud" | "Curve" | "Instance" | "Volume" | "Edit" | "GreasePencil"

GeometryComponent {
  Type       GeometryComponentType
  Ownership  GeometryOwnershipType
  Attributes AttributeStorage
}

MeshComponent         GeometryComponent & { Type "Mesh", Mesh Option(Mesh3D) }
PointCloudComponent   GeometryComponent & { Type "PointCloud", PointCloud Option(PointCloud) }
CurveComponent        GeometryComponent & { Type "Curve", Curves Option(Curves) }
InstancesComponent    GeometryComponent & { Type "Instance", Instances Option(Instances) }
VolumeComponent       GeometryComponent & { Type "Volume", Volume Option(Volume3D) }
GreasePencilComponent GeometryComponent & { Type "GreasePencil", GreasePencil Option(GreasePencil) }

InstanceReferenceType "None" | "Object" | "Collection" | "GeometrySet"

InstanceReference {
  Type        InstanceReferenceType
  Object      Option(Object3D)
  Collection  Option(Collection3D)
  GeometrySet Option(GeometrySet)
}

Instances {
  References       List(InstanceReference)
  ReferenceHandles List(Int)
  Transforms       List(Float4x4)
  InstancesNum     Int
  Attributes       AttributeStorage
}

GeometrySet {
  Name       String
  Components Map(GeometryComponentType, GeometryComponent)
  Bundle     Option(Any)
}

#
3. Geometry Entities: Mesh, BMesh, Subdiv, Curves, PointCloud, Volume, GPencil
#

bDeformWeight { DefNr Int, Weight Float }
MDeformVert   { Dw List(bDeformWeight), Flag Int }
bDeformGroup  { Name String, Flag Int }

KeyBlock {
  Name      String
  Curval    Float
  Type      Int
  Relative  Int
  Flag      Int
  TotElem   Int
  Uid       Int
  Data      List(Float3)
  Vgroup    String
  Slidermin Float
  Slidermax Float
}

Key ID & {
  Type     "KE"
  TypeMode Int
  ElemSize Int
  Refkey   Option(KeyBlock)
  Block    List(KeyBlock)
  From     Option(ID)
  Totkey   Int
  Flag     Int
  Ctime    Float
  UidGen   Int
}

BMHeader { Index Int, Htype Int, Hflag Int }
BMVert   { Head BMHeader, Co Float3, No Float3, Edge Option(BMEdge) }
BMEdge   { Head BMHeader, V1 BMVert, V2 BMVert, Loop Option(BMLoop) }
BMLoop   { Head BMHeader, V BMVert, E BMEdge, F BMFace, Next BMLoop, Prev BMLoop, RadialNext BMLoop, RadialPrev BMLoop }
BMFace   { Head BMHeader, LFirst BMLoop, Len Int, No Float3, MatNr Int }
BMElem   BMVert | BMEdge | BMLoop | BMFace

BMesh {
  Totvert    Int
  Totedge    Int
  Totloop    Int
  Totface    Int
  Selectmode Int
  Verts      List(BMVert)
  Edges      List(BMEdge)
  Faces      List(BMFace)
  ActiveFace Option(BMFace)
}

SubdivVtxBoundaryInterpolation "None" | "EdgeOnly" | "EdgeAndCorner"
SubdivFVarLinearInterpolation  "None" | "CornersOnly" | "CornersPlus1" | "CornersPlus2" | "Boundaries" | "All"

SubdivSettings {
  IsSimple                 Bool
  IsAdaptive               Bool
  Level                    Int
  UseCreases               Bool
  VtxBoundaryInterpolation SubdivVtxBoundaryInterpolation
  FvarLinearInterpolation  SubdivFVarLinearInterpolation
}

SubdivCCG {
  Level         Int
  GridSize      Int
  GridArea      Int
  GridsNum      Int
  Positions     List(Float3)
  Normals       List(Float3)
  Masks         List(Float)
  Faces         OffsetIndices
  GridToFaceMap List(Int)
}

Mesh3D ID & {
  Type             "ME"
  VertsNum         Int
  EdgesNum         Int
  FacesNum         Int
  CornersNum       Int
  FaceOffsets      List(Int)
  Attributes       AttributeStorage
  Materials        List(Material3D)
  Key              Option(Key)
  SubdivCcg        Option(SubdivCCG)
  TexspaceLocation Float3
  TexspaceSize     Float3
  Symmetry         Int
  RemeshVoxelSize  Float
  RemeshVoxelAdapt Float
  RemeshMode       Int
}

CurveType  "CatmullRom" | "Poly" | "Bezier" | "Nurbs"
HandleType "Free" | "Auto" | "Vector" | "Align"
NormalMode "MinimumTwist" | "ZUp" | "Free"
KnotsMode  "Normal" | "EndPoint" | "Bezier" | "Custom"

CurvesGeometry {
  PointsNum          Int
  CurvesNum          Int
  CurveOffsets       List(Int)
  CustomKnots        List(Float)
  Attributes         AttributeStorage
  TypeCounts         (Int, Int, Int, Int)
  EvaluatedPositions Option(List(Float3))
  EvaluatedTangents  Option(List(Float3))
  EvaluatedNormals   Option(List(Float3))
  EvaluatedLengths   Option(List(Float))
  Bounds             Option(Bounds(Float3))
}

Curves ID & {
  Type            "CV"
  Geometry        CurvesGeometry
  Materials       List(Material3D)
  Surface         Option(Object3D)
  SurfaceUvMap    String
  Symmetry        Int
  SelectionDomain AttrDomain
  Flag            Int
}

PointCloud ID & {
  Type       "PT"
  Totpoint   Int
  Attributes AttributeStorage
  Materials  List(Material3D)
  Flag       Int
}

VolumeGridType "Unknown" | "Boolean" | "Float" | "Double" | "Int" | "Int64" | "Vec3f" | "Vec3d" | "Vec3i" | "Mask" | "Points"

VolumeGridData {
  Name             String
  GridType         VolumeGridType
  IsLoaded         Bool
  ActiveVoxels     Int
  ActiveLeafVoxels Int
  ActiveTiles      Int
  SizeInBytes      Int
  ActiveBounds     Bounds(Int3)
  Transform        Float4x4
  ErrorMessage     String
}

Volume3D ID & {
  Type          "VO"
  Filepath      String
  PackedFile    Option(PackedFile)
  IsSequence    Bool
  SequenceMode  Int
  FrameStart    Int
  FrameDuration Int
  FrameOffset   Int
  Flag          Int
  ActiveGrid    Int
  Materials     List(Material3D)
  Grids         List(VolumeGridData)
  VelocityGrid  String
  VelocityUnit  Int
  VelocityScale Float
}

GreasePencilDrawing {
  Strokes           CurvesGeometry
  CurvePlaneNormals List(Float3)
  TextureMatrices   List(Float4x2)
  UserCount         Int
}

GreasePencilFrame {
  DrawingIndex Int
  Flag         Int
  Type         BezTripleKeyframeType
}

GreasePencilLayerMask {
  LayerName String
  Flag      Int
}

GreasePencilTreeNode {
  Name   String
  Flag   Int
  Color  Float3
  Parent Option(GreasePencilLayerGroup)
}

GreasePencilLayer GreasePencilTreeNode & {
  Frames        Map(Int, GreasePencilFrame)
  BlendMode     Int
  Opacity       Float
  ParentObject  Option(Object3D)
  Parsubstr     String
  ParentInverse Float4x4
  Translation   Float3
  Rotation      Float3
  Scale         Float3
  ViewLayerName String
  Masks         List(GreasePencilLayerMask)
}

GreasePencilLayerGroup GreasePencilTreeNode & {
  Children   List(GreasePencilTreeNode)
  ColorTag   Int
  IsExpanded Bool
}

GreasePencil ID & {
  Type                 "GP"
  Drawings             List(GreasePencilDrawing)
  RootGroup            GreasePencilLayerGroup
  ActiveNode           Option(GreasePencilTreeNode)
  Materials            List(Material3D)
  VertexGroupNames     List(bDeformGroup)
  VertexGroupActiveIdx Int
  Flag                 Int
}

#
4. Animation, Rigging, Armature, Pose, F-Curves, Drivers & NLA
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
  Flag      Int
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

#
5. Objects, Modifiers, Physics (Cloth, Fluid, RigidBody, XPBD) & Scenes
#

ObjectType
  "Empty" | "Mesh" | "CurveLegacy" | "Surf" | "Font" | "MBall" | "Lamp"
  | "Camera" | "Lattice" | "Armature" | "Speaker" | "Lightprobe"
  | "GpencilLegacy" | "Curves" | "Pointcloud" | "Volume" | "GreasePencil"

ObjectMode
  "Object" | "Edit" | "Sculpt" | "VertexPaint" | "WeightPaint" | "TexturePaint"
  | "ParticleEdit" | "Pose" | "SculptCurves" | "PaintGreasePencil"
  | "SculptGreasePencil" | "WeightGreasePencil" | "VertexGreasePencil"

ModifierType
  "None" | "Subsurf" | "Lattice" | "Curve" | "Build" | "Mirror" | "Decimate"
  | "Wave" | "Armature" | "Hook" | "Softbody" | "Boolean" | "Array" | "EdgeSplit"
  | "Displace" | "UVProject" | "Smooth" | "Cast" | "MeshDeform" | "ParticleSystem"
  | "ParticleInstance" | "Explode" | "Cloth" | "Collision" | "Bevel" | "Shrinkwrap"
  | "Mask" | "SimpleDeform" | "Multires" | "Surface" | "Fluid" | "ShapeKey"
  | "Solidify" | "Screw" | "Warp" | "WeightVGEdit" | "WeightVGMix" | "WeightVGProximity"
  | "Ocean" | "DynamicPaint" | "Remesh" | "Skin" | "LaplacianSmooth" | "Triangulate"
  | "UVWarp" | "MeshCache" | "LaplacianDeform" | "Wireframe" | "DataTransfer"
  | "NormalEdit" | "CorrectiveSmooth" | "MeshSequenceCache" | "SurfaceDeform"
  | "WeightedNormal" | "Weld" | "Nodes" | "MeshToVolume" | "VolumeDisplace" | "VolumeToMesh"

ModifierData {
  Name          String
  Type          ModifierType
  Mode          Int
  Flag          Int
  PersistentUid Int
  SessionUid    SessionUID
  ExecutionTime Float
  Error         Option(String)
}

NodesModifierData ModifierData & {
  Type          "Nodes"
  NodeGroup     Option(bNodeTree)
  Settings      Option(IDProperty)
  BakeDirectory String
  BakeTarget    Int
  Flag          Int
}

// Physics: Cloth, Fluid, RigidBody & XPBD
ClothVertex {
  Flags        Int
  V            Float3
  X            Float3
  Xold         Float3
  Mass         Float
  Goal         Float
  Impulse      Float3
  StructStiff  Float
  BendStiff    Float
  ShearStiff   Float
  ShrinkFactor Float
}

ClothSpring {
  Ij           Int
  Kl           Int
  Restlen      Float
  Type         Int
  Flags        Int
  LinStiffness Float
  AngStiffness Float
}

Cloth {
  Verts       List(ClothVertex)
  Springs     List(ClothSpring)
  Numsprings  Int
  MvertNum    Int
  Bvhtree     Option(BVHTree)
  Bvhselftree Option(BVHTree)
}

FluidDomainType   "Gas" | "Liquid"
FluidFlowType     "Smoke" | "Fire" | "SmokeFire" | "Liquid"
FluidFlowBehavior "Inflow" | "Outflow" | "Geometry"

FluidDomainSettings {
  Type            FluidDomainType
  Res             Int3
  ResMin          Int3
  ResMax          Int3
  BaseRes         Int3
  CellSize        Float3
  GlobalSize      Float3
  CacheFrameStart Int
  CacheFrameEnd   Int
  Flags           Int
}

RigidBodyObType  "Active" | "Passive"
RigidBodyConType "Fixed" | "Point" | "Hinge" | "Slider" | "Piston" | "Generic" | "GenericSpring" | "Motor"

RigidBodyOb {
  Type        RigidBodyObType
  Shape       Int
  Flag        Int
  ColGroups   Int
  Mass        Float
  Friction    Float
  Restitution Float
  Margin      Float
  LinDamp     Float
  AngDamp     Float
  Orn         Quaternion
  Pos         Float3
}

RigidBodyCon {
  Type                RigidBodyConType
  Flag                Int
  Ob1                 Option(Object3D)
  Ob2                 Option(Object3D)
  BreakingThreshold   Float
  NumSolverIterations Int
}

XPBDGeometryRef {
  Positions           List(Vec3f)
  Velocities          List(Vec3f)
  PrevPositions       List(Vec3f)
  InvMasses           List(Float)
  Rotations           List(Quat)
  AngularVelocities   List(Vec3f)
  PrevRotations       List(Quat)
  MomentsOfInertia    List(Vec3f)
  InvMomentsOfInertia List(Vec3f)
}

ParticleSettings ID & {
  Type     "PA"
  Flag     Int
  PartType Int
  Totpart  Int
  Sta      Float
  End      Float
  Lifetime Float
  Size     Float
  Mass     Float
}

Material3D ID & {
  Type                "MA"
  SurfaceRenderMethod Int
  BlendMethod         Int
  AlphaThreshold      Float
  R                   Float, G Float, B Float, A Float
  Metallic            Float
  Roughness           Float
  Nodetree            Option(bNodeTree)
  Flag                Int
}

LightType "Local" | "Sun" | "Spot" | "Area"

Light3D ID & {
  Type        "LA"
  LaType      LightType
  R           Float, G Float, B Float
  Energy      Float
  Spotsize    Float
  Spotblend   Float
  AreaSize    Float
  AreaSizey   Float
  SunAngle    Float
  Radius      Float
  Temperature Float
  Tint        Float3
  Nodetree    Option(bNodeTree)
}

Camera3D ID & {
  Type          "CA"
  CamType       Int
  ClipStart     Float
  ClipEnd       Float
  Lens          Float
  OrthoScale    Float
  SensorX       Float
  SensorY       Float
  Shiftx        Float
  Shifty        Float
  DofDistance   Float
  ApertureFstop Float
}

World3D ID & {
  Type     "WO"
  Horr     Float, Horg Float, Horb Float
  Exposure Float
  Nodetree Option(bNodeTree)
}

Object3D ID & {
  Type                "OB"
  ObType              ObjectType
  Mode                ObjectMode
  Data                Option(ID)
  Parent              Option(Object3D)
  Obmat               Float4x4
  Loc                 Float3
  Scale               Float3
  Rot                 Float3
  Quat                Quaternion
  RotAxis             Float3
  RotAngle            Float
  Rotmode             Int
  Materials           List(Option(Material3D))
  Color               Color4f
  Defbase             List(bDeformGroup)
  Modifiers           List(ModifierData)
  Constraints         List(bConstraint)
  Pose                Option(bPose)
  RigidBodyObject     Option(RigidBodyOb)
  RigidBodyConstraint Option(RigidBodyCon)
}

CollectionObject { Ob Object3D }
CollectionChild  { Collection Collection3D }

Collection3D ID & {
  Type           "GR"
  Gobject        List(CollectionObject)
  Children       List(CollectionChild)
  InstanceOffset Float3
  Flag           Int
  ColorTag       Int
}

ViewLayer {
  Name             String
  Flag             Int
  PassFlag         Int
  Samples          Int
  MaterialOverride Option(Material3D)
  WorldOverride    Option(World3D)
}

Scene3D ID & {
  Type             "SCE"
  Camera           Option(Object3D)
  World            Option(World3D)
  MasterCollection Collection3D
  ViewLayers       List(ViewLayer)
  CursorLocation   Float3
  CursorRotation   Quaternion
  R                RenderData
  ViewSettings     ColorManagedViewSettings
  DisplaySettings  ColorManagedDisplaySettings
  Nodetree         Option(bNodeTree)
  Flag             Int
  UseNodes         Bool
}

Depsgraph {
  Bmain              Main
  InputScene         Scene3D
  InputViewLayer     ViewLayer
  EvaluatedScene     Scene3D
  EvaluatedViewLayer ViewLayer
  Mode               EvaluationMode
  Ctime              Float
  IsFullyEvaluated   Bool
}

#
6. Node System, Sculpt PBVH & Window Manager (WM / Screen / Editors)
#

NodeSocketDatatype
  "Custom" | "Value" | "Int" | "Boolean" | "Vector" | "RGBA" | "Shader"
  | "String" | "Object" | "Image" | "Geometry" | "Collection" | "Texture"
  | "Material" | "Rotation" | "Menu" | "Matrix" | "Bundle" | "Closure"

NodeSocketInOut "Input" | "Output"

bNodeSocket {
  Identifier   String
  Name         String
  Label        String
  Description  String
  Idname       String
  Type         NodeSocketDatatype
  InOut        NodeSocketInOut
  Flag         Int
  DefaultValue Any
  Location     Float2
}

bNodeLink {
  FromNode         Option(bNode)
  ToNode           Option(bNode)
  FromSock         Option(bNodeSocket)
  ToSock           Option(bNodeSocket)
  Flag             Int
  MultiInputSortId Int
}

bNode {
  Name       String
  Label      String
  Idname     String
  Identifier Int
  Flag       Int
  Color      Float3
  Locx       Float, Locy Float
  Width      Float, Height Float
  Parent     Option(bNode)
  Id         Option(ID)
  Storage    Any
  Inputs     List(bNodeSocket)
  Outputs    List(bNodeSocket)
}

bNodeTree ID & {
  Type              "NT"
  Idname            String
  TreeType          Int
  Flag              Int
  Nodes             List(bNode)
  Links             List(bNodeLink)
  ViewCenter        Float2
  ActiveOutputIndex Int
  ColorTag          Int
  Description       String
}

// Sculpt & PBVH
PBVHType "Mesh" | "Grids" | "BMesh"

PBVHNode {
  Parent         Int
  Bounds         Bounds(Float3)
  BoundsOrig     Bounds(Float3)
  ChildrenOffset Int
  Flag           Int
}

PBVHTree {
  TreeType        PBVHType
  PrimIndices     List(Int)
  BoundsDirty     List(Bool)
  NormalsDirty    List(Bool)
  VisibilityDirty List(Bool)
  Nodes           List(PBVHNode)
}

Brush ID & {
  Type            "BR"
  Curve           Option(CurveMapping)
  Blend           Int
  Weight          Float
  Size            Int
  Alpha           Float
  Hardness        Float
  Rgb             Float3
  SecondaryRgb    Float3
  SculptBrushType Int
}

// Window Manager & Editor Spaces
SpaceTypeID  "Empty" | "View3D" | "Graph" | "Outliner" | "Properties" | "File" | "Image" | "Info" | "Sequence" | "Text" | "Action" | "Nla" | "Script" | "Node" | "Console" | "UserPref" | "Clip" | "Topbar" | "Statusbar" | "Spreadsheet" | "Project"
RegionTypeID "Window" | "Header" | "Channels" | "Temporary" | "UI" | "Tools" | "ToolProps" | "Preview" | "Hud" | "NavigationBar" | "Execute" | "Footer" | "ToolHeader" | "Xr" | "AssetShelf"

wmOperatorStatus "RunningModal" | "Cancelled" | "Finished" | "PassThrough" | "Interface"

wmOperatorType {
  Name        String
  Idname      String
  Description String
  UndoGroup   String
  Srna        Option(StructRNA)
  Flag        Int
}

wmOperator {
  Idname     String
  Properties Option(IDProperty)
  Type       Option(wmOperatorType)
  Customdata Any
  Ptr        Option(PointerRNA)
  Flag       Int
}

wmWindow {
  Winid         Int
  Scene         Option(Scene3D)
  ViewLayerName String
  Posx          Int, Posy Int
  Sizex         Int, Sizey Int
  Windowstate   Int
  Active        Int
}

wmWindowManager ID & {
  Type              "WM"
  Windows           List(wmWindow)
  Windrawable       Option(wmWindow)
  Winactive         Option(wmWindow)
  Operators         List(wmOperator)
  UndoStack         Option(UndoStack)
  IsInterfaceLocked Bool
}

#
7. Universal Scene Description (USD) & Procedural Content Generation (PCG)
#

PrimvarInterpolation "constant" | "uniform" | "vertex" | "faceVarying" | "varying"
UsdSpecifier         "def" | "over" | "class"
UsdModelKind         "group" | "assembly" | "component" | "subcomponent"

TimeSamplesIn  { Kind "TimeSamples", Samples Map(Float, Any), Interpolation String }
AttributeIn    { Kind "Attribute", Name String, ShapeName String, Value Any, TimeSamples Option(IdRef(TimeSamplesIn)) }
PrimvarIn      { Kind "Primvar", Name String, ShapeName String, Interpolation PrimvarInterpolation, ElementSize Int, Indices List(Int), Value Any }
RelationshipIn { Kind "Relationship", Name String, Targets List(String) }
PropertyIn     AttributeIn | PrimvarIn | RelationshipIn

SublayerArcIn    { Kind "SublayerArc", LayerRef IdRef(LayerIn), LayerPosition Int }
InheritArcIn     { Kind "InheritArc", TargetPath String }
VariantSetIn     { Kind "VariantSet", Name String, SelectedVariant String, Variants Map(String, IdRef(PrimIn)) }
ReferenceArcIn   { Kind "ReferenceArc", AssetPath String, TargetPrim String, LayerOffsetTime Float, LayerScaleTime Float }
PayloadArcIn     { Kind "PayloadArc", AssetPath String, TargetPrim String, IsLoaded Bool }
SpecializeArcIn  { Kind "SpecializeArc", TargetPath String }
CompositionArcIn SublayerArcIn | InheritArcIn | VariantSetIn | ReferenceArcIn | PayloadArcIn | SpecializeArcIn

PrimIn {
  Kind            "Prim"
  Name            String
  Specifier       UsdSpecifier
  ShapeName       String
  ModelKind       UsdModelKind
  Active          Bool
  Visibility      String
  Children        List(IdRef(PrimIn))
  Properties      List(IdRef(PropertyIn))
  CompositionArcs List(IdRef(CompositionArcIn))
}

InstanceablePrimIn PrimIn & { IsInstance Bool, MasterPrimPath String }

PointInstancerIn PrimIn & {
  Prototypes   List(IdRef(PrimIn))
  ProtoIndices List(Int)
  Positions    List(VectorFloat3)
  Orientations List(Quaternion)
  Scales       List(VectorFloat3)
}

LayerIn {
  Kind        "Layer"
  Identifier  String
  SubLayers   List(IdRef(LayerIn))
  DefaultPrim String
  IsAnonymous Bool
}

StageIn {
  Kind               "Stage"
  RootLayer          IdRef(LayerIn)
  SessionLayer       IdRef(LayerIn)
  DefaultPrim        IdRef(PrimIn)
  TimeCodesPerSecond Float
  FramesPerSecond    Float
}

// PCG (Procedural Content Generation)
PcgPinDirection     "In" | "Out"
PcgDataType         "Point" | "Surface" | "Spline" | "Volume" | "Mesh" | "Attribute"
SpatialSetOperation "Union" | "Intersection" | "Difference"

PcgPin {
  PinName           String
  Direction         PcgPinDirection
  AllowedTypes      List(PcgDataType)
  IsMultiConnection Bool
}

PcgEdge {
  FromNodeId  String
  FromPinName String
  ToNodeId    String
  ToPinName   String
}

PcgPoint {
  Transform  Transform3d
  Density    Float
  Steepness  Float
  BoundsMin  VectorFloat3
  BoundsMax  VectorFloat3
  Seed       Int
  Color      RgbaColorFloat
  Attributes Map(String, Any)
}

IPcgNode {
  Name               String
  Inputs             List(PcgPin)
  Outputs            List(PcgPin)
  Enabled            Bool
  DebugVisualization Bool
}

SurfaceSamplerNode IPcgNode & {
  Kind                  "SurfaceSampler"
  SamplingMethod        String
  PointsPerSquaredMeter Float
  PointExtents          VectorFloat3
  Looseness             Float
}

SplineSamplerNode IPcgNode & {
  Kind              "SplineSampler"
  SampleDistance    Float
  SubdivisionMethod String
  FillInteriorSpace Bool
}

NoiseFieldNode IPcgNode & {
  Kind                "NoiseField"
  NoiseType           String
  Frequency           Float
  Octaves             Int
  Lacunarity          Float
  TargetAttributeName String
}

TransformPointsNode IPcgNode & {
  Kind         "TransformPoints"
  OffsetMin    VectorFloat3
  OffsetMax    VectorFloat3
  RotationMin  VectorFloat3
  RotationMax  VectorFloat3
  UniformScale Bool
  ScaleMin     VectorFloat3
  ScaleMax     VectorFloat3
}

WaveFunctionCollapseNode IPcgNode & {
  Kind                  "WaveFunctionCollapse"
  GridSize              VectorInt3
  TileSize              VectorFloat3
  AdjacencyRuleSetAsset String
  PeriodicWrap          Bool
}

LSystemGrammarNode IPcgNode & {
  Kind       "LSystemGrammar"
  Axiom      String
  Rules      Map(String, String)
  Iterations Int
  AngleStep  Float
  StepLength Float
}

MeshSpawnEntry {
  MeshAssetPath   String
  Weight          Float
  ScaleAdjustment VectorFloat3
  CollisionPreset String
}

StaticMeshSpawnerNode IPcgNode & {
  Kind                 "StaticMeshSpawner"
  MeshEntries          List(MeshSpawnEntry)
  InstancingStrategy   String
  ApplyColorToMaterial Bool
  CastShadows          Bool
}

PcgGraph {
  Nodes             List(IdRef(IPcgNode))
  Edges             List(PcgEdge)
  ExposedParameters Map(String, Any)
}

#
8. 3D I/O Export & Import Formats (Alembic, FBX, OBJ, PLY, STL, glTF, USD)
#

PathReferenceMode "Auto" | "Absolute" | "Relative" | "Match" | "Strip" | "Copy"

IOBaseParams {
  Filepath    String
  ForwardAxis AxisSigned
  UpAxis      AxisSigned
  GlobalScale Float
}

AlembicExportParams IOBaseParams & {
  FrameStart      Float
  FrameEnd        Float
  SelectedOnly    Bool
  ExportUvs       Bool
  ExportNormals   Bool
  ExportVColors   Bool
  ApplySubdiv     Bool
  CurvesAsMesh    Bool
  ExportHair      Bool
  ExportParticles Bool
  EvaluationMode  EvaluationMode
}

FBXImportParams IOBaseParams & {
  VertexColors      "None" | "sRGB" | "Linear"
  ValidateMeshes    Bool
  UseCustomNormals  Bool
  ImportSubdivision Bool
  UseCustomProps    Bool
  IgnoreLeafBones   Bool
  UseAnim           Bool
  AnimOffset        Float
}

OBJExportParams IOBaseParams & {
  ExportAnimation        Bool
  StartFrame             Int
  EndFrame               Int
  ExportSelectedObjects  Bool
  ApplyModifiers         Bool
  ExportEvalMode         EvaluationMode
  ExportUv               Bool
  ExportNormals          Bool
  ExportColors           Bool
  ExportMaterials        Bool
  ExportTriangulatedMesh Bool
  ExportCurvesAsNurbs    Bool
  PathMode               PathReferenceMode
}

GLTFExportParams IOBaseParams & {
  Format             "GLB" | "GLTF_SEPARATE" | "GLTF_EMBEDDED"
  ExportDraco        Bool
  DracoCompression   Int
  ExportAnimations   Bool
  ExportMorphTargets Bool
  ExportSkins        Bool
  ExportLights       Bool
  ExportCameras      Bool
}

#
9. Ontological Typestates & 3D Domain Transitions
#

Evaluated       { EvalTimestamp Float }
DepsgraphSynced { SyncCount Int }
Baked           { BakeDir String, BakedFrameRange Int2 }
LibOverridden   { ReferenceUid SessionUID }
InEditMode      { ActiveTool String }

InvalidTopology   { Reason String }
MissingDependency { MissingIdName String }

ValidateMeshTopology(M Mesh3D) [
  VertsNum . {
    [ _ >= 0 ] [ M & Evaluated { EvalTimestamp 1.0 } ]
    _          [ InvalidTopology { Reason "Negative vertex count" } ]
  }
]

CreateMain(Path String) [
  Main {
    Filepath          Path
    VersionFile       400
    SubversionFile    0
    MinVersionFile    400
    MinSubversionFile 0
    IsGlobalMain      true
  }
]

CreateObject3D(NameStr String, Kind ObjectType, DataBlock Option(ID)) [
  Object3D {
    Id     NameStr
    Name   NameStr
    Type   "OB"
    ObType Kind
    Mode   "Object"
    Data   DataBlock
    Scale  (1.0, 1.0, 1.0)
    Quat   Quaternion { W 1.0, X 0.0, Y 0.0, Z 0.0 }
    Users  1
  }
]

LinkObjectToCollection(Coll Collection3D, Ob Object3D) [
  Coll & {
    Gobject (Coll.Gobject + [CollectionObject { Ob Ob }])
  }
]

SetObjectMode(Ob Object3D, TargetMode ObjectMode) [
  TargetMode . {
    "Edit" [ Ob & InEditMode { ActiveTool "builtin.select_box" } & { Mode "Edit" } ]
    _      [ Ob & { Mode TargetMode } ]
  }
]
