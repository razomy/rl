_ thing
_ enumerations
_ intangible
_ math
_ gpu
_ system

// =============================================================================
// 1. Core Primitives, Math, Containers & Memory (BLI)
// =============================================================================

SessionUID { Value Int }
UUID       { Bytes List(Byte) }
SubFrame   { Frame Int, Subframe Float }

Int2   (Int, Int)
Int3   (Int, Int, Int)
Int4   (Int, Int, Int, Int)
Float2 (Float, Float)
Float3 (Float, Float, Float)
Float4 (Float, Float, Float, Float)

Float2x2 (Float2, Float2)
Float3x3 (Float3, Float3, Float3)
Float4x2 (Float2, Float2, Float2, Float2)
Float4x4 (Float4, Float4, Float4, Float4)

Rcti { Xmin Int, Xmax Int, Ymin Int, Ymax Int }
Rctf { Xmin Float, Xmax Float, Ymin Float, Ymax Float }

Bounds(T) {
  Min T
  Max T
}

Color4f { R Float, G Float, B Float, A Float }
Color4b { R Byte, G Byte, B Byte, A Byte }

AngleRadian    { Radian Float }
AngleCartesian { Cos Float, Sin Float }
Quaternion     { W Float, X Float, Y Float, Z Float }
AxisAngle      { Axis Float3, Angle AngleRadian }
EulerXYZ       { X Float, Y Float, Z Float }

DualQuaternion {
  Quat        Quaternion
  Trans       Quaternion
  Scale       Float4x4
  ScaleWeight Float
  QuatWeight  Float
}

Transform {
  X Float4
  Y Float4
  Z Float4
}

SpaceTransform {
  LocalToTarget Float4x4
  TargetToLocal Float4x4
}

OrderedEdge {
  VLow  Int
  VHigh Int
}

IndexRange {
  Start Int
  Size  Int
}

IndexMaskSegment {
  Offset      Int
  BaseIndices List(Int)
}

IndexMask {
  IndicesNum   Int
  SegmentsNum  Int
  Segments     List(IndexMaskSegment)
  BeginInSeg   Int
  EndInSeg     Int
}

OffsetIndices {
  Offsets List(Int)
}

GroupedSpan(T) {
  Offsets OffsetIndices
  Data    List(T)
}

ImplicitSharingInfo {
  StrongUsers Int
  WeakUsers   Int
  Version     Int
}

ImplicitSharingInfoAndData {
  SharingInfo Option(ImplicitSharingInfo)
  Data        Any
}

GPointer {
  Type Str
  Data Any
}

GSpan {
  Type Str
  Data Any
  Size Int
}

GArray  GSpan & { Capacity Int }
GVArray GSpan & { IsSingle Bool }

GList {
  CppType Str
  Data    Any
  Size    Int
}

ComputeContextHash { V1 Int, V2 Int }

ComputeContext {
  Parent     Option(ComputeContext)
  Hash       ComputeContextHash
  ParentsNum Int
}

BVHTreeAxisRange { Min Float, Max Float }
BVHTreeOverlap   { IndexA Int, IndexB Int }
BVHTreeNearest   { Index Int, Co Float3, No Float3, DistSq Float, Flags Int }
BVHTreeRay       { Origin Float3, Direction Float3, Radius Float }
BVHTreeRayHit    { Index Int, Co Float3, No Float3, Dist Float }

BVHTree {
  Epsilon  Float
  TreeType Int
  Len      Int
}

KDTreeNode(T) {
  Left  Int
  Right Int
  Co    T
  Index Int
  Dim   Int
}

KDTree(T) {
  Nodes        List(KDTreeNode(T))
  Root         Int
  MaxNodeIndex Int
  IsBalanced   Bool
}

Quadric {
  A2 Float, Ab Float, Ac Float, Ad Float
  B2 Float, Bc Float, Bd Float
  C2 Float, Cd Float
  D2 Float
}

VoronoiParams {
  Scale       Float
  Detail      Float
  Roughness   Float
  Lacunarity  Float
  Smoothness  Float
  Exponent    Float
  Randomness  Float
  MaxDistance Float
  Normalize   Bool
  Feature     Int
  Metric      Int
}

VoronoiOutput {
  Distance Float
  Color    Float3
  Position Float4
}

// =============================================================================
// 2. Core Data-Blocks (ID), Main Database, Library & Undo (BKE / BLO)
// =============================================================================

IDType "SCE" | "LI" | "OB" | "ME" | "CU_LEGACY" | "MB" | "MA" | "TE" | "IM" | "LT" | "LA" | "CA" | "KE" | "WO" | "SCR" | "VF" | "TXT" | "SPK" | "LP" | "SO" | "GR" | "AR" | "AC" | "NT" | "BR" | "PA" | "GD_LEGACY" | "WM" | "MC" | "MSK" | "LS" | "PAL" | "PC" | "CF" | "WS" | "CV" | "PT" | "VO" | "GP"

IDPropertyType "STRING" | "INT" | "FLOAT" | "ARRAY" | "GROUP" | "ID" | "DOUBLE" | "IDPARRAY" | "BOOLEAN" | "ENUM"

IDProperty {
  Name    Str
  Type    IDPropertyType
  Subtype Str
  Flag    Int
  Value   Any
  UiData  Option(Any)
}

IDRuntimeRemap {
  Status            Int
  SkippedRefcounted Int
  SkippedDirect     Int
  SkippedIndirect   Int
}

IDRuntime {
  SrcBlendModificationTime Int
  Remap                    IDRuntimeRemap
  Depsgraph                Option(Depsgraph)
}

IDOverrideLibraryPropertyOperation {
  Operation      Int
  Flag           Int
  SubitemRefName Option(Str)
  SubitemLocName Option(Str)
  SubitemRefIdx  Int
  SubitemLocIdx  Int
}

IDOverrideLibraryProperty {
  RnaPath    Str
  Operations List(IDOverrideLibraryPropertyOperation)
  Tag        Int
}

IDOverrideLibrary {
  Reference     Option(ID)
  Properties    List(IDOverrideLibraryProperty)
  HierarchyRoot Option(ID)
  Flag          Int
}

ID Identifiable & {
  Name              Str
  Type              IDType
  Flag              Int
  Tag               Int
  Users             Int
  SessionUid        SessionUID
  Library           Option(Library)
  LibraryWeakRef    Option(Str)
  OverrideLibrary   Option(IDOverrideLibrary)
  Properties        Option(IDProperty)
  SystemProperties  Option(IDProperty)
  AssetData         Option(AssetMetaData)
  Preview           Option(PreviewImage)
  AnimData          Option(AnimData)
  Runtime           IDRuntime
}

Library ID & {
  Filepath          Str
  FilepathAbs       Str
  Parent            Option(Library)
  PackedFile        Option(PackedFile)
  TempIndex         Int
  VersionFile       Int
  SubversionFile    Int
  ArchivedLibraries List(Library)
}

IDRemapType   "Remap" | "Cleanup"
IDRemapResult "SourceUnavailable" | "SourceNotMappable" | "SourceRemapped" | "SourceUnassigned"

IDRemapper {
  Mappings            Map(ID, ID)
  NeverNullUsers      Set(ID)
  AllowIdTypeMismatch Bool
}

BlendThumbnail {
  Width  Int
  Height Int
  Data   List(Byte)
}

MainColorspace {
  SceneLinearName          Str
  SceneLinearToXyz         Float3x3
  IsMissingOpencolorioConf Bool
  IsFailedOpencolorioConf  Bool
}

MainIDRelationsEntryItem {
  IdPointer  Option(ID)
  SessionUid Int
  UsageFlag  Int
}

MainIDRelationsEntry {
  FromIds    List(MainIDRelationsEntryItem)
  ToIds      List(MainIDRelationsEntryItem)
  SessionUid Int
  Tags       Int
}

MainIDRelations {
  RelationsFromPointers Map(Any, MainIDRelationsEntry)
  Flag                  Int
}

Main {
  Filepath                      Str
  VersionFile                   Int
  SubversionFile                Int
  MinVersionFile                Int
  MinSubversionFile             Int
  BuildCommitTimestamp          Int
  BuildHash                     Str
  HasForwardCompatibilityIssues Bool
  IsAssetEditFile               Bool
  Recovered                     Bool
  IsMemfileUndoWritten          Bool
  IsMemfileUndoFlushNeeded      Bool
  UseMemfileFullBarrier         Bool
  IsLockedForLinking            Bool
  IsReadInvalid                 Bool
  IsGlobalMain                  Bool
  IsActionSlotToIdMapDirty      Bool
  NeedPreviewRenderRestart      Bool
  IsUpdatingNodeTrees           Bool
  IsPartOfProject               Bool
  Thumb                         Option(BlendThumbnail)
  CurLib                        Option(Library)
  Colorspace                    MainColorspace
  Relations                     Option(MainIDRelations)
  Scenes                        List(Scene)
  Libraries                     List(Library)
  Objects                       List(Object)
  Meshes                        List(Mesh)
  CurvesLegacy                  List(Curve)
  Metaballs                     List(MetaBall)
  Materials                     List(Material)
  Textures                      List(Tex)
  Images                        List(Image)
  Lattices                      List(Lattice)
  Lights                        List(Light)
  Cameras                       List(Camera)
  Shapekeys                     List(Key)
  Worlds                        List(World)
  Screens                       List(bScreen)
  Fonts                         List(VFont)
  Texts                         List(Text)
  Speakers                      List(Speaker)
  Lightprobes                   List(LightProbe)
  Sounds                        List(bSound)
  Collections                   List(Collection)
  Armatures                     List(bArmature)
  Actions                       List(Action)
  Nodetrees                     List(bNodeTree)
  Brushes                       List(Brush)
  Particles                     List(ParticleSettings)
  Palettes                      List(Palette)
  Paintcurves                   List(PaintCurve)
  WindowManagers                List(wmWindowManager)
  GpencilsLegacy                List(bGPdata)
  GreasePencils                 List(GreasePencil)
  Movieclips                    List(MovieClip)
  Masks                         List(Mask)
  Linestyles                    List(FreestyleLineStyle)
  Cachefiles                    List(CacheFile)
  Workspaces                    List(WorkSpace)
  HairCurves                    List(Curves)
  Pointclouds                   List(PointCloud)
  Volumes                       List(Volume)
}

MainMergeReport {
  Reports              ReportList
  NumMergedIds         Int
  NumUnknownIds        Int
  NumRemappedIds       Int
  NumRemappedLibraries Int
}

PackedFileCompare "Equal" | "Differs" | "NoFile"
PackedFileStatus  "WriteOriginal" | "WriteLocal" | "UseLocal" | "UseOriginal" | "Keep" | "Remove" | "Ask"

PackedFile {
  Size        Int
  Seek        Int
  Data        Any
  SharingInfo Option(ImplicitSharingInfo)
}

BHeadType "BHead4" | "SmallBHead8" | "LargeBHead8"

BHead {
  Code   Int
  SdnaNr Int
  OldPtr Int
  Len    Int
  Nr     Int
}

BlenderHeader {
  PointerSize       Int
  Endian            Int
  FileVersion       Int
  FileFormatVersion Int
  HeaderType        BHeadType
}

MemFileChunk {
  Buf               List(Byte)
  Size              Int
  IsIdentical       Bool
  IsIdenticalFuture Bool
  IdSessionUid      Int
}

MemFile {
  Chunks        List(MemFileChunk)
  Size          Int
  SharedStorage Map(Int, ImplicitSharingInfoAndData)
}

MemFileUndoData {
  Filepath Str
  Memfile  MemFile
  UndoSize Int
}

BlendFileWritePathRemap "None" | "Relative" | "RelativeAll" | "Absolute"

BlendFileWriteParams {
  RemapMode        BlendFileWritePathRemap
  UseSaveVersions  Bool
  UseSaveAsCopy    Bool
  UseUserdef       Bool
  IsCopypasteBuf   Bool
  Thumb            Option(BlendThumbnail)
}

BlendWriter {
  Filepath Str
  IsUndo   Bool
}

BlendDataReader {
  FileVersion             Int
  IsUndo                  Bool
  SharedDataByStoredAddr  Map(Int, ImplicitSharingInfoAndData)
  CurrentLibrary          Option(Library)
  Reports                 Option(ReportList)
}

BlendLibReader {
  Main    Main
  IsUndo  Bool
  Reports Option(ReportList)
}

BlendfileLinkAppendContextItem {
  Name            Str
  Libraries       List(Bool)
  IdCode          IDType
  Action          Int
  Tag             Int
  NewId           Option(ID)
  SourceLibrary   Option(Library)
  LiboverrideId   Option(ID)
  ReusableLocalId Option(ID)
  Userdata        Any
}

BlendfileLinkAppendContextLibrary {
  Path             Str
  BloHandleIsOwned Bool
}

BlendfileLinkAppendContext {
  Libraries        List(BlendfileLinkAppendContextLibrary)
  Items            List(BlendfileLinkAppendContextItem)
  TargetCollection Option(Collection)
  ProcessStage     Int
}

UndoStepDir    "Undo" | "Redo"
UndoPushReturn "Success" | "Failed"

UndoRefID(T) {
  Ptr                Option(T)
  Name               Str
  LibraryFilepathAbs Str
}

UndoType {
  Identifier Str
  Flags      Int
  StepSize   Int
}

UndoStep {
  Name            Str
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

ReportType "Debug" | "Info" | "Operator" | "Property" | "Warning" | "Error" | "ErrorInvalidInput" | "ErrorInvalidContext" | "ErrorOutOfMemory"

Report {
  Type       ReportType
  Flag       Int
  Len        Int
  TypeStr    Str
  Message    Str
  SessionUid Int
}

ReportList {
  List       List(Report)
  PrintLevel ReportType
  StoreLevel ReportType
  Flag       Int
}

CallbackEvent "FrameChangePre" | "FrameChangePost" | "RenderPre" | "RenderPost" | "RenderWrite" | "RenderStats" | "RenderInit" | "RenderComplete" | "RenderCancel" | "LoadPre" | "LoadPost" | "LoadPostFail" | "SavePre" | "SavePost" | "SavePostFail" | "UndoPre" | "UndoPost" | "RedoPre" | "RedoPost" | "DepsgraphUpdatePre" | "DepsgraphUpdatePost" | "VersionUpdate" | "LoadFactoryUserdefPost" | "LoadFactoryStartupPost" | "XrSessionStartPre" | "AnnotationPre" | "AnnotationPost" | "ObjectBakePre" | "ObjectBakeComplete" | "ObjectBakeCancel" | "CompositePre" | "CompositePost" | "CompositeCancel" | "AnimationPlaybackPre" | "AnimationPlaybackPost" | "TranslationUpdatePost" | "ExtensionReposUpdatePre" | "ExtensionReposUpdatePost" | "ExtensionReposSync" | "ExtensionReposFilesClear" | "BlendimportPre" | "BlendimportPost" | "ExitPre"

ProjectVariableType          "String" | "Int" | "Float"
ProjectVariableStringSubtype "None" | "Filepath"

ProjectVariable {
  Name          Str
  Type          ProjectVariableType
  StringSubtype ProjectVariableStringSubtype
  Description   Str
  Prop          IDProperty
}

BlenderProject {
  Name                    Str
  RootPath                Str
  OcioConfigPath          Str
  SplashImagePath         Str
  Variables               List(ProjectVariable)
  ActiveVariableIndex     Int
  ActiveAssetLibraryIndex Int
  IsDirty                 Bool
  OcioConfigUsePath       Bool
}

RecentProject {
  Path Str
  Name Str
}

UserAssetLibraryOwner "User" | "Project" | "Extension"

bUserAssetLibrary {
  Name       Str
  Dirpath    Str
  RemoteUrl  Str
  AuthToken  Str
  ImportMode AssetImportMethod
  Owner      UserAssetLibraryOwner
  Uuid       UUID
  Flag       Int
}

bUserExtensionRepo {
  Name          Str
  Module        Str
  CustomDirpath Str
  RemoteUrl     Str
  Flag          Int
}

bUserAssetShelfSettings {
  ShelfIdname         Str
  EnabledCatalogPaths List(Str)
}

bAddon {
  Module Str
  Properties Option(IDProperty)
}

bUserMenuItem {
  UiName Str
  Type   Int
}

bUserMenu {
  SpaceType Int
  Context   Str
  Items     List(bUserMenuItem)
}

bTheme {
  Name Str
}

UserDef {
  Themes             List(bTheme)
  UiStyles           List(uiStyle)
  Addons             List(bAddon)
  AssetLibraries     List(bUserAssetLibrary)
  ExtensionRepos     List(bUserExtensionRepo)
  AssetShelfSettings List(bUserAssetShelfSettings)
  UserMenus          List(bUserMenu)
  Dpi                Float
  UiScale            Float
}

// =============================================================================
// 3. Attributes, Fields, Bake & Geometry Set (BKE)
// =============================================================================

AttrStorageType "Array" | "Single"
AttrType        "Bool" | "Int8" | "Int16_2D" | "Int32" | "Int32_2D" | "Float" | "Float2" | "Float3" | "Float4" | "Float4x4" | "ColorByte" | "ColorFloat" | "Quaternion" | "String"
AttrDomain      "Point" | "Edge" | "Face" | "Corner" | "Curve" | "Instance" | "Layer"
AttrDomainMask  Int

AttributeOwnerType "Mesh" | "PointCloud" | "Curves" | "GreasePencil" | "GreasePencilDrawing"

AttributeOwner {
  Type AttributeOwnerType
  Ptr  Any
}

AttributeMetaData {
  Domain   AttrDomain
  DataType AttrType
}

Attribute {
  Name        Str
  Domain      AttrDomain
  DataType    AttrType
  StorageType AttrStorageType
  Data        GList
}

AttributeStorage {
  Attributes List(Attribute)
}

AttributeReader(T) {
  Varray      List(T)
  Domain      AttrDomain
  SharingInfo Option(ImplicitSharingInfo)
}

AttributeWriter(T) {
  Varray     List(T)
  Domain     AttrDomain
  IsModified Bool
}

AttributeAccessor {
  Owner      Any
  Attributes AttributeStorage
}

MutableAttributeAccessor AttributeAccessor & {
  IsMutable true
}

AttributeTransferData {
  Name     Str
  MetaData AttributeMetaData
  Src      GSpan
  Dst      GSpan
}

GeometryOwnershipType "Owned" | "Editable" | "ReadOnly"
GeometryComponentType "Mesh" | "PointCloud" | "Curve" | "Instance" | "Volume" | "Edit" | "GreasePencil"

GeometryComponent {
  Type       GeometryComponentType
  Ownership  GeometryOwnershipType
  Attributes AttributeStorage
}

MeshComponent         GeometryComponent & { Type "Mesh", Mesh Option(Mesh) }
PointCloudComponent   GeometryComponent & { Type "PointCloud", PointCloud Option(PointCloud) }
CurveComponent        GeometryComponent & { Type "Curve", Curves Option(Curves), CurveForRender Option(Curve) }
InstancesComponent    GeometryComponent & { Type "Instance", Instances Option(Instances) }
VolumeComponent       GeometryComponent & { Type "Volume", Volume Option(Volume) }
GreasePencilComponent GeometryComponent & { Type "GreasePencil", GreasePencil Option(GreasePencil) }

CurvesEditHints {
  CurvesIdOrig  Curves
  PositionsData ImplicitSharingInfoAndData
  DeformMats    Option(List(Float3x3))
}

GreasePencilDrawingEditHints {
  DrawingOrig   GreasePencilDrawing
  PositionsData ImplicitSharingInfoAndData
  DeformMats    Option(List(Float3x3))
  Positions     Option(List(Float3))
}

GreasePencilEditHints {
  GreasePencilIdOrig GreasePencil
  DrawingHints       Option(List(GreasePencilDrawingEditHints))
}

MeshEditHints {
  MeshDeform Option(MeshComponent)
  MeshCage   Option(MeshComponent)
}

NodeGizmoID {
  ContextHash ComputeContextHash
  NodeId      Int
}

GizmoEditHints {
  GizmoTransforms Map(NodeGizmoID, Float4x4)
}

GeometryComponentEditData GeometryComponent & {
  Type                  "Edit"
  CurvesEditHints       Option(CurvesEditHints)
  GreasePencilEditHints Option(GreasePencilEditHints)
  GizmoEditHints        Option(GizmoEditHints)
  MeshEditHints         Option(MeshEditHints)
}

GeometrySet {
  Name       Str
  Components Map(GeometryComponentType, GeometryComponent)
  Bundle     Option(Any)
}

InstanceReferenceType "None" | "Object" | "Collection" | "GeometrySet"

InstanceReference {
  Type        InstanceReferenceType
  Object      Option(Object)
  Collection  Option(Collection)
  GeometrySet Option(GeometrySet)
}

Instances {
  References       List(InstanceReference)
  ReferenceHandles List(Int)
  Transforms       List(Float4x4)
  InstancesNum     Int
  Attributes       AttributeStorage
}

FieldContextType "Mesh" | "Curves" | "PointCloud" | "GreasePencil" | "GreasePencilLayer" | "Instances" | "Geometry" | "Voxel" | "Tiles"

FieldContext {
  ContextType FieldContextType
  Domain      AttrDomain
}

MeshFieldContext              FieldContext & { ContextType "Mesh", Mesh Mesh }
CurvesFieldContext            FieldContext & { ContextType "Curves", Curves CurvesGeometry, CurvesId Option(Curves) }
PointCloudFieldContext        FieldContext & { ContextType "PointCloud", PointCloud PointCloud }
GreasePencilFieldContext      FieldContext & { ContextType "GreasePencil", GreasePencil GreasePencil }
GreasePencilLayerFieldContext FieldContext & { ContextType "GreasePencilLayer", GreasePencil GreasePencil, LayerIndex Int }
InstancesFieldContext         FieldContext & { ContextType "Instances", Instances Instances }

FieldInput {
  CppType  Str
  Category Str
}

AttributeFieldInput        FieldInput & { Name Str }
AttributeExistsFieldInput  FieldInput & { Name Str }
NamedLayerSelectionInput   FieldInput & { LayerName Str }
IDAttributeFieldInput      FieldInput
NormalFieldInput           FieldInput & { LegacyCornerNormals Bool, TrueNormals Bool }
CurveLengthFieldInput      FieldInput

BakeDataBlockID {
  Type    IDType
  IdName  Str
  LibName Str
}

BakeCacheStatus "Valid" | "Invalid" | "Baked"

BakePath {
  MetaDir  Str
  BlobsDir Str
  BakeDir  Option(Str)
}

BlobSlice {
  Name  Str
  Range IndexRange
}

BakeValuesItem {
  Name  Option(Str)
  Value SocketValueVariant
}

BakeValues {
  ValuesById Map(Int, BakeValuesItem)
}

FrameCache {
  Frame          SubFrame
  Values         BakeValues
  MetaDataSource Option(Str)
}

NodeBakeCache {
  Frames            List(FrameCache)
  BlobsDir          Option(Str)
  FailedFindingBake Bool
}

SimulationNodeCache {
  Bake        NodeBakeCache
  CacheStatus BakeCacheStatus
  PrevFrame   Option(SubFrame)
  PrevValues  Option(BakeValues)
}

ModifierCache {
  RequestedBakes      Set(Int)
  SimulationCacheById Map(Int, SimulationNodeCache)
  BakeCacheById       Map(Int, NodeBakeCache)
}

// =============================================================================
// 4. Animation, Rigging, NLA, Drivers & Actions (ANIM / BKE)
// =============================================================================

SlotHandle       { Value Int }
ActionStripType  "Keyframe"
ActionLayerFlags Int
ActionLayerMix   "Replace" | "Add" | "Subtract" | "Multiply"

Action ID & {
  Type              "AC"
  Layers            List(ActionLayer)
  Slots             List(ActionSlot)
  StripKeyframeData List(ActionStripKeyframeData)
  ActiveSlotHandle  SlotHandle
}

ActionLayer {
  Name    Str
  Flags   ActionLayerFlags
  MixMode ActionLayerMix
  Strips  List(ActionStrip)
}

ActionStrip {
  StripType   ActionStripType
  FrameStart  Float
  FrameEnd    Float
  FrameOffset Float
  DataIndex   Int
}

ActionSlot {
  Handle     SlotHandle
  IdType     IDType
  Identifier Str
  Flags      Int
}

ActionStripKeyframeData {
  Channelbags List(ActionChannelbag)
}

ActionChannelbag {
  SlotHandle    SlotHandle
  FCurves       List(FCurve)
  ChannelGroups List(bActionGroup)
}

BoneColor {
  PaletteIndex Int
  Regular      Color4b
  Select       Color4b
  Active       Color4b
  Flag         Int
}

bActionGroup {
  Name       Str
  Channels   List(FCurve)
  Color      BoneColor
  Flag       Int
  CustomCol  Int
}

BezTripleKeyframeType "Keyframe" | "Breakdown" | "MovingHold" | "Extreme" | "Jitter" | "Generated"
BezTripleHandle       "Free" | "Auto" | "Vect" | "Align" | "AutoClamp"
BezTripleInterp       "Constant" | "Linear" | "Bezier" | "Back" | "Bounce" | "Circ" | "Cubic" | "Elastic" | "Expo" | "Quad" | "Quart" | "Quint" | "Sine"

BezTriple {
  Vec      (Float3, Float3, Float3)
  Tilt     Float
  Weight   Float
  Radius   Float
  Ipo      BezTripleInterp
  H1       BezTripleHandle
  H2       BezTripleHandle
  F1       Int
  F2       Int
  F3       Int
  Hide     Bool
  KeyType  BezTripleKeyframeType
  Easing   Int
  Back     Float
  Amplitude Float
  Period   Float
}

FModifierType "Null" | "Generator" | "FnGenerator" | "Envelope" | "Cycles" | "Noise" | "Limits" | "Step"

FModifier {
  Name      Str
  Type      FModifierType
  Flag      Int
  Influence Float
  Start     Float
  End       Float
  BlendIn   Float
  BlendOut  Float
}

DriverVarType "SingleProp" | "RotDiff" | "LocDiff" | "TransformChannel" | "ContextProp"

DriverTarget {
  Id            Option(ID)
  IdType        IDType
  RnaPath       Str
  PchanName     Str
  TransChan     Int
  RotationMode  Int
  Flag          Int
  ContextProp   Int
  FallbackValue Float
}

DriverVar {
  Name       Str
  Type       DriverVarType
  NumTargets Int
  Targets    List(DriverTarget)
}

DriverType "Average" | "Sum" | "Scripted" | "Min" | "Max"

ChannelDriver {
  Variables  List(DriverVar)
  Expression Str
  Type       DriverType
  Influence  Float
  Curval     Float
  Flag       Int
}

FCurveCycleType "None" | "Perfect" | "Offset"

FCurve {
  RnaPath     Str
  ArrayIndex  Int
  Flag        Int
  Extend      Int
  AutoSmoothing Int
  ColorMode   Int
  Color       Float3
  Curval      Float
  Bezt        List(BezTriple)
  Driver      Option(ChannelDriver)
  Modifiers   List(FModifier)
  Group       Option(bActionGroup)
}

FCurveDescriptor {
  RnaPath    Str
  ArrayIndex Int
  PropType   Option(Int)
  PropSubType Option(Int)
  GroupName  Option(Str)
}

NlaStripType      "Clip" | "Transition" | "Meta" | "Sound"
NlaBlendMode      "Replace" | "Combine" | "Add" | "Subtract" | "Multiply"
NlaExtrapolate    "Hold" | "HoldForward" | "Nothing"
NlaTimeConvert    "EvalToStrip" | "StripToEval"

NlaStrip {
  Name           Str
  Type           NlaStripType
  BlendMode      NlaBlendMode
  Extrapolation  NlaExtrapolate
  Flag           Int
  Start          Float
  End            Float
  ActStart       Float
  ActEnd         Float
  Repeat         Float
  Scale          Float
  BlendIn        Float
  BlendOut       Float
  Influence      Float
  StripTime      Float
  Action         Option(Action)
  ActionSlotHandle SlotHandle
  ActionSlotIdent  Str
  Fcurves        List(FCurve)
  Modifiers      List(FModifier)
  Strips         List(NlaStrip)
  SpeakerHandle  Option(Any)
}

NlaTrack {
  Name   Str
  Index  Int
  Flag   Int
  Strips List(NlaStrip)
}

AnimDataMergeCopyMode "KeepDst" | "SrcCopy" | "SrcRef"

AnimData {
  Action             Option(Action)
  SlotHandle         SlotHandle
  LastSlotIdentifier Str
  TmpAction          Option(Action)
  TmpSlotHandle      SlotHandle
  TmpLastSlotIdent   Str
  Drivers            List(FCurve)
  NlaTracks          List(NlaTrack)
  ActTrack           Option(NlaTrack)
  ActStrip           Option(NlaStrip)
  ActBlendmode       NlaBlendMode
  ActExtendmode      NlaExtrapolate
  ActInfluence       Float
  Flag               Int
}

OwnedAnimData {
  OwnerId ID
  Adt     AnimData
}

AnimationEvalContext {
  Depsgraph Depsgraph
  EvalTime  Float
}

AnimationBasePathChange {
  SrcBasepath Str
  DstBasepath Str
}

SingleKeyingResult "Success" | "UnknownFailure" | "CannotCreateFcurve" | "FcurveNotKeyframeable" | "NoKeyNeeded" | "UnableToInsertToNlaStack" | "IdNotEditable" | "IdNotAnimatable" | "NoValidLayer" | "NoValidStrip" | "NoValidSlot" | "CannotResolvePath"

CombinedKeyingResult {
  ResultCounter Map(SingleKeyingResult, Int)
}

KeyingSetPath {
  Id         Option(ID)
  Group      Str
  RnaPath    Str
  ArrayIndex Int
  Flag       Int
  GroupMode  Int
}

KeyingSet {
  Idname      Str
  Name        Str
  Description Str
  TypeInfo    Str
  Paths       List(KeyingSetPath)
  ActivePath  Int
  Flag        Int
  KeyingFlag  Int
}

TimeMarker {
  Frame  Int
  Name   Str
  Flag   Int
  Camera Option(Object)
}

bMotionPathVert {
  Co   Float3
  Flag Int
}

bMotionPath {
  Points     List(bMotionPathVert)
  StartFrame Int
  EndFrame   Int
  Length     Int
  LineThickness Int
  Flag       Int
  Color      Float3
  ColorPost  Float3
}

bAnimVizSettings {
  Recalc      Int
  PathType    Int
  PathStep    Int
  PathRange   Int
  PathViewFlag Int
  PathBakeFlag Int
  PathStart   Int
  PathEnd     Int
  PathBefore  Int
  PathAfter   Int
}

Bone {
  Name          Str
  Parent        Option(Bone)
  Children      List(Bone)
  Roll          Float
  Head          Float3
  Tail          Float3
  BoneMat       Float3x3
  Flag          Int
  ArmHead       Float3
  ArmTail       Float3
  ArmMat        Float4x4
  ArmRoll       Float
  Dist          Float
  Weight        Float
  Xwidth        Float
  Length        Float
  Zwidth        Float
  RadHead       Float
  RadTail       Float
  Roll1         Float
  Roll2         Float
  CurveInX      Float
  CurveInZ      Float
  CurveOutX     Float
  CurveOutZ     Float
  Ease1         Float
  Ease2         Float
  ScaleIn       Float3
  ScaleOut      Float3
  Segments      Int
  Color         BoneColor
  InheritScale  Int
}

EditBone {
  Name          Str
  Parent        Option(EditBone)
  Roll          Float
  Head          Float3
  Tail          Float3
  Flag          Int
  Dist          Float
  Weight        Float
  Xwidth        Float
  Zwidth        Float
  RadHead       Float
  RadTail       Float
  Segments      Int
  Roll1         Float
  Roll2         Float
  CurveInX      Float
  CurveInZ      Float
  CurveOutX     Float
  CurveOutZ     Float
  Ease1         Float
  Ease2         Float
  ScaleIn       Float3
  ScaleOut      Float3
  Color         BoneColor
  Collections   List(BoneCollection)
}

MoveLocation "Before" | "After"

BoneCollection {
  Name        Str
  Bones       List(Bone)
  Flags       Int
  ChildIndex  Int
  ChildCount  Int
  ColorSet    Int
}

bArmature ID & {
  Type                  "AR"
  Bonebase              List(Bone)
  EditBones             Option(List(EditBone))
  ActiveBone            Option(Bone)
  ActiveEditBone        Option(EditBone)
  Collections           List(BoneCollection)
  ActiveCollectionIndex Int
  Drawtype              Int
  Flag                  Int
  AxesPosition          Float
}

bPoseChannelRuntime {
  SessionUid SessionUID
  BboneSegments Int
}

bPoseChannel {
  Name         Str
  Bone         Option(Bone)
  Parent       Option(bPoseChannel)
  Child        Option(bPoseChannel)
  Constraints  List(bConstraint)
  Loc          Float3
  Size         Float3
  Eul          Float3
  Quat         Quaternion
  RotAxis      Float3
  RotAngle     Float
  RotMode      Int
  ChanMat      Float4x4
  PoseMat      Float4x4
  ConstMatrix  Float4x4
  PoseHead     Float3
  PoseTail     Float3
  LimitMin     Float3
  LimitMax     Float3
  Stiffness    Float3
  IkStretch    Float
  IkRotWeight  Float
  IkLinWeight  Float
  Roll1        Float
  Roll2        Float
  CurveInX     Float
  CurveInZ     Float
  CurveOutX    Float
  CurveOutZ    Float
  Ease1        Float
  Ease2        Float
  ScaleIn      Float3
  ScaleOut     Float3
  Custom       Option(Object)
  CustomTx     Option(bPoseChannel)
  CustomScale  Float3
  CustomTranslation Float3
  CustomEuler  Float3
  MotionPath   Option(bMotionPath)
  Color        BoneColor
  Flag         Int
  Protectflag  Int
  AgrIndex     Int
  Runtime      bPoseChannelRuntime
}

bPose {
  Channels     List(bPoseChannel)
  ChanHash     Map(Str, bPoseChannel)
  ActionGroups List(bActionGroup)
  ActiveGroup  Int
  Flag         Int
  Ctime        Float
  StrideOffset Float3
  CyclicOffset Float3
  AnimViz      bAnimVizSettings
}

PoseBackup {
  IsSelectionRelevant Bool
  Channels            List(bPoseChannel)
}

ConstraintType "Null" | "ChildOf" | "TrackTo" | "Ik" | "FollowPath" | "RotLimit" | "LocLimit" | "SizeLimit" | "SameVol" | "RotLike" | "LocLike" | "SizeLike" | "Python" | "Action" | "LockTrack" | "DistLimit" | "StretchTo" | "MinMax" | "RigidBodyJoint" | "ClampTo" | "Transform" | "Shrinkwrap" | "DampTrack" | "SplineIk" | "Pivot" | "FollowTrack" | "CameraSolver" | "ObjectSolver" | "TransformCache" | "Armature" | "GeometryAttribute"

bConstraintTarget {
  Tar       Option(Object)
  Subtarget Str
  Matrix    Float4x4
  Space     Int
  Flag      Int
  Type      Int
  Weight    Float
}

bConstraint {
  Name       Str
  Type       ConstraintType
  Flag       Int
  OwnSpace   Int
  TarSpace   Int
  Enforce    Float
  Headtail   Float
  LinError   Float
  RotError   Float
  Data       Any
}

bConstraintOb {
  Depsgraph           Depsgraph
  Scene               Scene
  Ob                  Object
  Pchan               Option(bPoseChannel)
  PchanArmbone        Option(Bone)
  Matrix              Float4x4
  StartMat            Float4x4
  SpaceObjWorldMatrix Float4x4
  Type                Int
  RotOrder            Int
}

// =============================================================================
// 5. Asset System (ASSET / BKE)
// =============================================================================

AssetImportMethod      "Link" | "Append" | "AppendReuse" | "Pack"
AssetLibraryType       "CurrentFile" | "All" | "Essential" | "Custom" | "OnlineEssentials"
RemoteAssetFileStatus  "Unset" | "NotOnDisk" | "Match" | "NoMatch"

AssetTag {
  Name Str
}

AssetMetaData {
  LocalTypeInfo   Option(Any)
  Properties      Option(IDProperty)
  CatalogId       UUID
  CatalogSimpleName Str
  Author          Str
  Description     Str
  Copyright       Str
  License         Str
  Tags            List(AssetTag)
  ActiveTag       Int
}

AssetLibraryReference {
  Type              AssetLibraryType
  CustomLibraryIndex Int
}

AssetWeakReference {
  AssetLibraryType        AssetLibraryType
  CustomAssetLibraryId    Str
  RelativeAssetIdentifier Str
}

AssetCatalogPath {
  Path Str
}

AssetCatalogFlags {
  IsDeleted         Bool
  IsFirstLoaded     Bool
  HasUnsavedChanges Bool
}

AssetCatalog {
  CatalogId  UUID
  Path       AssetCatalogPath
  SimpleName Str
  Flags      AssetCatalogFlags
}

AssetCatalogFilter {
  MatchingCatalogIds Set(UUID)
  KnownCatalogIds    Set(UUID)
}

AssetCatalogTreeItem {
  Name              Str
  CatalogId         UUID
  SimpleName        Str
  HasUnsavedChanges Bool
  Parent            Option(AssetCatalogTreeItem)
  Children          Map(Str, AssetCatalogTreeItem)
}

AssetCatalogTree {
  RootItems Map(Str, AssetCatalogTreeItem)
}

AssetCatalogService {
  AssetLibraryRoot  Str
  IsReadOnly        Bool
  CatalogCollection Map(UUID, AssetCatalog)
  CatalogTree       AssetCatalogTree
  UndoSnapshots     List(Map(UUID, AssetCatalog))
  RedoSnapshots     List(Map(UUID, AssetCatalog))
}

URLWithHash {
  Url  Str
  Hash Str
}

OnlineAssetFile {
  Path        Str
  SizeInBytes Int
  Url         URLWithHash
}

OnlineAssetInfo {
  Files      List(OnlineAssetFile)
  PreviewUrl Option(URLWithHash)
}

ExternalAsset {
  Name             Str
  IdType           IDType
  Metadata         AssetMetaData
  Preview          Option(PreviewImage)
  RemoteFileStatus RemoteAssetFileStatus
  OnlineInfo       Option(OnlineAssetInfo)
}

AssetRepresentation {
  OwnerAssetLibrary  Option(AssetLibrary)
  RelativeIdentifier Str
  AssetVariant       ID | ExternalAsset
  UseRelativePath    Bool
}

AssetStorage {
  ExternalAssets List(AssetRepresentation)
  LocalIdAssets  List(AssetRepresentation)
}

AssetLibrary {
  LibraryType             AssetLibraryType
  Name                    Str
  RootPath                Str
  IsReadOnly              Bool
  MayOverrideImportMethod Bool
  AssetStorage            AssetStorage
  CatalogService          AssetCatalogService
}

RemoteLibraryDefinitionRef {
  RemoteUrl    Str
  CacheDirpath Str
  AuthToken    Option(Str)
}

RemoteLibraryStatus "Loading" | "Finished" | "Cancelled" | "Failure"

RemoteLibraryLoadingStatus {
  Timeout            Float
  Status             Option(RemoteLibraryStatus)
  FailureMessage     Option(Str)
  MetafilesInPlace   Bool
}

DiskFileHashService {
  StoragePath Str
}

// =============================================================================
// 6. Geometry Entities: Mesh, BMesh, Curves, PointCloud, Volume, GPencil, Lattice, MetaBall (BKE / BMesh)
// =============================================================================

CornerNormalSpace {
  VecLnor  Float3
  VecRef   Float3
  VecOrtho Float3
  RefAlpha Float
  RefBeta  Float
}

CornerNormalSpaceArray {
  Spaces             List(CornerNormalSpace)
  CornerSpaceIndices List(Int)
  CornersBySpace     List(List(Int))
}

MeshTopologyState {
  EdgeVerts         List(Int2)
  CornerVerts       List(Int)
  CornerEdges       List(Int)
  FaceOffsetIndices List(Int)
}

Mesh ID & {
  Type             "ME"
  VertsNum         Int
  EdgesNum         Int
  FacesNum         Int
  CornersNum       Int
  FaceOffsets      List(Int)
  Attributes       AttributeStorage
  Materials        List(Material)
  Key              Option(Key)
  EditMesh         Option(BMEditMesh)
  SubdivCcg        Option(SubdivCCG)
  Texflag          Int
  TexspaceLocation Float3
  TexspaceSize     Float3
  Symmetry         Int
  RemeshVoxelSize  Float
  RemeshVoxelAdapt Float
  RemeshMode       Int
}

BMHeader {
  Index Int
  Htype Int
  Hflag Int
}

BMVert {
  Head BMHeader
  Co   Float3
  No   Float3
  Edge Option(BMEdge)
}

BMEdge {
  Head BMHeader
  V1   BMVert
  V2   BMVert
  Loop Option(BMLoop)
}

BMLoop {
  Head       BMHeader
  V          BMVert
  E          BMEdge
  F          BMFace
  Next       BMLoop
  Prev       BMLoop
  RadialNext BMLoop
  RadialPrev BMLoop
}

BMFace {
  Head   BMHeader
  LFirst BMLoop
  Len    Int
  No     Float3
  MatNr  Int
}

BMElem BMVert | BMEdge | BMLoop | BMFace

BMEditSelection {
  Htype Int
  Ele   BMElem
}

BMesh {
  Totvert     Int
  Totedge     Int
  Totloop     Int
  Totface     Int
  Totvertsel  Int
  Totedgesel  Int
  Totfacesel  Int
  ElemIndexDirty Int
  Selectmode  Int
  Shapenr     Int
  Verts       List(BMVert)
  Edges       List(BMEdge)
  Faces       List(BMFace)
  Selected    List(BMEditSelection)
  ActiveFace  Option(BMFace)
}

EditMeshData {
  VertPositions List(Float3)
  VertNormals   List(Float3)
  FaceNormals   List(Float3)
  FaceCenters   List(Float3)
}

BMEditMesh {
  Bm            BMesh
  Looptris      List((BMLoop, BMLoop, BMLoop))
  Selectmode    Int
  MatNr         Int
  NeedsFlushToId Bool
  VertexCos     Option(EditMeshData)
}

BMOpSlot {
  SlotName Str
  SlotType Int
  Elements List(Any)
}

BMOperator {
  TypeId   Int
  SlotsIn  Map(Str, BMOpSlot)
  SlotsOut Map(Str, BMOpSlot)
  Flag     Int
}

BMBVHTree {
  Tree   BVHTree
  Looptris List((BMLoop, BMLoop, BMLoop))
  Bm     BMesh
}

SubdivVtxBoundaryInterpolation "None" | "EdgeOnly" | "EdgeAndCorner"
SubdivFVarLinearInterpolation  "None" | "CornersOnly" | "CornersPlus1" | "CornersPlus2" | "Boundaries" | "All"
SubdivEvaluatorType            "Cpu" | "Gpu"

SubdivSettings {
  IsSimple                 Bool
  IsAdaptive               Bool
  Level                    Int
  UseCreases               Bool
  VtxBoundaryInterpolation SubdivVtxBoundaryInterpolation
  FvarLinearInterpolation  SubdivFVarLinearInterpolation
}

SubdivStats {
  TopologyRefinerCreationTime Double
  SubdivToMeshTime            Double
  SubdivToMeshGeometryTime    Double
  EvaluatorCreationTime       Double
  EvaluatorRefineTime         Double
  SubdivToCcgTime             Double
  SubdivToCcgElementsTime     Double
  TopologyCompareTime         Double
}

Subdiv {
  Settings SubdivSettings
  Stats    SubdivStats
}

CCGKey {
  Level        Int
  ElemSize     Int
  GridSize     Int
  GridArea     Int
  GridBytes    Int
  NormalOffset Int
  MaskOffset   Int
  HasNormals   Bool
  HasMask      Bool
}

SubdivToCCGSettings {
  Resolution Int
  NeedNormal Bool
  NeedMask   Bool
}

SubdivCCGCoord {
  GridIndex Int
  X         Int
  Y         Int
}

SubdivCCG {
  Subdiv        Option(Subdiv)
  Level         Int
  GridSize      Int
  GridArea      Int
  GridsNum      Int
  Positions     List(Float3)
  Normals       List(Float3)
  Masks         List(Float)
  Faces         OffsetIndices
  GridToFaceMap List(Int)
  GridHidden    Option(List(Bool))
}

CurveType       "CatmullRom" | "Poly" | "Bezier" | "Nurbs"
HandleType      "Free" | "Auto" | "Vector" | "Align"
NormalMode      "MinimumTwist" | "ZUp" | "Free"
KnotsMode       "Normal" | "EndPoint" | "Bezier" | "Custom"

NurbsBasisCache {
  Weights      List(Float)
  StartIndices List(Int)
  Invalid      Bool
}

CurvesGeometry {
  PointsNum         Int
  CurvesNum         Int
  CurveOffsets      List(Int)
  CustomKnots       List(Float)
  Attributes        AttributeStorage
  TypeCounts        (Int, Int, Int, Int)
  EvaluatedPositions Option(List(Float3))
  EvaluatedTangents  Option(List(Float3))
  EvaluatedNormals   Option(List(Float3))
  EvaluatedLengths   Option(List(Float))
  Bounds            Option(Bounds(Float3))
}

CurvesSurfaceTransforms {
  CurvesToWorld         Float4x4
  CurvesToSurface       Float4x4
  WorldToCurves         Float4x4
  WorldToSurface        Float4x4
  SurfaceToWorld        Float4x4
  SurfaceToCurves       Float4x4
  SurfaceToCurvesNormal Float4x4
}

Curves ID & {
  Type          "CV"
  Geometry      CurvesGeometry
  Materials     List(Material)
  Surface       Option(Object)
  SurfaceUvMap  Str
  Symmetry      Int
  SelectionDomain AttrDomain
  Flag          Int
}

BPoint {
  Vec    Float4
  Alfa   Float
  Weight Float
  Radius Float
  F1     Int
  Hide   Bool
}

NurbType "Poly" | "Bezier" | "Bspline" | "Cardinal" | "Mebius"

Nurb {
  Type     NurbType
  MatNr    Int
  Hide     Bool
  Flag     Int
  Pntsu    Int
  Pntsv    Int
  Resolu   Int
  Resolv   Int
  Orderu   Int
  Orderv   Int
  Flagu    Int
  Flagv    Int
  Knotsu   List(Float)
  Knotsv   List(Float)
  Bp       List(BPoint)
  Bezt     List(BezTriple)
  TiltInterp Int
  RadiusInterp Int
  Charidx  Int
}

DispList {
  Type     Int
  Flag     Int
  Parts    Int
  Nr       Int
  Col      Int
  Verts    List(Float3)
  Nors     List(Float3)
  Index    List(Int)
  Charidx  Int
  Totindex Int
}

CurveCache {
  Disp                List(DispList)
  DeformedNurbs       List(Nurb)
  AnimPathAccumLength List(Float)
}

CVKeyIndex {
  KeyIndex    Int
  NuIndex     Int
  PtIndex     Int
  VertexIndex Int
  Switched    Bool
}

EditNurb {
  Nurbs    List(Nurb)
  KeyIndex Map(Any, CVKeyIndex)
  Shapenr  Int
}

CharInfo {
  Flag   Int
  MatNr  Int
  Kern   Float
}

TextBox {
  X Float, Y Float, W Float, H Float
}

EditFontSelBox {
  X Float, Y Float, W Float, H Float, Rotate Float
}

EditFont {
  Textbuf       Str
  Textbufinfo   List(CharInfo)
  FontSizeEval  Float
  Textcurs      (Float2, Float2, Float2, Float2)
  Selboxes      List(EditFontSelBox)
  Len           Int
  Pos           Int
  Selstart      Int
  Selend        Int
  NeedsFlushToId Bool
}

Curve ID & {
  Type             "CU_LEGACY"
  Nurb             List(Nurb)
  Editnurb         Option(EditNurb)
  Bevobj           Option(Object)
  Taperobj         Option(Object)
  Textoncurve      Option(Object)
  Materials        List(Material)
  BevelProfile     Option(CurveProfile)
  Key              Option(Key)
  Editfont         Option(EditFont)
  Str              Str
  Tb               List(TextBox)
  Vfont            Option(VFont)
  Vfontb           Option(VFont)
  Vfonti           Option(VFont)
  Vfontbi          Option(VFont)
  Resolu           Int
  Resolv           Int
  Width            Float
  Extrude          Float
  BevelRadius      Float
  BevelRes         Int
  Fsize            Float
  Linedist         Float
  Shear            Float
  Wordspace        Float
  Ulpos            Float
  Ulheight         Float
  Xof              Float
  Yof              Float
  Actnu            Int
  Actvert          Int
  Flag             Int
}

VFontDataMetrics {
  Scale       Float
  EmRatio     Float
  AscendRatio Float
}

VChar {
  Nurbsbase List(Nurb)
  Width     Float
  Bounds    Rctf
}

VFontData {
  Name       Str
  Metrics    VFontDataMetrics
  Characters Map(Int, VChar)
}

VFont ID & {
  Type       "VF"
  Filepath   Str
  Data       Option(VFontData)
  PackedFile Option(PackedFile)
}

PointCloud ID & {
  Type       "PT"
  Totpoint   Int
  Attributes AttributeStorage
  Materials  List(Material)
  Flag       Int
}

VolumeGridType "Unknown" | "Boolean" | "Float" | "Double" | "Int" | "Int64" | "Vec3f" | "Vec3d" | "Vec3i" | "Mask" | "Points"

VolumeGridData {
  Name             Str
  GridType         VolumeGridType
  IsLoaded         Bool
  ActiveVoxels     Int
  ActiveLeafVoxels Int
  ActiveTiles      Int
  SizeInBytes      Int
  ActiveBounds     Bounds(Int3)
  Transform        Float4x4
  ErrorMessage     Str
}

DenseFloatVolumeGrid {
  Type            VolumeGridType
  Resolution      Int3
  TextureToObject Float4x4
  Channels        Int
  Voxels          List(Float)
}

VolumeToMeshResolutionMode "Grid" | "VoxelAmount" | "VoxelSize"

VolumeToMeshResolution {
  Mode        VolumeToMeshResolutionMode
  VoxelSize   Float
  VoxelAmount Float
}

Volume ID & {
  Type             "VO"
  Filepath         Str
  PackedFile       Option(PackedFile)
  IsSequence       Bool
  SequenceMode     Int
  FrameStart       Int
  FrameDuration    Int
  FrameOffset      Int
  Flag             Int
  ActiveGrid       Int
  Materials        List(Material)
  Render           Any
  Display          Any
  Grids            List(VolumeGridData)
  VelocityGrid     Str
  VelocityUnit     Int
  VelocityScale    Float
}

GreasePencilFillCache {
  FillMap     List(Int)
  FillOffsets List(Int)
}

GreasePencilTriangleCache {
  Triangles                List(Int3)
  TriangleOffsets          List(Int)
  IntersectionPoints       List(Float3)
  IntersectionPointOffsets List(Int)
}

GreasePencilDrawing {
  Strokes            CurvesGeometry
  FillCache          Option(GreasePencilFillCache)
  TriangleCache      Option(GreasePencilTriangleCache)
  CurvePlaneNormals  List(Float3)
  TextureMatrices    List(Float4x2)
  UserCount          Int
}

GreasePencilFrame {
  DrawingIndex Int
  Flag         Int
  Type         BezTripleKeyframeType
}

GreasePencilLayerMask {
  LayerName Str
  Flag      Int
}

GreasePencilTreeNode {
  Name       Str
  Flag       Int
  Color      Float3
  Parent     Option(GreasePencilLayerGroup)
  Next       Option(GreasePencilTreeNode)
  Prev       Option(GreasePencilTreeNode)
}

GreasePencilLayer GreasePencilTreeNode & {
  Frames            Map(Int, GreasePencilFrame)
  BlendMode         Int
  Opacity           Float
  ParentObject      Option(Object)
  Parsubstr         Str
  ParentInverse     Float4x4
  Translation       Float3
  Rotation          Float3
  Scale             Float3
  ViewLayerName     Str
  Masks             List(GreasePencilLayerMask)
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
  Materials            List(Material)
  VertexGroupNames     List(bDeformGroup)
  VertexGroupActiveIdx Int
  OnionSkinning        Any
  Flag                 Int
}

bGPDspoint {
  X        Float, Y Float, Z Float
  Pressure Float
  Strength Float
  Time     Float
  Flag     Int
  UvFac    Float
  UvRot    Float
  UvFill   Float2
  VertColor Color4f
}

bGPDstroke {
  Points    List(bGPDspoint)
  Dvert     List(MDeformVert)
  Thickness Int
  Inittime  Double
  MatNr     Int
  Flag      Int
  Hardeness Float
  AspectRatio Float2
  FillOpacityFac Float
  BoundboxMin Float3
  BoundboxMax Float3
  UvTranslation Float2
  UvRotation    Float
  UvScale       Float2
}

bGPDframe {
  Strokes  List(bGPDstroke)
  Framenum Int
  Flag     Int
  KeyType  Int
}

bGPDlayer {
  Info      Str
  Frames    List(bGPDframe)
  Actframe  Option(bGPDframe)
  Flag      Int
  OnionFlag Int
  Color     Color4f
  Fill      Color4f
  Thickness Int
  Gstep     Int
  GstepNext Int
  GcolorPrev Float3
  GcolorNext Float3
  Opacity   Float
}

bGPdata ID & {
  Type   "GD_LEGACY"
  Layers List(bGPDlayer)
  Flag   Int
}

Lattice ID & {
  Type       "LT"
  Pntsu      Int
  Pntsv      Int
  Pntsw      Int
  Flag       Int
  Opntsu     Int
  Opntsv     Int
  Opntsw     Int
  Typeu      Int
  Typev      Int
  Typew      Int
  Actbp      Int
  Fu         Float, Fv Float, Fw Float
  Du         Float, Dv Float, Dw Float
  Def        List(BPoint)
  Key        Option(Key)
  Dvert      List(MDeformVert)
  Vgroup     Str
  Editlatt   Option(Lattice)
}

MetaElem {
  Type Int
  Flag Int
  Co   Float3
  Quat Quaternion
  Exp  Float3
  Rad  Float
  S    Float
  Mat  Option(Float4x4)
  Imat Option(Float4x4)
}

MetaBall ID & {
  Type      "MB"
  Elems     List(MetaElem)
  Disp      List(DispList)
  Editelems Option(List(MetaElem))
  LastElem  Option(MetaElem)
  Materials List(Material)
  Flag      Int
  Wiresize  Float
  Rendersize Float
  Thresh    Float
}

KeyBlock {
  Name       Str
  Curval     Float
  Type       Int
  Relative   Int
  Flag       Int
  TotElem    Int
  Uid        Int
  Data       List(Float3)
  Vgroup     Str
  Slidermin  Float
  Slidermax  Float
}

Key ID & {
  Type      "KE"
  TypeMode  Int
  ElemSize  Int
  Refkey    Option(KeyBlock)
  Block     List(KeyBlock)
  From      Option(ID)
  Totkey    Int
  Flag      Int
  Ctime     Float
  UidGen    Int
}

bDeformWeight {
  DefNr  Int
  Weight Float
}

MDeformVert {
  Dw   List(bDeformWeight)
  Flag Int
}

bDeformGroup {
  Name Str
  Flag Int
}

// =============================================================================
// 7. Objects, Modifiers, Physics, Particles, Collections & Scenes (BKE)
// =============================================================================

ObjectType "Empty" | "Mesh" | "CurveLegacy" | "Surf" | "Font" | "MBall" | "Lamp" | "Camera" | "Lattice" | "Armature" | "Speaker" | "Lightprobe" | "GpencilLegacy" | "Curves" | "Pointcloud" | "Volume" | "GreasePencil"

ObjectMode "Object" | "Edit" | "Sculpt" | "VertexPaint" | "WeightPaint" | "TexturePaint" | "ParticleEdit" | "Pose" | "EditGpencilLegacy" | "SculptGpencilLegacy" | "PaintGpencilLegacy" | "WeightGpencilLegacy" | "VertexGpencilLegacy" | "SculptCurves" | "PaintGreasePencil" | "SculptGreasePencil" | "WeightGreasePencil" | "VertexGreasePencil"

ObjectRuntime {
  ObjectToWorld          Float4x4
  WorldToObject          Float4x4
  ParentDisplayOrigin    Float3
  SelectId               Int
  IsDataEvalOwned        Bool
  BoundsEval             Option(Bounds(Float3))
  DataOrig               Option(ID)
  DataEval               Option(ID)
  GeometrySetEval        Option(GeometrySet)
  ContainedGeometryTypes Int
  ObjectAsTempMesh       Option(Mesh)
  ObjectAsTempCurve      Option(Curve)
  PoseBackup             Option(PoseBackup)
  CurveCache             Option(CurveCache)
  LocalCollectionsBits   Int
  SculptSession          Option(SculptSession)
  LastUpdateTransform    Int
  LastUpdateGeometry     Int
  LastUpdateShading      Int
}

LightLinking {
  ReceiverCollection Option(Collection)
  BlockerCollection  Option(Collection)
}

Object ID & {
  Type                  "OB"
  ObType                ObjectType
  Mode                  ObjectMode
  Data                  Option(ID)
  Parent                Option(Object)
  Track                 Option(Object)
  Parsubstr             Str
  Partype               Int
  Par1                  Int, Par2 Int, Par3 Int
  Parentinv             Float4x4
  Constinv              Float4x4
  Obmat                 Float4x4
  Loc                   Float3
  Dloc                  Float3
  Scale                 Float3
  Dscale                Float3
  Rot                   Float3
  Drot                  Float3
  Quat                  Quaternion
  Dquat                 Quaternion
  RotAxis               Float3
  DrotAxis              Float3
  RotAngle              Float
  DrotAngle             Float
  Rotmode               Int
  Protectflag           Int
  Trackflag             Int
  Upflag                Int
  Transflag             Int
  BaseFlag              Int
  BaseLocalViewBits     Int
  ColBits               Int
  Materials             List(Option(Material))
  Matbits               List(Bool)
  Actcol                Int
  Totcol                Int
  Dt                    Int
  Boundtype             Int
  EmptyDrawtype         Int
  EmptyDrawsize         Float
  ImageUser             Option(ImageUser)
  Color                 Color4f
  Shapenr               Int
  Shapeflag             Int
  Defbase               List(bDeformGroup)
  Actdef                Int
  Modifiers             List(ModifierData)
  GpencilModifiers      List(GpencilModifierData)
  ShaderFx              List(ShaderFxData)
  Constraints           List(bConstraint)
  Particlesystem        List(ParticleSystem)
  Pose                  Option(bPose)
  Pd                    Option(PartDeflect)
  Soft                  Option(SoftBody)
  InstanceCollection    Option(Collection)
  RigidBodyObject       Option(RigidBodyOb)
  RigidBodyConstraint   Option(RigidBodyCon)
  Motionpath            Option(bMotionPath)
  AnimViz               bAnimVizSettings
  Lightgroup            Option(Str)
  LightLinking          Option(LightLinking)
  LightprobeCache       Option(LightProbeObjectCache)
  Runtime               ObjectRuntime
}

DupliObject {
  Ob                   Object
  ObData               Option(ID)
  Mat                  Float4x4
  Orco                 Float3
  Uv                   Float2
  Type                 Int
  NoDraw               Bool
  Level                Int
  PreviewBaseGeometry  Option(GeometrySet)
  PreviewInstanceIndex Int
  PersistentId         List(Int)
  RandomId             Int
  ParticleSystem       Option(ParticleSystem)
  InstanceIdx          Int
}

ModifierType "None" | "Subsurf" | "Lattice" | "Curve" | "Build" | "Mirror" | "Decimate" | "Wave" | "Armature" | "Hook" | "Softbody" | "Boolean" | "Array" | "EdgeSplit" | "Displace" | "UVProject" | "Smooth" | "Cast" | "MeshDeform" | "ParticleSystem" | "ParticleInstance" | "Explode" | "Cloth" | "Collision" | "Bevel" | "Shrinkwrap" | "Fluidsim" | "Mask" | "SimpleDeform" | "Multires" | "Surface" | "Fluid" | "ShapeKey" | "Solidify" | "Screw" | "Warp" | "WeightVGEdit" | "WeightVGMix" | "WeightVGProximity" | "Ocean" | "DynamicPaint" | "Remesh" | "Skin" | "LaplacianSmooth" | "Triangulate" | "UVWarp" | "MeshCache" | "LaplacianDeform" | "Wireframe" | "DataTransfer" | "NormalEdit" | "CorrectiveSmooth" | "MeshSequenceCache" | "SurfaceDeform" | "WeightedNormal" | "Weld" | "Fluid" | "Nodes" | "MeshToVolume" | "VolumeDisplace" | "VolumeToMesh" | " GreasePencilOpacity" | "GreasePencilSubdiv" | "GreasePencilColor" | "GreasePencilTint" | "GreasePencilSmooth" | "GreasePencilOffset" | "GreasePencilNoise" | "GreasePencilMirror" | "GreasePencilThickness" | "GreasePencilLattice" | "GreasePencilDash" | "GreasePencilMultiply" | "GreasePencilLength" | "GreasePencilWeightAngle" | "GreasePencilArray" | "GreasePencilWeightProximity" | "GreasePencilHook" | "GreasePencilLineart" | "GreasePencilArmature" | "GreasePencilTime" | "GreasePencilEnvelope" | "GreasePencilOutline" | "GreasePencilShrinkwrap" | "GreasePencilBuild" | "GreasePencilSimplify" | "GreasePencilTexture"

ModifierApplyFlag Int

ModifierEvalContext {
  Depsgraph Depsgraph
  Object    Object
  Flag      ModifierApplyFlag
}

ModifierData {
  Name                Str
  Type                ModifierType
  Mode                Int
  Flag                Int
  UiExpandFlag        Int
  PersistentUid       Int
  SessionUid          SessionUID
  ExecutionTime       Float
  Error               Option(Str)
  LayoutPanelStates   List(Any)
}

SubsurfModifierData ModifierData & {
  Type         "Subsurf"
  SubdivType   Int
  Levels       Int
  RenderLevels Int
  Quality      Int
  UvSmooth     Int
  BoundarySmooth Int
  Flags        Int
}

MirrorModifierData ModifierData & {
  Type         "Mirror"
  Axis         Int
  Flag         Int
  Tolerance    Float
  BisectThreshold Float
  MirrorOb     Option(Object)
}

NodesModifierBake {
  Id         Int
  Flag       Int
  BakeMode   Int
  Directory  Str
  FrameStart Int
  FrameEnd   Int
}

NodesModifierData ModifierData & {
  Type              "Nodes"
  NodeGroup         Option(bNodeTree)
  Settings          Option(IDProperty)
  BakeDirectory     Str
  BakeTarget        Int
  Flag              Int
  Bakes             List(NodesModifierBake)
  RuntimeCache      Option(ModifierCache)
}

GpencilModifierData {
  Name Str
  Type Int
  Mode Int
  Flag Int
}

ShaderFxType "Null" | "Blur" | "Colorize" | "Flip" | "Glow" | "Pixel" | "Rim" | "Shadow" | "Swirl" | "Wave"

ShaderFxData {
  Name Str
  Type ShaderFxType
  Mode Int
  Flag Int
}

BlurShaderFxData     ShaderFxData & { Type "Blur", Radius Float2, Samples Int, Rotation Float }
ColorizeShaderFxData ShaderFxData & { Type "Colorize", LowColor Color4f, HighColor Color4f, Factor Float, ColorMode Int }
FlipShaderFxData     ShaderFxData & { Type "Flip" }
GlowShaderFxData     ShaderFxData & { Type "Glow", GlowColor Color4f, SelectColor Float3, Threshold Float, Blur Int2, Samples Int, Rotation Float, BlendMode Int }
PixelShaderFxData    ShaderFxData & { Type "Pixel", Size Int2,Rgba Color4f }
RimShaderFxData      ShaderFxData & { Type "Rim", Offset Int2, RimRgb Float3, MaskRgb Float3, RimMode Int, Blur Int2, Samples Int }
ShadowShaderFxData   ShadowShaderFxData_Base
SwirlShaderFxData    ShaderFxData & { Type "Swirl", Object Option(Object), Radius Int, Angle Float }
WaveShaderFxData     ShaderFxData & { Type "Wave", Orientation Int, Amplitude Float, Period Float, Phase Float }

ShadowShaderFxData_Base ShaderFxData & {
  Type        "Shadow"
  Object      Option(Object)
  Offset      Int2
  Scale       Float2
  ShadowRgba  Color4f
  Amplitude   Float
  Period      Float
  Phase       Float
  Orientation Int
  Rotation    Float
  Blur        Int2
  Samples     Int
}

ClothVertex {
  Flags           Int
  V               Float3
  Xconst          Float3
  X               Float3
  Xold            Float3
  Tx              Float3
  Txold           Float3
  Tv              Float3
  Mass            Float
  Goal            Float
  Impulse         Float3
  Xrest           Float3
  Dcvel           Float3
  ImpulseCount    Int
  AvgSpringLen    Float
  StructStiff     Float
  BendStiff       Float
  ShearStiff      Float
  SpringCount     Int
  ShrinkFactor    Float
  InternalStiff   Float
  PressureFactor  Float
}

ClothSpring {
  Ij           Int
  Kl           Int
  Mn           Int
  Restlen      Float
  Restang      Float
  Type         Int
  Flags        Int
  LinStiffness Float
  AngStiffness Float
  Editrestlen  Float
  Target       Float3
}

Cloth {
  Verts               List(ClothVertex)
  Springs             List(ClothSpring)
  Numsprings          Int
  MvertNum            Int
  PrimitiveNum        Int
  Bvhtree             Option(BVHTree)
  Bvhselftree         Option(BVHTree)
  VertTris            List(Int3)
  Edgeset             Set(OrderedEdge)
  SewEdgeGraph        Set(OrderedEdge)
  LastFrame           Int
  InitialMeshVolume   Float
  AverageAcceleration Float3
}

ClothModifierData ModifierData & {
  Type       "Cloth"
  ClothObject Option(Cloth)
  SimParms   Any
  CollParms  Any
  PointCache Option(PointCache)
}

FluidDomainType     "Gas" | "Liquid"
FluidFlowType       "Smoke" | "Fire" | "SmokeFire" | "Liquid"
FluidFlowBehavior   "Inflow" | "Outflow" | "Geometry"
FluidEffectorType   "Collision" | "Guide"

FluidDomainSettings {
  Type             FluidDomainType
  Res              Int3
  ResMin           Int3
  ResMax           Int3
  BaseRes          Int3
  CellSize         Float3
  GlobalSize       Float3
  PrevLoc          Float3
  Shift            Int3
  ShiftF           Float3
  ObjShiftF        Float3
  Imat             Float4x4
  Obmat            Float4x4
  Fluidmat         Float4x4
  FluidmatWt       Float4x4
  CacheFrameStart  Int
  CacheFrameEnd    Int
  CacheFrameOffset Int
  Flags            Int
}

FluidFlowSettings {
  Type     FluidFlowType
  Behavior FluidFlowBehavior
  Flags    Int
}

FluidEffectorSettings {
  Type  FluidEffectorType
  Flags Int
}

FluidModifierData ModifierData & {
  Type     "Fluid"
  FluidType Int
  Domain   Option(FluidDomainSettings)
  Flow     Option(FluidFlowSettings)
  Effector Option(FluidEffectorSettings)
  Time     Float
}

DynamicPaintSurface {
  Name        Str
  Format      Int
  Type        Int
  DispType    Int
  Effect      Int
  EffectUi    Int
  InitColorType Int
  Flags       Int
  Color       Color4f
  StartFrame  Int
  EndFrame    Int
  Substeps    Int
  PointCache  Option(PointCache)
}

DynamicPaintCanvasSettings {
  Surfaces   List(DynamicPaintSurface)
  ActiveSur  Int
  Flags      Int
}

DynamicPaintBrushSettings {
  Flags Int
  Alpha Float
  R     Float, G Float, B Float
  Wetness Float
}

DynamicPaintModifierData ModifierData & {
  Type      "DynamicPaint"
  PaintType Int
  Canvas    Option(DynamicPaintCanvasSettings)
  Brush     Option(DynamicPaintBrushSettings)
}

OceanResult {
  Disp   Float3
  Normal Float3
  Foam   Float
  Jminus Float
  Jplus  Float
  Eminus Float3
  Eplus  Float3
}

OceanCache {
  Bakepath    Str
  Relbase     Str
  WaveScale   Float
  ChopAmount  Float
  FoamCoverage Float
  FoamFade    Float
  Start       Int
  End         Int
  Duration    Int
  ResolutionX Int
  ResolutionY Int
  Baked       Bool
}

OceanModifierData ModifierData & {
  Type       "Ocean"
  Ocean      Option(Any)
  OceanCache Option(OceanCache)
  Resolution Int
  ViewportResolution Int
  SpatialSize Int
  WindVelocity Float
  Damp       Float
  SmallestWave Float
  Depth      Float
  WaveAlignment Float
  WaveDirection Float
  WaveScale  Float
  ChopAmount Float
  FoamCoverage Float
  Time       Float
  Spectrum   Int
  BakeStart  Int
  BakeEnd    Int
  Cachepath  Str
  Foamlayername Str
  Spraylayername Str
  Cached     Bool
  Flag       Int
}

BodyPoint {
  OrigS        Float3
  OrigE        Float3
  OrigT        Float3
  Pos          Float3
  Vec          Float3
  Force        Float3
  Goal         Float
  Prevpos      Float3
  Prevvec      Float3
  Mass         Float
  Springweight Float
}

SoftBody {
  Totpoint   Int
  Totspring  Int
  Bpoint     List(BodyPoint)
  PointCache Option(PointCache)
  Flags      Int
}

RigidBodyObType  "Active" | "Passive"
RigidBodyConType "Fixed" | "Point" | "Hinge" | "Slider" | "Piston" | "Generic" | "GenericSpring" | "Motor"

RigidBodyOb {
  Type         RigidBodyObType
  Shape        Int
  Flag         Int
  ColGroups    Int
  MeshSource   Int
  Mass         Float
  Friction     Float
  Restitution  Float
  Margin       Float
  LinDamp      Float
  AngDamp      Float
  LinSleepThresh Float
  AngSleepThresh Float
  Orn          Quaternion
  Pos          Float3
}

RigidBodyCon {
  Type              RigidBodyConType
  Flag              Int
  Ob1               Option(Object)
  Ob2               Option(Object)
  BreakingThreshold Float
  NumSolverIterations Int
}

RigidBodyWorld {
  Group            Option(Collection)
  Constraints      Option(Collection)
  EffectorWeights  Option(EffectorWeights)
  PointCache       Option(PointCache)
  Ltime            Float
  TimeScale        Float
  SubstepsPerFrame Int
  NumSolverIterations Int
  Flag             Int
}

EffectorWeights {
  Group  Option(Collection)
  Weight List(Float)
  GlobalGravity Float
  Flag   Int
}

PartDeflect {
  Flag      Int
  Deflect   Int
  Forcefield Int
  Falloff   Int
  Shape     Int
  TexMode   Int
  Kink      Int
  KinkAxis  Int
  Zdir      Int
  FStrength Float
  FDamp     Float
  FFlow     Float
  FNoise    Float
  FSize     Float
  FPower    Float
  Maxdist   Float
  Mindist   Float
  Maxrad    Float
  Minrad    Float
}

BoidRule {
  Name Str
  Type Int
  Flag Int
}

BoidState {
  Name  Str
  Id    Int
  Flag  Int
  Rules List(BoidRule)
}

BoidSettings {
  Options          Int
  LandingSmoothness Float
  Height           Float
  Banking          Float
  Pitch            Float
  Health           Float
  Aggression       Float
  Strength         Float
  Accuracy         Float
  Range            Float
  AirMaxSpeed      Float
  AirMinSpeed      Float
  AirMaxAcc        Float
  AirMaxAve        Float
  AirPersonalSpace Float
  LandJumpSpeed    Float
  LandMaxSpeed     Float
  LandAcc          Float
  LandAve          Float
  LandPersonalSpace Float
  LandStickForce   Float
  States           List(BoidState)
}

ParticleKey {
  Co   Float3
  Vel  Float3
  Rot  Quaternion
  Ave  Float3
  Time Float
}

ParticleData {
  State     ParticleKey
  PrevState ParticleKey
  Hair      List(ParticleKey)
  Time      Float
  Lifetime  Float
  Dietime   Float
  Size      Float
  Num       Int
  NumDmcache Int
  Totkey    Int
  Flag      Int
}

ChildParticle {
  Num    Int
  Parent Int
  Pa     (Int, Int, Int, Int)
  W      Float4
  Fuv    Float4
  Foffset Float
}

ParticleTarget {
  Ob     Option(Object)
  Psys   Int
  Flag   Int
  Mode   Int
  Time   Float
  Duration Float
}

ParticleSettings ID & {
  Type            "PA"
  Flag            Int
  PartType        Int
  Distr           Int
  From            Int
  Reactevent      Int
  Numb            Int
  Phystype        Int
  Rotmode         Int
  Avemode         Int
  Reactshape      Int
  Draw            Int
  DrawAs          Int
  DrawSize        Int
  Childtype       Int
  RenAs           Int
  Sta             Float
  End             Float
  Lifetime        Float
  Randlife        Float
  Timetweak       Float
  Chto            Float
  Jit             Int
  Totpart         Int
  Userjit         Int
  GridRes         Int
  Subframes       Int
  ChildNbr        Int
  RenChildNbr     Int
  Normalfac       Float
  Obbfac          Float
  Randfac         Float
  Texfac          Float
  Tanfac          Float
  Tanphase        Float
  Reactfac        Float
  Avefac          Float3
  Phasefac        Float
  Randrotfac      Float
  Randphasefac    Float
  Size            Float
  Randsize        Float
  Mass            Float
  Boids           Option(BoidSettings)
  EffectorWeights Option(EffectorWeights)
  InstanceObject  Option(Object)
  DupGroup        Option(Collection)
}

ParticleSystem {
  Name        Str
  Part        Option(ParticleSettings)
  Particles   List(ParticleData)
  Child       List(ChildParticle)
  Edit        Option(PTCacheEdit)
  Targets     List(ParticleTarget)
  TargetOb    Option(Object)
  LatticeDeformData Option(Any)
  Parent      Option(Object)
  PointCache  Option(PointCache)
  PtCaches    List(PointCache)
  Seed        Int
  ChildSeed   Int
  Flag        Int
  Totpart     Int
  Totunexist  Int
  Totchild    Int
  Recalc      Int
}

PTCacheMem {
  Frame     Int
  Totpoint  Int
  DataTypes Int
  Flag      Int
  Data      List(Any)
}

PointCache {
  Name        Str
  Flag        Int
  Step        Int
  Simframe    Int
  Startframe  Int
  Endframe    Int
  Editframe   Int
  LastExact   Int
  LastValid   Int
  Compression Int
  Totpoint    Int
  Index       Int
  MemCache    List(PTCacheMem)
}

PTCacheEditKey {
  Co      Float3
  Vel     Float3
  Rot     Quaternion
  Time    Float
  WorldCo Float3
  Ftime   Float
  Length  Float
  Flag    Int
}

PTCacheEditPoint {
  Keys   List(PTCacheEditKey)
  Totkey Int
  Flag   Int
}

PTCacheEdit {
  Points    List(PTCacheEditPoint)
  Psys      Option(ParticleSystem)
  Totpoint  Int
  Totframes Int
  Totcached Int
  Edited    Bool
  Flags     Int
}

CacheFileLayer {
  Filepath Str
  Flag     Int
}

CacheFile ID & {
  Type            "CF"
  IsSequence      Bool
  ForwardAxis     Int
  UpAxis          Int
  OverrideFrame   Bool
  Scale           Float
  Frame           Float
  FrameOffset     Float
  AnimationFlag   Int
  TypeFormat      Int
  Filepath        Str
  VelocityName    Str
  VelocityUnit    Int
  ActiveLayerIdx  Int
  Layers          List(CacheFileLayer)
}

CollectionObject {
  Ob Object
}

CollectionChild {
  Collection Collection
}

CollectionExport {
  Name       Str
  ExporterId Str
  Properties Option(IDProperty)
}

CollectionImport {
  ImporterId Str
  Properties Option(IDProperty)
}

Collection ID & {
  Type           "GR"
  Gobject        List(CollectionObject)
  Children       List(CollectionChild)
  Exporters      List(CollectionExport)
  Importer       Option(CollectionImport)
  InstanceOffset Float3
  Flag           Int
  ColorTag       Int
  LineartUsage   Int
  LineartFlags   Int
  LineartImask   Int
}

Base {
  Object        Object
  Flag          Int
  FlagFromSet   Int
  LocalViewBits Int
  LocalCollectionsBits Int
}

LayerCollection {
  Collection          Collection
  LocalCollection     Option(Collection)
  Flag                Int
  RuntimeFlag         Int
  LayerCollections    List(LayerCollection)
  LocalCollectionsBits Int
}

ViewLayerAOVType "Color" | "Value"

ViewLayerAOV {
  Name Str
  Type ViewLayerAOVType
  Flag Int
}

ViewLayerLightgroup {
  Name Str
}

FreestyleModuleConfig {
  Script   Option(Text)
  IsDisplayed Bool
}

FreestyleLineSet {
  Name       Str
  Linestyle  Option(FreestyleLineStyle)
  Group      Option(Collection)
  Flags      Int
  Selection  Int
  Qi         Int
  QiStart    Int
  QiEnd      Int
  EdgeTypes  Int
  ExcludeEdgeTypes Int
}

FreestyleConfig {
  Mode          Int
  RaycastingAlgorithm Int
  Flags         Int
  SphereRadius  Float
  KrDerivativeEpsilon Float
  CreaseAngle   Float
  Modules       List(FreestyleModuleConfig)
  Linesets      List(FreestyleLineSet)
}

ViewLayer {
  Name                  Str
  Flag                  Int
  PassFlag              Int
  PassAlphaThreshold    Float
  Samples               Int
  MaterialOverride      Option(Material)
  WorldOverride         Option(World)
  Aovs                  List(ViewLayerAOV)
  ActiveAov             Option(ViewLayerAOV)
  Lightgroups           List(ViewLayerLightgroup)
  ActiveLightgroup      Option(ViewLayerLightgroup)
  FreestyleConfig       FreestyleConfig
  ObjectBases           List(Base)
  Basact                Option(Base)
  LayerCollections      List(LayerCollection)
  ActiveCollection      Option(LayerCollection)
}

SceneRenderView {
  Name       Str
  Suffix     Str
  Viewflag   Int
  CameraSuffix Str
}

ImageFormatData {
  Imtype          Int
  Depth           Int
  Planes          Int
  Quality         Int
  Compress        Int
  ExrCodec        Int
  CineonFlag      Int
  CineonWhite     Int
  CineonBlack     Int
  CineonGamma     Float
  ViewsFormat     Int
  ColorManagement Int
  MediaType       Int
  ViewSettings    ColorManagedViewSettings
  DisplaySettings ColorManagedDisplaySettings
  LinearColorspaceSettings ColorManagedColorspaceSettings
}

RenderData {
  ImFormat         ImageFormatData
  Xsch             Int
  Ysch             Int
  Size             Int
  Xasp             Float
  Yasp             Float
  Sfra             Int
  Efra             Int
  Cfie             Int
  Subframe         Float
  Psfra            Int
  Pefra            Int
  Framapto         Int
  Images           Int
  Framelen         Float
  Blurfac          Float
  FrameStep        Int
  Stereomode       Int
  Dimensionspreset Int
  Filtertype       Int
  Tilex            Int
  Tiley            Int
  Threads          Int
  ThreadsMode      Int
  Mode             Int
  Scemode          Int
  Gauss            Float
  DitherIntensity  Float
  BakeMode         Int
  BakeFilter       Int
  BakeFlag         Int
  BakeNormalSpace  Int
  BakeSamples      Int
  BakeBiasdist     Float
  BakeUserScale    Float
  Pic              Str
  Engine           Str
  ViewsFormat      Int
  Views            List(SceneRenderView)
  Actview          Int
}

UnitSettings {
  ScaleLength Float
  System      Int
  SystemRotation Int
  LengthUnit  Int
  MassUnit    Int
  TimeUnit    Int
  TemperatureUnit Int
  Flag        Int
}

TransformOrientation {
  Name Str
  Mat  Float3x3
}

TransformOrientationSlot {
  Type            Int
  IndexCustom     Int
  Flag            Int
}

SceneCompositorEffect {
  Name                 Str
  NodeGroup            Option(bNodeTree)
  Properties           Option(IDProperty)
  Flags                Int
  UiPanelDataExpansion Int
}

ToolSettings {
  VgroupWeight      Float
  Doublimit         Float
  Normalsize        Float
  Automerge         Int
  Selectmode        Int
  Unwrapper         Int
  UvcalcMargin      Float
  UvFlag            Int
  UvSelectmode      Int
  UvSticky          Int
  GpInterpolate     Any
  GpSculpt          Any
  Sculpt            Option(Paint)
  Vpaint            Option(Paint)
  Wpaint            Option(Paint)
  Imapaint          Option(Paint)
  Gpaint            Option(Paint)
  Gpvpaint          Option(Paint)
  Gpwpaint          Option(Paint)
  Gpsculpt          Option(Paint)
  CurvesSculpt      Option(Paint)
  Particle          Any
  ProportionalSize  Float
  SelectThresh      Float
  AutokeyMode       Int
  AutokeyFlag       Int
  KeyframeType      BezTripleKeyframeType
  TransformPivotPoint Int
  TransformFlag     Int
  SnapMode          Int
  SnapNodeMode      Int
  SnapUvMode        Int
  SnapAnimMode      Int
  SnapFlag          Int
  SnapFlagNode      Int
  SnapFlagSeq       Int
  SnapFlagAnim      Int
  SnapTarget        Int
  SnapTransformModeFlag Int
  ProportionalEdit  Int
  PropMode          Int
}

Scene ID & {
  Type                   "SCE"
  Camera                 Option(Object)
  World                  Option(World)
  Set                    Option(Scene)
  MasterCollection       Collection
  ViewLayers             List(ViewLayer)
  Basact                 Option(Base)
  CursorLocation         Float3
  CursorRotation         Quaternion
  CursorRotationEuler    Float3
  CursorRotationAxis     Float3
  CursorRotationAngle    Float
  CursorRotationMode     Int
  R                      RenderData
  ToolSettings           ToolSettings
  Unit                   UnitSettings
  ViewSettings           ColorManagedViewSettings
  DisplaySettings        ColorManagedDisplaySettings
  SequencerColorspaceSettings ColorManagedColorspaceSettings
  RigidBodyWorld         Option(RigidBodyWorld)
  Gpd                    Option(bGPdata)
  Clip                   Option(MovieClip)
  Nodetree               Option(bNodeTree)
  Ed                     Option(Any)
  Markers                List(TimeMarker)
  TransformOrientations  List(TransformOrientation)
  OrientationSlots       (TransformOrientationSlot, TransformOrientationSlot, TransformOrientationSlot, TransformOrientationSlot)
  Keyingsets             List(KeyingSet)
  ActiveKeyingset        Int
  CompositorEffects      List(SceneCompositorEffect)
  ActiveCompositorEffect Option(SceneCompositorEffect)
  Flag                   Int
  UseNodes               Bool
}

// =============================================================================
// 8. Shading, Materials, Lights, Cameras, Images, Color Management & Nodes (BKE)
// =============================================================================

CBData {
  R    Float, G Float, B Float, A Float
  Pos  Float
  Cur  Int
}

ColorBand {
  Tot        Int
  Cur        Int
  Ipo        Int
  ColorMode  Int
  HueInterp  Int
  Data       List(CBData)
}

CurveMapSlopeType "Negative" | "Positive" | "PositiveNegative"

CurveMapPoint {
  X    Float
  Y    Float
  Flag Int
  Shorty Int
}

CurveMap {
  Totpoint  Int
  Flag      Int
  Range     Float
  Mintable  Float
  Maxtable  Float
  ExtIn     Float2
  ExtOut    Float2
  Curve     List(CurveMapPoint)
  Table     List(CurveMapPoint)
  Premultable List(CurveMapPoint)
  Shorty    Float2
}

CurveMapping {
  Flag      Int
  Cur       Int
  Preset    Int
  ChangedTimestamp Int
  Curr      Rctf
  Clipr     Rctf
  Cm        (CurveMap, CurveMap, CurveMap, CurveMap)
  Black     Float3
  White     Float3
  Bwmul     Float3
  Sample    Float3
  Tone      Int
}

CurveProfilePoint {
  X      Float
  Y      Float
  Flag   Int
  H1     Int
  H2     Int
  H1Loc  Float2
  H2Loc  Float2
}

CurveProfile {
  PathLen     Int
  SegmentsLen Int
  Preset      Int
  Path        List(CurveProfilePoint)
  Table       List(CurveProfilePoint)
  Segments    List(CurveProfilePoint)
  Flag        Int
  ViewRect    Rctf
  ClipRect    Rctf
}

ColorManagedViewSettings {
  Flag                    Int
  Look                    Str
  ViewTransform           Str
  Exposure                Float
  Gamma                   Float
  CurveMapping            Option(CurveMapping)
  WhiteBalanceTemperature Float
  WhiteBalanceTint        Float
}

ColorManagedDisplaySettings {
  DisplayDevice Str
  Emulation     Int
}

ColorManagedColorspaceSettings {
  Name Str
}

Histogram {
  Channels Int
  XRes     Int
  DataR    List(Float)
  DataG    List(Float)
  DataB    List(Float)
  DataLuma List(Float)
  DataA    List(Float)
  Xmax     Float
  Ymax     Float
  Mode     Int
  Flag     Int
  Height   Int
}

Scopes {
  Ok                Int
  SampleFull        Int
  SampleLines       Int
  Accuracy          Float
  WavefrmMode       Int
  WavefrmAlpha      Float
  WavefrmYmax       Float
  WavefrmHeight     Int
  VecscopeAlpha     Float
  VecscopeHeight    Int
  VecscopeMode      Int
  Minmax            (Float2, Float2, Float2)
  Hist              Histogram
}

MaterialGPencilStyle {
  StrokeRgba Color4f
  FillRgba   Color4f
  MixRgba    Color4f
  Flip       Float
  TextureAngle Float
  TextureScale Float2
  TextureOffset Float2
  TextureOpacity Float
  TexturePixsize Float
  Mode       Int
  GradientType Int
  MixFactor  Float
  AlignmentMode Int
  AlignmentRotation Float
  PassIndex  Int
  Flag       Int
  StrokeStyle Int
  FillStyle  Int
  Sima       Option(Image)
  Ima        Option(Image)
}

Material ID & {
  Type             "MA"
  SurfaceRenderMethod Int
  BlendMethod      Int
  BlendShadow      Int
  AlphaThreshold   Float
  R                Float, G Float, B Float, A Float
  Specr            Float, Specg Float, Specb Float
  Metallic         Float
  Roughness        Float
  Index            Int
  PreviewBlendType Int
  LineCol          Color4f
  LinePriority     Int
  VcolAlpha        Int
  PaintActiveSlot  Int
  PaintCloneSlot   Int
  TotSlots         Int
  DisplacementMethod Int
  VolumeIntersectionMethod Int
  ThicknessMode    Int
  Nodetree         Option(bNodeTree)
  GpStyle          Option(MaterialGPencilStyle)
  Flag             Int
}

Tex ID & {
  Type       "TE"
  TexType    Int
  Stype      Int
  Noisesize  Float
  Turbul     Float
  Bright     Float
  Contrast   Float
  Saturation Float
  Rfac       Float, Gfac Float, Bfac Float
  Filtersize Float
  MgH        Float
  MgLacunarity Float
  MgOctaves  Float
  MgOffset   Float
  MgGain     Float
  DistAmount Float
  NsOutscale Float
  VnW1       Float, VnW2 Float, VnW3 Float, VnW4 Float
  VnMexp     Float
  VnDistm    Int
  VnColtype  Int
  Noisedepth Int
  Noisetype  Int
  Noisebasis Int
  Noisebasis2 Int
  Imaflag    Int
  Flag       Int
  Ima        Option(Image)
  Coba       Option(ColorBand)
  Nodetree   Option(bNodeTree)
}

MTex {
  Texco     Int
  Mapto     Int
  Blendtype Int
  Object    Option(Object)
  Tex       Option(Tex)
  Uvname    Str
  Ofs       Float3
  Size      Float3
  Rot       Float
  R         Float, G Float, B Float, K Float
  DefVar    Float
}

LightType "Local" | "Sun" | "Spot" | "Area"

Light ID & {
  Type              "LA"
  LaType            LightType
  Flag              Int
  Mode              Int
  R                 Float, G Float, B Float
  Energy            Float
  Shdwr             Float, Shdwg Float, Shdwb Float
  Spotsize          Float
  Spotblend         Float
  AreaSize          Float
  AreaSizey         Float
  AreaSizez         Float
  AreaShape         Int
  AreaSpread        Float
  SunAngle          Float
  CascadeMaxDist    Float
  CascadeExponent   Float
  CascadeFade       Float
  CascadeCount      Int
  Bias              Float
  Clipsta           Float
  Clipend           Float
  Bleedexp          Float
  Radius            Float
  CutoffDistance    Float
  ShadowMaxRes      Float
  ShadowFilterRadius Float
  ShadowJitterOverblur Float
  Temperature       Float
  Tint              Float3
  Nodetree          Option(bNodeTree)
}

LightProbeType "Cube" | "Plane" | "Volume"

LightProbe ID & {
  Type            "LP"
  ProbeType       LightProbeType
  Flag            Int
  AttenuationType Int
  Distinf         Float
  Distpar         Float
  Falloff         Float
  Clipsta         Float
  Clipend         Float
  Visbleedbias    Float
  Visblur         Float
  Intensity       Float
  GridResolutionX Int
  GridResolutionY Int
  GridResolutionZ Int
  DataDisplaySize Float
  VisibilityGrp   Option(Collection)
}

LightProbeGridCacheFrame {
  BakingStatus    Int
  SurfelsLen      Int
  Resolution      Int3
  IrradianceL0    List(Float3)
  IrradianceL1a   List(Float3)
  IrradianceL1b   List(Float3)
  IrradianceL1c   List(Float3)
  VirtualOffset   List(Float4)
  Validity        List(Float)
}

LightProbeObjectCache {
  GridStaticCache Option(LightProbeGridCacheFrame)
  Shared          Bool
  Dirty           Bool
}

CameraBGImage {
  Ima      Option(Image)
  Iuser    ImageUser
  Clip     Option(MovieClip)
  Cuser    MovieClipUser
  Offset   Float2
  Scale    Float
  Rotation Float
  Alpha    Float
  Flag     Int
  Source   Int
}

CameraParams {
  IsOrtho           Bool
  IsFlippedX        Bool
  Lens              Float
  OrthoScale        Float
  Zoom              Float
  Roll              Float
  Shiftx            Float
  Shifty            Float
  Offsetx           Float
  Offsety           Float
  SensorX           Float
  SensorY           Float
  SensorFit         Int
  UseAspectOverride Bool
  AspectOverride    Float
  ClipStart         Float
  ClipEnd           Float
  Ycor              Float
  Viewdx            Float
  Viewdy            Float
  Viewplane         Rctf
  Winmat            Float4x4
}

Camera ID & {
  Type               "CA"
  CamType            Int
  Dtype              Int
  Flag               Int
  Passepartalpha     Float
  ClipStart          Float
  ClipEnd            Float
  Lens               Float
  OrthoScale         Float
  Drawsize           Float
  SensorX            Float
  SensorY            Float
  Shiftx             Float
  Shifty             Float
  DofDistance        Float
  SensorFit          Int
  PanoramaType       Int
  FisheyeFov         Float
  FisheyeLens        Float
  LatitudeMin        Float
  LatitudeMax        Float
  LongitudeMin       Float
  LongitudeMax       Float
  FisheyePolyK0      Float
  FisheyePolyK1      Float
  FisheyePolyK2      Float
  FisheyePolyK3      Float
  FisheyePolyK4      Float
  CentralCylRangeU   Float2
  CentralCylRangeV   Float2
  DofObject          Option(Object)
  DofSubtarget       Str
  ApertureFstop      Float
  ApertureRatio      Float
  ApertureBlades     Int
  ApertureRotation   Float
  BgImages           List(CameraBGImage)
}

World ID & {
  Type             "WO"
  Horr             Float, Horg Float, Horb Float
  Exposure         Float
  Exp              Float
  Range            Float
  Mode             Int
  Flag             Int
  Misi             Float
  Miststa          Float
  Mistdist         Float
  Misthi           Float
  Aodist           Float
  Aoenergy         Float
  SunThreshold     Float
  SunAngle         Float
  SunShadowMaxRes  Float
  SunShadowFilterRadius Float
  SunShadowJitterOverblur Float
  Nodetree         Option(bNodeTree)
  Lightgroup       Option(Str)
}

ImageTile {
  TileNumber Int
  GenX       Int
  GenY       Int
  GenType    Int
  GenFlag    Int
  GenDepth   Int
  GenColor   Color4f
  Label      Str
}

RenderSlot {
  Name   Str
  Render Option(RenderResult)
}

ImageUser {
  Scene       Option(Scene)
  Framenr     Int
  Frames      Int
  Offset      Int
  Sfra        Int
  Cycl        Int
  Pass        Int
  Tile        Int
  MultiIndex  Int
  View        Int
  Layer       Int
  Flag        Int
}

ImageGPUTextures {
  Texture         Option(GPUTexture)
  TileMapping     Option(GPUTexture)
  NeedTileMapping Bool
}

Image ID & {
  Type                "IM"
  Filepath            Str
  Source              Int
  ImgType             Int
  Flag                Int
  Colormode           Int
  AlphaMode           Int
  GenX                Int
  GenY                Int
  GenType             Int
  GenFlag             Int
  GenDepth            Int
  GenColor            Color4f
  Aspx                Float
  Aspy                Float
  ColorspaceSettings  ColorManagedColorspaceSettings
  Stereo3dFormat      Option(Any)
  RenderSlots         List(RenderSlot)
  ActiveRenderSlot    Int
  LastRenderSlot      Int
  Tiles               List(ImageTile)
  ActiveTileIndex     Int
  Views               List(Any)
  PackedFiles         List(PackedFile)
}

NodeSocketDatatype "Custom" | "Value" | "Int" | "Boolean" | "Vector" | "RGBA" | "Shader" | "String" | "Object" | "Image" | "Geometry" | "Collection" | "Texture" | "Material" | "Rotation" | "Menu" | "Matrix" | "Bundle" | "Closure"
NodeSocketInOut    "Input" | "Output"

SocketValueVariant {
  StorageKind Int
  Value       Any
}

bNodeSocket {
  Identifier   Str
  Name         Str
  Label        Str
  Description  Str
  Idname       Str
  Type         NodeSocketDatatype
  InOut        NodeSocketInOut
  Flag         Int
  Limit        Int
  DefaultValue Any
  Prop         Option(IDProperty)
  Link         Option(bNodeLink)
  Location     Float2
}

bNodeLink {
  FromNode Option(bNode)
  ToNode   Option(bNode)
  FromSock Option(bNodeSocket)
  ToSock   Option(bNodeSocket)
  Flag     Int
  MultiInputSortId Int
}

bNodePanelRuntime {
  HeaderCenterY Option(Float)
  MinY          Float
  MaxY          Float
  FillNodeEnd   Bool
  InputSocket   Option(bNodeSocket)
}

bNode {
  Name       Str
  Label      Str
  Idname     Str
  Identifier Int
  TypeLegacy Int
  Flag       Int
  Color      Float3
  Locx       Float, Locy Float
  Width      Float, Height Float
  Miniwidth  Float
  Offsetx    Float, Offsety Float
  Parent     Option(bNode)
  Id         Option(ID)
  Storage    Any
  Prop       Option(IDProperty)
  Inputs     List(bNodeSocket)
  Outputs    List(bNodeSocket)
  Panels     List(bNodePanelRuntime)
  Custom1    Int, Custom2 Int
  Custom3    Float, Custom4 Float
}

bNodeTreeInterfaceItemType "Socket" | "Panel"

bNodeTreeInterfaceItem {
  ItemType bNodeTreeInterfaceItemType
}

bNodeTreeInterfaceSocket bNodeTreeInterfaceItem & {
  ItemType            "Socket"
  Name                Str
  Description         Str
  SocketType          Str
  InOut               NodeSocketInOut
  Flag                Int
  AttributeDomain     AttrDomain
  DefaultAttributeName Str
  StructureType       Int
  Identifier          Str
  SocketData          Any
  Properties          Option(IDProperty)
}

bNodeTreeInterfacePanel bNodeTreeInterfaceItem & {
  ItemType    "Panel"
  Name        Str
  Description Str
  Flag        Int
  Identifier  Int
  Items       List(bNodeTreeInterfaceItem)
}

bNodeTreeInterface {
  RootPanel   bNodeTreeInterfacePanel
  ActiveIndex Int
  NextUid     Int
}

bNodeTreeZone {
  Index        Int
  Depth        Int
  InputNodeId  Option(Int)
  OutputNodeId Option(Int)
  ParentZone   Option(bNodeTreeZone)
  ChildZones   List(bNodeTreeZone)
  ChildNodeIds List(Int)
  BorderLinks  List(bNodeLink)
}

bNodeTreeZones {
  Zones               List(bNodeTreeZone)
  RootZones           List(bNodeTreeZone)
  NodeIdsOutsideZones List(Int)
  ZoneByNodeId        Map(Int, Int)
}

bNodeTree ID & {
  Type                "NT"
  Idname              Str
  TreeType            Int
  Flag                Int
  Nodes               List(bNode)
  Links               List(bNodeLink)
  TreeInterface       bNodeTreeInterface
  ViewCenter          Float2
  ActiveOutputIndex   Int
  ColorTag            Int
  Description         Str
  DefaultGroupWidth   Float
  Zones               Option(bNodeTreeZones)
}

// =============================================================================
// 9. Sculpt, Paint, PBVH, Masks, Tracking, Sound, Text & Freestyle (BKE)
// =============================================================================

PaintMode     "Sculpt" | "Vertex" | "Weight" | "Texture3D" | "Texture2D" | "GPencil" | "VertexGPencil" | "SculptGPencil" | "WeightGPencil" | "SculptCurves" | "Invalid"
AssetCategory "Invalid" | "CurvesSculpt" | "GPencilDraw" | "GPencilSculpt" | "GPencilVertex" | "GPencilWeight" | "MeshSculpt" | "MeshTexture" | "MeshVertex" | "MeshWeight"

PaletteColor {
  Color Float3
  Value Float
}

Palette ID & {
  Type        "PAL"
  Colors      List(PaletteColor)
  ActiveColor Int
}

PaintCurvePoint {
  Bez  BezTriple
  Pressure Float
}

PaintCurve ID & {
  Type        "PC"
  Points      List(PaintCurvePoint)
  TotPoints   Int
  ActiveIndex Int
}

Brush ID & {
  Type             "BR"
  Clone            Any
  Curve            Option(CurveMapping)
  Mtex             MTex
  MaskMtex         MTex
  PaintCurve       Option(PaintCurve)
  IconImbuf        Option(ImBuf)
  GpencilSettings  Option(Any)
  CurvesSculptSettings Option(Any)
  Blend            Int
  ObMode           Int
  Weight           Float
  Size             Int
  Flag             Int
  Flag2            Int
  MaskPressure     Int
  Jitter           Float
  JitterAbsolute   Int
  OverlayFlags     Int
  Spacing          Int
  SmoothStrokeRadius Int
  SmoothStrokeFactor Float
  Rate             Float
  Rgb              Float3
  SecondaryRgb     Float3
  Alpha            Float
  Hardness         Float
  Flow             Float
  WetMix           Float
  WetPersistence   Float
  Density          Float
  TipRoundness     Float
  TipScaleX        Float
  SculptPlane      Int
  PlaneOffset      Float
  SculptBrushType  Int
  VertexBrushType  Int
  WeightBrushType  Int
  ImageBrushType   Int
  GpencilBrushType Int
  CurvesSculptBrushType Int
}

Paint {
  Brush                   Option(Brush)
  ActiveBrushRef          Option(AssetWeakReference)
  CavityCurve             Option(CurveMapping)
  Palette                 Option(Palette)
  SymmetryFlags           Int
  Flags                   Int
  NumInputSamples         Int
  TileOffset              Float3
}

PBVHType "Mesh" | "Grids" | "BMesh"

PBVHNode {
  Parent         Int
  Bounds         Bounds(Float3)
  BoundsOrig     Bounds(Float3)
  ChildrenOffset Int
  Flag           Int
}

PBVHMeshNode  PBVHNode & { FaceIndices List(Int), VertIndices List(Int), UniqueVertsNum Int, CornersNum Int }
PBVHGridsNode PBVHNode & { PrimIndices List(Int) }
PBVHBMeshNode PBVHNode & { BmFaces Set(BMFace), BmUniqueVerts Set(BMVert), BmOtherVerts Set(BMVert) }

PBVHTree {
  TreeType        PBVHType
  PrimIndices     List(Int)
  BoundsDirty     List(Bool)
  NormalsDirty    List(Bool)
  VisibilityDirty List(Bool)
  Nodes           List(PBVHNode)
}

SculptSession {
  ShapekeyActive     Option(KeyBlock)
  Bm                 Option(BMesh)
  MultiresModifier   Option(ModifierData)
  SubdivCcg          Option(SubdivCCG)
  Pbvh               Option(PBVHTree)
  DeformModifiersActive Bool
  DeformCos          List(Float3)
  DeformImats        List(Float3x3)
  ActiveFaceIndex    Option(Int)
  ActiveGridIndex    Option(Int)
  CursorRadius       Float
  CursorLocation     Float3
  CursorNormal       Float3
  CursorViewNormal   Float3
  PivotPos           Float3
  PivotRot           Quaternion
  PivotScale         Float3
  ModeType           ObjectMode
  NeedsFlushToId     Bool
  StickyShadingColor Bool
}

MaskParent {
  IdType    Int
  Type      Int
  Id        Option(ID)
  Parent    Str
  SubParent Str
  ParentOrig Float2
}

MaskSplinePointUW {
  U      Float
  W      Float
  Flag   Int
}

MaskSplinePoint {
  Bezt   BezTriple
  TotUw  Int
  Uw     List(MaskSplinePointUW)
  Parent MaskParent
}

MaskSpline {
  Flag        Int
  OffsetMode  Int
  WeightInterp Int
  TotPoint    Int
  Points      List(MaskSplinePoint)
  PointsDeform Option(List(MaskSplinePoint))
}

MaskLayerShape {
  Data    List(Float)
  TotVert Int
  Frame   Int
  Flag    Int
}

MaskLayer {
  Name           Str
  Splines        List(MaskSpline)
  SplinesShapes  List(MaskLayerShape)
  ActSpline      Option(MaskSpline)
  ActPoint       Option(MaskSplinePoint)
  Alpha          Float
  Blend          Int
  BlendFlag      Int
  Falloff        Int
  Flag           Int
  VisibilityFlag Int
}

Mask ID & {
  Type          "MSK"
  Masklayers    List(MaskLayer)
  ActLayer      Int
  Sfra          Int
  Efra          Int
}

MovieClipUser {
  Framenr     Int
  RenderSize  Int
  RenderFlag  Int
}

MovieTrackingMarker {
  Pos           Float2
  PatternCorners (Float2, Float2, Float2, Float2)
  SearchMin     Float2
  SearchMax     Float2
  Framenr       Int
  Flag          Int
}

MovieTrackingTrack {
  Name         Str
  PatMin       Float2
  PatMax       Float2
  SearchMin    Float2
  SearchMax    Float2
  Offset       Float2
  Markersnr    Int
  LastMarker   Int
  Markers      List(MovieTrackingMarker)
  BundlePos    Float3
  Error        Float
  Flag         Int
  PatFlag      Int
  SearchFlag   Int
  Color        Float3
  FramesLimit  Int
  Margin       Int
  PatternMatch Int
  MotionModel  Int
  AlgorithmFlag Int
  MinimumCorrelation Float
  Weight       Float
  WeightStab   Float
}

MovieTrackingPlaneMarker {
  Corners (Float2, Float2, Float2, Float2)
  Framenr Int
  Flag    Int
}

MovieTrackingPlaneTrack {
  Name         Str
  PointTracks  List(MovieTrackingTrack)
  PointTracksnr Int
  Markers      List(MovieTrackingPlaneMarker)
  Markersnr    Int
  Flag         Int
  Image        Option(Image)
  ImageOpacity Float
  LastMarker   Int
}

MovieTrackingCamera {
  DistortionModel Int
  SensorWidth     Float
  PixelAspect     Float
  Focal           Float
  Units           Int
  PrincipalPoint  Float2
  PrincipalPointPx Float2
  K1              Float, K2 Float, K3 Float
  P1              Float, P2 Float
}

MovieTrackingObject {
  Name         Str
  Flag         Int
  Scale        Float
  Tracks       List(MovieTrackingTrack)
  PlaneTracks  List(MovieTrackingPlaneTrack)
  ActiveTrack  Option(MovieTrackingTrack)
  ActivePlaneTrack Option(MovieTrackingPlaneTrack)
  Keyhyframe1  Int
  Keyframe2    Int
}

MovieTracking {
  Camera      MovieTrackingCamera
  TracksLegacy List(MovieTrackingTrack)
  PlaneTracksLegacy List(MovieTrackingPlaneTrack)
  Objects     List(MovieTrackingObject)
  Objectnr    Int
  ActiveObjectIndex Int
}

MovieClip ID & {
  Type        "MC"
  Filepath    Str
  Source      Int
  Lastframe   Int
  Lastsize    Int2
  Aspx        Float
  Aspy        Float
  Tracking    MovieTracking
  StartFrame  Int
  FrameOffset Int
  Flag        Int
  Len         Int
  ColorspaceSettings ColorManagedColorspaceSettings
}

SoundChannels "Invalid" | "Mono" | "Stereo" | "StereoLfe" | "Surround4" | "Surround5" | "Surround51" | "Surround61" | "Surround71"

SoundInfo {
  Samplerate Float
  Channels   SoundChannels
  Length     Float
}

bSound ID & {
  Type       "SO"
  Filepath   Str
  PackedFile Option(PackedFile)
  SampleRate Float
  Channels   SoundChannels
  Volume     Float
  Pitch      Float
  Panning    Float
  Flags      Int
  MinGain    Float
  MaxGain    Float
  Distance   Float
}

Speaker ID & {
  Type            "SPK"
  Sound           Option(bSound)
  VolumeMax       Float
  VolumeMin       Float
  DistanceMax     Float
  DistanceReference Float
  Attenuation     Float
  ConeAngleOuter  Float
  ConeAngleInner  Float
  ConeVolumeOuter Float
  Volume          Float
  Pitch           Float
  Flag            Int
}

TextLine {
  Line   Str
  Format Option(Str)
  Len    Int
}

Text ID & {
  Type     "TXT"
  Filepath Option(Str)
  Flags    Int
  Nlines   Int
  Lines    List(TextLine)
  Curl     Option(TextLine)
  Sell     Option(TextLine)
  Curc     Int
  Selc     Int
  Mtime    Int
}

LineStyleModifier {
  Name      Str
  Type      Int
  Blend     Int
  Influence Float
  Flags     Int
}

FreestyleLineStyle ID & {
  Type               "LS"
  R                  Float, G Float, B Float, Alpha Float
  Thickness          Float
  ThicknessPosition  Int
  ThicknessRatio     Float
  Flag               Int
  Caps               Int
  Chaining           Int
  Rounds             Int
  SplitLength        Float
  MinAngle           Float
  MaxAngle           Float
  MinLength          Float
  MaxLength          Float
  ChainCount         Int
  SplitDash1         Int, SplitGap1 Int
  SplitDash2         Int, SplitGap2 Int
  SplitDash3         Int, SplitGap3 Int
  SortKey            Int
  IntegrationType    Int
  Texstep            Float
  PrTexture          Int
  UseNodes           Bool
  ColorModifiers     List(LineStyleModifier)
  AlphaModifiers     List(LineStyleModifier)
  ThicknessModifiers List(LineStyleModifier)
  GeometryModifiers  List(LineStyleModifier)
  Mtex               List(Option(MTex))
  Nodetree           Option(bNodeTree)
}

StudioLight {
  Index             Int
  Flag              Int
  Name              Str
  Filepath          Str
  IconIdIrradiance  Int
  IconIdRadiance    Int
  IconIdMatcap      Int
  IconIdMatcapFlip  Int
  EquirectWorkingSpace Str
  LightAmbient      Float3
}

ViewerPathElemType "Id" | "Modifier" | "GroupNode" | "SimulationZone" | "ViewerNode" | "RepeatZone" | "ForeachGeometryElementZone" | "EvaluateClosureNode"

ViewerPathElem {
  Type   ViewerPathElemType
  UiName Str
}

IDViewerPathElem                         ViewerPathElem & { Type "Id", Id Option(ID) }
ModifierViewerPathElem                   ViewerPathElem & { Type "Modifier", ModifierUid Int }
GroupNodeViewerPathElem                  ViewerPathElem & { Type "GroupNode", NodeId Int }
SimulationZoneViewerPathElem             ViewerPathElem & { Type "SimulationZone", SimOutputNodeId Int }
ViewerNodeViewerPathElem                 ViewerPathElem & { Type "ViewerNode", NodeId Int }
RepeatZoneViewerPathElem                 ViewerPathElem & { Type "RepeatZone", RepeatOutputNodeId Int, Iteration Int }
ForeachGeometryElementZoneViewerPathElem ViewerPathElem & { Type "ForeachGeometryElementZone", ZoneOutputNodeId Int, Index Int }
EvaluateClosureNodeViewerPathElem        ViewerPathElem & { Type "EvaluateClosureNode", EvaluateNodeId Int, SourceOutputNodeId Int, SourceTree Option(bNodeTree) }

ViewerPath {
  Path List(ViewerPathElem)
}

// =============================================================================
// 10. Dependency Graph (DEG)
// =============================================================================

EvaluationMode "Viewport" | "Render"

DepsSceneComponentType  "Parameters" | "Animation" | "Audio" | "Sequencer" | "Compositor"
DepsObjectComponentType "Any" | "Parameters" | "Animation" | "Transform" | "Geometry" | "EvaluationResults" | "Pose" | "Bone" | "ParticleSystem" | "Shading" | "Cache" | "Dupli" | "Synchronization" | "Audio" | "Armature" | "GenericDatablock" | "Visibility" | "LightLinking"
PhysicsCollisionType    "Collision" | "SmokeCollision" | "DynamicBrush"

Depsgraph {
  Bmain             Main
  InputScene        Scene
  InputViewLayer    ViewLayer
  EvaluatedScene    Scene
  EvaluatedViewLayer ViewLayer
  Mode              EvaluationMode
  Ctime             Float
  DebugFlags        Int
  DebugName         Str
  IsFullyEvaluated  Bool
}

DEGObjectIterSettings {
  Depsgraph       Depsgraph
  Flags           Int
  ViewerPath      Option(ViewerPath)
  IncludedObjects Option(Set(Object))
}

// =============================================================================
// 11. Context, Window Manager, Screen, Spaces & Regions (BKE / WM / ED)
// =============================================================================

ContextResult     "Ok" | "MemberNotFound" | "NoData"
ContextDataType   "Pointer" | "Collection" | "Property" | "String" | "Int64"
ContextObjectMode "EditMesh" | "EditCurve" | "EditSurface" | "EditText" | "EditArmature" | "EditMetaball" | "EditLattice" | "EditCurves" | "EditGreasePencil" | "EditPointCloud" | "Pose" | "Sculpt" | "PaintWeight" | "PaintVertex" | "PaintTexture" | "Particle" | "Object" | "PaintGpencilLegacy" | "EditGpencilLegacy" | "SculptGpencilLegacy" | "WeightGpencilLegacy" | "VertexGpencilLegacy" | "SculptCurves" | "PaintGreasePencil" | "SculptGreasePencil" | "WeightGreasePencil" | "VertexGreasePencil"

bContextStoreEntry {
  Name  Str
  Value PointerRNA | Str | Int
}

bContextStore {
  Entries List(bContextStoreEntry)
  Used    Bool
}

bContext {
  Main          Option(Main)
  Scene         Option(Scene)
  ViewLayer     Option(ViewLayer)
  WindowManager Option(wmWindowManager)
  Window        Option(wmWindow)
  Workspace     Option(WorkSpace)
  Screen        Option(bScreen)
  Area          Option(ScrArea)
  SpaceData     Option(SpaceLink)
  Region        Option(ARegion)
  RegionPopup   Option(ARegion)
  GizmoGroup    Option(wmGizmoGroup)
  Store         Option(bContextStore)
  PollMsg       Option(Str)
}

SpaceTypeID "Empty" | "View3D" | "Graph" | "Outliner" | "Properties" | "File" | "Image" | "Info" | "Sequence" | "Text" | "Action" | "Nla" | "Script" | "Node" | "Console" | "UserPref" | "Clip" | "Topbar" | "Statusbar" | "Spreadsheet" | "Project"

RegionTypeID "Window" | "Header" | "Channels" | "Temporary" | "UI" | "Tools" | "ToolProps" | "Preview" | "Hud" | " NavigationBar" | "Execute" | "Footer" | "ToolHeader" | "Xr" | "AssetShelf" | "AssetShelfHeader"

View2D {
  Tot       Rctf
  Cur       Rctf
  Vert      Rcti
  Hor       Rcti
  Mask      Rcti
  Min       Float2
  Max       Float2
  Minzoom   Float
  Maxzoom   Float
  Scroll    Int
  ScrollUi  Int
  Keeptot   Int
  Keepzoom  Int
  Keepofs   Int
  Flag      Int
  Align     Int
  Winx      Int
  Winy      Int
  Oldwinx   Int
  Oldwiny   Int
  Around    Int
  AlphaVert Int
  AlphaHor  Int
  PageSizeY Float
}

PanelType {
  Idname             Str
  Label              Str
  Description        Str
  TranslationContext Str
  Context            Str
  Category           Str
  OwnerId            Str
  ParentId           Str
  ActiveProperty     Str
  SpaceType          Int
  RegionType         Int
  UiUnitsX           Int
  OffsetUnitsXy      Float2
  Order              Int
  Flag               Int
  Parent             Option(PanelType)
  Children           List(PanelType)
}

LayoutPanelState {
  Idname Str
  Flag   Int
}

Panel {
  Panelname          Str
  Tabname            Str
  Drawname           Str
  Ofsx               Int, Ofsy Int
  Sizex              Int, Sizey Int
  Blocksizex         Int, Blocksizey Int
  Labelofs           Int
  Flag               Int
  RuntimeFlag        Int
  Sortorder          Int
  Activedata         Any
  Type               Option(PanelType)
  Children           List(Panel)
  LayoutPanelStates  List(LayoutPanelState)
}

HeaderType {
  Idname     Str
  SpaceType  Int
  RegionType Int
}

MenuType {
  Idname             Str
  Label              Str
  TranslationContext Str
  OwnerId            Str
  Description        Str
  Flag               Int
}

uiListType {
  Idname Str
}

uiList {
  ListType    Option(uiListType)
  ListId      Str
  LayoutType  Int
  Flag        Int
  ListGrip    Int
  ListLastLen Int
  ListLastActivei Int
  FilterName  Str
  FilterFlag  Int
  FilterSortFlag Int
}

AssetShelfType {
  Idname             Str
  SpaceType          Int
  IdTypesPrefilter   Int
  ActivateOperator   Str
  DragOperator       Str
  Flag               Int
  DefaultPreviewSize Int
}

ARegionType {
  RegionId    Int
  Flag        Int
  Minsizex    Int, Minsizey Int
  Prefsizex   Int, Prefsizey Int
  Keymapflag  Int
  DoLock      Int
  Lock        Int
  Paneltypes  List(PanelType)
  Headertypes List(HeaderType)
}

SpaceType {
  Name        Str
  SpaceId     Int
  IconId      Int
  Keymapflag  Int
  Regiontypes List(ARegionType)
}

AZone {
  Region Option(ARegion)
  Type   Int
  X1     Int, Y1 Int, X2 Int, Y2 Int
  Rect   Rcti
  Alpha  Float
}

ARegion {
  V2d             View2D
  Winrct          Rcti
  Drawrct         Rcti
  Winx            Int, Winy Int
  Visible         Int
  Regiontype      Int
  Alignment       Int
  Flag            Int
  Sizex           Int, Sizey Int
  DoDraw          Int
  Overlap         Int
  FlagFullscreen  Int
  Regiondata      Any
  Panels          List(Panel)
  UiLists         List(uiList)
  UiBlocks        List(uiBlock)
  Type            Option(ARegionType)
  SearchFilter    Str
}

SpaceLink {
  SpaceType  Int
  Blockscale Float
  Regionbase List(ARegion)
}

View3DShading {
  Type                  Int
  PrevType              Int
  PrevTypeWire          Int
  ColorType             Int
  Flag                  Int
  Light                 Int
  BackgroundType        Int
  CavityType            Int
  WireColorType         Int
  StudioLight           Str
  LookdevLight          Str
  Matcap                Str
  SingleColor           Float3
  StudiolightRotZ       Float
  StudiolightBackground Float
  StudiolightIntensity  Float
  StudiolightBlur       Float
  ObjectOutlineColor    Float3
  XrayAlpha             Float
  XrayAlphaWire         Float
  CavityValleyFactor    Float
  CavityRidgeFactor     Float
  BackgroundColor       Float3
  CurvatureRidgeFactor  Float
  CurvatureValleyFactor Float
  RenderPass            Int
  AovName               Str
}

View3DOverlay {
  Flag                    Int
  EditFlag                Int
  NormalsLength           Float
  NormalsConstantScreenSize Float
  BackwireOpacity         Float
  PaintFlag               Int
  WpaintFlag              Int
  TexturePaintModeOpacity Float
  VertexPaintModeOpacity  Float
  WeightPaintModeOpacity  Float
  SculptModeMaskOpacity   Float
  SculptModeFaceSetsOpacity Float
  ViewerAttributeOpacity  Float
  XrayAlphaBone           Float
  BoneWireAlpha           Float
  FadeInactiveAlpha       Float
  WireframeThreshold      Float
  WireframeOpacity        Float
  RetopologyOffset        Float
  GpencilPaperOpacity     Float
  GpencilGridOpacity      Float
  GpencilFadeLayer        Float
  GpencilVertexPaintOpacity Float
  HandleDisplay           Int
  SculptCurvesCageOpacity Float
}

RegionView3D {
  Winmat           Float4x4
  Viewmat          Float4x4
  Viewinv          Float4x4
  Persmat          Float4x4
  Persinv          Float4x4
  Viewcamtexcofac  Float4
  Viewmatob        Float4x4
  Persmatob        Float4x4
  Clip             (Float4, Float4, Float4, Float4, Float4, Float4)
  ClipLocal        (Float4, Float4, Float4, Float4, Float4, Float4)
  Clipbb           Option(List(Float3))
  Ofs              Float3
  Dist             Float
  Camdx            Float, Camdy Float
  Pixsize          Float
  Viewquat         Quaternion
  Camzoom          Float
  IsPersp          Int
  Persp            Int
  View             Int
  ViewAxisRoll     Int
  Viewlock         Int
  RuntimeViewlock  Int
  ViewlockQuad     Int
  Ofslock          Float2
  Twdrawflag       Int
  Rflag            Int
  TexelSize        Float
}

View3D SpaceLink & {
  SpaceType        1
  Scene            Option(Scene)
  Camera           Option(Object)
  ObCenter         Option(Object)
  RenderBorder     Rctf
  Localvd          Option(View3D)
  ObCenterBone     Str
  LocalViewUid     Int
  Layact           Int
  LocalCollectionsUid Int
  ObCenterCursor   Int
  Scenelock        Int
  GpFlag           Int
  Flag             Int
  Flag2            Int
  Lens             Float
  Grid             Float
  Near             Float
  Far              Float
  Ofs              Float3
  Cursor           Float3
  GizmoFlag        Int
  GizmoShowObject  Int
  GizmoShowArmature Int
  GizmoShowEmpty   Int
  GizmoShowLight   Int
  GizmoShowCamera  Int
  Gridflag         Int
  Gridlines        Int
  Gridsubdiv       Int
  VertexOpacity    Float
  Nodetree         Option(bNodeTree)
  Shading          View3DShading
  Overlay          View3DOverlay
  ViewerPath       ViewerPath
}

SpaceProperties SpaceLink & { SpaceType 4, Mainb Int, Mainbo Int, Mainbuser Int, Preview Int, Flag Int, DataContext Int, Pathflag Int, TabSearchResults Int, OutlinerSync Int }
SpaceOutliner   SpaceLink & { SpaceType 3, Treestore Option(Any), SearchString Str, SearchFlags Int,Flag Int, Outlinevis Int, LiboverrideViewMode Int, Storeflag Int, Filter Int, FilterState Int, ShowRestrictFlags Int, FilterIdType Int }
SpaceNode       SpaceLink & { SpaceType 16, Treepath List(Any), Edittree Option(bNodeTree), Nodetree Option(bNodeTree), Id Option(ID), From Option(ID), Flag Int, Texfrom Int, Shaderfrom Int,ReCenter Float2, Zoom Float, Cursor Float2, Overlay Any, SelectedViewerPath ViewerPath }
SpaceImage      SpaceLink & { SpaceType 6, Image Option(Image), Iuser ImageUser, Scopes Scopes, SampleLineHist Histogram, Gpd Option(bGPdata), Cursor Float2, Xof Float, Yof Float, Zoom Float, Centx Float, Centy Float, Mode Int,Pin Bool, Flag Int, UvOpacity Float, TileGridShape Int2, CustomGridSubdiv Int, MaskInfo Any }
SpaceAction     SpaceLink & { SpaceType 12, Action Option(Action), Ads Any, Timeslide Float, Flag Int, Mode Int, ModePrev Int, Autosnap Int, CacheFlag Int }
SpaceGraph      SpaceLink & { SpaceType 2, Ads Any, Mode Int, Autosnap Int, Flag Int, CursorTime Float, CursorVal Float, PivotPoint Int }
SpaceNla        SpaceLink & { SpaceType 13, Autosnap Int, Flag Int, Ads Any }
SpaceSeq        SpaceLink & { SpaceType 8, View2d View2D, Xof Float, Yof Float, Mainb Int, RenderSize Int, Chanshown Int,zebra Int, Flag Int, Zoom Float, View Int, OverlayFrameType Int, CompositeFlag Int, Gpd Option(bGPdata), Cursor Float2 }
SpaceFile       SpaceLink & { SpaceType 5, Params Option(Any), AssetParams Option(Any), Files Option(Any), FoldersPrev List(Any), FoldersNext List(Any), Operator Option(wmOperator),ScrollOffset Int }
SpaceClip       SpaceLink & { SpaceType 17, Clip Option(MovieClip), User MovieClipUser, Scopes Any, Flag Int, Mode Int, View Int, PathLength Int, Xof Float, Yof Float, Xlockof Float, Ylockof Float, Zoom Float, Gpd Option(bGPdata), MaskInfo Any }
SpaceText       SpaceLink & { SpaceType 9, Text Option(Text), Top Int, Left Int, Flags Int, Lheight Int, Tabnumber Int, Wordwrap Int, Dolivehl Int, Showlinenrs Int, ShowSyntax Int, Findstr Str, Replacestr Str, MarginColumn Int }
SpaceConsole    SpaceLink & { SpaceType 18, Lheight Int, History List(Any), Scrollback List(Any), Prompt Str, Language Str, SelStart Int, SelEnd Int }
SpaceUserPref   SpaceLink & { SpaceType 19, FilterType Int, Filter Str }
SpaceSpreadsheet SpaceLink & { SpaceType 20, Flag Int, FilterFlag Int, GeometryComponentType Int, AttributeDomain Int, ObjectEvalState Int, ViewerPath ViewerPath }

ScrVert {
  Vec  Int2
  Flag Int
}

ScrEdge {
  V1     ScrVert
  V2     ScrVert
  Border Int
  Flag   Int
}

ScrAreaMap {
  Vertbase List(ScrVert)
  Edgebase List(ScrEdge)
  Areabase List(ScrArea)
}

ScrArea {
  V1         ScrVert
  V2         ScrVert
  V3         ScrVert
  V4         ScrVert
  Full       Option(bScreen)
  Totrct     Rcti
  Spacetype  Int
  Butspacetype Int
  ButspacetypeSubtype Int
  Winx       Int, Winy Int
  Headertype Int
  DoRefresh  Int
  Flag       Int
  Regionbase List(ARegion)
  Spacedata  List(SpaceLink)
  Actionzones List(AZone)
}

bScreen ID & {
  Type        "SCR"
  Vertbase    List(ScrVert)
  Edgebase    List(ScrEdge)
  Areabase    List(ScrArea)
  Regionbase  List(ARegion)
  Scene       Option(Scene)
  Flag        Int
  Winid       Int
  RedrawsFlag Int
  Temp        Int
  State       Int
  DoDraw      Int
  DoRefresh   Int
  ActiveRegion Option(ARegion)
  Animtimer   Option(wmTimer)
}

WorkSpaceLayout {
  Screen Option(bScreen)
  Name   Str
}

WorkSpaceStatusItem {
  Icon        Int
  Text        Str
  SpaceFactor Float
  Inverted    Bool
}

bToolRef {
  SpaceType Int
  Mode      Int
  Idname    Str
  Flag      Int
}

WorkSpace ID & {
  Type                 "WS"
  Layouts              List(WorkSpaceLayout)
  HookLayoutRelations  List(Any)
  OwnerIds             List(Any)
  Tools                List(bToolRef)
  PinScene             Option(Scene)
  ObjectMode           ObjectMode
  Flags                Int
  Order                Int
  AssetLibraryRef      AssetLibraryReference
  ViewerPath           ViewerPath
  Status               List(WorkSpaceStatusItem)
}

WorkSpaceInstanceHook {
  Active       Option(WorkSpace)
  ActLayout    Option(WorkSpaceLayout)
  TempWorkspaceStore Option(WorkSpace)
  TempLayoutStore    Option(WorkSpaceLayout)
}

wmEvent {
  Type          Int
  Val           Int
  Xy            Int2
  Mval          Int2
  Utf8Buf       Str
  Modifier      Int
  Direction     Int
  Keymodifier   Int
  TabletData    Option(Any)
  Custom        Int
  Customdata    Any
  PrevType      Int
  PrevVal       Int
  PrevXy        Int2
  PrevPressType Int
  PrevPressXy   Int2
  PrevPressModifier Int
}

wmOperatorStatus "RunningModal" | "Cancelled" | "Finished" | "PassThrough" | "Interface"
OpCallContext    "InvokeDefault" | "InvokeRegionWin" | "InvokeRegionChannels" | "InvokeRegionPreview" | "InvokeArea" | "InvokeScreen" | "ExecDefault" | "ExecRegionWin" | "ExecRegionChannels" | "ExecRegionPreview" | "ExecArea" | "ExecScreen"

wmOperatorType {
  Name           Str
  Idname         Str
  TranslationContext Str
  Description    Str
  UndoGroup      Str
  Srna           Option(StructRNA)
  Flag           Int
}

wmOperator {
  Idname     Str
  Properties Option(IDProperty)
  Type       Option(wmOperatorType)
  Customdata Any
  Ptr        Option(PointerRNA)
  Reports    Option(ReportList)
  Macro      List(wmOperator)
  Upmacro    Option(wmOperator)
  Layout     Option(uiLayout)
  Flag       Int
}

wmKeyMapItem {
  Idname     Str
  Properties Option(IDProperty)
  Propvalue  Int
  Type       Int
  Val        Int
  Shift      Int
  Ctrl       Int
  Alt        Int
  Oskey      Int
  Hyper      Int
  Keymodifier Int
  Direction  Int
  Flag       Int
  Maptype    Int
  Id         Int
  Ptr        Option(PointerRNA)
}

wmKeyMap {
  Idname            Str
  Spaceid           Int
  Regionid          Int
  OwnerId           Str
  Flag              Int
  KmiId             Int
  Items             List(wmKeyMapItem)
  DiffItems         List(Any)
  ModalItems        Option(Any)
}

wmKeyConfig {
  Idname   Str
  Basename Str
  Keymaps  List(wmKeyMap)
  Actkeymap Int
  Flag     Int
}

wmGizmoProperty {
  Type       Option(Any)
  TargetRna  PointerRNA
  Prop       Option(PropertyRNA)
  Index      Int
  Value      Any
}

wmGizmoType {
  Idname     Str
  StructSize Int
  Srna       Option(StructRNA)
}

wmGizmo {
  Type            Option(wmGizmoType)
  ParentGzgroup   Option(wmGizmoGroup)
  InteractionData Any
  Ptr             Option(PointerRNA)
  Properties      Option(IDProperty)
  MatrixSpace     Float4x4
  MatrixBasis     Float4x4
  MatrixOffset    Float4x4
  MatrixFinal     Float4x4
  Color           Color4f
  ColorHi         Color4f
  ScaleFinal      Float
  ScaleBasis      Float
  LineWidth       Float
  SelectBias      Float
  Flag            Int
  State           Int
  HighlightPart   Int
  DragPart        Int
  TargetProperties List(wmGizmoProperty)
}

wmGizmoGroupType {
  Idname      Str
  Name        Str
  OwnerId     Str
  Spaceid     Int
  Regionid    Int
  Gizmoflag   Int
  Keymap      Option(wmKeyMap)
  Srna        Option(StructRNA)
}

wmGizmoGroup {
  Type            Option(wmGizmoGroupType)
  Gizmos          List(wmGizmo)
  Ptr             Option(PointerRNA)
  Properties      Option(IDProperty)
  Customdata      Any
  InitFlag        Int
}

wmTimer {
  EventType    Int
  TimeStep     Double
  TimeStart    Double
  TimeLast     Double
  TimeDelta    Double
  TimeDuration Double
  Customdata   Any
  Flags        Int
}

wmNotifier {
  Window     Option(wmWindow)
  Category   Int
  Data       Int
  Subtype    Int
  Action     Int
  Reference  Any
}

wmJob {
  Win       Option(wmWindow)
  Owner     Any
  Name      Str
  Flag      Int
  JobType   Int
  Suspended Bool
  Running   Bool
  Ready     Bool
  DoUpdate  Bool
  Stop      Bool
  Progress  Float
}

wmDrag {
  Icon       Int
  Type       Int
  Poin       Any
  Path       Str
  Value      Double
  Imb        Option(ImBuf)
  Scale      Float
  Sx         Int, Sy Int
  Opname     Str
  Flags      Int
}

wmDropBox {
  Opname     Str
  optype     Option(wmOperatorType)
  Ptr        Option(PointerRNA)
  Opcontext  OpCallContext
}

wmWindow {
  Parent             Option(wmWindow)
  Scene              Option(Scene)
  NewScene           Option(Scene)
  ViewLayerName      Str
  UnpinnedScene      Option(Scene)
  WorkspaceHook      Option(WorkSpaceInstanceHook)
  GlobalAreas        ScrAreaMap
  Winid              Int
  Posx               Int, Posy Int
  Sizex              Int, Sizey Int
  Windowstate        Int
  Active             Int
  Cursor             Int
  Lastcursor         Int
  Modalcursor        Int
  Grabcursor         Int
  Addmousemove       Bool
  Winflag            Int
  Stereo3dFormat     Option(Any)
  EventQueue         List(wmEvent)
  Eventstate         Option(wmEvent)
  Handlers           List(Any)
  Modalhandlers      List(Any)
}

wmWindowManager ID & {
  Type                   "WM"
  Windows                List(wmWindow)
  Windrawable            Option(wmWindow)
  Winactive              Option(wmWindow)
  Initialized            Int
  FileSaved              Int
  OpUndoDepth            Int
  OutlinerSyncSelectDirty Int
  IsInterfaceLocked      Bool
  Reports                ReportList
  NotifierQueue          List(wmNotifier)
  Operators              List(wmOperator)
  Keyconfigs             List(wmKeyConfig)
  Defaultconf            Option(wmKeyConfig)
  Addonconf              Option(wmKeyConfig)
  Userconf               Option(wmKeyConfig)
  Timers                 List(wmTimer)
  Jobs                   List(wmJob)
  Drags                  List(wmDrag)
  UndoStack              Option(UndoStack)
}

// =============================================================================
// 12. User Interface, Widgets, Views, Fonts & Translations (UI / BLF / BLT)
// =============================================================================

FontShadowType "None" | "Blur3x3" | "Blur5x5" | "Outline"
BLFWrapMode    "Minimal" | "Typographical" | "Path" | "HardLimit"
ResultBLF      { Lines Int, Width Int }

DateFormat "Default" | "LE_Slash" | "LE_Dot" | "LE_Dash" | "ME_Slash" | "BE_Slash" | "BE_Dot" | "BE_Dash"
TimeFormat "H24" | "H12"

BLTI18nContextDescriptor {
  CId   Str
  PyId  Str
  Value Str
}

EmbossType "Emboss" | "None" | "Pulldown" | "PieMenu" | "NoneOrStatus" | "Undefined"
ButtonType "But" | "Row" | "Text" | "Menu" | "ButToggle" | "Num" | "NumSlider" | "Color" | "ButMenu" | "Label" | "Sepr" | "SeprLine" | "SeprSpacer" | "Link" | "Inlink" | "KeyEvent" | "Hsvcube" | "Pulldown" | "Roundbox" | "Colorband" | "Unitvec" | "Curve" | "ListBox" | "ListRow" | "Tab" | "Popover" | "Scroll" | "Block" | "ButValue" | "SearchMenu" | "Extra" | "HotKeyEvent" | "Image" | "Histogram" | "Waveform" | "Vectorscope" | "Progress" | "NodeSocket" | "Grip" | "TrackPreview" | "CurveProfile" | "Decorator" | "ViewItem" | "TextBox"
FontStyleAlign "Left" | "Center" | "Right"

uiFontStyle {
  UifontId        Int
  Points          Float
  CharacterWeight Int
  Shadow          Int
  Shadx           Int
  Shady           Int
  Shadowalpha     Float
  Shadowcolor     Float
  Bold            Bool
  Italic          Bool
}

uiStyle {
  Name          Str
  Panelzoom     Float
  Paneltitle    uiFontStyle
  Grouplabel    uiFontStyle
  Widget        uiFontStyle
  Tooltip       uiFontStyle
  Columnspace   Int
  Templatespace Int
  Boxspace      Int
  Buttonspacex  Int
  Buttonspacey  Int
  Panelspace    Int
  Panelouter    Int
}

uiWidgetColors {
  Outline       Color4b
  OutlineSel    Color4b
  Inner         Color4b
  InnerSel      Color4b
  Item          Color4b
  Text          Color4b
  TextSel       Color4b
  Shaded        Bool
  Shadetop      Int
  Shadedown     Int
  Roundness     Float
}

ColorPicker {
  HsvPerceptual       Float3
  HsvPerceptualInit   Float3
  HsvPerceptualSlider Float3
  HsvLinearSlider     Float3
  RgbPerceptualSlider Float3
  Hexcol              Str
  IsInit              Bool
  UseColorCubic       Bool
  UseColorLock        Bool
  UseLuminosityLock   Bool
  LuminosityLockValue Float
  HasAlpha            Bool
}

PieMenuData {
  Title           Str
  Icon            Int
  PieDirMask      Int
  PieDir          Float2
  PieCenterInit   Float2
  PieCenterSpawned Float2
  LastPos         Float2
  DurationGesture Double
  Flags           Int
  EventType       Int
  Alphafac        Float
}

TextboxState {
  Scroll       Int
  VisibleLines Int
}

TextWrapCache {
  WrapWidth    Int
  Aspect       Float
  Text         Str
  WrappedLines List(Str)
}

MarkdownItemText {
  X         Float
  Y         Float
  SizePx    Float
  FontId    Int
  Weight    Int
  Italic    Bool
  IsInQuote Bool
  Text      Str
  Url       Option(Str)
}

MarkdownItemHorizontalRule { Y Float }
MarkdownItemQuoteLine      { X Float, Y Float, Height Float }
MarkdownItemCodeBox        { Rect Rctf, Kind Int }
MarkdownItem               MarkdownItemText | MarkdownItemHorizontalRule | MarkdownItemQuoteLine | MarkdownItemCodeBox

MarkdownLayout {
  Items         List(MarkdownItem)
  ContentHeight Float
}

uiButton {
  Type            ButtonType
  Pointype        Int
  Bit             Bool
  Bitnr           Int
  Retval          Int
  Str             Str
  Drawstr         Str
  Rect            Rctf
  Hardmin         Float
  Hardmax         Float
  Softmin         Float
  Softmax         Float
  Tip             Str
  DisabledInfo    Option(Str)
  Emboss          EmbossType
  Block           Option(uiBlock)
  Alignnr         Int
  Rnapoin         Option(PointerRNA)
  Rnaprop         Option(PropertyRNA)
  Rnaindex        Int
  Icon            Int
  Iconadd         Int
  IconScale       Float
  Col             Color4b
  Flag            Int
  Drawflag        Int
  Dragflag        Int
  Dragtype        Int
  Optype          Option(wmOperatorType)
  Opptr           Option(PointerRNA)
  Opcontext       OpCallContext
  UnitType        Int
  Pos             Int
  Selsta          Int
  Selend          Int
  Placeholder     Option(Str)
  Layout          Option(uiLayout)
  Context         Option(bContextStore)
  Imb             Option(ImBuf)
}

uiButtonText         uiButton & { Type "Text", UseLabelStyle Bool }
uiButtonTextBox      uiButton & { Type "TextBox", State Option(TextboxState), LastTotalLines Int, WrapCache Option(TextWrapCache) }
uiButtonPush         uiButton & { Type "But", DrawAsLink Bool, DrawAsOverlay Bool }
uiButtonNumber       uiButton & { Type "Num", StepSize Float, Precision Float }
uiButtonNumberSlider uiButton & { Type "NumSlider", StepSize Float, Precision Float }
uiButtonColor        uiButton & { Type "Color", IsPaletteColor Bool, PaletteColorIndex Int }
uiButtonTab          uiButton & { Type "Tab", Menu Option(MenuType) }
uiButtonSearch       uiButton & { Type "SearchMenu", PreviewRows Int, PreviewCols Int, ResultsAreSuggestions Bool }
uiButtonDecorator    uiButton & { Type "Decorator", DecoratedRnaindex Int, ToggleKeyframeOnClick Bool }
uiButtonProgress     uiButton & { Type "Progress", ProgressFactor Float, ProgressType Int }
uiButtonLabel        uiButton & { Type "Label", AlphaFactor Float, DrawIconBorder Bool, MaxLines Int, TextAlign FontStyleAlign, Markdown Option(MarkdownLayout) }
uiButtonViewItem     uiButton & { Type "ViewItem", ViewItem Option(AbstractViewItem), DrawWidth Int, DrawHeight Int }

LayoutType      "Panel" | "Header" | "Menu" | "Toolbar" | "PieMenu" | "VerticalBar"
LayoutDirection "Horizontal" | "Vertical"
ItemType        "Button" | "Row" | "Column" | "ColumnFlow" | "GridFlow" | "Box" | "Absolute" | "Split" | "Overlap" | "Radial" | "Root" | "LayoutPanelHeader" | "LayoutPanelBody"

uiItem {
  ItemType     ItemType
  Flag         Int
  Parent       Option(uiLayout)
  Context      Option(bContextStore)
  Heading      Str
  Align        Bool
  VariableSize Bool
  Emboss       EmbossType
  ScaleX       Float
  ScaleY       Float
  UiUnitsX     Int
  UiUnitsY     Int
  SearchWeight Float
}

uiLayout uiItem & {
  Root     Option(uiLayoutRoot)
  Items    List(uiItem)
  X        Int, Y Int
  W        Int, H Int
}

uiLayoutRoot {
  Type             LayoutType
  Opcontext        OpCallContext
  Emw              Int, Emh Int
  Padding          Int
  Style            Option(uiStyle)
  Block            Option(uiBlock)
  Layout           uiLayout
  Direction        LayoutDirection
  UseDynamicHeight Bool
}

uiBlock {
  Name            Str
  Buttons         List(uiButton)
  Panel           Option(Panel)
  Oldblock        Option(uiBlock)
  Layouts         List(uiLayoutRoot)
  Curlayout       Option(uiLayout)
  Contexts        List(bContextStore)
  Views           List(AbstractView)
  Winmat          Float4x4
  Rect            Rctf
  Safety          Rctf
  Aspect          Float
  AlertLevel      Int
  Flag            Int
  Alignnr         Int
  ContentHints    Int
  Direction       Int
  ThemeStyle      Int
  Emboss          EmbossType
  AutoOpen        Bool
  Lock            Bool
  Lockstr         Option(Str)
  Active          Bool
  Tooltipdisabled Bool
  Endblock        Bool
  BoundsType      Int
  BoundsOffset    Int2
  Bounds          Int
  Minbounds       Int
  Unit            Option(UnitSettings)
  ColorPickers    List(ColorPicker)
  DisplayDevice   Str
  PieData         Option(PieMenuData)
}

PopupMenu {
  Block     Option(uiBlock)
  Layout    Option(uiLayout)
  But       Option(uiButton)
  Butregion Option(ARegion)
  Title     Str
  Mx        Int, My Int
  Popup     Bool
  Slideout  Bool
}

TooltipStyle   "Normal" | "Header" | "Mono"
TooltipColorID "Main" | "Sub" | "Value" | "Active" | "Warning" | "Error"

TooltipImage {
  Ibuf          Option(ImBuf)
  Width         Int
  Height        Int
  Premultiplied Bool
  Border        Bool
  TextColor     Bool
  Background    Int
}

TooltipField {
  Text    Str
  TextSuffix Str
  Style   TooltipStyle
  ColorId TooltipColorID
  IsPad   Bool
  Image   Option(TooltipImage)
}

TooltipData {
  Fields List(TooltipField)
}

SearchItems {
  Maxitem   Int
  Totitem   Int
  Maxstrlen Int
  Offset    Int
  OffsetI   Int
  More      Int
  Names     List(Str)
  Icons     List(Int)
  ButFlags  List(Int)
  HasIcon   Bool
}

ViewScrollDirection "Up" | "Down"
PageScrollDirection "Up" | "Down" | "Top" | "Bottom"

AbstractView {
  IsReconstructed        Bool
  PrevFilterString       Str
  NeedsFiltering         Bool
  Bounds                 Option(Rcti)
  ContextMenuTitle       Str
  PopupKeepOpen          Bool
  IsMultiselectSupported Bool
}

AbstractViewItem {
  View                   Option(AbstractView)
  ViewItemBut            Option(uiButtonViewItem)
  IsActivatable          Bool
  IsInteractive          Bool
  IsHovered              Bool
  IsActive               Bool
  IsSelected             Bool
  IsRenaming             Bool
  IsHighlightedSearch    Bool
  IsFilteredVisible      Bool
  IsAlwaysCollapsible    Bool
  SelectOnClick          Bool
  ReactivateOnClick      Bool
  ActivateForContextMenu Bool
}

GridViewStyle {
  TileWidth  Int
  TileHeight Int
}

AbstractGridViewItem AbstractViewItem & {
  Identifier    Str
  Label         Str
  PreviewIconId Int
  HideLabel     Bool
}

AbstractGridView AbstractView & {
  Items             List(AbstractGridViewItem)
  ItemCountFiltered Option(Int)
  Style             GridViewStyle
  ColsPerRow        Int
}

AbstractTreeViewItem AbstractViewItem & {
  Label    Str
  Icon     Int
  IsOpen   Bool
  Parent   Option(AbstractTreeViewItem)
  Children List(AbstractTreeViewItem)
}

AbstractTreeView AbstractView & {
  RootItems          List(AbstractTreeViewItem)
  CustomHeight       Option(Int)
  ScrollValue        Option(Int)
  LastTotItems       Int
  ShowDisplayOptions Bool
  InvertSearchFilter Bool
  SearchString       Str
  SortAlpha          Bool
  InvertSortType     Int
}

Icon {
  Obj      Any
  ObjType  Int
  Flag     Int
  IdType   Int
}

IconGeom {
  IconId      Int
  CoordsLen   Int
  CoordsRange Int2
}

IconBufferRef {
  Width    Int
  Height   Int
  Channels Int
  Buffer   List(Byte)
}

PreviewImageRenderEndStatus "Finished" | "Failed" | "Cancelled"

PreviewImage {
  W        (Int, Int)
  H        (Int, Int)
  Flag     (Int, Int)
  ChangedTimestamp (Int, Int)
  Rect     (List(Int), List(Int))
  IconId   Int
  Tag      Int
  UserCount Int
}

// =============================================================================
// 13. Compositor System (COM)
// =============================================================================

CompositorExecutionMode "Render" | "Preview"
CompositorResultType    "Float" | "Float2" | "Float3" | "Float4" | "Color" | "Int" | "Int2" | "Int3" | "Bool" | "Float4x4" | "Menu" | "String"
CompositorPrecision     "Half" | "Full"

CompositorDomain {
  DataSize       Int2
  DisplaySize    Int2
  DataOffset     Int2
  Transformation Float3x3
  IsTransposed   Bool
}

CryptomatteMetaData {
  Hash       Str
  Conversion Str
  Manifest   Str
}

CompositorMetaData {
  IsNonColorData Bool
  Cryptomatte    CryptomatteMetaData
  Fields         Map(Str, Str)
}

CompositorResult {
  Type           CompositorResultType
  Precision      CompositorPrecision
  Domain         CompositorDomain
  IsSingleValue  Bool
  SingleValue    Any
  ReferenceCount Int
  MetaData       CompositorMetaData
  Texture        Option(GPUTexture)
}

InputRealizationMode "None" | "Transforms" | "OperationDomain"
ImplicitInputType    "UniformImageCoordinates" | "SceneFrame"

InputDescriptor {
  Type                CompositorResultType
  RealizationMode     InputRealizationMode
  ImplicitInput       Option(ImplicitInputType)
  DomainPriority      Int
  ExpectsSingleValue  Bool
  SkipTypeConversion  Bool
}

CompositorOperation {
  Results              Map(Str, CompositorResult)
  InputDescriptors     Map(Str, InputDescriptor)
  ResultsMappedToInputs Map(Str, CompositorResult)
}

SimpleOperation CompositorOperation & {
  OutputIdentifier Str
  InputIdentifier  Str
}

NodeOperation CompositorOperation & {
  Node           bNode
  ComputeContext ComputeContext
}

ZoneOperation CompositorOperation & {
  Zone           bNodeTreeZone
  ComputeContext ComputeContext
}

ShaderOperation CompositorOperation & {
  ComputeContext ComputeContext
}

MultiFunctionProcedureOperation CompositorOperation & {
  ComputeContext       ComputeContext
  ParameterIdentifiers List(Str)
}

CompositorSchedule {
  NodeGroup      bNodeTree
  Zone           Option(bNodeTreeZone)
  Nodes          List(bNode)
  UnneededInputs Set(bNodeSocket)
}

MorphologicalBlurOperation "Dilate" | "Erode"
PaddingMethod              "Zero" | "Extend"
SummedAreaTableOperation   "Identity" | "Square"
CoordinatesType            "Uniform" | "Normalized" | "Pixel"
DenoisedAuxiliaryPassType  "Albedo" | "Normal"

BokehKernelKey {
  Size          Int2
  Sides         Int
  Rotation      Float
  Roundness     Float
  Catadioptric  Float
  LensShift     Float
}

CachedImageKey {
  LayerIndex Int
  PassName   Str
  ViewName   Str
  Frame      Int
}

CachedMaskKey {
  DataSize          Int2
  DisplaySize       Int2
  DataOffset        Int2
  AspectRatio       Float
  UseFeather        Bool
  SrgbToLinear      Bool
  Frame             Int
  MotionBlurSamples Int
  MotionBlurShutter Float
}

CachedShaderKey {
  InfoName  Str
  Precision CompositorPrecision
}

DericheGaussianCoefficients {
  Sigma                            Float
  FeedbackCoefficients             Float4
  CausalFeedforwardCoefficients    Float4
  NonCausalFeedforwardCoefficients Float4
  CausalBoundaryCoefficient        Float
  NonCausalBoundaryCoefficient     Float
}

VanVlietGaussianCoefficients {
  Sigma                                Float
  FirstCausalFeedforwardCoefficients   Float2
  FirstNonCausalFeedforwardCoeffs      Float2
  FirstFeedbackCoefficients            Float2
  SecondCausalFeedforwardCoefficients  Float2
  SecondNonCausalFeedforwardCoeffs     Float2
  SecondFeedbackCoefficients           Float2
  FirstCausalBoundaryCoefficient       Float
  FirstNonCausalBoundaryCoefficient    Float
  SecondCausalBoundaryCoefficient      Float
  SecondNonCausalBoundaryCoefficient   Float
}

FogGlowKernel {
  KernelSize          Int
  SpatialSize         Int2
  FieldOfView         AngleRadian
  NormalizationFactor Float
}

StringImageKey {
  String              Str
  Font                Option(VFont)
  Size                Float
  HorizontalAlignment Int
  VerticalAlignment   Int
  WrapWidth           Option(Int)
}

StaticCacheManager {
  BokehKernels      Map(BokehKernelKey, CompositorResult)
  CachedImages      Map(CachedImageKey, CompositorResult)
  CachedMasks       Map(CachedMaskKey, CompositorResult)
  DericheCoeffs     Map(Float, DericheGaussianCoefficients)
  VanVlietCoeffs    Map(Float, VanVlietGaussianCoefficients)
  FogGlowKernels    List(FogGlowKernel)
  StringImages      Map(StringImageKey, CompositorResult)
}

// =============================================================================
// 14. Draw Manager & Viewport Render Engines: EEVEE, Workbench, Overlay, GPencil, Image, Select (DRW)
// =============================================================================

DRWSelectStage "PassPre" | "PassPost"
DRWState       Int

DRWView {
  Viewmat      Float4x4
  Viewinv      Float4x4
  Winmat       Float4x4
  Wininv       Float4x4
  Persmat      Float4x4
  Persinv      Float4x4
  ClipPlanes   List(Float4)
  IsInverted   Bool
  VisibilityOk Bool
}

DRWPass {
  Name  Str
  State DRWState
}

PassSimple   DRWPass
PassMain     DRWPass
PassSortable DRWPass

ObjectRef {
  Object      Object
  DupliObject Option(DupliObject)
  DupliParent Option(Object)
}

ObjectHandle {
  ObRef      ObjectRef
  Recalc     Int
  ResHandle  Int
}

DrawEngine {
  Name Str
  Used Bool
}

RenderEngineType {
  Idname Str
  Name   Str
  Flag   Int
}

RenderEngine {
  Type       Option(RenderEngineType)
  Depsgraph  Option(Depsgraph)
  Scene      Option(Scene)
  ViewLayer  Option(ViewLayer)
  CameraOverride Option(Object)
  ResolutionX Int
  ResolutionY Int
  Flag       Int
}

// --- EEVEE Engine Types ---

EEVEECameraType    "Persp" | "Ortho" | "PanoEquirect" | "PanoEquisolid" | "PanoEquidistant" | "PanoMirror" | "PanoEquiangularCubemapFace" | "PanoFisheyeLensPolynomial" | "PanoCentralCylindrical"
EEVEEPanoramicFace "PosX" | "NegX" | "PosY" | "NegY" | "PosZ" | "NegZ"

EEVEECameraData {
  Persmat                       Float4x4
  Persinv                       Float4x4
  Viewmat                       Float4x4
  Viewinv                       Float4x4
  Winmat                        Float4x4
  Wininv                        Float4x4
  UvScale                       Float2
  UvBias                        Float2
  EquirectScale                 Float2
  EquirectScaleInv              Float2
  EquirectBias                  Float2
  FisheyeFov                    Float
  FisheyeLens                   Float
  FisheyePolynomialCoefficients Float4
  CentralCylindricalRange       Float4
  FisheyeSensor                 Float2
  FisheyePolynomialBias         Float
  PanoramicViewOverscan         Float
  PanoramicViewMask             Int
  ClipNear                      Float
  ClipFar                       Float
  Type                          EEVEECameraType
  ScreenDiagonalLength          Float
  Initialized                   Bool
}

EEVEEDebugMode "None" | "LightCulling" | "HizValidation" | "IrradianceCacheSurfelsNormal" | "IrradianceCacheSurfelsIrradiance" | "IrradianceCacheSurfelsVisibility" | "IrradianceCacheSurfelsCluster" | "IrradianceCacheVirtualOffset" | "IrradianceCacheValidity" | "ShadowTilemaps" | "ShadowValues" | "ShadowTileRandomColor" | "ShadowTilemapRandomColor" | "ShadowAtomicCost" | "GbufferStorage" | "GbufferEvaluation" | "DofPlanes"

EEVEEPassStorageType "Color" | "Value" | "Cryptomatte" | "DenoisingDepth"
EEVEEPassCategory    Int

EEVEEFilmSample {
  Texel        Int2
  Weight       Float
  WeightSumInv Float
}

EEVEEFilmData {
  Extent                    Int2
  Offset                    Int2
  RenderExtent              Int2
  SubpixelOffset            Float2
  ExtentInv                 Float2
  Overscan                  Int
  UseHistory                Bool
  BackgroundOpacity         Float
  ColorLen                  Int
  ValueLen                  Int
  MistId                    Int
  NormalId                  Int
  PositionId                Int
  VectorId                  Int
  DiffuseLightId            Int
  DiffuseColorId            Int
  SpecularLightId           Int
  SpecularColorId           Int
  VolumeLightId             Int
  EmissionId                Int
  EnvironmentId             Int
  ShadowId                  Int
  AmbientOcclusionId        Int
  TransparentId             Int
  DenoisingDepthId          Int
  DenoisingNormalId         Int
  DenoisingRoughnessId      Int
  DenoisingDiffuseAlbedoId  Int
  DenoisingSpecularAlbedoId Int
  DepthId                   Int
  CombinedId                Int
  DisplayId                 Int
  DisplayStorageType        EEVEEPassStorageType
  AovColorId                Int
  AovColorLen               Int
  AovValueId                Int
  AovValueLen               Int
  CryptomatteObjectId       Int
  CryptomatteAssetId        Int
  CryptomatteMaterialId     Int
  CryptomatteSamplesLen     Int
  MistScale                 Float
  MistBias                  Float
  MistExponent              Float
  ExposureScale             Float
  ScalingFactor             Int
  TextureLodBias            Float
  FilterRadius              Float
  SamplesLen                Int
  SamplesWeightTotal        Float
  Samples                   List(EEVEEFilmSample)
}

EEVEEGBufferMode "None" | "Diffuse" | "Reflection" | "ReflectionColorless" | "Unlit" | "Refraction" | "RefractionColorless" | "Translucent" | "Subsurface" | "ThinRefraction" | "ThinRefractionColorless"

EEVEEGBuffer {
  HeaderLayerCount  Int
  ClosureLayerCount Int
  NormalLayerCount  Int
}

EEVEEHiZData {
  UvScale Float2
}

EEVEELightType "Sun" | "Point" | "Spot" | "Area" | "Ellipse"

EEVEELightData {
  ObjectToWorld       Transform
  PowerFactor         Float4
  ShapePower          Float
  PointPower          Float
  ResourceId          Int
  Flags               Int
  Color               Float3
  Type                EEVEELightType
  ClipNear            Int
  ClipFar             Int
  TilemapIndex        Int
  FilterRadius        Float
  LodBias             Float
  LodMin              Float
  LightSetMembership  Int2
}

EEVEELightCullingData {
  TileToUvFac    Float2
  ZbinScale      Float
  ZbinBias       Float
  ItemsCount     Int
  LocalLightsLen Int
  SunLightsLen   Int
  VisibleCount   Int
  TileSize       Float
  TileXLen       Int
  TileYLen       Int
  TileWordLen    Int
  ViewIsFlipped  Bool
}

EEVEEShadowProjectionType "Cubeface" | "Clipmap" | "Cascade"
EEVEECubeFace             "ZNeg" | "XPos" | "XNeg" | "YPos" | "YNeg" | "ZPos"

EEVEEShadowTileMapData {
  Viewmat             Float4x4
  Winmat              Float4x4
  Corners             (Float4, Float4, Float4, Float4)
  GridOffset          Int2
  GridShift           Int2
  ProjectionType      EEVEEShadowProjectionType
  TilesIndex          Int
  ClipDataIndex       Int
  LightType           EEVEELightType
  IsDirty             Bool
  EffectiveLodMin     Int
  ClipNear            Float
  ClipFar             Float
  HalfSize            Float
  CenterOffset        Float2
  ShadowSetMembership Int2
}

EEVEEShadowTileData {
  Page        Int3
  CacheIndex  Int
  IsUsed      Bool
  DoUpdate    Bool
  IsAllocated Bool
  IsRendered  Bool
  IsCached    Bool
}

EEVEEShadowSceneData {
  RayCount        Int
  StepCount       Int
  FilmPixelRadius Float
  UseJitter       Bool
  UseDebugCost    Bool
}

EEVEEShadowStatistics {
  PageUsedCount      Int
  PageUpdateCount    Int
  PageAllocatedCount Int
  PageRenderedCount  Int
  ViewNeededCount    Int
}

EEVEEMaterialPipeline "Deferred" | "Forward" | "PrepassDeferred" | "PrepassDeferredVelocity" | "PrepassForward" | "PrepassForwardVelocity" | "PrepassOverlap" | "PrepassPlanar" | "VolumeOccupancy" | "VolumeMaterial" | "Shadow" | "Capture"
EEVEEMaterialGeometry "Mesh" | "PointCloud" | "Curves" | "Gsplat" | "Volume" | "World"

EEVEEDepthOfFieldData {
  ScatterColorThreshold   Float
  ScatterNeighborMaxColor Float
  BokehBlades             Float
  BokehAnisotropicScale   Float2
  BokehRotation           Float
  GatherUvFac             Float2
  ScatterMaxRect          Int
  CameraType              Int
  CocMul                  Float
  CocBias                 Float
  CocAbsMax               Float
}

EEVEEMotionBlurData {
  TargetSizeInv Float2
  MotionScale   Float2
  DepthScale    Float
}

EEVEEVolumesInfoData {
  WinmatFinite             Float4x4
  WininvFinite             Float4x4
  WininvStable             Float4x4
  WinmatStable             Float4x4
  HistoryWinmatStable      Float4x4
  CurrViewToPastView       Float4x4
  TexSize                  Int3
  LightClamp               Float
  InvTexSize               Float3
  ShadowSteps              Float
  CoordScale               Float2
  MainViewExtent           Float2
  MainViewExtentInv        Float2
  TileSize                 Int
  TileSizeLod              Int
  DepthNear                Float
  DepthFar                 Float
  DepthDistribution        Float
  HistoryDepthNear         Float
  HistoryDepthFar          Float
  HistoryDepthDistribution Float
  HistoryOpacity           Float
}

EEVEEClampData {
  SunThreshold    Float
  SurfaceDirect   Float
  SurfaceIndirect Float
  VolumeDirect    Float
  VolumeIndirect  Float
  DirectScale     Float
  IndirectScale   Float
}

EEVEEPipelineInfoData {
  AlphaHashScale                Float
  RayType                       Int
  IsMainViewInverted            Bool
  GbufferAdditionalDataLayerId  Int
  UseMonochromaticTransmittance Bool
  CanRaycast                    Bool
}

EEVEEUniformData {
  Camera     EEVEECameraData
  Clamp      EEVEEClampData
  Film       EEVEEFilmData
  Hiz        EEVEEHiZData
  Shadow     EEVEEShadowSceneData
  Volumes    EEVEEVolumesInfoData
  Time       Float
  Frame      Float
}

EEVEESamplingDimension "FilterU" | "FilterV" | "LensU" | "LensV" | "Time" | "ShadowU" | "ShadowV" | "ShadowW" | "ShadowX" | "ShadowY" | "Closure" | "Lightprobe" | "Transparency" | "SssU" | "SssV" | "RaytraceU" | "RaytraceV" | "RaytraceW" | "RaytraceX" | "AoU" | "AoV" | "AoW" | "CurvesU" | "VolumeU" | "VolumeV" | "VolumeW" | "ShadowI" | "ShadowJ" | "ShadowK" | "GbufferU" | "GbufferV" | "GbufferW" | "FilmU"

EEVEEInstance DrawEngine & {
  Name                    "EEVEE"
  Depsgraph               Option(Depsgraph)
  Scene                   Option(Scene)
  ViewLayer               Option(ViewLayer)
  CameraEvalObject        Option(Object)
  CameraOrigObject        Option(Object)
  UniformData             EEVEEUniformData
  PipelineInfo            EEVEEPipelineInfoData
  Gbuffer                 EEVEEGBuffer
  DebugMode               EEVEEDebugMode
  IsLightBake             Bool
  IsImageRender           Bool
  IsViewportImageRender   Bool
  IsPlayback              Bool
  IsNavigating            Bool
  IsPainting              Bool
  IsTransforming          Bool
  IsViewportCompositorUsed Bool
  DrawOverlays            Bool
  UseSurfaces             Bool
  UseCurves               Bool
  UseVolumes              Bool
  SampleIndex             Int
  SampleCount             Int
}

// --- Workbench Engine Types ---

WorkbenchGeometryType "Mesh" | "Curves" | "PointCloud" | "Gsplat"
WorkbenchPipelineType "Opaque" | "Transparent"
WorkbenchLightingType "Flat" | "Studio" | "Matcap"
WorkbenchShaderType   "Material" | "Texture"

WorkbenchMaterial {
  BaseColor  Float3
  PackedData Int
}

WorkbenchSolidLightData {
  Direction        Float4
  SpecularColor    Float4
  DiffuseColorWrap Float4
}

WorkbenchWorldData {
  ViewportSize          Float2
  ViewportSizeInv       Float2
  ObjectOutlineColor    Float4
  ShadowDirectionVs     Float4
  ShadowFocus           Float
  ShadowShift           Float
  ShadowMul             Float
  ShadowAdd             Float
  Lights                (WorkbenchSolidLightData, WorkbenchSolidLightData, WorkbenchSolidLightData, WorkbenchSolidLightData)
  AmbientColor          Float4
  CavitySampleStart     Int
  CavitySampleEnd       Int
  CavitySampleCountInv  Float
  CavityJitterScale     Float
  CavityValleyFactor    Float
  CavityRidgeFactor     Float
  CavityAttenuation     Float
  CavityDistance        Float
  CurvatureRidge        Float
  CurvatureValley       Float
  UiScale               Float
  MatcapOrientation     Int
  UseSpecular           Bool
  XrayMode              Bool
  XrayAlpha             Float
  BackgroundColor       Float4
}

WorkbenchSceneState {
  Scene                 Option(Scene)
  CameraObject          Option(Object)
  Camera                Option(Camera)
  ViewProjectionMatrix  Float4x4
  ViewForward           Float3
  Resolution            Int2
  ObjectMode            ContextObjectMode
  Shading               View3DShading
  LightingType          WorkbenchLightingType
  XrayMode              Bool
  CullState             DRWState
  ClipPlanes            List(Float4)
  BackgroundColor       Float4
  DrawCavity            Bool
  DrawCurvature         Bool
  DrawShadows           Bool
  DrawOutline           Bool
  DrawDof               Bool
  DrawAa                Bool
  DrawObjectId          Bool
  ShadowsUseRt          Bool
  Sample                Int
  SamplesLen            Int
  ResetTaaNextSample    Bool
  RenderFinished        Bool
  Updated               Bool
  MaterialOverride      WorkbenchMaterial
  MaterialAttributeColor WorkbenchMaterial
  ShowPaintBvhDebug     Bool
}

WorkbenchInstance DrawEngine & {
  Name       "Workbench"
  SceneState WorkbenchSceneState
  WorldData  WorkbenchWorldData
}

// --- Overlay Engine Types ---

OverlayBackgroundType "Solid" | "Gradient" | "Checker" | "Radial" | "SolidChecker" | "Mask"
OverlayUVLineStyle    "Outline" | "Dash" | "Black" | "White" | "Shadow"

OverlayGridData {
  Steps    Float4
  Offset   Float2
  ClipRect Float2
  Level    Float
  NumLines Int
}

OverlayThemeSizes {
  Pixel            Float
  ObjectCenter     Float
  LightCenter      Float
  LightCircle      Float
  LightCircleShadow Float
  Vert             Float
  Edge             Float
  FaceDot          Float
  Checker          Float
  VertexGpencil    Float
}

OverlayUniformData {
  Sizes            OverlayThemeSizes
  SizeViewport     Float2
  SizeViewportInv  Float2
  FresnelMixEdit   Float
  PixelFac         Float
  BackfaceCulling  Bool
}

OverlayBoneEnvelopeData {
  HeadSphere           Float4
  TailSphere           Float4
  BoneColorAndWireWidth Float4
  StateColor           Float4
  XAxis                Float4
}

OverlayBoneStickData {
  BoneStart  Float4
  BoneEnd    Float4
  WireColor  Float4
  BoneColor  Float4
  HeadColor  Float4
  TailColor  Float4
}

OverlayInstance DrawEngine & {
  Name            "Overlay"
  ClippingEnabled Bool
  UniformData     OverlayUniformData
}

// --- Grease Pencil Engine Types ---

GPencilMaterialFlag Int
GPencilLightType    "Point" | "Spot" | "Sun" | "Ambient"

GPencilShaderMaterial {
  StrokeColor    Float4
  FillColor      Float4
  FillMixColor   Float4
  FillUvRotScale Float4
  FillUvOffset   Float2
  AlignmentRot   Float2
  StrokeTexMix   Float
  StrokeUScale   Float
  FillTexMix     Float
  Flag           GPencilMaterialFlag
  Packed1        Float4
  Packed2        Float4
  RandomPacked   Int4
}

GPencilShaderLight {
  LightColor Float3
  Type       GPencilLightType
  Right      Float3
  SpotSize   Float
  Up         Float3
  SpotBlend  Float
  Forward    Float3
  Position   Float3
}

GPencilInstance DrawEngine & {
  Name                "GPencil"
  Cfra                Int
  IsRender            Bool
  IsViewport          Bool
  DrawWireframe       Bool
  IsStrokeOrder3d     Int
  CameraZAxis         Float3
  CameraZOffset       Float
  CameraPos           Float3
  DofParams           Float2
  SimplifyFill        Bool
  SimplifyFx          Bool
  SimplifyAntialias   Bool
  UseLighting         Bool
  UseLights           Bool
  FadeLayerOpacity    Float
  FadeGpObjectOpacity Float
  Fade3dObjectOpacity Float
  MaskOpacity         Float
  XrayAlpha           Float
  VertexPaintOpacity  Float
  ForceStrokeOrder3d  Bool
}

// --- Image & Select Engine Types ---

ImageEngineShaderParameters {
  Flags          Int
  Shuffle        Float4
  FarNear        Float2
  UsePremulAlpha Bool
}

ImageEngineInstance DrawEngine & {
  Name       "Image"
  Parameters ImageEngineShaderParameters
}

SelectType "SelectAll" | "SelectPickAll" | "SelectPickNearest"

SelectInfoData {
  Cursor Int2
  Mode   SelectType
  Radius Int
}

SelectEngineInstance DrawEngine & {
  Name       "Select"
  SelectInfo SelectInfoData
}

// =============================================================================
// 15. Editors, Tools, Keyframes, Transform & Gizmos (ED)
// =============================================================================

WalkSelectDirection "Up" | "Down" | "Left" | "Right"
SelectOp            "Add" | "Sub" | "Set" | "And" | "Xor"
SimilarCmp          "Equal" | "Greater" | "Less"

SelectPickParams {
  SelOp             SelectOp
  DeselectAll       Bool
  SelectPassthrough Bool
}

ViewContext {
  Bmain      Option(Main)
  Depsgraph  Option(Depsgraph)
  Scene      Option(Scene)
  ViewLayer  Option(ViewLayer)
  Obact      Option(Object)
  Obedit     Option(Object)
  Region     Option(ARegion)
  V3d        Option(View3D)
  Win        Option(wmWindow)
  Wm         Option(wmWindowManager)
  Rv3d       Option(RegionView3D)
  Em         Option(BMEditMesh)
  Mval       Int2
}

ViewDepths {
  W          Int
  H          Int
  X          Int
  Y          Int
  Depths     List(Float)
  DepthRange (Double, Double)
}

SnapMode          Int
SnapTargetOP      "All" | "NotSelected" | "NotActive" | "NotEdited" | "Selectable"
SnapEditType      "Edit" | "NonEdit" | "Cage"
SnapOcclusionTest "Disabled" | "FrontFace" | "Always"

SnapObjectParams {
  SnapTargetSelect        SnapTargetOP
  EditModeType            SnapEditType
  OcclusionTest           SnapOcclusionTest
  GridSize                Float
  FaceNearestSteps        Int
  UseBackfaceCulling      Bool
  KeepOnSameTarget        Bool
  IgnoreEditmodeFiltering Bool
}

SnapObjectHitDepth {
  Depth  Float
  Co     Float3
  Normal Float3
  Index  Int
  ObUuid Int
}

V3DSnapCursorData {
  TypeSource   SnapMode
  TypeTarget   SnapMode
  Loc          Float3
  Nor          Float3
  Obmat        Float4x4
  ElemIndex    Int3
  PlaneOmat    Float3x3
  IsSnapInvert Bool
  IsEnabled    Bool
}

V3DSnapCursorState {
  Flag          Int
  SourceColor   Color4b
  TargetColor   Color4b
  ColorBox      Color4b
  Prevpoint     Option(Float3)
  BoxDimensions Float3
  DrawPoint     Bool
  DrawPlane     Bool
  DrawBox       Bool
}

TransformBounds {
  Center         Float3
  Min            Float3
  Max            Float3
  Axis           Float3x3
  AxisMin        Float3
  AxisMax        Float3
  UseMatrixSpace Bool
  MatrixSpace    Float4x4
}

TransformCalcParams {
  UseOnlyCenter    Bool
  UseLocalAxis     Bool
  OrientationIndex Int
}

NumInput {
  IdxMax         Int
  UnitSys        Int
  UnitType       List(Int)
  UnitUseRadians Bool
  Flag           Int
  ValFlag        List(Int)
  Val            List(Float)
  ValNoUnits     List(Double)
  ValOrg         List(Float)
  ValInc         List(Float)
  Idx            Int
  Str            Str
  StrCur         Int
}

SliderMode "Percent" | "Float"

tSlider {
  Mode            SliderMode
  Factor          Float
  Min             Float
  Max             Float
  IncrementStep   Float
  AllowOvershoot  Bool
  AllowIncrements Bool
  UnitStr         Str
  PropertyLabel   Str
}

GizmoGeomInfo {
  Nverts  Int
  Ntris   Int
  Verts   List(Float3)
  Normals List(Float3)
  Indices List(Int)
}

GizmoCommonData {
  RangeFac         Float
  Offset           Float
  Range            Float
  Min              Float
  Max              Float
  IsCustomRangeSet Bool
}

GizmoInteraction {
  InitValue        Float
  InitMval         Float2
  InitOffset       Float
  InitMatrixFinal  Float4x4
  InitMatrixBasis  Float4x4
  PrevOffset       Float
  PrecisionOffset  Float
}

AnimContType   "None" | "Action" | "ShapeKey" | "Gpdata" | "GreasePencil" | "Dopesheet" | "FCurve" | "Drivers" | "Nla" | "Scene" | "Mask" | "Timelines"
AnimChannelType "None" | "Summary" | "Scene" | "Object" | "Group" | "FCurve" | "NlaAction" | "FillActD" | "FillDrivers" | "DsMat" | "DsTex" | "DsLight" | "DsCam" | "DsCacheFile" | "DsCurve" | "DsKey" | "DsWorld" | "DsNTtree" | "DsPart" | "DsMBall" | "DsArm" | "DsMesh" | "DsLat" | "DsSpk" | "DsGpdata" | "DsMask" | "DsHair" | "DsPointCloud" | "DsVolume" | "ShapeKey" | "Gplayer" | "GreasePencilData" | "GreasePencilLayer" | "GreasePencilLayerGroup" | "Maskdat" | "Masklay" | "NlaTrack" | "NlaControl" | "ActionSlot"
AnimFilterFlags Int

bAnimContext {
  Data           Any
  Datatype       AnimContType
  Mode           Int
  Spacetype      Int
  Regiontype     Int
  Bmain          Option(Main)
  Scene          Option(Scene)
  ViewLayer      Option(ViewLayer)
  Obact          Option(Object)
  Region         Option(ARegion)
  Sl             Option(SpaceLink)
  Ads            Option(Any)
  Reports        Option(ReportList)
}

bAnimListElem {
  Data         Any
  Type         AnimChannelType
  Index        Int
  Flag         Int
  Tag          Int
  Datatype     Int
  KeyData      Any
  Id           Option(ID)
  FcurveOwnerId Option(ID)
  Adt          Option(AnimData)
  SlotHandle   SlotHandle
}

ActKeyBlockInfo {
  Flag     Int
  Conflict Int
  Sel      Bool
}

ActKeyColumn {
  KeyType     BezTripleKeyframeType
  HandleType  Int
  ExtremeType Int
  Sel         Int
  Cfra        Float
  Block       ActKeyBlockInfo
  Totcurve    Int
  Totkey      Int
  Totblock    Int
}

AnimKeylist {
  ColumnLen            Int
  IsRuntimeInitialized Bool
  KeyColumns           List(ActKeyColumn)
}

AnimTransformableType "Bone" | "Object"

AnimTransformable {
  Type             AnimTransformableType
  OwnerId          ID
  Name             Str
  FcurveGroupName  Str
  RnaPathFromId    Str
  Location         Float3
  RotationMode     Int
  Scale            Float3
}

PoseBlendState "Init" | "Blending" | "Original" | "Confirm" | "Cancel"

PoseBlendData {
  State       PoseBlendState
  NeedsRedraw Bool
  BlendFactor Float
  IsFlipped   Bool
  PoseBackup  Option(PoseBackup)
  Objects     List(Object)
  Act         Option(Action)
  ActFlipped  Option(Action)
}

UvMapVert {
  LoopOfFaceIndex Int
  FaceIndex       Int
  Separate        Bool
}

UvElement {
  Loop            BMLoop
  LoopOfFaceIndex Int
  Island          Int
  Separate        Bool
  Flag            Int
}

UvElementMap {
  TotalUvs       Int
  TotalUniqueUvs Int
  TotalIslands   Int
  Storage        List(UvElement)
}

// =============================================================================
// 16. Ontological Typestates & Railway-Free Pipelines (Razomy Section 11)
// =============================================================================

Evaluated       { EvalTimestamp Float }
DepsgraphSynced { SyncCount Int }
GpuReady        { VramAllocatedBytes Int }
Baked           { BakeDir Str, BakedFrameRange Int2 }
Packed          { PackedSize Int }
LibOverridden   { ReferenceUid SessionUID }
InEditMode      { ActiveTool Str }

InvalidTopology     { Reason Str }
MissingDependency   { MissingIdName Str }
ShaderCompileError  { ShaderName Str, ErrorLog Str }
BakeFailure         { NodeId Int, ErrorMsg Str }
OutOfVramError      { RequestedBytes Int }

ValidateMeshTopology(M Mesh) [
  VertsNum . {
    [ _ >= 0 ] [ M & Evaluated { EvalTimestamp 1.0 } ]
    _          [ InvalidTopology { Reason "Negative vertex count" } ]
  }
]

SyncDepsgraphTransform(O Object) [
  O.Runtime.LastUpdateTransform . {
    [ _ >= 0 ] [ O & DepsgraphSynced { SyncCount 1 } ]
    _          [ MissingDependency { MissingIdName O.Name } ]
  }
]

CompileEEVEEShaders(E EEVEEInstance) [
  E.SampleCount . {
    [ _ > 0 ] [ E & GpuReady { VramAllocatedBytes 67108864 } ]
    _         [ ShaderCompileError { ShaderName "eevee_deferred_light_eval", ErrorLog "Zero sample count" } ]
  }
]

ExecuteMeshEvaluationPipeline(InitialMesh Mesh) [
  InitialMesh
  . ValidateMeshTopology
]

ExecuteEEVEEFrameRender(Engine EEVEEInstance & GpuReady) [
  "Rendering EEVEE frame (Sample {SampleIndex}/{SampleCount}, VRAM: {VramAllocatedBytes}B)" . Shell.Log
]

// =============================================================================
// 17. Core Blender Transitions & Domain Operations
// =============================================================================

// --- Main & ID Lifecycle Transitions ---

CreateMain(Path Str) [
  Main {
    Filepath          Path
    VersionFile       400
    SubversionFile    0
    MinVersionFile    400
    MinSubversionFile 0
    IsGlobalMain      true
  }
]

AddIdToMain(M Main, Block ID) [
  Block.Type . {
    "SCE" [ M & { Scenes (M.Scenes + [Block]) } ]
    "OB"  [ M & { Objects (M.Objects + [Block]) } ]
    "ME"  [ M & { Meshes (M.Meshes + [Block]) } ]
    "MA"  [ M & { Materials (M.Materials + [Block]) } ]
    "AC"  [ M & { Actions (M.Actions + [Block]) } ]
    "NT"  [ M & { Nodetrees (M.Nodetrees + [Block]) } ]
    "GR"  [ M & { Collections (M.Collections + [Block]) } ]
    "GP"  [ M & { GreasePencils (M.GreasePencils + [Block]) } ]
    "CV"  [ M & { HairCurves (M.HairCurves + [Block]) } ]
    "PT"  [ M & { Pointclouds (M.Pointclouds + [Block]) } ]
    "VO"  [ M & { Volumes (M.Volumes + [Block]) } ]
    _     [ M ]
  }
]

RenameId(Target ID, NewName Str) [
  Target & { Name NewName }
]

IncrementIdUsers(Target ID) [
  Target & { Users (Users + 1) }
]

DecrementIdUsers(Target ID) [
  Users . {
    [ _ > 0 ] [ Target & { Users (Users - 1) } ]
    _         [ Target ]
  }
]

MakeIdLocal(Target ID) [
  Target & { Library None }
]

CreateLibOverride(LocalId ID, RefId ID) [
  LocalId & LibOverridden { ReferenceUid RefId.SessionUid } & {
    OverrideLibrary Some(IDOverrideLibrary {
      Reference     Some(RefId)
      Properties    None
      HierarchyRoot Some(LocalId)
      Flag          0
    })
  }
]

// --- Scene, Collection & Object Transitions ---

CreateObject(NameStr Str, Kind ObjectType, DataBlock Option(ID)) [
  Object {
    Id      NameStr
    Name    NameStr
    Type    "OB"
    ObType  Kind
    Mode    "Object"
    Data    DataBlock
    Scale   (1.0, 1.0, 1.0)
    Quat    Quaternion { W 1.0, X 0.0, Y 0.0, Z 0.0 }
    Users   1
  }
]

LinkObjectToCollection(Coll Collection, Ob Object) [
  Coll & {
    Gobject (Coll.Gobject + [CollectionObject { Ob Ob }])
  }
]

UnlinkObjectFromCollection(Coll Collection, Ob Object) [
  Coll & {
    Gobject (Coll.Gobject . Stream.Filter([ _.Ob.Id != Ob.Id ]))
  }
]

SetObjectMode(Ob Object, TargetMode ObjectMode) [
  TargetMode . {
    "Edit" [ Ob & InEditMode { ActiveTool "builtin.select_box" } & { Mode "Edit" } ]
    _      [ Ob & { Mode TargetMode } ]
  }
]

SetSceneFrame(S Scene, FrameNum Int, SubframeVal Float) [
  S & {
    R (S.R & { Cfie FrameNum, Subframe SubframeVal })
  }
]

// --- Animation, Action & NLA Transitions ---

CreateAction(NameStr Str) [
  Action {
    Id               NameStr
    Name             NameStr
    Type             "AC"
    Layers           None
    Slots            None
    StripKeyframeData None
    ActiveSlotHandle SlotHandle { Value 0 }
    Users            1
  }
]

AddActionSlot(Act Action, Ident Str, TargetType IDType) [
  NewHandle SlotHandle { Value (Act.Slots.Length + 1) }
  NewSlot   ActionSlot { Handle NewHandle, IdType TargetType, Identifier Ident, Flags 0 }
  Act & {
    Slots            (Act.Slots + [NewSlot])
    ActiveSlotHandle NewHandle
  }
]

AddActionLayer(Act Action, LayerName Str) [
  NewLayer ActionLayer { Name LayerName, Flags 0, MixMode "Replace", Strips None }
  Act & {
    Layers (Act.Layers + [NewLayer])
  }
]

AssignActionToId(Target ID, Act Action, Slot ActionSlot) [
  Adt AnimData {
    Action             Some(Act)
    SlotHandle         Slot.Handle
    LastSlotIdentifier Slot.Identifier
    TmpAction          None
    TmpSlotHandle      SlotHandle { Value 0 }
    TmpLastSlotIdent   ""
    Drivers            None
    NlaTracks          None
    ActTrack           None
    ActStrip           None
    ActBlendmode       "Replace"
    ActExtendmode      "Hold"
    ActInfluence       1.0
    Flag               0
  }
  Target & { AnimData Some(Adt) }
]

UnassignActionFromId(Target ID) [
  Target.AnimData . {
    Some [ Target & { AnimData Some(Value & { Action None, SlotHandle SlotHandle { Value 0 } }) } ]
    None [ Target ]
  }
]

PushActionToNlaTrack(Adt AnimData, TrackName Str, StartFrame Float, EndFrame Float) [
  Adt.Action . {
    Some [
      Strip NlaStrip {
        Name             TrackName
        Type             "Clip"
        BlendMode        "Replace"
        Extrapolation    "Hold"
        Flag             0
        Start            StartFrame
        End              EndFrame
        ActStart         StartFrame
        ActEnd           EndFrame
        Repeat           1.0
        Scale            1.0
        BlendIn          0.0
        BlendOut         0.0
        Influence        1.0
        StripTime        0.0
        Action           Some(Value)
        ActionSlotHandle Adt.SlotHandle
        ActionSlotIdent  Adt.LastSlotIdentifier
        Fcurves          None
        Modifiers        None
        Strips           None
        SpeakerHandle    None
      }
      Track NlaTrack {
        Name   TrackName
        Index  Adt.NlaTracks.Length
        Flag   0
        Strips [Strip]
      }
      Adt & {
        Action    None
        NlaTracks (Adt.NlaTracks + [Track])
      }
    ]
    None [ Adt ]
  }
]

// --- Armature & Bone Collection Transitions ---

AddBoneCollection(Arm bArmature, CollName Str) [
  NewColl BoneCollection {
    Name       CollName
    Bones      None
    Flags      1
    ChildIndex 0
    ChildCount 0
    ColorSet   0
  }
  Arm & {
    Collections           (Arm.Collections + [NewColl])
    ActiveCollectionIndex Arm.Collections.Length
  }
]

AssignBoneToCollection(Coll BoneCollection, TargetBone Bone) [
  Coll & {
    Bones (Coll.Bones + [TargetBone])
  }
]

UnassignBoneFromCollection(Coll BoneCollection, TargetBone Bone) [
  Coll & {
    Bones (Coll.Bones . Stream.Filter([ _.Name != TargetBone.Name ]))
  }
]

// --- Asset Catalog Transitions ---

AddAssetCatalog(Service AssetCatalogService, Path AssetCatalogPath, SimpleName Str, NewUuid UUID) [
  Cat AssetCatalog {
    CatalogId  NewUuid
    Path       Path
    SimpleName SimpleName
    Flags      AssetCatalogFlags { IsDeleted false, IsFirstLoaded false, HasUnsavedChanges true }
  }
  Service & {
    CatalogCollection (Service.CatalogCollection & { (NewUuid) Cat })
  }
]

SoftDeleteAssetCatalog(Cat AssetCatalog) [
  Cat & {
    Flags (Cat.Flags & { IsDeleted true, HasUnsavedChanges true })
  }
]

MarkIdAsAsset(Target ID, AuthorStr Str, DescStr Str, CatId UUID) [
  Meta AssetMetaData {
    LocalTypeInfo     None
    Properties        None
    CatalogId         CatId
    CatalogSimpleName ""
    Author            AuthorStr
    Description       DescStr
    Copyright         ""
    License           ""
    Tags              None
    ActiveTag         0
  }
  Target & { AssetData Some(Meta) }
]

ClearIdAssetData(Target ID) [
  Target & { AssetData None }
]

// --- Geometry Set, Attributes & Node Tree Transitions ---

AddAttribute(Storage AttributeStorage, AttrName Str, Dom AttrDomain, Kind AttrType, RawData GList) [
  NewAttr Attribute {
    Name        AttrName
    Domain      Dom
    DataType    Kind
    StorageType "Array"
    Data        RawData
  }
  Storage & {
    Attributes (Storage.Attributes + [NewAttr])
  }
]

RemoveAttribute(Storage AttributeStorage, AttrName Str) [
  Storage & {
    Attributes (Storage.Attributes . Stream.Filter([ _.Name != AttrName ]))
  }
]

ReplaceMeshInGeometrySet(GSet GeometrySet, NewMesh Option(Mesh), OwnType GeometryOwnershipType) [
  Comp MeshComponent {
    Type       "Mesh"
    Ownership  OwnType
    Attributes (NewMesh . { Some [ Value.Attributes ] None [ AttributeStorage { Attributes None } ] })
    Mesh       NewMesh
  }
  GSet & {
    Components (GSet.Components & { ("Mesh") Comp })
  }
]

AddNodeToTree(Tree bNodeTree, NodeIdname Str, NodeName Str) [
  NewNode bNode {
    Name       NodeName
    Label      NodeName
    Idname     NodeIdname
    Identifier (Tree.Nodes.Length + 1)
    TypeLegacy 0
    Flag       0
    Color      (0.6, 0.6, 0.6)
    Locx       0.0, Locy 0.0
    Width      140.0, Height 100.0
    Miniwidth  42.0
    Offsetx    0.0, Offsety 0.0
    Parent     None
    Id         None
    Storage    None
    Prop       None
    Inputs     None
    Outputs    None
    Panels     None
    Custom1    0, Custom2 0
    Custom3    0.0, Custom4 0.0
  }
  Tree & {
    Nodes (Tree.Nodes + [NewNode])
  }
]

LinkNodeSockets(Tree bNodeTree, FromN bNode, FromS bNodeSocket, ToN bNode, ToS bNodeSocket) [
  NewLink bNodeLink {
    FromNode         Some(FromN)
    ToNode           Some(ToN)
    FromSock         Some(FromS)
    ToSock           Some(ToS)
    Flag             0
    MultiInputSortId 0
  }
  Tree & {
    Links (Tree.Links + [NewLink])
  }
]

// --- Undo Stack Transitions ---

PushUndoStep(Stack UndoStack, StepName Str, Kind UndoType, SizeBytes Int) [
  Step UndoStep {
    Name            StepName
    Type            Kind
    DataSize        SizeBytes
    Skip            false
    UseMemfileStep  true
    UseOldBmainData true
    IsApplied       true
  }
  Stack & {
    Steps      (Stack.Steps + [Step])
    StepActive Some(Step)
  }
]


_ base
_ math
_ containers
_ gpu_types
_ std.io

// =============================================================================
// 1. Core Primitives, Math & Spatial Algebra
// =============================================================================

UUID      Str
SessionId Int

Vec2i (Int, Int)
Vec2f (Float, Float)
Vec3i (Int, Int, Int)
Vec3f (Float, Float, Float)
Vec4f (Float, Float, Float, Float)

Color3f (Float, Float, Float)
Color4f (Float, Float, Float, Float)
Color4b (Byte, Byte, Byte, Byte)

Quat   (Float, Float, Float, Float)
Euler  (Float, Float, Float)
Mat3x3 (Vec3f, Vec3f, Vec3f)
Mat4x4 (Vec4f, Vec4f, Vec4f, Vec4f)

DualQuat {
  Rotation    Quat
  Translation Vec4f
  Scale       Mat4x4
  ScaleWeight Float
}

AxisAngle {
  Axis  Vec3f
  Angle Float
}

RectI {
  XMin Int
  XMax Int
  YMin Int
  YMax Int
}

RectF {
  XMin Float
  XMax Float
  YMin Float
  YMax Float
}

Bounds2f {
  Min Vec2f
  Max Vec2f
}

Bounds3f {
  Min Vec3f
  Max Vec3f
}

BoundBox {
  Corners List(Vec3f)
}


// =============================================================================
// 2. Domain Enumerations (Sum Types)
// =============================================================================

IDType
  "Scene" | "Library" | "Object" | "Mesh" | "Curve" | "MetaBall" | "Material"
  | "Texture" | "Image" | "Lattice" | "Light" | "Camera" | "Key" | "World"
  | "Screen" | "VFont" | "Text" | "Speaker" | "Sound" | "Collection" | "Armature"
  | "Action" | "NodeTree" | "Brush" | "ParticleSettings" | "WindowManager"
  | "MovieClip" | "Mask" | "LineStyle" | "Palette" | "PaintCurve" | "CacheFile"
  | "WorkSpace" | "LightProbe" | "Curves" | "PointCloud" | "Volume" | "GreasePencil"

ObjectType
  "Empty" | "Mesh" | "Curve" | "Surface" | "Font" | "MetaBall" | "Lamp"
  | "Camera" | "Lattice" | "Armature" | "Speaker" | "LightProbe" | "Curves"
  | "PointCloud" | "Volume" | "GreasePencil"

ObjectMode
  "Object" | "Edit" | "Sculpt" | "VertexPaint" | "WeightPaint" | "TexturePaint"
  | "ParticleEdit" | "Pose" | "PaintGreasePencil" | "SculptGreasePencil"
  | "WeightGreasePencil" | "VertexGreasePencil" | "SculptCurves"

AttrDomain
  "Point" | "Edge" | "Face" | "Corner" | "Curve" | "Instance" | "Layer"

AttrType
  "Bool" | "Int8" | "Int32" | "Int2" | "Float" | "Float2" | "Float3"
  | "Float4" | "Color4f" | "Color4b" | "Quat" | "Mat4x4" | "String"

SpaceType
  "Empty" | "View3D" | "Graph" | "Outliner" | "Properties" | "File" | "Image"
  | "Info" | "Sequence" | "Text" | "Action" | "Nla" | "Script" | "Node"
  | "Console" | "UserPref" | "Clip" | "TopBar" | "StatusBar" | "Spreadsheet" | "Project"

RegionType
  "Window" | "Header" | "Channels" | "Temporary" | "UI" | "Tools" | "ToolProps"
  | "Preview" | "HUD" | "NavigationBar" | "Execute" | "Footer" | "ToolHeader" | "XR"

OperatorStatus
  "RunningModal" | "Cancelled" | "Finished" | "PassThrough" | "Handled" | "Interface"

SymmetryFlags
  "None" | "X" | "Y" | "Z" | "XY" | "XZ" | "YZ" | "XYZ" | "Feather" | "Radial"

BlendMode
  "Mix" | "Add" | "Subtract" | "Multiply" | "Lighten" | "Darken" | "EraseAlpha"
  | "AddAlpha" | "Overlay" | "HardLight" | "ColorBurn" | "LinearBurn" | "ColorDodge"
  | "Screen" | "SoftLight" | "PinLight" | "VividLight" | "LinearLight" | "Difference"
  | "Exclusion" | "Hue" | "Saturation" | "Luminosity" | "Color" | "Interpolate"

DrawType
  "BoundBox" | "Wire" | "Solid" | "Material" | "Texture" | "Render"

AxisSigned
  "PosX" | "PosY" | "PosZ" | "NegX" | "NegY" | "NegZ"

PathReferenceMode
  "Auto" | "Absolute" | "Relative" | "Match" | "Strip" | "Copy"

EvaluationMode
  "Viewport" | "Render"


// =============================================================================
// 3. Core DNA, IDs, Custom Properties & RNA Reflection
// =============================================================================

IDPropertyValue
  Str | Int | Float | Bool | List(Any) | ID

IDPropertyUIData {
  Description Option(Str)
  Subtype     Option(Str)
  Min         Option(Float)
  Max         Option(Float)
  SoftMin     Option(Float)
  SoftMax     Option(Float)
  Step        Option(Float)
  Precision   Option(Int)
}

IDProperty {
  Name   Str
  Type   "String" | "Int" | "Float" | "Array" | "Group" | "ID" | "Double" | "Boolean"
  Value  IDPropertyValue
  UIData Option(IDPropertyUIData)
  Flag   Int
}

IDOverridePropertyOperation {
  Operation      "NoOp" | "Replace" | "Difference" | "Factor" | "InsertAfter" | "InsertBefore"
  SubpropName    Option(Str)
  SubpropIndex   Int
}

IDOverrideProperty {
  RnaPath    Str
  Operations List(IDOverridePropertyOperation)
}

IDOverrideLibrary {
  Reference     Option(ID)
  HierarchyRoot Option(ID)
  Properties    List(IDOverrideProperty)
  Flag          Int
}

AssetMetaData {
  Author      Option(Str)
  Description Option(Str)
  Copyright   Option(Str)
  License     Option(Str)
  Tags        List(Str)
  CatalogId   UUID
  Properties  List(IDProperty)
}

PreviewImage {
  Width     Int
  Height    Int
  RectByte  List(Byte)
  RectFloat List(Float)
  IconId    Int
  Flag      Int
}

Library {
  Filepath   Str
  PackedFile Option(PackedFile)
  Parent     Option(Library)
  Flag       "IsArchive" | "IsExternal" | "None"
}

ID {
  SessionUid       SessionId
  Type             IDType
  Name             Str
  Library          Option(Library)
  Users            Int
  FakeUser         Bool
  IsExtra          Bool
  IsEmbedded       Bool
  Properties       List(IDProperty)
  SystemProperties List(IDProperty)
  OverrideLibrary  Option(IDOverrideLibrary)
  AssetData        Option(AssetMetaData)
  Preview          Option(PreviewImage)
}

PackedFile {
  Size Int
  Data List(Byte)
}

Main {
  Filepath        Str
  VersionFile     Int
  SubversionFile  Int
  IsDirty         Bool
  Scenes          List(Scene)
  Libraries       List(Library)
  Objects         List(Object)
  Meshes          List(Mesh)
  Curves          List(Curves)
  MetaBalls       List(MetaBall)
  Materials       List(Material)
  Textures        List(Texture)
  Images          List(Image)
  Lattices        List(Lattice)
  Lights          List(Light)
  Cameras         List(Camera)
  ShapeKeys       List(Key)
  Worlds          List(World)
  Screens         List(Screen)
  Fonts           List(VFont)
  Texts           List(Text)
  Speakers        List(Speaker)
  Sounds          List(Sound)
  Collections     List(Collection)
  Armatures       List(Armature)
  Actions         List(Action)
  NodeTrees       List(NodeTree)
  Brushes         List(Brush)
  Particles       List(ParticleSettings)
  Palettes        List(Palette)
  PaintCurves     List(PaintCurve)
  WorkSpaces      List(WorkSpace)
  LightProbes     List(LightProbe)
  PointClouds     List(PointCloud)
  Volumes         List(Volume)
  GreasePencils   List(GreasePencil)
  MovieClips      List(MovieClip)
  Masks           List(Mask)
  LineStyles      List(FreestyleLineStyle)
  CacheFiles      List(CacheFile)
}

// RNA Reflection & Access
PointerRNA {
  OwnerId   Option(ID)
  Type      Option(StructRNA)
  Data      Any
  Ancestors List(PointerRNA)
}

PropertyRNA {
  Identifier         Str
  Name               Str
  Description        Str
  TranslationContext Str
  Type               "Boolean" | "Int" | "Float" | "String" | "Enum" | "Pointer" | "Collection"
  Subtype            Str
  Flag               Int
  OverrideFlag       Int
  ArrayDimension     Int
  IsEditable         Bool
  IsAnimatable       Bool
}

FunctionRNA {
  Identifier  Str
  Description Str
  Flag        Int
  Parameters  List(PropertyRNA)
  ReturnProp  Option(PropertyRNA)
}

StructRNA {
  Identifier         Str
  Name               Str
  Description        Str
  TranslationContext Str
  Icon               Int
  Base               Option(StructRNA)
  NameProperty       Option(PropertyRNA)
  IteratorProperty   Option(PropertyRNA)
  Properties         List(PropertyRNA)
  Functions          List(FunctionRNA)
}

PathResolvedRNA {
  Ptr       PointerRNA
  Prop      PropertyRNA
  PropIndex Int
}

Depsgraph {
  Scene     Scene
  ViewLayer ViewLayer
  Mode      EvaluationMode
  Ctime     Float
}


// =============================================================================
// 4. Attributes, Geometry Components & Geometry Set
// =============================================================================

Attribute {
  Name        Str
  Domain      AttrDomain
  DataType    AttrType
  StorageType "Array" | "Single"
  Data        List(Any)
}

AttributeStorage {
  Attributes  List(Attribute)
  ActiveIndex Int
}

AttributeFilter {
  IgnoredAttributes Set(Str)
}

DeformWeight {
  DefIndex Int
  Weight   Float
}

DeformVert {
  Weights List(DeformWeight)
}

DeformGroup {
  Name Str
  Locked Bool
}

KeyBlock {
  Uid        Int
  Name       Str
  Pos        Float
  CurVal     Float
  Type       "Linear" | "Cardinal" | "BSpline" | "CatmullRom"
  Relative   Int
  VertexGroup Str
  SliderMin  Float
  SliderMax  Float
  Flag       "Mute" | "Selected" | "Locked" | "LockedShape"
  Data       List(Vec3f)
}

Key ID & {
  Type       "Normal" | "Relative"
  RefKey     Option(KeyBlock)
  Blocks     List(KeyBlock)
  From       Option(ID)
  Ctime      Float
}

// --- Mesh ---
Mesh ID & {
  AnimData             Option(AnimData)
  Key                  Option(Key)
  Materials            List(Option(Material))
  VertsNum             Int
  EdgesNum             Int
  FacesNum             Int
  CornersNum           Int
  VertPositions        List(Vec3f)
  Edges                List(Vec2i)
  FaceOffsets          List(Int)
  CornerVerts          List(Int)
  CornerEdges          List(Int)
  AttributeStorage     AttributeStorage
  VertexGroupNames     List(DeformGroup)
  VertexGroupActive    Int
  DeformVerts          List(DeformVert)
  ActiveColorAttribute Option(Str)
  DefaultColorAttribute Option(Str)
  ActiveUvMap          Option(Str)
  DefaultUvMap         Option(Str)
  Symmetry             SymmetryFlags
  RemeshMode           "Voxel" | "Quad"
  RemeshVoxelSize      Float
  RemeshAdaptivity     Float
  TexspaceLocation     Vec3f
  TexspaceSize         Vec3f
}

// --- Curves ---
CurveType
  "CatmullRom" | "Poly" | "Bezier" | "Nurbs"

HandleType
  "Free" | "Auto" | "Vector" | "Align"

KnotsMode
  "Normal" | "EndPoint" | "Bezier" | "Custom"

NormalMode
  "MinimumTwist" | "ZUp" | "Free"

CurvesGeometry {
  PointsNum        Int
  CurvesNum        Int
  CurveOffsets     List(Int)
  AttributeStorage AttributeStorage
  VertexGroupNames List(DeformGroup)
}

Curves ID & {
  AnimData              Option(AnimData)
  Geometry              CurvesGeometry
  Materials             List(Option(Material))
  Surface               Option(Object)
  SurfaceUvMap          Option(Str)
  Symmetry              SymmetryFlags
  SelectionDomain       AttrDomain
}

// --- PointCloud & Gaussian Splatting ---
PointCloud ID & {
  AnimData         Option(AnimData)
  PointType        "Points" | "GSplat"
  TotPoint         Int
  AttributeStorage AttributeStorage
  Materials        List(Option(Material))
}

// --- Volume & OpenVDB ---
VolumeGridType
  "Unknown" | "Boolean" | "Float" | "Double" | "Int" | "Int64"
  | "Vec3f" | "Vec3d" | "Vec3i" | "Mask" | "Points"

VolumeGrid {
  Name      Str
  GridType  VolumeGridType
  Transform Mat4x4
  IsLoaded  Bool
}

VolumeDisplay {
  Density             Float
  WireframeType       "None" | "Bounds" | "Boxes" | "Points"
  WireframeDetail     "Coarse" | "Fine"
  InterpolationMethod "Linear" | "Cubic" | "Closest"
  SliceAxis           "Auto" | "X" | "Y" | "Z"
  SliceDepth          Float
}

VolumeRender {
  Precision "Half" | "Full" | "Variable"
  Space     "Object" | "World"
  StepSize  Float
  Clipping  Float
}

Volume ID & {
  AnimData       Option(AnimData)
  Filepath       Str
  PackedFile     Option(PackedFile)
  IsSequence     Bool
  SequenceMode   "Clip" | "Extend" | "Repeat" | "PingPong"
  FrameStart     Int
  FrameDuration  Int
  FrameOffset    Int
  ActiveGrid     Int
  Materials      List(Option(Material))
  Render         VolumeRender
  Display        VolumeDisplay
  VelocityGrid   Str
  VelocityUnit   "Frame" | "Second"
  VelocityScale  Float
  Grids          List(VolumeGrid)
}

// --- Grease Pencil v3 ---
GreasePencilDrawing {
  Type     "Drawing" | "Reference"
  Geometry CurvesGeometry
}

GreasePencilFrame {
  DrawingIndex Int
  KeyType      "Keyframe" | "Extreme" | "Breakdown" | "Jitter" | "MoveHold"
  Selected     Bool
  ImplicitHold Bool
}

GreasePencilLayerMask {
  LayerName Str
  Hide      Bool
  Invert    Bool
}

GreasePencilTreeNode {
  Name      Str
  Visible   Bool
  Locked    Bool
  Selected  Bool
  Muted     Bool
  UseLights Bool
  Color     Color3f
}

GreasePencilLayer GreasePencilTreeNode & {
  Frames      Map(Int, GreasePencilFrame)
  BlendMode   "Regular" | "HardLight" | "Add" | "Subtract" | "Multiply" | "Divide"
  Opacity     Float
  Masks       List(GreasePencilLayerMask)
  Parent      Option(Object)
  ParentBone  Option(Str)
  Translation Vec3f
  Rotation    Euler
  Scale       Vec3f
  ViewLayer   Option(Str)
}

GreasePencilLayerGroup GreasePencilTreeNode & {
  Children List(GreasePencilLayer | GreasePencilLayerGroup)
  ColorTag Int
}

GreasePencilOnionSkinning {
  Opacity         Float
  Mode            "Absolute" | "Relative" | "Selected"
  UseCustomColors Bool
  UseFade         Bool
  ShowLoop        Bool
  FramesBefore    Int
  FramesAfter     Int
  ColorBefore     Color3f
  ColorAfter      Color3f
}

GreasePencil ID & {
  AnimData         Option(AnimData)
  Drawings         List(GreasePencilDrawing)
  RootGroup        GreasePencilLayerGroup
  ActiveNode       Option(GreasePencilTreeNode)
  AttributeStorage AttributeStorage
  Materials        List(Option(Material))
  VertexGroupNames List(DeformGroup)
  OnionSkinning    GreasePencilOnionSkinning
}

// --- Instances & GeometrySet ---
InstanceReference {
  Data ID | GeometrySet
}

Instances {
  References       List(InstanceReference)
  ReferenceHandles List(Int)
  Transforms       List(Mat4x4)
  AttributeStorage AttributeStorage
}

GeometryComponent
  Mesh | Curves | PointCloud | Volume | GreasePencil | Instances

GeometrySet {
  Mesh         Option(Mesh)
  Curves       Option(Curves)
  PointCloud   Option(PointCloud)
  Volume       Option(Volume)
  GreasePencil Option(GreasePencil)
  Instances    Option(Instances)
  Bundle       Option(Bundle)
}


// =============================================================================
// 5. Scene, Objects, Collections, Cameras, Lights & World
// =============================================================================

BoneColor {
  PaletteIndex Int
  Solid        Color4b
  Select       Color4b
  Active       Color4b
}

Bone {
  Name             Str
  Parent           Option(Bone)
  Children         List(Bone)
  Roll             Float
  Head             Vec3f
  Tail             Vec3f
  BoneMat          Mat3x3
  ArmHead          Vec3f
  ArmTail          Vec3f
  ArmMat           Mat4x4
  ArmRoll          Float
  Length           Float
  RadiusHead       Float
  RadiusTail       Float
  Segments         Int
  InheritScaleMode "Full" | "FixShear" | "Aligned" | "Average" | "None"
  Color            BoneColor
  Flag             Int
}

BoneCollection {
  Name       Str
  Bones      List(Bone)
  ChildIndex Int
  ChildCount Int
  Visible    Bool
  Solo       Bool
  Expanded   Bool
  Properties List(IDProperty)
}

Armature ID & {
  AnimData         Option(AnimData)
  Bones            List(Bone)
  ActiveBone       Option(Bone)
  Collections      List(BoneCollection)
  ActiveCollection Option(Str)
  DrawType         "Octahedral" | "Stick" | "BBone" | "Envelope" | "Wire"
  AxesPosition     Float
}

PoseChannel {
  Name          Str
  Bone          Option(Bone)
  Parent        Option(PoseChannel)
  Child         Option(PoseChannel)
  Constraints   List(Constraint)
  Location      Vec3f
  Scale         Vec3f
  RotationEuler Euler
  RotationQuat  Quat
  RotationAxis  Vec3f
  RotationAngle Float
  RotationMode  Str
  ChannelMat    Mat4x4
  PoseMat       Mat4x4
  PoseHead      Vec3f
  PoseTail      Vec3f
  CustomObject  Option(Object)
  CustomScale   Vec3f
  Color         BoneColor
  MotionPath    Option(MotionPath)
  Properties    List(IDProperty)
}

Pose {
  Channels     List(PoseChannel)
  ActionGroups List(ActionGroup)
  ActiveGroup  Int
  IkSolver     "Legacy" | "Itasc"
  AnimViz      AnimVizSettings
}

CameraStereoSettings {
  InterocularDistance Float
  ConvergenceDistance Float
  ConvergenceMode     "OffAxis" | "Parallel" | "Toe"
  Pivot               "Left" | "Right" | "Center"
}

CameraDOFSettings {
  FocusObject    Option(Object)
  FocusSubtarget Option(Str)
  FocusDistance  Float
  ApertureFstop  Float
  ApertureRatio  Float
  ApertureBlades Int
  Enabled        Bool
}

Camera ID & {
  AnimData       Option(AnimData)
  CameraType     "Persp" | "Ortho" | "Pano" | "Custom"
  ClipStart      Float
  ClipEnd        Float
  Lens           Float
  OrthoScale     Float
  SensorX        Float
  SensorY        Float
  SensorFit      "Auto" | "Horizontal" | "Vertical"
  ShiftX         Float
  ShiftY         Float
  Dof            CameraDOFSettings
  Stereo         CameraStereoSettings
  Passepartout   Float
}

Light ID & {
  AnimData           Option(AnimData)
  LightType          "Point" | "Sun" | "Spot" | "Area"
  Color              Color3f
  Temperature        Float
  UseTemperature     Bool
  Energy             Float
  Exposure           Float
  Radius             Float
  SpotSize           Float
  SpotBlend          Float
  AreaShape          "Square" | "Rect" | "Disk" | "Ellipse"
  AreaSizeX          Float
  AreaSizeY          Float
  SunAngle           Float
  CastShadow         Bool
  DiffuseFactor      Float
  SpecularFactor     Float
  TransmissionFactor Float
  VolumeFactor       Float
  NodeTree           Option(NodeTree)
}

World ID & {
  AnimData        Option(AnimData)
  HorizonColor    Color3f
  Exposure        Float
  UseNodes        Bool
  NodeTree        Option(NodeTree)
  ProbeResolution Int
  SunThreshold    Float
  SunAngle        Float
}

MaterialGPencilStyle {
  StrokeRgba    Color4f
  FillRgba      Color4f
  StrokeStyle   "Solid" | "Texture"
  FillStyle     "Solid" | "Gradient" | "Texture"
  Mode          "Line" | "Dots" | "Squares"
  StrokeImage   Option(Image)
  FillImage     Option(Image)
  ShowStroke    Bool
  ShowFill      Bool
  Locked        Bool
  Hidden        Bool
}

Material ID & {
  AnimData                Option(AnimData)
  SurfaceRenderMethod     "Deferred" | "Forward"
  BaseColor               Color4f
  SpecularColor           Color3f
  Roughness               Float
  Metallic                Float
  Alpha                   Float
  UseNodes                Bool
  NodeTree                Option(NodeTree)
  BlendMethod             "Opaque" | "Clip" | "Hashed" | "Blend"
  DisplacementMethod      "Bump" | "Displacement" | "Both"
  VolumeIntersectionMethod "Fast" | "Accurate"
  LineArtFlags            Int
  GPencilStyle            Option(MaterialGPencilStyle)
}

Object ID & {
  AnimData             Option(AnimData)
  ObjectType           ObjectType
  Data                 Option(ID)
  Parent               Option(Object)
  ParentType           "Object" | "Armature" | "Bone" | "Vertex" | "Vertex3"
  ParentBone           Option(Str)
  ParentInverse        Mat4x4
  Location             Vec3f
  Scale                Vec3f
  RotationEuler        Euler
  RotationQuat         Quat
  RotationAxisAngle    AxisAngle
  RotationMode         Str
  ObjectToWorld        Mat4x4
  WorldToObject        Mat4x4
  Mode                 ObjectMode
  Materials            List(Option(Material))
  ActiveMaterialIndex  Int
  Modifiers            List(ModifierData)
  GreasePencilModifiers List(ModifierData)
  ShaderFx             List(ShaderFxData)
  Constraints          List(Constraint)
  VertexGroups         List(DeformGroup)
  ActiveVertexGroup    Int
  Pose                 Option(Pose)
  ParticleSystems      List(ParticleSystem)
  RigidBodyObject      Option(RigidBodyOb)
  RigidBodyConstraint  Option(RigidBodyCon)
  InstanceCollection   Option(Collection)
  Color                Color4f
  DisplayType          DrawType
  VisibilityFlags      Int
  ShapeKeyIndex        Int
  ShapeKeyPinned       Bool
}

Collection ID & {
  Objects        List(Object)
  Children       List(Collection)
  InstanceOffset Vec3f
  ColorTag       Int
  Flag           Int
}

LayerCollection {
  Collection      Collection
  Children        List(LayerCollection)
  Exclude         Bool
  Holdout         Bool
  IndirectOnly    Bool
  HideViewport    Bool
}

ViewLayerAOV {
  Name Str
  Type "Color" | "Value"
}

ViewLayer {
  Name                Str
  LayerCollections    List(LayerCollection)
  ActiveCollection    Option(LayerCollection)
  ActiveObject        Option(Object)
  Objects             List(Object)
  MaterialOverride    Option(Material)
  WorldOverride       Option(World)
  Samples             Int
  PassFlags           Int
  AOVs                List(ViewLayerAOV)
  Lightgroups         List(Str)
  FreestyleConfig     Option(FreestyleConfig)
}

View3DCursor {
  Location          Vec3f
  RotationQuat      Quat
  RotationEuler     Euler
  RotationAxisAngle AxisAngle
  RotationMode      Str
}

TimeMarker {
  Frame  Int
  Name   Str
  Select Bool
  Camera Option(Object)
}

UnitSettings {
  ScaleLength     Float
  System          "None" | "Metric" | "Imperial"
  SystemRotation  "Degrees" | "Radians"
  LengthUnit      Str
  MassUnit        Str
  TimeUnit        Str
  TemperatureUnit Str
}

Scene ID & {
  AnimData              Option(AnimData)
  Camera                Option(Object)
  World                 Option(World)
  BackgroundScene       Option(Scene)
  MasterCollection      Collection
  ViewLayers            List(ViewLayer)
  Cursor                View3DCursor
  UseNodes              Bool
  CompositingNodeGroup  Option(NodeTree)
  CompositorEffects     List(SceneCompositorEffect)
  Editing               Option(Editing)
  ToolSettings          ToolSettings
  RenderData            RenderData
  AudioData             AudioData
  Markers               List(TimeMarker)
  TransformOrientations List(TransformOrientation)
  UnitSettings          UnitSettings
  PhysicsSettings       PhysicsSettings
  RigidBodyWorld        Option(RigidBodyWorld)
  ViewSettings          ColorManagedViewSettings
  DisplaySettings       ColorManagedDisplaySettings
  SimulationFrameStart  Int
  SimulationFrameEnd    Int
  EEVEE                 SceneEEVEE
}


// =============================================================================
// 6. Animation, Rigging, F-Curves, Drivers & NLA
// =============================================================================

BezierTriple {
  LeftHandle    Vec2f
  Knot          Vec2f
  RightHandle   Vec2f
  HandleType1   HandleType
  HandleType2   HandleType
  Interpolation "Constant" | "Linear" | "Bezier" | "Back" | "Bounce" | "Circ" | "Cubic" | "Elastic" | "Expo" | "Quad" | "Quart" | "Quint" | "Sine"
  Easing        "Auto" | "EaseIn" | "EaseOut" | "EaseInOut"
  KeyframeType  "Keyframe" | "Extreme" | "Breakdown" | "Jitter" | "MoveHold" | "Generated"
  Selected1     Bool
  SelectedKnot  Bool
  Selected2     Bool
  Amplitude     Float
  Period        Float
  Back          Float
}

FModifierType
  "Null" | "Generator" | "FnGenerator" | "Envelope" | "Cycles"
  | "Noise" | "Limits" | "Stepped" | "Smooth"

FModifier {
  Name        Str
  Type        FModifierType
  Enabled     Bool
  Muted       Bool
  Active      Bool
  Influence   Float
  UseInfluence Bool
  StartFrame  Float
  EndFrame    Float
  BlendIn     Float
  BlendOut    Float
  Data        Any
}

DriverTarget {
  TargetId      Option(ID)
  RnaPath       Str
  BoneName      Str
  TransformChan Str
  RotationMode  Str
  FallbackValue Float
  UseFallback   Bool
}

DriverVar {
  Name    Str
  Type    "SingleProp" | "RotDiff" | "LocDiff" | "TransformChan" | "ContextProp"
  Targets List(DriverTarget)
  CurVal  Float
}

ChannelDriver {
  Type       "Average" | "Python" | "Sum" | "Min" | "Max"
  Expression Str
  Variables  List(DriverVar)
  CurVal     Float
  Influence  Float
  UseSelf    Bool
  IsValid    Bool
}

FCurve {
  RnaPath       Str
  ArrayIndex    Int
  Group         Option(ActionGroup)
  Driver        Option(ChannelDriver)
  Modifiers     List(FModifier)
  Keyframes     List(BezierTriple)
  ColorMode     "AutoRainbow" | "AutoRGB" | "AutoYRGB" | "Custom"
  Color         Color3f
  Extrapolation "Constant" | "Linear"
  AutoSmoothing "None" | "ContAccel"
  Selected      Bool
  Active        Bool
  Muted         Bool
  Locked        Bool
}

ActionGroup {
  Name     Str
  Channels List(FCurve)
  Selected Bool
  Locked   Bool
  Expanded Bool
}

ActionSlot {
  Identifier Str
  TargetType IDType
  Handle     Int
}

ActionChannelbag {
  SlotHandle Int
  Groups     List(ActionGroup)
  FCurves    List(FCurve)
}

ActionStripKeyframeData {
  Channelbags List(ActionChannelbag)
}

ActionStrip {
  StripType   "Keyframe"
  DataIndex   Int
  FrameStart  Float
  FrameEnd    Float
  FrameOffset Float
}

ActionLayer {
  Name      Str
  Influence Float
  MixMode   "Replace" | "Add" | "Subtract" | "Multiply" | "Combine"
  Strips    List(ActionStrip)
}

Action ID & {
  Layers            List(ActionLayer)
  Slots             List(ActionSlot)
  StripKeyframeData List(ActionStripKeyframeData)
  LegacyCurves      List(FCurve)
  LegacyGroups      List(ActionGroup)
  Markers           List(TimeMarker)
  FrameStart        Float
  FrameEnd          Float
}

NlaStrip {
  Name          Str
  Type          "Clip" | "Transition" | "Meta" | "Sound"
  Action        Option(Action)
  ActionSlot    Int
  StartFrame    Float
  EndFrame      Float
  ActionStart   Float
  ActionEnd     Float
  Scale         Float
  Repeat        Float
  BlendIn       Float
  BlendOut      Float
  BlendMode     "Replace" | "Add" | "Subtract" | "Multiply" | "Combine"
  ExtendMode    "Hold" | "HoldForward" | "Nothing"
  Influence     Float
  StripTime     Float
  FCurves       List(FCurve)
  Modifiers     List(FModifier)
  Strips        List(NlaStrip)
  Selected      Bool
  Active        Bool
  Muted         Bool
}

NlaTrack {
  Name     Str
  Index    Int
  Strips   List(NlaStrip)
  Selected Bool
  Active   Bool
  Muted    Bool
  Solo     Bool
  Locked   Bool
}

AnimData {
  Action        Option(Action)
  SlotHandle    Int
  TempAction    Option(Action)
  TempSlot      Int
  NlaTracks     List(NlaTrack)
  ActiveTrack   Option(NlaTrack)
  ActiveStrip   Option(NlaStrip)
  Drivers       List(FCurve)
  BlendMode     "Replace" | "Add" | "Subtract" | "Multiply" | "Combine"
  ExtendMode    "Hold" | "HoldForward" | "Nothing"
  Influence     Float
  InTweakMode   Bool
}

MotionPath {
  Points        List(Vec3f)
  StartFrame    Int
  EndFrame      Int
  ColorPre      Color3f
  ColorPost     Color3f
  LineThickness Int
}

AnimVizSettings {
  PathType      "AroundFrame" | "InRange"
  PathRange     "Scene" | "Manual" | "AllKeys" | "SelectedKeys"
  PathStep      Int
  StartFrame    Int
  EndFrame      Int
  BeforeCurrent Int
  AfterCurrent  Int
}


// =============================================================================
// 7. Modifiers, Constraints, Physics & Simulation (XPBD / Cloth / Fluid)
// =============================================================================

ModifierType
  "Subsurf" | "Lattice" | "Curve" | "Build" | "Mirror" | "Decimate" | "Wave"
  | "Armature" | "Hook" | "Softbody" | "Boolean" | "Array" | "EdgeSplit"
  | "Displace" | "UVProject" | "Smooth" | "Cast" | "MeshDeform" | "ParticleSystem"
  | "ParticleInstance" | "Explode" | "Cloth" | "Collision" | "Bevel" | "Shrinkwrap"
  | "Mask" | "SimpleDeform" | "Multires" | "Surface" | "Fluid" | "ShapeKey"
  | "Solidify" | "Screw" | "Ocean" | "Warp" | "WeightVGEdit" | "WeightVGMix"
  | "WeightVGProximity" | "DynamicPaint" | "Remesh" | "Skin" | "LaplacianSmooth"
  | "Triangulate" | "UVWarp" | "MeshCache" | "LaplacianDeform" | "Wireframe"
  | "Weld" | "DataTransfer" | "NormalEdit" | "CorrectiveSmooth" | "MeshSequenceCache"
  | "SurfaceDeform" | "WeightedNormal" | "Nodes" | "MeshToVolume" | "VolumeDisplace"
  | "VolumeToMesh" | "GreasePencilOpacity" | "GreasePencilSubdiv" | "GreasePencilColor"
  | "GreasePencilTint" | "GreasePencilSmooth" | "GreasePencilOffset" | "GreasePencilNoise"
  | "GreasePencilMirror" | "GreasePencilThickness" | "GreasePencilLattice"
  | "GreasePencilDash" | "GreasePencilMultiply" | "GreasePencilLength"
  | "GreasePencilLineart" | "GreasePencilArmature" | "GreasePencilTime"
  | "GreasePencilSimplify" | "GreasePencilEnvelope" | "GreasePencilOutline"
  | "GreasePencilShrinkwrap" | "GreasePencilBuild" | "GreasePencilTexture"

ModifierMode
  "Realtime" | "Render" | "Editmode" | "OnCage"

ModifierData {
  Name             Str
  Type             ModifierType
  Mode             Int
  PersistentUid    Int
  ExecutionTime    Float
  Error            Option(Str)
  SystemProperties List(IDProperty)
}

SubsurfModifier ModifierData & {
  SubdivType     "CatmullClark" | "Simple"
  Levels         Int
  RenderLevels   Int
  Quality        Int
  UvSmooth       Str
  BoundarySmooth Str
}

MirrorModifier ModifierData & {
  AxisX          Bool
  AxisY          Bool
  AxisZ          Bool
  BisectX        Bool
  BisectY        Bool
  BisectZ        Bool
  Tolerance      Float
  MirrorObject   Option(Object)
}

BooleanModifier ModifierData & {
  Operation       "Intersect" | "Union" | "Difference"
  Solver          "Float" | "Exact" | "Manifold"
  OperandType     "Object" | "Collection"
  Object          Option(Object)
  Collection      Option(Collection)
  DoubleThreshold Float
}

BevelModifier ModifierData & {
  Value        Float
  Segments     Int
  AffectType   "Vertices" | "Edges"
  LimitMethod  "None" | "Angle" | "Weight" | "VGroup"
  BevelAngle   Float
  Profile      Float
  CustomProfile Option(CurveProfile)
}

NodesModifierBake {
  Id          Int
  BakeMode    "Animation" | "Still"
  BakeTarget  "Packed" | "Disk"
  Directory   Option(Str)
  FrameStart  Int
  FrameEnd    Int
  BakeSize    Int
}

NodesModifier ModifierData & {
  NodeGroup     Option(NodeTree)
  BakeDirectory Option(Str)
  BakeTarget    "Packed" | "Disk"
  Bakes         List(NodesModifierBake)
}

ShaderFxData {
  Name Str
  Type "Blur" | "Colorize" | "Flip" | "Glow" | "Pixel" | "Rim" | "Shadow" | "Swirl" | "Wave"
  Mode Int
}

Constraint {
  Name       Str
  Type       Str
  Target     Option(Object)
  Subtarget  Option(Str)
  Influence  Float
  OwnerSpace "World" | "Custom" | "Pose" | "LocalWithParent" | "Local"
  TargetSpace "World" | "Custom" | "Pose" | "LocalWithParent" | "Local"
  Muted      Bool
}

// --- Physics & PointCache ---
PointCache {
  Name        Str
  Index       Int
  StartFrame  Int
  EndFrame    Int
  Step        Int
  SimFrame    Int
  Compression "None" | "ZstdFiltered"
  Flag        Int
}

PhysicsSettings {
  Gravity        Vec3f
  QuickCacheStep Int
}

ClothSimSettings {
  Mass              Float
  StepsPerFrame     Int
  TimeScale         Float
  Tension           Float
  Compression       Float
  Shear             Float
  Bending           Float
  DampingTension    Float
  DampingCompression Float
  DampingShear      Float
  DampingBending    Float
  VertexGroupMass   Str
}

ClothCollSettings {
  EnableCollision     Bool
  EnableSelfCollision Bool
  DistanceMin         Float
  SelfDistanceMin     Float
  Friction            Float
  SelfFriction        Float
  CollisionCollection Option(Collection)
}

FluidDomainSettings {
  DomainType         "Gas" | "Liquid"
  ResolutionMax      Int
  UseAdaptiveDomain  Bool
  UseNoise           Bool
  UseMesh            Bool
  UseViscosity       Bool
  CacheDirectory     Str
  CacheFileFormat    "Uni" | "OpenVDB" | "Raw" | "Object"
  PointCache         PointCache
}

RigidBodyWorld {
  Group               Option(Collection)
  Constraints         Option(Collection)
  TimeScale           Float
  SubstepsPerFrame    Int
  NumSolverIterations Int
  PointCache          PointCache
}

RigidBodyOb {
  Type        "Active" | "Passive"
  Shape       "Box" | "Sphere" | "Capsule" | "Cylinder" | "Cone" | "ConvexHull" | "Mesh" | "Compound"
  Mass        Float
  Friction    Float
  Restitution Float
  Margin      Float
}

RigidBodyCon {
  Type       "Fixed" | "Point" | "Hinge" | "Slider" | "Piston" | "Generic" | "GenericSpring" | "Motor"
  Object1    Option(Object)
  Object2    Option(Object)
  Breakable  Bool
  Threshold  Float
}

ParticleSettings ID & {
  AnimData     Option(AnimData)
  ParticleType "Emitter" | "Hair"
  EmitFrom     "Verts" | "Faces" | "Volume"
  Distribution "Jittered" | "Random" | "Grid"
  PhysicsType  "No" | "Newton" | "Keyed" | "Boids" | "Fluid"
  Count        Int
  FrameStart   Float
  FrameEnd     Float
  Lifetime     Float
  NormalFactor Float
  Mass         Float
  Size         Float
}

ParticleSystem {
  Name       Str
  Settings   Option(ParticleSettings)
  Seed       Int
  ChildSeed  Int
  PointCache PointCache
}

// --- XPBD Solver ---
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

XPBDConstraintSetParams {
  Geometries            List(XPBDGeometryRef)
  DeltaTime             Float
  ComplianceTermFactor  Float
  DynamicFrictionFactor Float
}

XPBDConstraintColoring {
  ColorMasks List(List(Int))
}

XPBDPinPositionConstraint {
  PointIndices List(Int)
  PinPositions List(Vec3f)
  Compliances  List(Float)
  ErrorScale   Float
  Lambdas      List(Float)
}

XPBDPinRotationConstraint {
  PointIndices List(Int)
  PinRotations List(Quat)
  Compliances  List(Float)
  ErrorScale   Float
  Lambdas      List(Vec4f)
}

XPBDCollisionFaceConstraint {
  GeometryIndex       Int
  Points              List(Int)
  PointRadii          List(Float)
  ContactPointsOnFace List(Vec3f)
  ContactPointsMotion List(Vec3f)
  FaceNormals         List(Vec3f)
  FaceMargins         List(Float)
  ComplianceTerms     List(Float)
  StaticFrictions     List(Float)
  DynamicFrictions    List(Float)
  ErrorScales         List(Float)
  ActiveStates        List(Bool)
  LambdasNormal       List(Float)
}

XPBDCollisionEdgeConstraint {
  GeometryIndex       Int
  PointPairs          List(Vec2i)
  PointRadii          List(Vec2f)
  ContactPointsOnEdge List(Vec3f)
  ContactPointsMotion List(Vec3f)
  EdgeDirections      List(Vec3f)
  EdgeNormals         List(Vec3f)
  EdgeMargins         List(Float)
  ComplianceTerms     List(Float)
  StaticFrictions     List(Float)
  DynamicFrictions    List(Float)
  ErrorScales         List(Float)
  ActiveStates        List(Bool)
  PointMixFactors     List(Float)
  LambdasNormal       List(Float)
}


// =============================================================================
// 8. Functions, Fields, MultiFunctions & LazyFunctions
// =============================================================================

FieldInput {
  DataType  AttrType
  DebugName Str
}

FieldOperation {
  Function MultiFunction
  Inputs   List(GField)
}

GField
  FieldInput | FieldOperation | Any

Field(T) {
  BaseField GField
}

FieldContext {
  Domain AttrDomain
}

FieldEvaluator {
  Context        FieldContext
  Mask           List(Int)
  SelectionField Option(Field(Bool))
  Fields         List(GField)
  IsEvaluated    Bool
}

// --- Multi-Function ---
MFDataType {
  Category "Single" | "Vector"
  BaseType AttrType
}

MFParamType {
  Category "SingleInput" | "VectorInput" | "SingleOutput" | "VectorOutput" | "SingleMutable" | "VectorMutable"
  DataType MFDataType
}

MFParamInfo {
  Name Str
  Type MFParamType
  Flag "None" | "SupportsUnusedOutput"
}

MFSignature {
  FunctionName Str
  Params       List(MFParamInfo)
}

MultiFunction {
  Signature MFSignature
}

// --- Lazy-Function ---
LFValueUsage
  "Used" | "Maybe" | "Unused"

LFInput {
  DebugName Str
  Type      AttrType
  Usage     LFValueUsage
}

LFOutput {
  DebugName Str
  Type      AttrType
}

LazyFunction {
  DebugName                   Str
  Inputs                      List(LFInput)
  Outputs                     List(LFOutput)
  AllowMissingRequestedInputs Bool
}

LFSocket {
  Node         LFNode
  Type         AttrType
  IsInput      Bool
  IndexInNode  Int
  IndexInGraph Int
}

LFInputSocket LFSocket & {
  Origin       Option(LFOutputSocket)
  DefaultValue Any
}

LFOutputSocket LFSocket & {
  Targets List(LFInputSocket)
}

LFNode {
  Function     Option(LazyFunction)
  Inputs       List(LFInputSocket)
  Outputs      List(LFOutputSocket)
  IndexInGraph Int
}

LFGraph {
  Name         Str
  Nodes        List(LFNode)
  GraphInputs  List(LFOutputSocket)
  GraphOutputs List(LFInputSocket)
}


// =============================================================================
// 9. Node System (BKE, Declarations, Bundles, Closures, Shader, Geo, Comp)
// =============================================================================

NodeTreeType
  "Shader" | "Composite" | "Texture" | "Geometry" | "Custom"

SocketDataType
  "Custom" | "Value" | "Int" | "Boolean" | "Vector" | "IntVector" | "Rotation"
  | "Matrix" | "String" | "RGBA" | "Shader" | "Object" | "Image" | "Geometry"
  | "Collection" | "Texture" | "Material" | "Font" | "Scene" | "Text" | "Mask"
  | "Sound" | "Menu" | "Bundle" | "Closure"

StructureType
  "Auto" | "Single" | "Dynamic" | "Field" | "Grid" | "List"

SocketDisplayShape
  "Circle" | "Square" | "Diamond" | "CircleDot" | "SquareDot" | "DiamondDot"
  | "Line" | "VolumeGrid" | "List"

SocketDeclaration {
  Name                  Str
  Identifier            Str
  ShortLabel            Option(Str)
  Description           Str
  InOut                 "Input" | "Output"
  SocketType            SocketDataType
  StructureType         StructureType
  DefaultValue          Any
  MinValue              Option(Float)
  MaxValue              Option(Float)
  HideValue             Bool
  IsMultiInput          Bool
  NoMuteLinks           Bool
  IsAttributeName       Bool
  IsLayerName           Bool
  IsVolumeGridName      Bool
  IsDefaultLinkSocket   Bool
  IsPanelToggle         Bool
}

PanelDeclaration {
  Identifier       Int
  Name             Str
  Description      Str
  DefaultCollapsed Bool
  Items            List(SocketDeclaration | PanelDeclaration)
}

NodeDeclaration {
  Inputs                List(SocketDeclaration)
  Outputs               List(SocketDeclaration)
  Panels                List(PanelDeclaration)
  UseCustomSocketOrder  Bool
  AllowAnySocketOrder   Bool
  IsFunctionNode        Bool
}

// --- Bundles & Closures ---
BundleItemValue {
  SocketType Option(SocketDataType)
  Value      Any
}

Bundle {
  Items Map(Str, BundleItemValue)
}

BundleSignatureItem {
  Key           Str
  SocketType    SocketDataType
  StructureType StructureType
}

BundleSignature {
  Items List(BundleSignatureItem)
}

ClosureSignature {
  Inputs  List(BundleSignatureItem)
  Outputs List(BundleSignatureItem)
}

Closure {
  Signature          ClosureSignature
  Function           LazyFunction
  DefaultInputValues List(Any)
  CapturedValues     List(Any)
}

// --- Node Tree Interface ---
NodeTreeInterfaceSocket {
  Name                 Str
  Description          Str
  Identifier           Str
  SocketType           SocketDataType
  InOut                "Input" | "Output"
  StructureType        StructureType
  AttributeDomain      AttrDomain
  DefaultAttributeName Option(Str)
  DefaultValue         Any
  Properties           List(IDProperty)
}

NodeTreeInterfacePanel {
  Name             Str
  Description      Str
  Identifier       Int
  DefaultCollapsed Bool
  Items            List(NodeTreeInterfaceSocket | NodeTreeInterfacePanel)
}

NodeTreeInterface {
  RootPanel   NodeTreeInterfacePanel
  ActiveIndex Int
}

// --- Nodes & Links ---
NodeSocket {
  Identifier   Str
  Name         Str
  Label        Str
  Description  Str
  InOut        "Input" | "Output"
  Type         SocketDataType
  DisplayShape SocketDisplayShape
  DefaultValue Any
  IsHidden     Bool
  IsMultiInput Bool
  IsAvailable  Bool
  Properties   List(IDProperty)
}

NodePanelState {
  Identifier Int
  Collapsed  Bool
}

NodeWarning {
  Type    "Error" | "Warning" | "Info"
  Message Str
}

Node {
  Identifier       Int
  Name             Str
  Label            Str
  Idname           Str
  Parent           Option(Node)
  Inputs           List(NodeSocket)
  Outputs          List(NodeSocket)
  PanelStates      List(NodePanelState)
  Location         Vec2f
  Width            Float
  Height           Float
  Color            Color3f
  UseCustomColor   Bool
  Muted            Bool
  Selected         Bool
  Active           Bool
  Collapsed        Bool
  ShowPreview      Bool
  TargetId         Option(ID)
  Storage          Any
  Declaration      Option(NodeDeclaration)
  Properties       List(IDProperty)
}

NodeLink {
  FromNode         Node
  FromSocket       NodeSocket
  ToNode           Node
  ToSocket         NodeSocket
  MultiInputSortId Int
  IsMuted          Bool
  IsValid          Bool
}

NodeTree ID & {
  AnimData        Option(AnimData)
  TreeType        NodeTreeType
  Idname          Str
  Description     Str
  Nodes           List(Node)
  Links           List(NodeLink)
  Interface       NodeTreeInterface
  ViewCenter      Vec2f
  DefaultWidth    Int
  ActiveViewerKey Int
}

// --- MaterialX Export ---
MaterialXNodeItemType
  "Any" | "Empty" | "Multioutput" | "String" | "Filename" | "Boolean" | "Integer"
  | "Float" | "Vector2" | "Vector3" | "Color3" | "Vector4" | "Color4" | "BSDF"
  | "EDF" | "DisplacementShader" | "SurfaceShader" | "Material" | "SurfaceOpacity"

MaterialXNodeItem {
  NodeName Str
  ItemType MaterialXNodeItemType
  Value    Any
  Inputs   Map(Str, MaterialXNodeItem)
}

MaterialXGraph {
  Material    Material
  NodePrefix  Str
  Nodes       Map(Str, MaterialXNodeItem)
  OutputNames List(Str)
}


// =============================================================================
// 10. GPU Subsystem, Shaders, Render Graph & BSL Shader Tool
// =============================================================================

GPUBackendType
  "None" | "OpenGL" | "Metal" | "Vulkan" | "Dummy"

GPUPrimType
  "Points" | "Lines" | "LineStrip" | "LineLoop" | "Triangles" | "TriStrip" | "TriFan" | "LinesAdj" | "TrisAdj"

GPUUsageType
  "Stream" | "Static" | "Dynamic" | "DeviceOnly"

GPUTextureFormat
  "RGBA8_UNORM" | "RGBA8_SRGB" | "RGBA16_UNORM" | "RGBA16_FLOAT" | "RGBA32_FLOAT"
  | "RG8_UNORM" | "RG16_FLOAT" | "RG32_FLOAT" | "R8_UNORM" | "R16_FLOAT" | "R32_FLOAT"
  | "R32_UINT" | "R32_SINT" | "R11G11B10_FLOAT" | "RGB10_A2" | "DEPTH24_STENCIL8"
  | "DEPTH32F_STENCIL8" | "DEPTH_COMPONENT24" | "DEPTH_COMPONENT32F"

GPUTextureUsage
  "ShaderRead" | "ShaderWrite" | "Attachment" | "HostRead" | "Atomic"

GPUDataFormat
  "Float" | "Int" | "UInt" | "UByte" | "UInt24_8" | "10_11_11_Rev" | "2_10_10_10_Rev" | "HalfFloat"

GPUBlendMode
  "None" | "Alpha" | "AlphaPremult" | "Additive" | "AdditivePremult" | "Multiply" | "Subtract" | "Invert" | "OIT" | "Background" | "Custom"

GPUDepthTest
  "None" | "Always" | "Less" | "LessEqual" | "Equal" | "Greater" | "GreaterEqual"

GPUWriteMask
  "None" | "Red" | "Green" | "Blue" | "Alpha" | "Depth" | "Stencil" | "Color" | "ColorAndDepth"

GPUFaceCullTest
  "None" | "Front" | "Back"

GPUVertAttr {
  Name   Str
  Type   AttrType
  Offset Int
}

GPUVertFormat {
  Attributes    List(GPUVertAttr)
  Stride        Int
  Deinterleaved Bool
}

GPUVertBuf {
  Format      GPUVertFormat
  VertexLen   Int
  VertexAlloc Int
  Usage       GPUUsageType
  Status      "Invalid" | "Init" | "Dirty" | "Uploaded"
  Data        List(Byte)
}

GPUIndexBuf {
  IndexType       "UInt16" | "UInt32"
  IndexStart      Int
  IndexLen        Int
  IndexBase       Int
  IsSubrange      Bool
  Data            List(Int)
}

GPUBatch {
  PrimType           GPUPrimType
  Verts              List(GPUVertBuf)
  Elem               Option(GPUIndexBuf)
  ProceduralVertices Int
  Shader             Option(GPUShader)
  Flag               Int
}

GPUUniformBuf {
  Name        Str
  SizeInBytes Int
  Slot        Int
  Data        List(Byte)
}

GPUStorageBuf {
  Name        Str
  SizeInBytes Int
  Usage       GPUUsageType
  Slot        Int
  Data        List(Byte)
}

GPUSamplerState {
  Filter     "Nearest" | "Linear" | "Anisotropic"
  Mipmap     "None" | "Nearest" | "Linear"
  ExtendX    "Extend" | "Repeat" | "MirroredRepeat" | "ClampToBorder"
  ExtendY    "Extend" | "Repeat" | "MirroredRepeat" | "ClampToBorder"
  ExtendZ    "Extend" | "Repeat" | "MirroredRepeat" | "ClampToBorder"
}

GPUTexture {
  Name         Str
  Type         "1D" | "1DArray" | "2D" | "2DArray" | "3D" | "Cube" | "CubeArray" | "Buffer"
  Format       GPUTextureFormat
  Usage        Int
  Width        Int
  Height       Int
  Depth        Int
  Mipmaps      Int
  SamplerState GPUSamplerState
}

GPUAttachment {
  Texture Option(GPUTexture)
  Layer   Int
  Mip     Int
}

GPUFrameBuffer {
  Name             Str
  Width            Int
  Height           Int
  DepthAttachment  GPUAttachment
  StencilAttachment GPUAttachment
  ColorAttachments List(GPUAttachment)
  Viewport         RectI
  Scissor          RectI
  ScissorTest      Bool
}

GPUOffScreen {
  Width        Int
  Height       Int
  Format       GPUTextureFormat
  ColorTexture GPUTexture
  DepthTexture GPUTexture
  FrameBuffer  GPUFrameBuffer
}

GPUViewport {
  Width              Int
  Height             Int
  IsStereo           Bool
  ActiveView         Int
  ColorTextures      List(GPUTexture)
  OverlayTextures    List(GPUTexture)
  DepthTexture       GPUTexture
  FramebufferRender  GPUFrameBuffer
  FramebufferOverlay GPUFrameBuffer
}

// --- Shader Create Info & Specialization ---
GPUSpecializationConstant {
  Name  Str
  Type  "Int" | "UInt" | "Float" | "Bool"
  Value Int | Float | Bool
}

GPUStageInterfaceInfo {
  Name       Str
  InstanceName Str
  Attributes List((Str, Str, "Smooth" | "Flat" | "NoPerspective"))
}

GPUResourceBinding {
  BindType  "UniformBuf" | "StorageBuf" | "Sampler" | "Image" | "AccelerationStructure" | "InputAttachment"
  Slot      Int
  Name      Str
  TypeName  Str
  Frequency "Pass" | "Batch" | "Geometry"
}

GPUShaderCreateInfo {
  Name                    Str
  VertexInputs            List((Int, AttrType, Str))
  VertexOutInterfaces     List(GPUStageInterfaceInfo)
  FragmentOutputs         List((Int, AttrType, Str))
  PushConstants           List((AttrType, Str, Int))
  SpecializationConstants List(GPUSpecializationConstant)
  Resources               List(GPUResourceBinding)
  VertexSource            Option(Str)
  GeometrySource          Option(Str)
  FragmentSource          Option(Str)
  ComputeSource           Option(Str)
  TypedefSources          List(Str)
  Defines                 List((Str, Str))
  LocalGroupSize          Vec3i
  DepthWrite              "Any" | "Unchanged" | "Greater" | "Less"
}

GPUShader {
  Name      Str
  IsValid   Bool
  IsCompute Bool
  Info      Option(GPUShaderCreateInfo)
}

// --- Ray Tracing Acceleration Structures ---
GPUBottomLevelAS {
  Name       Str
  Geometries List((GPUIndexBuf, GPUVertBuf))
}

GPUTopLevelAS {
  Name      Str
  Instances List((GPUBottomLevelAS, Mat4x4, Byte))
  IsDirty   Bool
}

// --- GPUMaterial (EEVEE / Viewport / Compositor) ---
GPUMaterialEngine
  "EEVEE" | "Compositor"

GPUMaterialStatus
  "Failed" | "Queued" | "Success"

GPUNodeLink {
  LinkType "Constant" | "Uniform" | "Attribute" | "UniformAttr" | "LayerAttr" | "Texture" | "Output"
  Name     Str
}

GPUNodeStack {
  Type       AttrType
  Value      Any
  Link       Option(GPUNodeLink)
  HasInput   Bool
  HasOutput  Bool
  SocketType Int
}

GPUPass {
  Shader Option(GPUShader)
  Status GPUMaterialStatus
}

GPUMaterial {
  Name                  Str
  Engine                GPUMaterialEngine
  Material              Option(Material)
  Status                GPUMaterialStatus
  Pass                  Option(GPUPass)
  UniformBuf            Option(GPUUniformBuf)
  HasSurfaceOutput      Bool
  HasVolumeOutput       Bool
  HasDisplacementOutput Bool
  Flags                 Int
  Uuid                  Int
}

// --- ShaderClosures (BSL / EEVEE / Cycles) ---
ClosureDiffuse {
  Color  Vec3f
  Normal Vec3f
}

ClosureSubsurface {
  Color     Vec3f
  Normal    Vec3f
  SssRadius Vec3f
}

ClosureTranslucent {
  Color  Vec3f
  Normal Vec3f
}

ClosureReflection {
  Color     Vec3f
  Normal    Vec3f
  Roughness Float
}

ClosureRefraction {
  Color     Vec3f
  Normal    Vec3f
  Roughness Float
  Ior       Float
}

ClosureVolumeScatter {
  Scattering Vec3f
  Anisotropy Float
}

ClosureVolumeAbsorption {
  Absorption Vec3f
}

ClosureEmission {
  Emission Vec3f
}

ClosureTransparency {
  Transmittance Vec3f
  Holdout       Float
}

ShaderClosure
  ClosureDiffuse | ClosureSubsurface | ClosureTranslucent | ClosureReflection
  | ClosureRefraction | ClosureVolumeScatter | ClosureVolumeAbsorption
  | ClosureEmission | ClosureTransparency

// --- Vulkan Render Graph ---
VKNodeType
  "BeginRendering" | "EndRendering" | "ClearAttachments" | "ClearColorImage"
  | "ClearDepthStencilImage" | "FillBuffer" | "UpdateBuffer" | "CopyBuffer"
  | "CopyImage" | "CopyBufferToImage" | "CopyImageToBuffer" | "BlitImage"
  | "Synchronization" | "UpdateMipmaps" | "Dispatch" | "DispatchIndirect"
  | "Draw" | "DrawIndexed" | "DrawIndirect" | "DrawIndexedIndirect"
  | "BeginQuery" | "EndQuery" | "ResetQueryPool" | "BuildAccelerationStructure"

VKResourceAccess {
  ResourceHandle Int
  ResourceType   "None" | "Image" | "Buffer"
  AccessFlags    Int
  ImageLayout    Int
}

VKRenderGraphNode {
  NodeType     VKNodeType
  StorageIndex Int
  Inputs       List(VKResourceAccess)
  Outputs      List(VKResourceAccess)
}

VKRenderGraph {
  Nodes List(VKRenderGraphNode)
}

// --- BSL Shader Tool (Lexer, AST, Semantic Analysis) ---
BSLTokenType
  "Invalid" | "Word" | "Number" | "String" | "NewLine" | "Space" | "Comment"
  | "Dot" | "Hash" | "Ampersand" | "ParOpen" | "ParClose" | "BracketOpen"
  | "BracketClose" | "SquareOpen" | "SquareClose" | "AngleOpen" | "AngleClose"
  | "Assign" | "SemiColon" | "Colon" | "Comma" | "Plus" | "Minus" | "Star" | "Slash"

BSLScopeType
  "Invalid" | "Global" | "Namespace" | "Struct" | "Function" | "LoopArgs"
  | "LoopBody" | "SwitchArg" | "SwitchBody" | "FunctionArgs" | "FunctionCall"
  | "Template" | "TemplateArg" | "Subscript" | "Preprocessor" | "Assignment"
  | "Attributes" | "Attribute" | "Local" | "Statement"

BSLToken {
  Type   BSLTokenType
  Offset Int
  Length Int
  Text   Str
}

BSLScope {
  Type       BSLScopeType
  TokenRange (Int, Int)
  Parent     Int
  Children   List(Int)
}

BSLSymbolVariable {
  Name            Str
  TypeName        Str
  ArrayDimensions Int
  Offset          Int
  IsConst         Bool
  IsConstexpr     Bool
}

BSLSymbolClass {
  Name       Str
  Size       Int
  Align      Int
  IsUnion    Bool
  IsEnum     Bool
  Members    List(BSLSymbolVariable)
}

BSLSymbolFunction {
  Name       Str
  ReturnType Str
  ArgTypes   List(Str)
  IsEntryPoint Bool
  IsConstexpr  Bool
}

BSLSymbolTable {
  Classes   Map(Str, BSLSymbolClass)
  Functions Map(Str, List(BSLSymbolFunction))
  Variables Map(Str, BSLSymbolVariable)
}


// =============================================================================
// 11. Image Buffer (ImBuf), OpenColorIO (OCIO) & Movie I/O
// =============================================================================

ImFileType
  "None" | "PNG" | "TGA" | "JPG" | "BMP" | "OpenEXR" | "Iris" | "PSD"
  | "JP2" | "RadHDR" | "TIF" | "Cineon" | "DPX" | "DDS" | "WebP" | "AVIF"

ImColorMode
  "BW" | "BWA" | "RGB" | "RGBA"

ImBuf {
  Width          Int
  Height         Int
  Channels       Int
  ColorMode      ImColorMode
  ByteData       Option(List(Byte))
  FloatData      Option(List(Float))
  ByteColorspace Str
  FloatColorspace Str
  GpuTexture     Option(GPUTexture)
  Ppm            (Float, Float)
  Filepath       Str
  FileType       ImFileType
  Metadata       List(IDProperty)
  Flags          Int
}

ImageTile {
  TileNumber Int
  Label      Str
  GenColor   Color4f
}

RenderSlot {
  Name   Str
  Render Option(RenderResult)
}

ImageUser {
  Scene       Option(Scene)
  FrameNr     Int
  Frames      Int
  Offset      Int
  StartFrame  Int
  Tile        Int
  Layer       Int
  Pass        Int
  View        Int
  Cyclic      Bool
}

Image ID & {
  Filepath           Str
  Source             "File" | "Sequence" | "Movie" | "Generated" | "Viewer" | "Tiled"
  ImageType          "Image" | "Multilayer" | "UvTest" | "RenderResult" | "Composite"
  AlphaMode          "Straight" | "Premul" | "ChannelPacked" | "None"
  ColorspaceSettings ColorManagedColorspaceSettings
  RenderSlots        List(RenderSlot)
  Tiles              List(ImageTile)
  ActiveTileIndex    Int
  Flag               Int
}

// --- OpenColorIO (OCIO) ---
OCIOColorSpace {
  Index             Int
  Name              Str
  Description       Str
  Family            Str
  InteropId         Str
  IsSceneLinear     Bool
  IsSrgb            Bool
  IsData            Bool
  IsDisplayReferred Bool
}

OCIOView {
  Index            Int
  Name             Str
  Description      Str
  IsHdr            Bool
  Gamut            "Unknown" | "Rec709" | "P3D65" | "Rec2020"
  TransferFunction "Unknown" | "sRGB" | "ExtendedsRGB" | "Gamma22" | "Gamma24" | "PQ" | "HLG"
  MaxNits          Int
}

OCIODisplay {
  Index       Int
  Name        Str
  UiName      Str
  Description Str
  Views       List(OCIOView)
}

OCIOLook {
  Index        Int
  Name         Str
  UiName       Str
  ProcessSpace Str
  IsNoop       Bool
}

OCIOConfig {
  ColorSpaces List(OCIOColorSpace)
  Displays    List(OCIODisplay)
  Looks       List(OCIOLook)
  LumaCoefs   Vec3f
  XyzToLinear Mat3x3
}

ColorManagedViewSettings {
  Look          Str
  ViewTransform Str
  Exposure      Float
  Gamma         Float
  Temperature   Float
  Tint          Float
  UseWhiteBalance Bool
  UseCurveMapping Bool
}

ColorManagedDisplaySettings {
  DisplayDevice Str
  Emulation     "None" | "Auto"
}

ColorManagedColorspaceSettings {
  Name      Str
  InteropId Str
}

// --- Movie Reader & Writer ---
MovieReader {
  Filepath         Str
  Width            Int
  Height           Int
  DurationFrames   Int
  Fps              Float
  StartOffsetSec   Float
  VideoStreamCount Int
  IsValid          Bool
}

MovieWriter {
  Filepath Str
  Width    Int
  Height   Int
  Fps      Float
  Codec    Str
}


// =============================================================================
// 12. Render Engine, Bake, Compositor & Hydra
// =============================================================================

RenderView {
  Name  Str
  ImBuf Option(ImBuf)
}

RenderPass {
  Name     Str
  FullName Str
  ChanId   Str
  View     Str
  ViewId   Int
  Channels Int
  RectX    Int
  RectY    Int
  ImBuf    Option(ImBuf)
}

RenderLayer {
  Name      Str
  RectX     Int
  RectY     Int
  LayFlag   Int
  PassFlag  Int
  Passes    List(RenderPass)
}

RenderResult {
  RectX        Int
  RectY        Int
  TileRect     RectI
  FrameNr      Int
  Ppm          (Float, Float)
  HaveCombined Bool
  Layers       List(RenderLayer)
  Views        List(RenderView)
  Text         Option(Str)
  Error        Option(Str)
  Metadata     List(IDProperty)
}

RenderStats {
  Frame          Int
  LocalView      Bool
  StartTime      Float
  LastFrameTime  Float
  SceneName      Str
  InfoStr        Str
  StatStr        Str
  MemUsed        Int
  MemPeak        Int
}

ImageFormatData {
  MediaType        "Image" | "MultiLayerImage" | "Video"
  ImType           ImFileType
  ColorMode        ImColorMode
  Depth            "8" | "10" | "12" | "16" | "32"
  Quality          Int
  Compression      Int
  ExrCodec         Str
  ViewsFormat      "Individual" | "Stereo3D" | "Multiview"
  ViewSettings     ColorManagedViewSettings
  DisplaySettings  ColorManagedDisplaySettings
  LinearColorspace ColorManagedColorspaceSettings
}

BakeData {
  Format            ImageFormatData
  Filepath          Str
  Width             Int
  Height            Int
  Margin            Int
  MarginType        "AdjacentFaces" | "Extend"
  CageExtrusion     Float
  MaxRayDistance    Float
  NormalSpace       "Object" | "Tangent"
  Target            "ImageTextures" | "VertexColors"
  SaveMode          "Internal" | "External"
  CageObject        Option(Object)
}

RenderData {
  ImFormat         ImageFormatData
  CurrentFrame     Int
  StartFrame       Int
  EndFrame         Int
  Subframe         Float
  FrameStep        Int
  ResolutionX      Int
  ResolutionY      Int
  ResolutionScale  Int
  PixelAspectX     Float
  PixelAspectY     Float
  Fps              Int
  FpsBase          Float
  Border           RectF
  Engine           Str
  MotionBlurShutter Float
  Bake             BakeData
}

SceneEEVEE {
  TaaSamples             Int
  TaaRenderSamples       Int
  UseRaytracing          Bool
  VolumetricStart        Float
  VolumetricEnd          Float
  VolumetricTileSize     Int
  VolumetricSamples      Int
  ShadowPoolSize         Int
  ShadowRayCount         Int
  ShadowStepCount        Int
  DirectLightIntensity   Float
  IndirectLightIntensity Float
}

RenderEngineType {
  Idname Str
  Name   Str
  Flag   Int
}

RenderEngine {
  Type           RenderEngineType
  CameraOverride Option(Object)
  ResolutionX    Int
  ResolutionY    Int
  Depsgraph      Option(Depsgraph)
  Reports        Option(ReportList)
  Flag           Int
}

Render {
  Name       Str
  Scene      Option(Scene)
  RenderData RenderData
  Result     Option(RenderResult)
  Stats      RenderStats
  Engine     Option(RenderEngine)
}

// --- USD Hydra Render Delegate ---
HydraEmittedGeometryPrim {
  SchemaToken Str
  Path        Str
}

HydraPopulateContext {
  Depsgraph   Depsgraph
  Main        Main
  Scene       Scene
  View3D      Option(View3D)
  RootPath    Str
  UseMaterialX Bool
}

HydraEngine {
  RenderDelegateName Str
  RenderEngine       RenderEngine
  Depsgraph          Option(Depsgraph)
  Scene              Option(Scene)
  PercentDone        Float
}


// =============================================================================
// 13. Sculpt, Paint, Grease Pencil Draw & Curves Sculpt
// =============================================================================

BrushCurvePreset
  "Custom" | "Smooth" | "Sphere" | "Root" | "Sharp" | "Linear" | "Pow4" | "InvSquare" | "Constant" | "Smoother"

SculptBrushType
  "Draw" | "Smooth" | "Pinch" | "Inflate" | "Grab" | "Layer" | "Flatten" | "Clay"
  | "Fill" | "Scrape" | "Nudge" | "Thumb" | "SnakeHook" | "Rotate" | "Simplify"
  | "Crease" | "Blob" | "ClayStrips" | "Mask" | "DrawSharp" | "ElasticDeform"
  | "Pose" | "MultiplaneScrape" | "SlideRelax" | "ClayThumb" | "Cloth"
  | "DrawFaceSets" | "Paint" | "Smear" | "Boundary" | "DisplacementEraser"
  | "DisplacementSmear" | "Plane" | "Blur" | "SceneProject"

CurvesSculptBrushType
  "Comb" | "Delete" | "SnakeHook" | "Add" | "GrowShrink" | "SelectionPaint"
  | "Pinch" | "Smooth" | "Puff" | "Density" | "Slide" | "Cut"

ImagePaintBrushType
  "Draw" | "Soften" | "Smear" | "Clone" | "Fill" | "Mask"

VertexPaintBrushType
  "Draw" | "Blur" | "Average" | "Smear"

WeightPaintBrushType
  "Draw" | "Blur" | "Average" | "Smear"

GPaintBrushType
  "Draw" | "Fill" | "Erase" | "Tint"

GPSculptBrushType
  "Smooth" | "Thickness" | "Strength" | "Grab" | "Push" | "Twist" | "Pinch" | "Randomize" | "Clone"

BrushStrokeMode
  "Normal" | "Invert" | "Smooth" | "Erase"

Brush ID & {
  SculptBrushType       SculptBrushType
  CurvesSculptBrushType CurvesSculptBrushType
  ImagePaintBrushType   ImagePaintBrushType
  VertexPaintBrushType  VertexPaintBrushType
  WeightPaintBrushType  WeightPaintBrushType
  GPaintBrushType       GPaintBrushType
  GPSculptBrushType     GPSculptBrushType
  Size                  Int
  UnprojectedRadius     Float
  Alpha                 Float
  Weight                Float
  Jitter                Float
  Spacing               Int
  SmoothStrokeRadius    Int
  SmoothStrokeFactor    Float
  Rate                  Float
  Rgb                   Color3f
  SecondaryRgb          Color3f
  BlendMode             BlendMode
  CurvePreset           BrushCurvePreset
  FalloffShape          "Sphere" | "Tube"
  AutomaskingFlags      Int
  Flag                  Int
}

PaletteColor {
  Color Color3f
  Value Float
}

Palette ID & {
  Colors      List(PaletteColor)
  ActiveColor Int
}

PaintCurvePoint {
  Bezier BezierTriple
  Pressure Float
}

PaintCurve ID & {
  Points      List(PaintCurvePoint)
  ActiveIndex Int
}

UnifiedPaintSettings {
  Size              Int
  UnprojectedSize   Float
  Alpha             Float
  Weight            Float
  Color             Color3f
  SecondaryColor    Color3f
  InputSamples      Int
  Flag              Int
}

Paint {
  Brush                Option(Brush)
  Palette              Option(Palette)
  SymmetryFlags        SymmetryFlags
  TileOffset           Vec3f
  UnifiedPaintSettings UnifiedPaintSettings
  Flags                Int
}

Sculpt {
  Paint           Paint
  DetailSize      Float
  ConstantDetail  Float
  DetailPercent   Float
  GravityFactor   Float
  GravityObject   Option(Object)
  Flags           Int
}

StrokeCache {
  InitialRadius      Float
  Radius             Float
  RadiusSquared      Float
  InitialMouse       Vec2f
  Mouse              Vec2f
  Location           Vec3f
  LastLocation       Vec3f
  StrokeDistance     Float
  Pressure           Float
  Hardness           Float
  BaseBrushStrength  Float
  BrushStrength      Float
  FirstTime          Bool
  ProjectionMat      Mat4x4
  ViewNormal         Vec3f
  SculptNormal       Vec3f
  GrabDelta          Vec3f
  PaintFaceSet       Int
  MirrorSymmetryPass SymmetryFlags
  RadialSymmetryPass Int
}

SculptSession {
  StrokeCache     Option(StrokeCache)
  ActiveVertIndex Int
  ActiveFaceIndex Int
  ActiveFaceSet   Int
  PivotPos        Vec3f
  PivotRot        Quat
  SubdivCCG       Option(Any)
  BMesh           Option(Any)
}

ToolSettings {
  Sculpt               Option(Sculpt)
  VertexPaint          Option(Paint)
  WeightPaint          Option(Paint)
  ImagePaint           Option(Paint)
  CurvesSculpt         Option(Paint)
  GpPaint              Option(Paint)
  GpSculptPaint        Option(Paint)
  GpVertexPaint        Option(Paint)
  GpWeightPaint        Option(Paint)
  UnifiedPaintSettings UnifiedPaintSettings
  SelectMode           Int
  UvSelectMode         Int
  TransformPivotPoint  Str
  SnapMode             Int
  SnapFlag             Int
  ProportionalEdit     Int
  ProportionalSize     Float
  AutoKeyMode          Int
}

// --- Sculpt & Paint Operations ---
SculptLocalData {
  Positions      List(Vec3f)
  LocalPositions List(Vec3f)
  Normals        List(Vec3f)
  Factors        List(Float)
  Distances      List(Float)
  Masks          List(Float)
  Translations   List(Vec3f)
}

CurvesBrush3D {
  PositionCu Vec3f
  RadiusCu   Float
}

StrokeExtension {
  IsFirst       Bool
  MousePosition Vec2f
  Pressure      Float
  Reports       Option(ReportList)
}

CurvesSculptCommonContext {
  Depsgraph Depsgraph
  Scene     Scene
  Region    ARegion
  View3D    View3D
  Rv3D      RegionView3D
  Object    Object
}

GreasePencilInputSample {
  MousePosition Vec2f
  Pressure      Float
}

GreasePencilStrokeParams {
  ToolSettings      ToolSettings
  Region            ARegion
  Rv3D              RegionView3D
  Scene             Scene
  ObjectOrig        Object
  ObjectEval        Object
  Layer             GreasePencilLayer
  LayerIndex        Int
  FrameNumber       Int
  MultiFrameFalloff Float
  Drawing           GreasePencilDrawing
}


// =============================================================================
// 14. Video Sequence Editor (VSE)
// =============================================================================

StripType
  "Image" | "Meta" | "Scene" | "Movie" | "MovieClip" | "Mask" | "Sound"
  | "Cross" | "Add" | "Sub" | "AlphaOver" | "AlphaUnder" | "GammaCross"
  | "Mul" | "Wipe" | "Glow" | "Transform" | "Color" | "Speed" | "Multicam"
  | "Adjustment" | "GaussianBlur" | "Text" | "ColorMix" | "Compositor"

StripTransform {
  Offset    Vec2f
  Scale     Vec2f
  Rotation  Float
  Origin    Vec2f
  Filter    "Nearest" | "Bilinear" | "CubicBSpline" | "CubicMitchell" | "Box" | "Subsampled3x3"
}

StripCrop {
  Top    Int
  Bottom Int
  Left   Int
  Right  Int
}

StripElem {
  Filename   Str
  OrigWidth  Int
  OrigHeight Int
  OrigFps    Float
}

StripData {
  Dirpath   Str
  Elements  List(StripElem)
  Transform StripTransform
  Crop      StripCrop
}

SeqRetimingKey {
  StripFrameIndex         Float
  RetimingFactor          Float
  OriginalStripFrameIndex Float
  Flag                    Int
}

StripModifierData {
  Name      Str
  Type      "ColorBalance" | "Curves" | "HueCorrect" | "BrightContrast" | "Mask" | "WhiteBalance" | "Tonemap" | "SoundEqualizer" | "Compositor" | "Pitch" | "Echo"
  MaskStrip Option(Strip)
  MaskInput Option(Mask)
  Enabled   Bool
}

Strip {
  SessionUid   SessionId
  Name         Str
  Type         StripType
  Channel      Int
  StartFrame   Float
  Length       Int
  StartOffset  Float
  EndOffset    Float
  BlendMode    BlendMode
  BlendOpacity Float
  ColorTag     Int
  Data         Option(StripData)
  Scene        Option(Scene)
  SceneCamera  Option(Object)
  Clip         Option(MovieClip)
  Mask         Option(Mask)
  Sound        Option(Sound)
  EffectInput1 Option(Strip)
  EffectInput2 Option(Strip)
  SubStrips    List(Strip)
  Modifiers    List(StripModifierData)
  RetimingKeys List(SeqRetimingKey)
  Selected     Bool
  SelectLeft   Bool
  SelectRight  Bool
  Muted        Bool
  Locked       Bool
}

SeqTimelineChannel {
  Index  Int
  Name   Str
  Muted  Bool
  Locked Bool
}

Editing {
  Strips           List(Strip)
  Channels         List(SeqTimelineChannel)
  CurrentMetaStrip Option(Strip)
  ActiveStrip      Option(Strip)
}


// =============================================================================
// 15. Editors, Spaces, Regions, Outliner, View3D, Transform & UV
// =============================================================================

View2D {
  TotalRect   RectF
  CurrentRect RectF
  VertScroll  RectI
  HorScroll   RectI
  Mask        RectI
  MinZoom     Float
  MaxZoom     Float
  WinX        Int
  WinY        Int
  Flag        Int
}

PanelType {
  Idname             Str
  Label              Str
  Category           Str
  TranslationContext Str
  SpaceType          SpaceType
  RegionType         RegionType
  Order              Int
  Flag               Int
}

Panel {
  Type       Option(PanelType)
  Name       Str
  Label      Str
  OfsX       Int
  OfsY       Int
  SizeX      Int
  SizeY      Int
  IsOpen     Bool
  IsPinned   Bool
  SubPanels  List(Panel)
}

ARegion {
  RegionType RegionType
  Alignment  "None" | "Top" | "Bottom" | "Left" | "Right" | "HorizontalSplit" | "VerticalSplit" | "Float" | "QuadSplit"
  WinRect    RectI
  WinX       Int
  WinY       Int
  Visible    Bool
  Overlap    Bool
  View2D     View2D
  Panels     List(Panel)
  Handlers   List(EventHandler)
}

SpaceLink {
  SpaceType SpaceType
  Regions   List(ARegion)
}

// --- Space View3D ---
View3DShading {
  Type            DrawType
  ColorType       "Material" | "Random" | "Single" | "Texture" | "Object" | "Vertex"
  Light           "Flat" | "Studio" | "MatCap"
  BackgroundType  "Theme" | "World" | "Viewport"
  StudioLight     Str
  Matcap          Str
  SingleColor     Color3f
  BackgroundColor Color3f
  XrayAlpha       Float
  Flag            Int
}

View3DOverlay {
  EditFlag               Int
  NormalsLength          Float
  WireframeThreshold     Float
  WireframeOpacity       Float
  RetopologyOffset       Float
  SculptMaskOpacity      Float
  SculptFaceSetsOpacity  Float
  ViewerAttributeOpacity Float
  Flag                   Int
}

RegionView3D {
  WinMat     Mat4x4
  ViewMat    Mat4x4
  ViewInv    Mat4x4
  PerspMat   Mat4x4
  PerspInv   Mat4x4
  ViewQuat   Quat
  Dist       Float
  Offset     Vec3f
  CamDx      Float
  CamDy      Float
  CamZoom    Float
  PixSize    Float
  Persp      "Ortho" | "Persp" | "Camera"
  View       "User" | "Front" | "Back" | "Left" | "Right" | "Top" | "Bottom" | "Camera"
  IsPersp    Bool
  ClipPlanes List(Vec4f)
}

View3D SpaceLink & {
  Camera        Option(Object)
  ObCenter      Option(Object)
  ObCenterBone  Str
  ViewQuat      Quat
  Dist          Float
  Lens          Float
  ClipStart     Float
  ClipEnd       Float
  Grid          Float
  GridLines     Int
  GridSubdiv    Int
  RenderBorder  RectF
  Shading       View3DShading
  Overlay       View3DOverlay
  GizmoFlag     Int
  Flag          Int
}

// --- Space Outliner ---
TreeStoreElemType
  "SomeId" | "Nla" | "NlaAction" | "DefGroupBase" | "DefGroup" | "Bone" | "EBone"
  | "ConstraintBase" | "Constraint" | "ModifierBase" | "Modifier" | "LinkedOb"
  | "PoseBase" | "PoseChannel" | "AnimData" | "DriverBase" | "ViewLayerBase"
  | "ViewLayer" | "BoneCollectionBase" | "BoneCollection" | "Strip" | "StripData"
  | "StripDup" | "RnaStruct" | "RnaProperty" | "RnaArrayElem" | "NlaTrack"
  | "GpLayer" | "LayerCollection" | "SceneCollectionBase" | "ViewCollectionBase"
  | "SceneObjectsBase" | "LibraryOverrideBase" | "LibraryOverride" | "GenericLabel"
  | "GreasePencilNode" | "ActionSlot" | "ShapeKeyBlock"

TreeStoreElem {
  Type     TreeStoreElemType
  Nr       Int
  Id       Option(ID)
  Closed   Bool
  Selected Bool
  Active   Bool
}

TreeElement {
  Name       Str
  StoreElem  Option(TreeStoreElem)
  Parent     Option(TreeElement)
  Subtree    List(TreeElement)
  IdCode     Int
  Index      Int
  DirectData Any
}

SpaceOutliner SpaceLink & {
  View2D              View2D
  Tree                List(TreeElement)
  SearchString        Str
  OutlineVis          "Scenes" | "Libraries" | "Sequence" | "DataApi" | "IdOrphans" | "ViewLayer" | "OverridesLibrary"
  LibOverrideViewMode "Properties" | "Hierarchies"
  SortMethod          "None" | "Alpha" | "Custom"
  Filter              Int
  ShowRestrictFlags   Int
  Flag                Int
}

// --- Other Editor Spaces ---
SpaceProperties SpaceLink & {
  View2D       View2D
  MainTab      Str
  PinId        Option(ID)
  UsePin       Bool
  SearchString Str
}

SpaceNode SpaceLink & {
  View2D           View2D
  NodeTree         Option(NodeTree)
  EditTree         Option(NodeTree)
  TargetId         Option(ID)
  FromId           Option(ID)
  TreeType         Str
  ShaderFrom       "Object" | "World" | "LineStyle"
  GeometryType     "Modifier" | "Tool"
  CompositorType   "Scene" | "Sequencer"
  Cursor           Vec2f
  Zoom             Float
  ShowBackdrop     Bool
  Pin              Bool
}

SpaceImage SpaceLink & {
  Image       Option(Image)
  ImageUser   ImageUser
  Mode        "View" | "Paint" | "Mask" | "UV"
  Cursor      Vec2f
  Zoom        Float
  OffsetX     Float
  OffsetY     Float
  Pin         Bool
  ShowAlpha   Bool
  ShowZbuf    Bool
}

SpaceSeq SpaceLink & {
  View2D          View2D
  MainRegionType  "ImBuf" | "Waveform" | "Vectorscope" | "Histogram" | "RgbParade"
  View            "Sequence" | "Preview" | "SequencePreview"
  RenderSize      "None" | "Scene" | "Proxy25" | "Proxy50" | "Proxy75" | "Proxy100"
  Cursor          Vec2f
  Zoom            Float
  ChannelShown    Int
  Flag            Int
}

FileSelectParams {
  Title           Str
  Directory       Str
  File            Str
  RenameFile      Str
  FilterGlob      Str
  FilterSearch    Str
  FilterId        Int
  ActiveFile      Int
  DisplayType     "Default" | "VerticalList" | "HorizontalList" | "Thumbnails"
  SortType        "Default" | "Alpha" | "Extension" | "Time" | "Size" | "AssetCatalog"
  RecursionLevel  Int
  Flag            Int
}

SpaceFile SpaceLink & {
  BrowseMode   "Files" | "Assets"
  Params       Option(FileSelectParams)
  Operator     Option(wmOperator)
  ScrollOffset Int
}

SpreadsheetColumn {
  Name        Str
  DisplayName Str
  DataType    AttrType
  Width       Float
}

SpreadsheetRowFilter {
  ColumnName Str
  Operation  "Equal" | "Greater" | "Less"
  Threshold  Float
  Enabled    Bool
  Value      Any
}

SpaceSpreadsheet SpaceLink & {
  Columns         List(SpreadsheetColumn)
  RowFilters      List(SpreadsheetRowFilter)
  ComponentType   "Mesh" | "Curve" | "PointCloud" | "Instances" | "Volume" | "GreasePencil"
  AttributeDomain AttrDomain
  ObjectEvalState "Evaluated" | "Original" | "ViewerNode"
  FilterFlag      Int
  Flag            Int
}

ConsoleLine {
  Line   Str
  Cursor Int
  Type   "Output" | "Input" | "Info" | "Error"
}

SpaceConsole SpaceLink & {
  Scrollback   List(ConsoleLine)
  History      List(ConsoleLine)
  Prompt       Str
  Language     Str
  LineHeight   Int
  HistoryIndex Int
  SelStart     Int
  SelEnd       Int
}

TextLine {
  Line   Str
  Format Option(Str)
}

Text ID & {
  Filepath  Option(Str)
  Lines     List(TextLine)
  Curl      Option(TextLine)
  Curc      Int
  Sell      Option(TextLine)
  Selc      Int
  IsDirty   Bool
  IsInMemory Bool
}

SpaceText SpaceLink & {
  Text          Option(Text)
  Top           Int
  Left          Int
  LineHeight    Int
  TabNumber     Int
  MarginColumn  Int
  WordWrap      Bool
  ShowLineNrs   Bool
  ShowSyntax    Bool
  FindString    Str
  ReplaceString Str
}

SpaceGraph SpaceLink & {
  View2D      View2D
  Mode        "Animation" | "Drivers"
  CursorTime  Float
  CursorVal   Float
  PivotAround Str
  Flag        Int
}

SpaceAction SpaceLink & {
  View2D   View2D
  Action   Option(Action)
  Mode     "Action" | "ShapeKey" | "GPencil" | "CacheFile" | "Mask" | "Timeline"
  Autosnap Str
  Flag     Int
}

SpaceNla SpaceLink & {
  View2D   View2D
  Autosnap Str
  Flag     Int
}

SpaceClip SpaceLink & {
  Clip      Option(MovieClip)
  User      MovieClipUser
  Mode      "Tracking" | "MaskEdit"
  View      "Clip" | "Graph" | "Dopesheet"
  Cursor    Vec2f
  Zoom      Float
  PathLength Int
  Flag      Int
}

// --- Transform Subsystem ---
TransformMode
  "Translation" | "Rotation" | "Resize" | "SkinResize" | "ToSphere" | "Shear"
  | "Bend" | "ShrinkFatten" | "Tilt" | "Trackball" | "PushPull" | "Crease"
  | "VertexCrease" | "BoneSize" | "BoneEnvelope" | "BoneRoll" | "CurveShrinkFatten"
  | "TimeTranslate" | "TimeSlide" | "TimeScale" | "TimeExtend" | "BakeTime"
  | "BWeight" | "Align" | "EdgeSlide" | "SeqSlide" | "GpOpacity" | "VertSlide" | " NormalRotation"

TransformOrientation {
  Name   Str
  Matrix Mat3x3
}

TransSnap {
  Mode       Int
  Flag       Int
  SourcePoint Vec3f
  TargetPoint Vec3f
  SnapNormal Vec3f
}

TransCon {
  Text   Str
  Matrix Mat3x3
  Mode   Int
}

TransData {
  Loc        Vec3f
  InitialLoc Vec3f
  Val        Float
  InitialVal Float
  Center     Vec3f
  AxisMatrix Mat3x3
  Factor     Float
  Dist       Float
}

TransDataContainer {
  ObjectEdit Option(Object)
  PoseObject Option(Object)
  Mat        Mat4x4
  InvMat     Mat4x4
  Data       List(TransData)
}

TransInfo {
  Mode           TransformMode
  State          "Running" | "Confirm" | "Cancel"
  DataContainers List(TransDataContainer)
  Con            TransCon
  Snap           TransSnap
  CenterGlobal   Vec3f
  Center2D       Vec2f
  Values         Vec4f
  ValuesFinal    Vec4f
  PropSize       Float
  SpaceType      SpaceType
  Scene          Option(Scene)
  ViewLayer      Option(ViewLayer)
  Area           Option(ScrArea)
  Region         Option(ARegion)
  Depsgraph      Option(Depsgraph)
}

// --- UV Editing & Parametrizer ---
UvNearestHit {
  Object      Object
  FaceIndex   Int
  CornerIndex Int
  DistSq      Float
}

UnwrapOptions {
  Method             "Conformal" | "AngleBased" | "Slim"
  FillHoles          Bool
  CorrectAspect      Bool
  UseSubsurf         Bool
  OnlySelectedFaces  Bool
  OnlySelectedUvs    Bool
  Margin             Float
}


// =============================================================================
// 16. I/O Subsystem (Alembic, FBX, OBJ, PLY, STL, SPZ, OTIO, USD)
// =============================================================================

IOBaseParams {
  Filepath    Str
  ForwardAxis AxisSigned
  UpAxis      AxisSigned
  GlobalScale Float
  Reports     Option(ReportList)
}

AlembicExportParams IOBaseParams & {
  FrameStart       Float
  FrameEnd         Float
  SelectedOnly     Bool
  ExportUvs        Bool
  ExportNormals    Bool
  ExportVColors    Bool
  ApplySubdiv      Bool
  CurvesAsMesh     Bool
  ExportHair       Bool
  ExportParticles  Bool
  EvaluationMode   EvaluationMode
}

AlembicImportParams IOBaseParams & {
  Paths               List(Str)
  IsSequence          Bool
  SetFrameRange       Bool
  ValidateMeshes      Bool
  AlwaysAddCacheReader Bool
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

OBJImportParams IOBaseParams & {
  ClampSize          Float
  UseSplitObjects    Bool
  UseSplitGroups     Bool
  ImportVertexGroups Bool
  ValidateMeshes     Bool
  CloseSplineLoops   Bool
}

PLYExportParams IOBaseParams & {
  AsciiFormat            Bool
  ExportSelectedObjects  Bool
  ApplyModifiers         Bool
  EvaluationMode         EvaluationMode
  ExportUv               Bool
  ExportNormals          Bool
  VertexColors           "None" | "sRGB" | "Linear"
  ExportAttributes       Bool
  ExportTriangulatedMesh Bool
}

PLYImportParams IOBaseParams & {
  UseSceneUnit     Bool
  VertexColors     "None" | "sRGB" | "Linear"
  ImportAttributes Bool
  MergeVerts       Bool
}

STLExportParams IOBaseParams & {
  AsciiFormat           Bool
  ExportSelectedObjects Bool
  UseSceneUnit          Bool
  ApplyModifiers        Bool
  EvaluationMode        EvaluationMode
  UseBatch              Bool
}

STLImportParams IOBaseParams & {
  UseFacetNormal  Bool
  UseSceneUnit    Bool
  UseMeshValidate Bool
}

SPZImportParams {
  Filepath Str
  Reports  Option(ReportList)
}

CSVImportParams {
  Filepath  Str
  Delimiter Str
  Reports   Option(ReportList)
}

OTIOExportParams {
  Filepath           Str
  UseResolveMetadata Bool
  Reports            Option(ReportList)
}

OTIOImportParams {
  Filepath Str
  Reports  Option(ReportList)
}


// =============================================================================
// 17. Window Manager, Screen, WorkSpaces, Events, Operators & Gizmos
// =============================================================================

Report {
  Type    "Debug" | "Info" | "Operator" | "Property" | "Warning" | "Error" | "ErrorInvalidInput" | "ErrorInvalidContext" | "ErrorOutOfMemory"
  Message Str
}

ReportList {
  Reports List(Report)
  Flag    Int
}

ScrVert {
  Coord Vec2i
  Flag  Int
}

ScrEdge {
  V1   ScrVert
  V2   ScrVert
  Flag Int
}

ScrArea {
  V1         ScrVert
  V2         ScrVert
  V3         ScrVert
  V4         ScrVert
  TotRect    RectI
  WinX       Int
  WinY       Int
  SpaceType  SpaceType
  Spaces     List(SpaceLink)
  Regions    List(ARegion)
  Handlers   List(EventHandler)
  Full       Option(Screen)
  Flag       Int
}

Screen ID & {
  Verts       List(ScrVert)
  Edges       List(ScrEdge)
  Areas       List(ScrArea)
  Regions     List(ARegion)
  ActiveArea  Option(ScrArea)
  IsTemp      Bool
  State       "Normal" | "Maximized" | "FullScreen"
}

WorkSpaceLayout {
  Name   Str
  Screen Screen
}

ToolRef {
  Idname    Str
  SpaceType SpaceType
  Mode      Int
  Properties List(IDProperty)
}

WorkSpace ID & {
  Layouts          List(WorkSpaceLayout)
  Tools            List(ToolRef)
  PinScene         Option(Scene)
  SequencerScene   Option(Scene)
  ViewerPath       List(Str)
  StatusText       Option(Str)
}

wmTabletData {
  Active           "None" | "Stylus" | "Eraser"
  Pressure         Float
  Tilt             Vec2f
  IsMotionAbsolute Bool
}

wmEvent {
  Type        Int
  Val         "Nothing" | "Press" | "Release" | "Click" | "DoubleClick" | "ClickDrag"
  XY          Vec2i
  Mval        Vec2i
  PrevXY      Vec2i
  PrevPressXY Vec2i
  Utf8Buf     Str
  Modifier    Int
  Direction   Int
  Keymodifier Int
  Tablet      wmTabletData
  CustomData  Any
  Flag        Int
}

wmKeyMapItem {
  Idname     Str
  PropValues List(IDProperty)
  Type       Int
  Val        Int
  Shift      Int
  Ctrl       Int
  Alt        Int
  Oskey      Int
  Keymodifier Int
  Inactive   Bool
}

wmKeyMap {
  Idname    Str
  SpaceType SpaceType
  RegionId  RegionType
  Items     List(wmKeyMapItem)
  IsModal   Bool
}

wmKeyConfig {
  Idname  Str
  Keymaps List(wmKeyMap)
}

wmOperatorType {
  Name               Str
  Idname             Str
  TranslationContext Str
  Description        Str
  UndoGroup          Str
  Srna               Option(StructRNA)
  LastProperties     List(IDProperty)
  ModalKeymap        Option(wmKeyMap)
  Flag               Int
}

wmOperator {
  Idname     Str
  Type       wmOperatorType
  Ptr        Option(PointerRNA)
  Properties List(IDProperty)
  Reports    Option(ReportList)
  Macro      List(wmOperator)
  CustomData Any
  Flag       Int
}

wmGizmoGroupType {
  Idname    Str
  Name      Str
  SpaceType SpaceType
  RegionId  RegionType
  Flag      Int
}

wmGizmoType {
  Idname     Str
  StructSize Int
}

wmGizmo {
  Type        wmGizmoType
  MatrixBasis Mat4x4
  MatrixSpace Mat4x4
  MatrixOffset Mat4x4
  Color       Color4f
  ColorHi     Color4f
  ScaleFinal  Float
  LineWidth   Float
  Flag        Int
}

wmGizmoGroup {
  Type   wmGizmoGroupType
  Gizmos List(wmGizmo)
}

wmJob {
  Owner      Any
  Name       Str
  JobType    Str
  Priority   Bool
  Progress   Float
  IsRunning  Bool
  Stop       Bool
  DoUpdate   Bool
  CustomData Any
}

EventHandler {
  Type "Gizmo" | "UI" | "Operator" | "Dropbox" | "Keymap"
  Flag Int
}

wmWindow {
  WinId          Int
  Parent         Option(wmWindow)
  Scene          Scene
  NewScene       Option(Scene)
  ViewLayerName  Str
  UnpinnedScene  Option(Scene)
  WorkSpace      WorkSpace
  ActiveLayout   WorkSpaceLayout
  PosX           Int
  PosY           Int
  SizeX          Int
  SizeY          Int
  WindowState    "Normal" | "Maximized" | "FullScreen"
  Cursor         Int
  ModalCursor    Int
  GrabCursorMode Int
  EventState     Option(wmEvent)
  EventQueue     List(wmEvent)
  Handlers       List(EventHandler)
  ModalHandlers  List(EventHandler)
}

wmWindowManager ID & {
  Windrawable   Option(wmWindow)
  Winactive     Option(wmWindow)
  Windows       List(wmWindow)
  Operators     List(wmOperator)
  Notifiers     List(Any)
  Reports       ReportList
  Jobs          List(wmJob)
  Drags         List(Any)
  Keyconfigs    List(wmKeyConfig)
  DefaultConf   Option(wmKeyConfig)
  AddonConf     Option(wmKeyConfig)
  UserConf      Option(wmKeyConfig)
  Timers        List(Any)
  AutosaveTimer Option(Any)
  IsInterfaceLocked Bool
}

bContext {
  Main          Main
  WindowManager wmWindowManager
  Window        Option(wmWindow)
  WorkSpace     Option(WorkSpace)
  Screen        Option(Screen)
  Area          Option(ScrArea)
  Region        Option(ARegion)
  Scene         Option(Scene)
  ViewLayer     Option(ViewLayer)
  Depsgraph     Option(Depsgraph)
}


// =============================================================================
// 18. Ontological Typestate & Railway-Free Pipelines (Spec Section 11)
// =============================================================================

// --- Typestates & Error Outcomes ---
Evaluated       { EvalTimestamp Int, Depsgraph Depsgraph }
GpuCompiled     { ShaderHandle GPUShader, CompiledAt Int }
RenderAllocated { OffScreen GPUOffScreen, Viewport GPUViewport }
UndoPushed      { StepName Str, MemorySize Int }
Baked           { BakeDirectory Str, FrameRange (Int, Int) }

DepsgraphMissing    { Reason Str }
ShaderCompileFailed { Log Str, Stage Str }
OutOfVram           { RequestedBytes Int, AvailableBytes Int }
InvalidTopology     { MeshName Str, NonManifoldCount Int }
IoWriteError        { Filepath Str, Reason Str }

// --- 1. Depsgraph & Geometry Evaluation Pipeline ---
EvaluateObjectGeometry(Obj Object) [
  Data . {
    Some(Mesh(M)) [
      M.VertsNum . {
        [ _ > 0 ] [ Obj & Evaluated { EvalTimestamp 1710000000, Depsgraph _ } ]
        _         [ InvalidTopology { MeshName M.Name, NonManifoldCount 0 } ]
      }
    ]
    _ [ DepsgraphMissing { Reason "Object has no evaluable mesh data" } ]
  }
]

// --- 2. Shader & Material Compilation Pipeline ---
CompileMaterialShader(Mat Material) [
  UseNodes . {
    true [
      Mat & GpuCompiled {
        ShaderHandle GPUShader { Name Mat.Name, IsValid true, IsCompute false, Info None }
        CompiledAt   1710000001
      }
    ]
    false [
      ShaderCompileFailed { Log "Material does not use node tree", Stage "Codegen" }
    ]
  }
]

AllocateRenderTargets(Mat Material & GpuCompiled, Width Int, Height Int) [
  (Width * Height * 16) . {
    [ _ < 1073741824 ] [
      Mat & RenderAllocated {
        OffScreen GPUOffScreen {
          Width  Width
          Height Height
          Format "RGBA16_FLOAT"
          ColorTexture _
          DepthTexture _
          FrameBuffer  _
        }
        Viewport _
      }
    ]
    _ [
      OutOfVram { RequestedBytes (Width * Height * 16), AvailableBytes 1073741824 }
    ]
  }
]

// Compiler infers return type:
// (Material & GpuCompiled & RenderAllocated) | ShaderCompileFailed | OutOfVram
PrepareMaterialForViewport(InitialMaterial Material) [
  InitialMaterial
  . CompileMaterialShader
  . AllocateRenderTargets(1920, 1080)
]


// =============================================================================
// 19. Pure State Transitions & Editor Operations
// =============================================================================

// --- Scene & ViewLayer Transitions ---
AddViewLayer(S Scene, LayerName Str) [
  NewLayer ViewLayer {
    Name             LayerName
    LayerCollections []
    ActiveCollection None
    ActiveObject     None
    Objects          []
    MaterialOverride None
    WorldOverride    None
    Samples          0
    PassFlags        1
    AOVs             []
    Lightgroups      []
    FreestyleConfig  None
  }
  S & { ViewLayers (ViewLayers + [NewLayer]) }
]

SetActiveCamera(S Scene, Cam Object & { ObjectType "Camera" }) [
  S & { Camera Some(Cam) }
]

SetSceneFrame(S Scene, Frame Int) [
  S & {
    RenderData (RenderData & { CurrentFrame Frame })
  }
]

// --- Object & Mode Transitions ---
SwitchObjectMode(O Object, TargetMode ObjectMode) [
  O & { Mode TargetMode }
]

AssignMaterialToSlot(O Object, SlotIndex Int, Mat Material) [
  O & {
    ActiveMaterialIndex SlotIndex
    Materials           (Materials + [Some(Mat)])
  }
]

// --- Node Tree Transitions ---
AddNodeToTree(Tree NodeTree, Idname Str, Name Str, Loc Vec2f) [
  NewNode Node {
    Identifier     (Tree.Nodes.Length + 1)
    Name           Name
    Label          Name
    Idname         Idname
    Parent         None
    Inputs         []
    Outputs        []
    PanelStates    []
    Location       Loc
    Width          140.0
    Height         100.0
    Color          (0.6, 0.6, 0.6)
    UseCustomColor false
    Muted          false
    Selected       true
    Active         true
    Collapsed      false
    ShowPreview    false
    TargetId       None
    Storage        None
    Declaration    None
    Properties     []
  }
  Tree & { Nodes (Nodes + [NewNode]) }
]

LinkNodeSockets(Tree NodeTree, FromN Node, FromS NodeSocket, ToN Node, ToS NodeSocket) [
  NewLink NodeLink {
    FromNode         FromN
    FromSocket       FromS
    ToNode           ToN
    ToSocket         ToS
    MultiInputSortId 0
    IsMuted          false
    IsValid          true
  }
  Tree & { Links (Links + [NewLink]) }
]

// --- Mesh & Geometry Transitions ---
TagMeshPositionsChanged(M Mesh) [
  M & {
    VertsNum (VertPositions.Length)
  }
]

// --- VSE Strip Transitions ---
SplitStripAtFrame(St Strip, SplitFrame Int) [
  (SplitFrame > StartFrame && SplitFrame < (StartFrame + Length)) . {
    true [
      LeftStrip  St & { Length (SplitFrame - StartFrame) }
      RightStrip St & { StartFrame SplitFrame, Length (Length - (SplitFrame - StartFrame)) }
      (LeftStrip, RightStrip)
    ]
    false [ (St, St) ]
  }
]

MuteStrip(St Strip)   [ St & { Muted true } ]
UnmuteStrip(St Strip) [ St & { Muted false } ]

// --- Screen & Workspace Transitions ---
ChangeActiveWorkSpace(Win wmWindow, NewWs WorkSpace) [
  Win & { WorkSpace NewWs }
]

MaximizeArea(Scr Screen, Area ScrArea) [
  Scr & {
    ActiveArea Some(Area)
    State      "Maximized"
  }
]

RestoreScreenState(Scr Screen & { State "Maximized" }) [
  Scr & {
    ActiveArea None
    State      "Normal"
  }
]
