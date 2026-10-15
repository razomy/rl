_ root.base
_ root.primitives
_ root.collections
_ root.math

// =============================================================================
// 1. CORE PRIMITIVES, ALGEBRAIC TYPES & META-TRAITS
// =============================================================================

Str       ""
Int       0
Float     0.0
Bool      false
Byte      0x00
Any       _
Void      {}
Null      {}
Undefined {}

I8   Int
I16  Int
I32  Int
I64  Int
I128 Int
U8   Byte
U16  Int
U32  Int
U64  Int
U128 Int
F32  Float
F64  Float

Char            Str
Char64          Str
Char128         Str
Char256         Str
InlineString    Str
FixedString     Str
MultilineString Str
Uuid            Str

None      {}
Some(T)   { Value T }
Option(T) Some(T) | None

Cons(T) { Head T, Tail List(T) }
List(T) None | Cons(T)

Map(K, V)      { (K) V }
Set(T)         { (T) Bool }
Tuple(T)       ()
DynamicArray(T) List(T)
StaticArray(T)  List(T)

// --- Meta-Traits & Identification ---

PrimaryId(T) { Id Str }
ForeignId(T) { Id Str }
IdRef(T)     { Id Str }

IResource        {}
IAttribute       {}
IEntity          { Id Str }
HasId(T)         { Id T }
HasPrimary(T)    { PrimaryId PrimaryId(T) }
HasForeign(T)    { EntityId ForeignId(T) }
HasName          { Name Str }
HasFullName      { FullName Str }
HasTitle         { Title Str }
HasDescription   { Description Str }
HasSlug          { Slug Str }
HasValue(T)      { Value T }
HasCount         { Count Int }
HasRange         { From Int, To Int }
HasMetadata      { Metadata Json }

// --- State Traits (Read-Only Flags) ---

HasActive     { IsActive Bool, IsInactive Bool }
HasEnable     { IsEnable Bool, IsDisable Bool }
HasVisible    { IsVisible Bool, IsInvisible Bool }
HasOpened     { IsOpened Bool }
HasDirty      { IsDirty Bool }
HasViewed     { IsViewed Bool }
HasReceived   { IsReceived Bool }
HasAchieved   { IsAchieved Bool }
HasCompleted  { IsCompleted Bool }
HasTouched    { IsTouched Bool }
HasSelect     { IsSelect Bool, IsDeselect Bool }
HasFocus      { IsFocus Bool, IsFocusout Bool }
HasHighlight  { IsHighlight Bool, IsNotHighlight Bool }
HasValid      { IsValid Bool }
HasLoading    { IsLoading Bool, Progress Float }

CardTraits HasTitle & HasDescription & HasOpened & HasDirty & {
  Image ImageModel
}

ExtendsEntity(TBase, TSelf) IEntity & HasPrimary(TSelf) & HasForeign(TBase)
ExtendsCountEntity(TBase, TSelf) ExtendsEntity(TBase, TSelf) & HasCount
ExtendsRangeEntity(TBase, TSelf) ExtendsEntity(TBase, TSelf) & HasRange

// --- Temporal Traits ---

DateTime             Int
DateTimeSerializable { Value I64 }

HasCreatedAt { CreatedAt DateTime }
HasUpdatedAt { UpdatedAt DateTime }
HasDeletedAt { DeletedAt Option(DateTime) }
HasReadAt    { ReadAt Option(DateTime) }

CudDateTime  HasCreatedAt & HasUpdatedAt & HasDeletedAt
CrudDateTime CudDateTime & HasReadAt

TimeAttribute IAttribute & {
  DayTime           Float
  DayTimeLength     Float
  TotalTime         Float
  DayTimeNormalized Float
}

DayPeriodType "DayTime" | "NightTime"


// =============================================================================
// 2. DATA STRUCTURES, GRAPHS, TREES & VRD (VIRTUAL RECURSIVE DICTIONARIES)
// =============================================================================

Offset         { Value Int }
Index          { Value Int }
OutIndex       { Value Int }
IndexOrOut     Index | OutIndex
OrderDirection "ASC" | "DESC"

HasOffset     { Offset Offset }
HasPrevOffset { PrevOffset Offset }
HasDeep       { Deep Int }
HasStack      { Stack List(Int) }

KeyValue(K, V)      { Key K, Value V }
KeyValueArray(K, V) { Key K, Values List(KvaOrValue(K, V)) }
KvaOrValue(K, V)    KeyValue(K, V) | KeyValueArray(K, V) | V

Dict(T)          Map(Str, T)
RecursiveDict(T) Map(Str, T | RecursiveDict(T))

Vrd(T)        Map(Str, VrdOrValue(T))
VrdOrValue(T) T | Vrd(T)

ListItem(T)      (Str, RecursiveList(T))
RecursiveList(T) List(ListItem(T)) | Str

// --- Classical Data Structures ---

LinkedListNode(T) {
  Value T
  Next  Option(LinkedListNode(T))
}

DoublyLinkedListNode(T) {
  Value T
  Prev  Option(DoublyLinkedListNode(T))
  Next  Option(DoublyLinkedListNode(T))
}

LinkedList(T) {
  Head Option(LinkedListNode(T))
  Size Int
}

DoublyLinkedList(T) {
  Head Option(DoublyLinkedListNode(T))
  Tail Option(DoublyLinkedListNode(T))
  Size Int
}

Stack(T)         { Items List(T) }
Queue(T)         { Items List(T) }
Deque(T)         { Items List(T) }
PriorityQueue(T) { Items List((T, Float)) }

RingBuffer(T) {
  Capacity Int
  Head     Int
  Tail     Int
  Buffer   List(T)
}

HashTable(K, V) {
  Buckets List(LinkedList((K, V)))
}

SkipListNode(T) {
  Value   T
  Forward List(SkipListNode(T))
}

SkipList(T) {
  Head     Option(SkipListNode(T))
  MaxLevel Int
}

DisjointSet(T) {
  Parent Map(T, T)
  Rank   Map(T, Int)
}

LRUCache(K, V) {
  Capacity Int
  Map      Map(K, DoublyLinkedListNode((K, V)))
  List     DoublyLinkedList((K, V))
}

// --- Probabilistic Structures ---

ProbabilisticDataStructure { Accuracy Float }

BloomFilter(T) ProbabilisticDataStructure & {
  UnderlyingStructure List(Byte)
  HashFunctions       List(Fn(T) [ Int ])
}

HyperLogLog(T) ProbabilisticDataStructure & {
  UnderlyingStructure List(Byte)
}

// --- Trees & Graphs ---

HasOrder(T)    { Prev Option(T), Next Option(T) }
HasParent(T)   { Parent Option(T) }
HasChildren(T) { Children List(T) }
HasChildrenDict(T) { Children Dict(T) }

Leaf(T) { Value T }

TreeNode(T) HasValue(T) & HasParent(TreeNode(T)) & HasChildren(TreeNode(T)) & HasOrder(TreeNode(T))
Tree(T)     { Root Option(TreeNode(T)) }

BinaryTreeNode(T) {
  Value T
  Left  Option(BinaryTreeNode(T))
  Right Option(BinaryTreeNode(T))
}

BinaryTree(T) { Root Option(BinaryTreeNode(T)) }

BalancedTreeType "AVL" | "RedBlack"
BalancedTree(T)  BinaryTree(T) & { TreeType BalancedTreeType }

BTree(T)       Tree(T) & { Degree Int }
Trie(T)        Tree(T) & { IsEndOfWord Bool }
HeapType       "MinHeap" | "MaxHeap"
Heap(T)        { HeapType HeapType, Array List(T) }
SegmentTree(T) { Array List(T) }

QuadTreeNode(T) { Children Tuple(Option(QuadTreeNode(T))) }
QuadTree(T)     { Root Option(QuadTreeNode(T)), Bounds BoundRectangle(Float) }

OctreeNode(T)   { Children Tuple(Option(OctreeNode(T))) }
Octree(T)       { Root Option(OctreeNode(T)), Bounds Cuboid }

KeyEdge(TFrom, TTo) { From TFrom, To TTo }

Graph { IsDirected Bool, IsWeighted Bool }
EdgeListGraph(N, E)    Graph & { Nodes List(N), Edges List((E, E)) }
GraphAdjacencyMatrix(T) Graph & { Vertices List(T), Matrix List(List(Float)) }
GraphAdjacencyList(T)   Graph & { AdjacencyMap Map(T, List(T)) }

BranchDict(T)       { Value Str, Children Dict(BranchDictOrLeaf(T)) }
BranchDictOrLeaf(T) BranchDict(T) | Leaf(T)
RootDict(T)         Dict(BranchDictOrLeaf(T))

MatrixRow(T)   { Row List(T) }
MatrixModel(T) { Rows List(MatrixRow(T)) }


// =============================================================================
// 3. GEOMETRY, VECTORS, COORDINATES & SPATIAL TRANSFORMS
// =============================================================================

MetricType "px" | "rem" | "em" | "vh" | "vw" | "percent" | "m" | "cm" | "mm"
MetricUnit { Value Float, Type MetricType }

HasX(U)      { X U }
HasY(U)      { Y U }
HasZ(U)      { Z U }
HasLength(U) { Length U }

Vector1(T) { X T }
Vector2(T) { X T, Y T }
Vector3(T) { X T, Y T, Z T }
Vector4(T) { X T, Y T, Z T, W T }

VectorFloat1 Vector1(Float)
VectorFloat2 Vector2(Float)
VectorFloat3 Vector3(Float)
VectorFloat4 Vector4(Float)
VectorInt1   Vector1(Int)
VectorInt2   Vector2(Int)
VectorInt3   Vector3(Int)

VectorFloat { Dimensions Int, Values List(Float) }
VectorInt   { Dimensions Int, Values List(Int) }

Vector2Metric Vector2(MetricUnit)
Quaternion    Vector3(Float) & { W Float }

BoundX(U)         { StartX U, FinishX U }
BoundY(U)         { StartY U, FinishY U }
BoundRectangle(U) BoundX(U) & BoundY(U)
BoundRectangleMetric BoundRectangle(MetricUnit)
NodeBound         BoundY(Float) & HasX(Float)

ISize1 { XLength Float }
ISize2 ISize1 & { YWidth Float }
ISize3 ISize2 & { ZHeight Float }

SizeAttribute     IAttribute & ISize3
PositionAttribute IAttribute & VectorFloat3
PivotAttribute    IAttribute & VectorFloat3
RotationAttribute IAttribute & { XDeg Float, YDeg Float, ZDeg Float }
ScaleAttribute    IAttribute & { XScale Float, YScale Float, ZScale Float }

AnchorAttribute IAttribute & {
  XStart  Float
  YStart  Float
  ZStart  Float
  XFinish Float
  YFinish Float
  ZFinish Float
}

Transform3d {
  Position VectorFloat3
  Rotation Quaternion
  Scale    VectorFloat3
}

FlexibleTransform Transform3d & {
  Anchors AnchorAttribute
  Size    SizeAttribute
  Pivot   PivotAttribute
}

EdgeModel { Start VectorFloat3, Finish VectorFloat3 }

// --- Shapes & Coordinate Systems ---

IShape        {}
IPolygonShape IShape
IDiameter     { Diameter Float }
ICircle       IShape & { Radius Float }
ISquare       IShape & IDiameter
IRectangle    IShape & VectorFloat2 & ISize2
ICuboid       IRectangle & ISize3
ICube         ICuboid

LineShape      IShape & { X1 Float, Y1 Float, X2 Float, Y2 Float }
EllipseShape   IShape & { Cx Float, Cy Float, Rx Float, Ry Float }
CircleShape    IShape & { Cx Float, Cy Float, R Float }
RectangleShape IShape & { X Float, Y Float, Width Float, Height Float, Radii List(Float) }
ConvexPolygon  IPolygonShape & { Radius Float, Sides Int }
Hexagon        ConvexPolygon & { Sides 6 }
HexagonalPrism Hexagon & { Height Float }

Cuboid ICuboid & PositionAttribute & RotationAttribute & ScaleAttribute & AnchorAttribute & {
  Size     VectorFloat3
  HalfSize VectorFloat3
  Center   VectorFloat3
}

SphericalAxis       "RadialDistance" | "PolarAngle" | "AzimuthalAngle"
SphericalCoordinate { Dimensions Int, Axis SphericalAxis }
EuclideanCoordinate { Dimensions Int }
HexagonCoordinate   { Size ISize3, Hex Hexagon }
CuboidCoordinate    { Aspect VectorFloat3, Cuboid ISize3, GlobalPos VectorFloat3 }

HexagonToEuclidean {
  Coordinate HexagonCoordinate
  StepPoint  VectorFloat
}


// =============================================================================
// 4. CONTEXT, PIPELINES, COMMANDS, EVENTS & REACTIVE STORES
// =============================================================================

ContextEventType "Add" | "Remove" | "Set"
ContextEvent     { EventType ContextEventType, Key Str, Value Any }

IReadOnlyContext IResource & {
  Store Map(Str, Any)
}

IContext IReadOnlyContext & {
  Parent   Option(IContext)
  Children List(IContext)
  Events   Channel(ContextEvent)
}

IContextable { Ctx IContext }

ContextEqualityReport {
  IsOperatorEqual     Bool
  IsObjectEquals      Bool
  IsReferenceEquals   Bool
  IsThisEquals        Bool
  IsSequenceEqual     Bool
  IsGetHashCode       Bool
  IsNodeComparerEqual Bool
  IsEqual             Bool
  PrintReport         Str
}

ContextRegistry {
  Registry Map(Str, IContext)
  Events   Channel(ContextEvent)
}

// --- Pipes & Pipelines ---

IPipe(T)           { Execute Fn(T) [ T ] }
IPipeAsync(T)      { Process Fn(T) [ T ] }
IContextPipe       IResource & { Modify Fn(IContext) [ IContext ], Cancel Fn(IContext) [ IContext ] }

Pipeline(T)      { Pipes List(IPipe(T)) }
PipelineAsync(T) { Pipes List(IPipeAsync(T)) }

ParallelPipe(T) {
  Pipes List(IPipeAsync(T))
  Merge Fn(List(T)) [ T ]
}

ContextPipeline IContextable & IContextPipe & {
  Pipes Map(Str, IContextPipe)
}

ChildFactoryContext {
  Id      Str
  Context IContext
  Factory Fn(IContext) [ IContext ]
}

ProduceContextJob(T) IContextable & {
  ChildContext T
  OrderIndex   Int
  Factory      Fn(IContext) [ IContext ]
}

ProduceContextsFromListJob(TContext, TEntity) IContextable & {
  ChildContexts List(TContext)
  Entities      List(TEntity)
  ListSelector  Fn(IContext) [ List(TEntity) ]
  Factory       Fn(IContext) [ IContext ]
}

// --- Commands, Queries & Jobs (CQRS) ---

IAExecutable IResource
IACommand    IAExecutable
IAQuery      IAExecutable

ICommand                 IACommand & { Execute Fn() [ Void ] }
ICommandIn(TReq)         IACommand & { Execute Fn(TReq) [ Void ] }
ICommandOut(TReq, TRes)  IACommand & { Execute Fn(TReq) [ TRes ] }
IQuery(TRes)             IAQuery   & { Execute Fn() [ TRes ] }

ActionContextCommand ICommand & IContextable & {
  Action Fn(IContext) [ Void ]
}

ActionDisposeCommand ICommand & IContextable & {
  Action  Fn(IContext) [ Void ]
  Dispose Fn(IContext) [ Void ]
}

IJob IResource & { Execute Fn() [ Void ], Dispose Fn() [ Void ] }
AJob IJob & IContextable

// --- Events & Observables ---

IEvent          {}
ExceptionEvent  IEvent & { Error Str, Message Str }

EventHandlerProvider {
  Handlers Map(Str, List(Fn(IEvent) [ Void ]))
}

SingleEventController {
  Provider EventHandlerProvider
}

OnEventExecuteJob(TEvent) AJob & {
  Action Fn(IReadOnlyContext, TEvent) [ Void ]
}

Change(T) { Before T, After T }

DifferenceType       "CREATED" | "UPDATED" | "DELETED" | "NESTED_UPDATE"
Difference(T)        { Type DifferenceType, Value T }
ReplaceDifference(T) { Type DifferenceType, PrevValue T, Value T }
ChangeDifference(T)  Difference(T) | ReplaceDifference(T)

EnumerableBroker(T) {
  CreateEvent  Channel(T)
  DestroyEvent Channel(T)
  UpdateEvent  Channel(Change(T))
}

ReactiveCollection(T) {
  Items    List(T)
  OnCreate List(Fn(T) [ Void ])
  OnRead   List(Fn(T) [ Void ])
  OnUpdate List(Fn(T) [ Void ])
  OnDelete List(Fn(T) [ Void ])
}

// --- Stores, Repositories & Collection Controllers ---

IReset          { Reset Fn() [ Void ] }
IReadStore(T)   { Read Fn() [ T ] }
IWriteStore(T)  { Write Fn(T) [ Void ] }
IStore(T)       IReset & IReadStore(T) & IWriteStore(T)
Gate(T)         { Get Fn() [ T ], Set Fn(T) [ Void ] }

MemoryStore(T) IStore(T) & {
  Value        T
  DefaultValue T
}

CollectionStore(T) IReset & {
  Store List(T)
}

IdCollectionStore(K, V) IReset & {
  Store Map(K, V)
}

ListCommander(T) {
  Broker     EnumerableBroker(T)
  Repository CollectionStore(T)
}

CollectionController(T) IContextable & {
  Broker    EnumerableBroker(T)
  Commander ListCommander(T)
  Query     IdCollectionStore(Str, T)
  Count     Int
}

UserCollectionController(T) CollectionController(T) & {
  User UserEntity
}

// --- Lifecycle & State Machines ---

IStart       { Start Fn() [ Void ] }
IFinish      { Finish Fn() [ Void ] }
IStartFinish IStart & IFinish & { IsStarted Bool }

DisposableStack {
  Disposables List(Fn() [ Void ])
}

ITransitable IContextable & {
  Next  Option(ITransitable)
  Enter Fn() [ Void ]
  Leave Fn() [ Void ]
}

FuncTransitable  ITransitable & { Condition Fn(IContext) [ Bool ] }
OneOfTransitable ITransitable & { Branches List(ITransitable) }

ContextTransitionMachine {
  FirstState   ITransitable
  CurrentState ITransitable
}

State                { Id Str }
StateTransition      { CanTransition Fn() [ Bool ], OnEnter Fn() [ Void ], OnExit Fn() [ Void ] }
StateTransitionTable { InitialState State, Transitions List((State, StateTransition, State)) }
StateMachine         { Table StateTransitionTable, CurrentState State }

RollbackCancelValidateTask(C) {
  Validate Fn(C) [ Bool ]
  Execute  Fn(C) [ C ]
  Cancel   Fn(C) [ C ]
  Rollback Fn(C) [ C ]
}

FileTaskManager(C) {
  CurrentContext Option(C)
  FileGate       Gate(C)
}


// =============================================================================
// 5. CODECS, SERIALIZATION, JSON, KV, YAML & COMPRESSION
// =============================================================================

Codec(D, E) {
  Encode Fn(D) [ E ]
  Decode Fn(E) [ D ]
}

SerializablePrimitive Str | Int | Float | Bool | Null
Serializable          SerializablePrimitive | List(Serializable) | Map(Str, Serializable)
Json                  Serializable

JsonTokenType "value" | "break" | "assign"
JsonToken     { TokenType JsonTokenType, Value Str, Deep Int }

DiffCreated { Type "CREATED", NewValue Json }
DiffDeleted { Type "DELETED", PrevValue Json }
DiffUpdated { Type "UPDATED", PrevValue Json, NewValue Json }
DiffNested  { Type "NESTED_UPDATE", Children Map(Str, DiffEntry) }
DiffEntry   DiffCreated | DiffDeleted | DiffUpdated | DiffNested

StoreStringCodecBridge(T) IStore(T) & {
  InnerCodec   Codec(T, Str)
  DefaultValue T
  RawStore     IStore(Str)
}

// --- Commit Deltas (String & VRD) ---

RemoveDeltaString { Offset Int, RemoveLength Int }
AddDeltaString    { Offset Int, AddValue Str }
DeltaString       RemoveDeltaString | AddDeltaString

ActorDatetimeDeltaString {
  Datetime Str
  Actor    Str
  Deltas   List(DeltaString)
}

RemoveDeltaVrd { Path List(Str), AfterPath List(Str), Remove Bool }
AddDeltaVrd    { Path List(Str), AfterPath List(Str), Add VrdOrValue(Str) }
DeltaVrd       RemoveDeltaVrd | AddDeltaVrd

ActorDatetimeDeltaVrd {
  Datetime Str
  Actor    Str
  Deltas   List(DeltaVrd)
}


// =============================================================================
// 6. HIGH-PERFORMANCE COLUMNAR, GRAPH & RAG DATABASES
// =============================================================================

NodeId  Int
EdgeId  Str
FieldId Int
OpCode  "SET_FIELD" | "ADD_NODE" | "CONNECT_EDGE" | "CLEAR_ELEMENT"
DbLayer "SYNTAX" | "SEMANTIC" | "TOPOLOGY" | "EXECUTION"

TypedArray Uint8Array | Uint32Array | Float32Array

ColumnConfig {
  InitialCapacity Int
  DefaultValue    Float
  Stride          Int
}

Column {
  Id     FieldId
  Name   EdgeId
  Config ColumnConfig
  Data   List(Float)
}

ChunkConfig {
  Bits         Int
  Size         Int
  Mask         Int
  DefaultValue Float
  Stride       Int
}

ChunkedColumn {
  Id          FieldId
  Name        EdgeId
  ChunkConfig ChunkConfig
  Chunks      Map(Int, List(Float))
}

ChunkConfig2D ChunkConfig & { Area Int }

ChunkedGrid2D {
  Id          FieldId
  Name        EdgeId
  ChunkConfig ChunkConfig2D
  Chunks      Map(Int, List(Float))
}

DbStore {
  Capacity Int
  NextId   NodeId
  FreeList List(NodeId)
  Columns  List(Column)
}

WalEntry {
  Op       OpCode
  EntityId NodeId
  FieldId  FieldId
  A1       Float
  A2       Float
  A3       Float
}

Wal {
  EntrySize Int
  Entries   List(WalEntry)
  Head      Int
}

WalTelemetry { MaxElements Int }

EventsContext {
  DirtyQueue List((NodeId, FieldId))
  DirtyCount Int
}

CoreDB {
  NodeStore     DbStore
  EdgeStore     DbStore
  FieldRegistry List(Column)
  Wal           Wal
  Events        EventsContext
  NextFieldId   FieldId
}

GraphTopology {
  Core          CoreDB
  NodesAsn      List(Option(HirNode))
  NodeFirstOut  Column
  NodeFirstIn   Column
  EdgeFrom      Column
  EdgeTo        Column
  EdgeLayer     Column
  EdgeNextOut   Column
  EdgeNextIn    Column
}

// --- Local Table & Io Database ---

DatabaseTable IEntity & HasPrimary(DatabaseTable) & {
  SerializedJson Str
}

ListTableModel(T) { Items List(T) }

PipelinedIdMemoryTableDatabase(T) {
  Store    List(T)
  Pipeline IPipe(T)
}

IoDatabaseController {
  Stores     Map(Str, IStore(Str))
  BeforeSave Channel(Bool)
  Loading    Bool
}

// --- Event Sourcing & RAG DB ---

EventActionType "Create" | "Read" | "Update" | "Delete"
ConfigEvent     { Type EventActionType, Path List(Str), Value Any }
EventSourcing   { Events List(ConfigEvent) }

ChunkSection { Id Str, Text Str }
ChunkFile    { FilePath Str, Content Str, CommitId Str, Chunks List(ChunkSection) }

RagDbConfig {
  Neo4jUri       Str
  Neo4jUser      Str
  Neo4jPassword  Str
  EmbeddingModel Str
  VectorDim      Int
}


// =============================================================================
// 7. UI ENGINE, GRAPHICS, ANIMATIONS, THEMES, ROUTING & POPUPS
// =============================================================================

RgbaColorFloat { R Float, G Float, B Float, A Float }
ColorRGBA      RgbaColorFloat

ColorType     "None" | "Primary" | "Secondary" | "Tertiary"
ActionTypeUi  "None" | "Neutral" | "Positive" | "Negative"
InfluenceType "None" | "Neutral" | "Dominant" | "Avoid"
EmphasisType  "None" | "Low" | "Medium" | "High"
EmotionType   "Fear" | "Anger" | "Joy" | "Sad"

PropertyStateType "Default" | "Focus" | "Active" | "Disabled" | "Highlight" | "Invisible"

ThemeColorPalette {
  ColorFarFar       RgbaColorFloat
  ColorFar          RgbaColorFloat
  Color             RgbaColorFloat
  ColorNear         RgbaColorFloat
  ColorNearNear     RgbaColorFloat
  ColorDisabledFar  RgbaColorFloat
  ColorDisabled     RgbaColorFloat
  ColorDisabledNear RgbaColorFloat
  OnColor           RgbaColorFloat
}

ThemeStateColorAttribute IAttribute & {
  DefaultColor   RgbaColorFloat
  FocusColor     RgbaColorFloat
  ActiveColor    RgbaColorFloat
  DisabledColor  RgbaColorFloat
  HighlightColor RgbaColorFloat
  InvisibleColor RgbaColorFloat
}

ShapeTheme  { EdgeColor RgbaColorFloat, FillColor RgbaColorFloat }
ThemeEntity IEntity & HasPrimary(ThemeEntity) & { BackgroundColor RgbaColorFloat }

ColorAttribute     IAttribute & { Color RgbaColorFloat }
OutlineAttribute   IAttribute & { OutlineWidth Float, OutlineColor RgbaColorFloat }
RoundedAttribute   IAttribute & { RoundedRadius Float }
ShadowAttribute    IAttribute & { ShadowWidth Float, ShadowColor RgbaColorFloat }
IntensityAttribute IAttribute & { Emission Float }

// --- Typography & Layout Attributes ---

FontStyle "None" | "Bold" | "Italic" | "Underline" | "LowerCase" | "UpperCase" | "SmallCaps" | "Strikethrough" | "Superscript" | "Subscript" | "Highlight"

FontSizeAttribute  IAttribute & { FontSize Float }
FontStyleAttribute IAttribute & { Style FontStyle }
TextAttribute      IAttribute & { Text Str }

LayoutAlign "Start" | "Center" | "End" | "Stretch" | "SpaceBetween" | "SpaceAround"
RectGravity "Center" | "Bottom" | "Right" | "Top" | "Left"

LayoutAlignAttribute   IAttribute & { Align LayoutAlign }
PaddingAttribute       IAttribute & { XStart Float, XFinish Float, YStart Float, YFinish Float }
SpacingAttribute       IAttribute & { Spacing Float }
StretchAttribute       IAttribute & { IsWidthStretch Bool }
StretchWeightAttribute IAttribute & { Weight Float }

// --- Universal UI Node (UIN) & CSS/Canvas Styling ---

GridTrackSize {
  Kind  Str
  Min   MetricUnit
  Max   MetricUnit
  Limit MetricUnit
  Count Int
}

GridContainerLayout {
  Kind           "Grid"
  Columns        List(GridTrackSize)
  Rows           List(GridTrackSize)
  AutoColumns    List(GridTrackSize)
  AutoRows       List(GridTrackSize)
  AutoFlow       Str
  TemplateAreas  List(Str)
  ColumnGap      MetricUnit
  RowGap         MetricUnit
  JustifyContent Str
  AlignContent   Str
  JustifyItems   Str
  AlignItems     Str
}

GridItemPlacement {
  ColumnStart Int
  ColumnEnd   Int
  RowStart    Int
  RowEnd      Int
  Area        Str
  JustifySelf Str
  AlignSelf   Str
}

FlexLayout {
  Kind           "Flex"
  Direction      Str
  Wrap           Str
  JustifyContent Str
  AlignItems     Str
  AlignContent   Str
  Gap            MetricUnit
}

FlexItemPlacement {
  Grow      Float
  Shrink    Float
  Basis     MetricUnit
  Order     Int
  AlignSelf Str
}

FlowLayout {
  Kind        "Flow"
  Display     Str
  FloatMode   Str
  ClearMode   Str
  BreakBefore Str
  BreakAfter  Str
  BreakInside Str
}

AnchoredLayout {
  Kind             "Anchored"
  AnchorMin        VectorFloat2
  AnchorMax        VectorFloat2
  Pivot            VectorFloat2
  AnchoredPosition VectorFloat2
  SizeDelta        VectorFloat2
}

FixedLayout {
  Kind   "Fixed"
  X      MetricUnit
  Y      MetricUnit
  Width  MetricUnit
  Height MetricUnit
}

UILayoutEngine GridContainerLayout | FlexLayout | FlowLayout | AnchoredLayout | FixedLayout

UISizing {
  Width       MetricUnit
  Height      MetricUnit
  MinWidth    MetricUnit
  MaxWidth    MetricUnit
  MinHeight   MetricUnit
  MaxHeight   MetricUnit
  AspectRatio Float
  BoxSizing   Str
}

UIPositioning { Mode Str, Insets PaddingAttribute, ZIndex Int }
UIOverflow    { X Str, Y Str }

SolidPaint    { Kind "Solid", Color ColorRGBA, Opacity Float }
GradientStop  { Offset Float, Color ColorRGBA }
GradientPaint { Kind "Gradient", Angle Float, Stops List(GradientStop) }
ImagePaint    { Kind "Image", Uri Str, Fit Str, Position Vector2Metric, Repeat Str }
UIPaint       SolidPaint | GradientPaint | ImagePaint

BorderSide { Width MetricUnit, Style Str, Color ColorRGBA }
UIBorders  { Top BorderSide, Right BorderSide, Bottom BorderSide, Left BorderSide, Radii List(MetricUnit) }

UIShadow {
  Kind         Str
  Offset       Vector2Metric
  BlurRadius   MetricUnit
  SpreadRadius MetricUnit
  Color        ColorRGBA
}

UIFilters {
  Blur         MetricUnit
  BackdropBlur MetricUnit
  Opacity      Float
  Grayscale    Float
  Contrast     Float
  Brightness   Float
  Saturate     Float
  BlendMode    Str
}

UITransforms {
  Origin       VectorFloat3
  Translate    VectorFloat3
  Scale        VectorFloat3
  Rotate       VectorFloat3
  Skew         VectorFloat2
  RawMatrix4x4 List(Float)
}

Typography {
  FontFamily     List(Str)
  FontSize       MetricUnit
  FontWeight     Int
  FontStyle      Str
  LineHeight     MetricUnit
  LetterSpacing  MetricUnit
  WordSpacing    MetricUnit
  TextAlign      Str
  VerticalAlign  Str
  TextTransform  Str
  TextDecoration Str
  WhiteSpace     Str
  WordBreak      Str
  TextOverflow   Str
  MaxLines       Int
  TextShadow     List(UIShadow)
  Color          UIPaint
}

UITransition {
  Property       Str
  DurationMs     Int
  DelayMs        Int
  TimingFunction Str
}

UIStyleBag {
  Sizing      UISizing
  Positioning UIPositioning
  Margin      PaddingAttribute
  Padding     PaddingAttribute
  Overflow    UIOverflow
  Backgrounds List(UIPaint)
  Borders     UIBorders
  Shadows     List(UIShadow)
  Filters     UIFilters
  Transforms  UITransforms
  Transitions List(UITransition)
  Cursor      Str
  Opacity     Float
  Visible     Bool
}

UIEventBinding    { Event Str, ActionId Str, Payload Any }
UIInteractionSpec { Focusable Bool, TabIndex Int, Events List(UIEventBinding) }

IUIBaseUin {
  Id              Str
  Name            Option(Str)
  Parent          Option(IdRef(UIUin))
  Children        List(IdRef(UIUin))
  ContainerLayout Option(UILayoutEngine)
  GridPlacement   Option(GridItemPlacement)
  FlexPlacement   Option(FlexItemPlacement)
  Style           Option(UIStyleBag)
  Interaction     Option(UIInteractionSpec)
}

SurfaceUin        IUIBaseUin & { Kind "SurfaceUin", Width MetricUnit, Height MetricUnit, Dpi Int }
ContainerUin      IUIBaseUin & { Kind "ContainerUin" }
TextLeafUin       IUIBaseUin & { Kind "TextLeafUin", Content Str, Typo Typography }
VectorShapeUin    IUIBaseUin & { Kind "VectorShapeUin", PathCommands Str, FillPaint Option(UIPaint), StrokePaint Option(UIPaint), StrokeWidth Option(MetricUnit) }
MediaAssetUin     IUIBaseUin & { Kind "MediaAssetUin", SourceUri Str, ImageFit "cover" | "contain" | "fill" | "none" }
TableContainerUin IUIBaseUin & { Kind "TableContainerUin", ColumnWidths List(MetricUnit) }
TableRowUin       IUIBaseUin & { Kind "TableRowUin", IsHeader Bool }
TableCellUin      IUIBaseUin & { Kind "TableCellUin", ColSpan Int, RowSpan Int }
UIControlType     "button" | "text-input" | "checkbox" | "radio" | "select" | "slider"
ControlUin        IUIBaseUin & { Kind "ControlUin", ControlType UIControlType, Value Any, Placeholder Option(Str), Disabled Bool, ReadOnly Bool }
ProjectionUin     IUIBaseUin & { Kind "ProjectionUin", SlotName Option(Str), ComponentDefinitionId Option(Str) }

UIUin SurfaceUin | ContainerUin | TextLeafUin | VectorShapeUin | MediaAssetUin | TableContainerUin | TableRowUin | TableCellUin | ControlUin | ProjectionUin

UIDocumentUin {
  Id      Str
  Title   Str
  RootId  Str
  Nodes   Map(Str, UIUin)
}

// --- Animations, Curves & Tracks ---

ICurve            { Evaluate Fn(Float) [ Float ] }
LinearCurve       ICurve
DecelerateCurve   ICurve
InvertedCurve     ICurve
BounceInCurve     ICurve
BounceOutCurve    ICurve
BounceInOutCurve  ICurve
ElasticInCurve    ICurve & { Period Float }
ElasticOutCurve   ICurve & { Period Float }
ElasticInOutCurve ICurve & { Period Float }

CubicCurve ICurve & {
  X1         Float
  Y1         Float
  X2         Float
  Y2         Float
  ErrorBound Float
}

ChainCurves { Items List((Float, ICurve)) }

IAnimationHandler { Handle Fn(Float) [ Void ] }

CurvedAnimationHandler {
  Handler IAnimationHandler
  Curve   ICurve
}

ChainAnimationHandler {
  Handlers List((Float, IAnimationHandler))
}

ColorHandler  IAnimationHandler & { From RgbaColorFloat, Delta RgbaColorFloat }
VectorHandler IAnimationHandler & { From VectorFloat3, Delta VectorFloat3 }

FadeAnimationAttribute IAttribute & {
  FadeInLength    Float
  FadeInLengthMs  Int
  FadeOutLength   Float
  FadeOutLengthMs Int
}

IAnimationTrack {
  From   Float
  Length Float
  To     Float
}

DefaultAnimationTrack IAnimationTrack & {
  Handler IAnimationHandler
}

RepeatAnimationTrack DefaultAnimationTrack & {
  TrackLength Float
  RepeatCount Float
}

AnimationTimeLine {
  CurrentTime Float
  TotalTime   Float
  IsPlaying   Bool
  Tracks      List(IAnimationTrack)
}

AnimationController {
  TimeLines List(AnimationTimeLine)
}

// --- Pointer & Input Events ---

PointerIdAttribute { Id Float }

APointerInput {
  IsActive      Bool
  Position      VectorFloat3
  DeltaPosition VectorFloat3
}

EnterPointerInput       APointerInput
LeavePointerInput       APointerInput
MovePointerInput        APointerInput
DownPointerInput        APointerInput
UpPointerInput          APointerInput
ClickPointerInput       APointerInput
SingleClickPointerInput APointerInput
DoubleClickPointerInput APointerInput
TripleClickPointerInput APointerInput
LongClickPointerInput   APointerInput

// --- Routing & Navigation ---

RouteValue {
  Slug    Str
  Payload Any
}

RouteConfig {
  PrimaryId   Str
  Slug        Str
  PayloadType Str
  Parent      Option(RouteConfig)
  Children    List(RouteConfig)
  Data        Any
}

RoutePath(T)       { Segments List(T) }
RouteChange        Change(RoutePath(RouteValue))
RouteHistory       { ActiveHistory List(RoutePath(RouteValue)), Count Int }

RouteTreeNode HasSlug & {
  Parent   Option(RouteTreeNode)
  Children List(RouteTreeNode)
}

IRouteEvent        IEvent & { Path RoutePath(RouteValue) }
RouteInitEvent     IRouteEvent
RouteEnterEvent    IRouteEvent
RouteLeaveEvent    IRouteEvent
RoutingStartEvent  IRouteEvent
RoutingFinishEvent IRouteEvent

RouteNavigateState {
  IsRouting Bool
  Event     Option(IRouteEvent)
  Path      RoutePath(RouteValue)
}

RouterNavigator {
  RootRouteTreeNode RouteTreeNode
  EnterPipeline     PipelineAsync(RouteChange)
  LeavePipeline     PipelineAsync(RouteChange)
  State             RouteNavigateState
}

RouterController IContextable & {
  Root      RouteTreeNode
  Navigator RouterNavigator
  History   RouteHistory
}

RouteApplicationEntity IEntity & HasPrimary(RouteApplicationEntity) & HasForeign(ApplicationEntity) & {
  History List(RoutePath(RouteValue))
  Path    RoutePath(RouteValue)
}

// --- Popups, Alerts, Banners & Toasters ---

PopupModel {
  Factory  Fn(IContext) [ IContext ]
  Response Any
}

APopupsController(T) IContextable & {
  Items     List(T)
  OnCreate  Channel(T)
  OnDestroy Channel(T)
}

AlertController    APopupsController(PopupModel)
BannersController  APopupsController(PopupModel)
SnackbarsController APopupsController(PopupModel)
ToastersController APopupsController(PopupModel) & { Limit Int }


// =============================================================================
// 8. COMPILER, AST, HIR, SEMANTIC GRAPH, USD SCENE & PCG
// =============================================================================

TokenType "VALUE" | "WHITESPACES" | "ASSIGN" | "SEPERATE" | "INDENT" | "DEDENT" | "NEWLINE" | "SEMICOLON" | "EOF"
Token     { Type TokenType, Value Str }
Span      { Offset Int, Length Int }

TokenCsn { Kind "TokenCsn", Token Token, Span Span }
GroupCsn { Kind "GroupCsn", Children List(CsNode) }
CsNode   TokenCsn | GroupCsn

// --- High-Level Intermediate Representation (HIR) ---

SyntaxRole    "Declaration" | "Expression" | "Statement" | "Shape" | "Binding" | "Operator"
SemanticLayer "Utils" | "System" | "Application" | "Domain"

IHirNode {
  SyntaxRole    SyntaxRole
  SemanticLayer SemanticLayer
}

FunctionDocExampleHirn { Code Str, Expected Str }

LiteralHirn   IHirNode & { Kind "Literal", Value Any }
OperatorHirn  IHirNode & { Kind "Operator", Operator Str, Operands List(IdRef(HirNode)) }
BranchHirn    IHirNode & { Kind "Branch", Pattern IdRef(HirNode), Value IdRef(HirNode) }
MatchHirn     IHirNode & { Kind "Match", Target IdRef(HirNode), Branches List(IdRef(BranchHirn)) }
GoHirn        IHirNode & { Kind "Go", Operator Str, Value IdRef(HirNode) }
LoopHirn      IHirNode & { Kind "Loop", Condition IdRef(HirNode), Block IdRef(BlockHirn) }
BlockHirn     IHirNode & { Kind "Block", Statements List(IdRef(HirNode)) }
BindingHirn   IHirNode & { Kind "Binding", Name Str, Shape IdRef(ReferenceHirn), Value Any }
StructHirn    IHirNode & { Kind "Struct", Name Str, Properties List(IdRef(BindingHirn)) }
ReferenceHirn IHirNode & { Kind "Reference", Target IdRef(HirNode), Property Option(IdRef(HirNode)), Arguments List(IdRef(HirNode)) }

FunctionHirn IHirNode & {
  Kind        "Function"
  Name        Str
  Parameters  List(IdRef(BindingHirn))
  ReturnShape IdRef(ReferenceHirn)
  Block       IdRef(BlockHirn)
  Examples    List(FunctionDocExampleHirn)
}

HirNode LiteralHirn | OperatorHirn | BranchHirn | MatchHirn | GoHirn | LoopHirn | BlockHirn | BindingHirn | StructHirn | ReferenceHirn | FunctionHirn

SemanticNode(T) { Hir T }

SemanticContext {
  NodeMap     Map(Str, HirNode)
  Root        HirNode
  SemanticMap Map(Str, SemanticNode(HirNode))
}

// --- Universal Scene Description (USD / Scene Graph) ---

PrimvarInterpolation "constant" | "uniform" | "vertex" | "faceVarying" | "varying"
InSpecifier          "def" | "over" | "class"
InModelKind          "group" | "assembly" | "component" | "subcomponent"

TimeSamplesIn  { Kind "TimeSamples", Samples Map(Float, Any), Interpolation Str }
AttributeIn    { Kind "Attribute", Name Str, ShapeName Str, Value Any, TimeSamples Option(IdRef(TimeSamplesIn)) }
PrimvarIn      { Kind "Primvar", Name Str, ShapeName Str, Interpolation PrimvarInterpolation, ElementSize Int, Indices List(Int), Value Any }
RelationshipIn { Kind "Relationship", Name Str, Targets List(Str) }
PropertyIn     AttributeIn | PrimvarIn | RelationshipIn

SublayerArcIn   { Kind "SublayerArc", LayerRef IdRef(LayerIn), LayerPosition Int }
InheritArcIn    { Kind "InheritArc", TargetPath Str }
VariantSetIn    { Kind "VariantSet", Name Str, SelectedVariant Str, Variants Map(Str, IdRef(PrimIn)) }
ReferenceArcIn  { Kind "ReferenceArc", AssetPath Str, TargetPrim Str, LayerOffsetTime Float, LayerScaleTime Float }
PayloadArcIn    { Kind "PayloadArc", AssetPath Str, TargetPrim Str, IsLoaded Bool }
SpecializeArcIn { Kind "SpecializeArc", TargetPath Str }
CompositionArcIn SublayerArcIn | InheritArcIn | VariantSetIn | ReferenceArcIn | PayloadArcIn | SpecializeArcIn

PrimIn {
  Kind            "Prim"
  Name            Str
  Specifier       InSpecifier
  ShapeName       Str
  ModelKind       InModelKind
  Active          Bool
  Visibility      Str
  Children        List(IdRef(PrimIn))
  Properties      List(IdRef(PropertyIn))
  CompositionArcs List(IdRef(CompositionArcIn))
}

InstanceablePrimIn PrimIn & { IsInstance Bool, MasterPrimPath Str }

PointInstancerIn PrimIn & {
  Prototypes   List(IdRef(PrimIn))
  ProtoIndices List(Int)
  Positions    List(VectorFloat3)
  Orientations List(Quaternion)
  Scales       List(VectorFloat3)
}

LayerIn {
  Kind        "Layer"
  Identifier  Str
  SubLayers   List(IdRef(LayerIn))
  DefaultPrim Str
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

// --- Procedural Content Generation (PCG) ---

PcgPinDirection      "In" | "Out"
PcgDataType          "Point" | "Surface" | "Spline" | "Volume" | "Mesh" | "Attribute"
SpatialSetOperation  "Union" | "Intersection" | "Difference"

PcgPin {
  PinName           Str
  Direction         PcgPinDirection
  AllowedTypes      List(PcgDataType)
  IsMultiConnection Bool
}

PcgEdge {
  FromNodeId  Str
  FromPinName Str
  ToNodeId    Str
  ToPinName   Str
}

PcgPoint {
  Transform  Transform3d
  Density    Float
  Steepness  Float
  BoundsMin  VectorFloat3
  BoundsMax  VectorFloat3
  Seed       Int
  Color      RgbaColorFloat
  Attributes Map(Str, Any)
}

PcgPointData   { Kind "PointData", Points List(PcgPoint), SpatialBounds Cuboid }
PcgSurfaceData { Kind "SurfaceData", SurfaceType Str, RaycastTargetLayer Str }
PcgSplineData  { Kind "SplineData", ControlPoints List(VectorFloat3), IsClosed Bool, SplineWidth Float }

IPcgNode {
  Name               Str
  Inputs             List(PcgPin)
  Outputs            List(PcgPin)
  Enabled            Bool
  DebugVisualization Bool
}

SurfaceSamplerNode IPcgNode & {
  Kind                   "SurfaceSampler"
  SamplingMethod         Str
  PointsPerSquaredMeter  Float
  PointExtents           VectorFloat3
  Looseness              Float
}

SplineSamplerNode IPcgNode & {
  Kind              "SplineSampler"
  SampleDistance    Float
  SubdivisionMethod Str
  FillInteriorSpace Bool
}

NoiseFieldNode IPcgNode & {
  Kind                "NoiseField"
  NoiseType           Str
  Frequency           Float
  Octaves             Int
  Lacunarity          Float
  TargetAttributeName Str
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

ProjectToSurfaceNode IPcgNode & {
  Kind                 "ProjectToSurface"
  RayDirection         VectorFloat3
  MaxRayDistance       Float
  AlignToSurfaceNormal Bool
  RetainOriginalZ      Bool
}

DensityFilterNode         IPcgNode & { Kind "DensityFilter", LowerThreshold Float, UpperThreshold Float, Invert Bool }
SpatialDistanceFilterNode IPcgNode & { Kind "SpatialDistanceFilter", MinimumDistance Float, PruneMode Str }
AttributeFilterNode       IPcgNode & { Kind "AttributeFilter", AttributeName Str, Comparator Str, CompareValue Any }

WaveFunctionCollapseNode IPcgNode & {
  Kind                  "WaveFunctionCollapse"
  GridSize              VectorInt3
  TileSize              VectorFloat3
  AdjacencyRuleSetAsset Str
  PeriodicWrap          Bool
}

LSystemGrammarNode IPcgNode & {
  Kind       "LSystemGrammar"
  Axiom      Str
  Rules      Map(Str, Str)
  Iterations Int
  AngleStep  Float
  StepLength Float
}

SpatialBooleanNode IPcgNode & { Kind "SpatialBoolean", Operation SpatialSetOperation, TargetTolerance Float }

MeshSpawnEntry {
  MeshAssetPath   Str
  Weight          Float
  ScaleAdjustment VectorFloat3
  CollisionPreset Str
}

StaticMeshSpawnerNode IPcgNode & {
  Kind                 "StaticMeshSpawner"
  MeshEntries          List(MeshSpawnEntry)
  InstancingStrategy   Str
  ApplyColorToMaterial Bool
  CastShadows          Bool
}

PcgGraph {
  Nodes             List(IdRef(IPcgNode))
  Edges             List(PcgEdge)
  ExposedParameters Map(Str, Any)
}


// =============================================================================
// 9. AI, LLM AGENTS, INTERACTION MESSAGES & AUTONOMOUS REFACTORING
// =============================================================================

SenderType       "SYSTEM" | "USER" | "MODEL" | "TOOL"
MessageTextType  "thinking" | "text" | "example"
CodeLanguageType "ts" | "py" | "js" | "sh" | "rl" | "cs" | "rust"
AgentTaskType    "do" | "goto" | "repeat" | "subtask"

IMessageNode IEntity

TextMn    IMessageNode & { Kind "TextMn", Text Str, TextType MessageTextType, IsDone Bool }
CodeMn    IMessageNode & { Kind "CodeMn", Text Str, CodeLanguage CodeLanguageType }
EntityMn  IMessageNode & { Kind "EntityMn", Entity IdRef(IEntity) }
TaskMn    IMessageNode & { Kind "TaskMn", TaskType AgentTaskType, IsDone Bool, SubTasks List(IdRef(TaskMn)) }
SenderMn  IMessageNode & { Kind "SenderMn", SenderType SenderType }

IToolNode IMessageNode & { FunctionSpec FunctionHirn }
RequestMn IToolNode    & { Kind "RequestMn", Args List(Any) }
ResultMn  IToolNode    & { Kind "ResultMn", Result Any }
ToolMn    IToolNode    & { Kind "ToolMn" }

AnyMn TextMn | CodeMn | EntityMn | TaskMn | RequestMn | ResultMn | ToolMn

InteractionTurn IEntity & {
  Kind     "InteractionTurn"
  Sender   IdRef(SenderMn)
  Messages List(IdRef(AnyMn))
}

InteractionEntity IEntity & {
  InteractionTurns List(InteractionTurn)
}

// --- LLM Contexts & Exceptions ---

TextAiMessage  { Sender SenderType, Content Str }
ToolsAiMessage { Sender SenderType, Tools List(FunctionHirn) }
AiMessage      TextAiMessage | ToolsAiMessage

AiLlmContext {
  Messages List(AiMessage)
  Tools    List(FunctionHirn)
}

LlmException              { ActualResult Str, ExpectedResult Str }
MustUseToolLlmException   LlmException
MaxAttemptLlmException    LlmException
PanicAnswerLlmException   LlmException
TypedAnswerLlmException   LlmException
ToolExecuteLlmException   LlmException

// --- Multi-Agent Company & Code Refactoring ---

ToolContext  { DirPath Str }
ActorContext { Tool ToolContext, Llm AiLlmContext }

DeveloperTask    { FileName Str, Instructions Str }
ArchitecturePlan { GlobalStrategy Str, Tasks List(DeveloperTask) }

FileEntry           { FullPath Str, RelativePath Str }
FileData            { RelativePath Str, Content Str }
FileOperationAction "CREATE" | "UPDATE" | "DELETE" | "RENAME"

FileOperation {
  Action  FileOperationAction
  Path    Str
  Content Str
  Reason  Str
}

BackupPaths {
  Dir              Str
  RawLogPath       Str
  JsonlOpsPath     Str
  JsonSnapshotPath Str
}

RefactorConfig {
  TargetDir             Str
  SystemPrompt          Str
  TaskPrompt            Str
  Model                 Str
  IgnoreList            List(Str)
  ApplyImmediately      Bool
  CleanupCacheAfterRun  Bool
  MaxContinuationTurns  Int
  MaxFullFilesInCache   Int
  BackupDirName         Str
}


// =============================================================================
// 10. MEDIA, IMAGE PROCESSING (VIPS) & TEXTURE FILTERS
// =============================================================================

ImageModel    { ImageData Any }
MaterialModel { MaterialData Any }
SoundModel    { SoundData Any }
SceneModel    { Name Str, Title Str }

ReadAndWriteImageExt "jpg" | "jpeg" | "png" | "webp" | "gif" | "avif" | "tiff" | "tif" | "ico" | "heif" | "heic"
OnlyReadImageExt     "svg" | "bmp"
AllImageExt          ReadAndWriteImageExt | OnlyReadImageExt

MediaCategory "Image" | "Audio" | "Video" | "Document" | "Archive" | "Code"

FileFormat {
  Extension   Str
  MediaType   Str
  Category    MediaCategory
  IconUrl     Str
  Conversions List(Str)
}

ImageMetadata {
  Width    Int
  Height   Int
  Bands    Int
  Space    Str
  HasAlpha Bool
}

ImageStats { Min Float, Max Float, Avg Float }

VipsImage {
  Width    Int
  Height   Int
  Bands    Int
  Data     List(Byte)
  Metadata ImageMetadata
}

// --- Texture Filters ---

ITextureFilter         { Apply Fn(VipsImage) [ VipsImage ] }
BlurTextureFilter      ITextureFilter & { BlurRadius Float }
BrightenTextureFilter  ITextureFilter & { Brightness Float }
ContrastTextureFilter  ITextureFilter & { Contrast Float }
EmbossTextureFilter    ITextureFilter & { Strength Float, WhiteLevel Float, Direction Str, Blend Bool }
EnhanceTextureFilter   ITextureFilter & { Enhance Float }
GrayscaleTextureFilter ITextureFilter
InvertTextureFilter    ITextureFilter
SepiaTextureFilter     ITextureFilter
SolarizeTextureFilter  ITextureFilter
HslTextureFilter       ITextureFilter & { Hue Float, Saturation Float, Luminance Float }
HsvTextureFilter       ITextureFilter & { Hue Float, Saturation Float, Value Float }
MaskTextureFilter      ITextureFilter & { Threshold Float }
ThresholdTextureFilter ITextureFilter & { Threshold Float }
NoiseTextureFilter     ITextureFilter & { Noise Float }
PixelateTextureFilter  ITextureFilter & { PixelSize Int }
PosterizeTextureFilter ITextureFilter & { Levels Int }
RgbTextureFilter       ITextureFilter & { Red Float, Green Float, Blue Float }
RgbaTextureFilter      RgbTextureFilter & { Alpha Float }
UnsharpMaskFilter      ITextureFilter & { Sigma Float, X1 Float, Y2 Float }


// =============================================================================
// 11. GAME ENGINE, BOARD MECHANICS, CLICKER GENERATORS & OBJECTIVES
// =============================================================================

EmpedoclesElements "None" | "Water" | "Earth" | "Fire" | "Air" | "Aether"

// --- Grid & Number Board ---

GridLayoutType "Rectangle" | "Hexagon" | "Isometric"

GridCellModel {
  GridPosition   VectorFloat3
  Size           VectorFloat3
  GridCoordinate VectorInt3
}

GridCellsLayoutOptions {
  Count VectorInt3
  Gap   VectorFloat3
  Size  VectorFloat3
}

GridCellsLayout {
  Cells   List(GridCellModel)
  Options GridCellsLayoutOptions
}

NumberBoardBlockType "None" | "RealNumber" | "NegativeNumber" | "Finish" | "Incrementer" | "Decrement" | "Multiplier" | "Divider"

NumberBoardBlockModel {
  Number      Int
  IsFinish    Bool
  NumberType  NumberBoardBlockType
  ElementType EmpedoclesElements
  IsActive    Bool
}

NumberBlockCellEntity IEntity & {
  Cell  GridCellModel
  Block NumberBoardBlockModel
}

SelectionActionType "None" | "Move" | "Swap" | "Merge" | "Increment" | "Decrement" | "Divider" | "Multiplier"

CellState {
  LastNumber   Int
  LastPosition GridCellModel
}

GridHistoryController {
  Snapshots List(List(CellState))
}

IBoardEvent             IEvent & { Cells List(NumberBlockCellEntity) }
BoardMoveEvent          IBoardEvent
BoardMergeEvent         IBoardEvent
BoardSwapEvent          IBoardEvent
BoardStepEvent          IBoardEvent
BoardStepUndoEvent      IBoardEvent
AfterBoardStepUndoEvent IBoardEvent

UserNumberBoardAnalyticEntity IEntity & HasPrimary(UserNumberBoardAnalyticEntity) & {
  UserId     ForeignId(UserEntity)
  Undoes     Int
  Steps      Int
  Swaps      Int
  Moves      Int
  Merges     Int
  Restarts   Int
  EarnRCoin  Int
  SpendRCoin Int
}

// --- Clicker & Resource Generators ---

UserGeneratorInteractionType "HoldUpProduce" | "HoldProduce" | "ClickProduce" | "AutoClickGenerator"
AutoClickGeneratorState      "Gathering" | "ProduceIncrements" | "ProduceDecrements" | "StoreIncrements" | "StoreDecrements" | "Dispose" | "DisposeIncrements" | "DisposeDecrement"

GeneratorModel {
  CoolingAbility          Float
  PassiveCoolingAbility   Float
  GatheringAbility        Float
  PassiveGatheringAbility Float
  GatheringHeatProducing  Float
  ProduceAbility          Float
  GeneratingHeatProducing Float
  OverheatMaxHeat         Float
  ConsumingCapacity       Float
  MaxCollect              Float
  DisposeAbility          Float
}

CoolingSystem {
  CoolingAbility        Float
  PassiveCoolingAbility Float
  HeatLevel             Float
  IsActive              Bool
}

GatheringSystem {
  Cooling                 CoolingSystem
  GatheringAbility        Float
  PassiveGatheringAbility Float
  GatheringHeatProducing  Float
  Collect                 Float
  IsActive                Bool
}

ProducingSystem {
  Cooling                 CoolingSystem
  Gathering               GatheringSystem
  ConsumingCapacity       Float
  ProduceAbility          Float
  GeneratingHeatProducing Float
  Produce                 Float
  IsActive                Bool
}

OverheatSystem   { Cooling CoolingSystem, MaxHeat Float, IsActive Bool }
OverGatherSystem { Gathering GatheringSystem, MaxCollect Float, IsActive Bool }
DisposeSystem    { Producing ProducingSystem, DisposeAbility Float, IsActive Bool }

Generator {
  IsActive         Bool
  CoolingSystem    CoolingSystem
  GatheringSystem  GatheringSystem
  ProducingSystem  ProducingSystem
  OverheatSystem   OverheatSystem
  OverGatherSystem OverGatherSystem
  DisposeSystem    DisposeSystem
}

CoolingZeroLevelException          { Reason Str }
OverheatException                  { Reason Str }
OverGatherException                { Reason Str }
GatheringTakeMoreThenAbleException { Reason Str }
ProducingTakeMoreThenAbleException { Reason Str }

// --- Products, Rewards, Achievements, Ranks, Skills & Trophies ---

ProductEntity IEntity & HasPrimary(ProductEntity) & HasName & HasTitle & {
  EnergyPrice Int
  Image       ImageModel
}

UserProductEntity ExtendsEntity(ProductEntity, UserProductEntity) & CardTraits & HasCount & {
  UserId ForeignId(UserEntity)
}

ProductContainerItemModel { ProductId ForeignId(ProductEntity), Count Int }

ProductContainerEntity IEntity & HasPrimary(ProductContainerEntity) & {
  Items List(ProductContainerItemModel)
}

CraftEntity {
  Produces  List(ProductEntity)
  Resources List(ProductEntity)
}

ShopProductModel HasPrimary(ShopProductModel) & {
  ProductId              ForeignId(ProductEntity)
  Count                  Int
  EnergyPriceModificator Int
}

ShopEntity IEntity & HasPrimary(ShopEntity) & HasName & {
  Products List(ShopProductModel)
}

RewardEntity IEntity & HasPrimary(RewardEntity) & HasTitle & {
  ProductContainerId ForeignId(ProductContainerEntity)
}

SpecialProductModel IEntity & HasPrimary(SpecialProductModel) & {
  PriceUsd Float
  RewardId ForeignId(RewardEntity)
}

AchievementEntity IEntity & HasPrimary(AchievementEntity) & HasName & HasTitle & {
  RewardId ForeignId(RewardEntity)
  Image    ImageModel
}

UserAchievementEntity ExtendsEntity(AchievementEntity, UserAchievementEntity) & CardTraits & HasAchieved & HasViewed & HasReceived & HasTouched & {
  UserId ForeignId(UserEntity)
}

CompleteObjectiveTotalAchievementEntity ExtendsCountEntity(AchievementEntity, CompleteObjectiveTotalAchievementEntity)
MergeAchievementEntity                  ExtendsCountEntity(AchievementEntity, MergeAchievementEntity)
MoveAchievementEntity                   ExtendsCountEntity(AchievementEntity, MoveAchievementEntity)
SwapAchievementEntity                   ExtendsCountEntity(AchievementEntity, SwapAchievementEntity)

RankEntity IEntity & HasPrimary(RankEntity) & HasName & HasTitle & {
  RequiredScore Int
  RewardId      ForeignId(RewardEntity)
  Image         ImageModel
}

UserRankEntity ExtendsEntity(RankEntity, UserRankEntity) & CardTraits & HasAchieved & HasCompleted & HasViewed & HasReceived & HasTouched & {
  UserId ForeignId(UserEntity)
}

SkillEdgeModel {
  SourceId ForeignId(SkillEntity)
  TargetId ForeignId(SkillEntity)
}

SkillEntity IEntity & HasPrimary(SkillEntity) & HasName & HasTitle & HasDescription & {
  Image         ImageModel
  ChildrenEdges List(SkillEdgeModel)
}

UserSkillEntity ExtendsEntity(SkillEntity, UserSkillEntity) & HasOpened & HasDirty & HasCompleted & HasViewed & HasReceived & HasTouched & {
  UserId      ForeignId(UserEntity)
  UpdatedDate DateTimeSerializable
}

BackCountSkillEntity  ExtendsCountEntity(SkillEntity, BackCountSkillEntity)
MergeCountSkillEntity ExtendsCountEntity(SkillEntity, MergeCountSkillEntity)
MoveCountSkillEntity  ExtendsCountEntity(SkillEntity, MoveCountSkillEntity)
SwapCountSkillEntity  ExtendsCountEntity(SkillEntity, SwapCountSkillEntity)

TrophyEntity IEntity & HasPrimary(TrophyEntity) & HasTitle & {
  Image ImageModel
}

UserTrophyEntity ExtendsEntity(TrophyEntity, UserTrophyEntity) & CardTraits & HasTouched & {
  UserId ForeignId(UserEntity)
}

// --- Locations, Chapters, Objectives & Tasks ---

LocationEntity IEntity & HasPrimary(LocationEntity) & {
  Style   ThemeEntity
  Factory Fn(IContext) [ IContext ]
}

NumberBoardLocationEntity ExtendsEntity(LocationEntity, NumberBoardLocationEntity) & {
  Matrix MatrixModel(NumberBoardBlockModel)
}

UserLocationModel {
  BestUserScore      Int
  CurrentUserScore   Int
  CurrentAdStepBack  Int
  MaxAdStepBack      Int
  IsBannerActive     Bool
  IsOpen             Bool
  IsRestartAvailable Bool
  IsRestartFree      Bool
  IsStepBackAvailable Bool
  IsStepBackFree     Bool
  IsVisited          Bool
}

GridStepsTaskEntity     { Steps Int }
RequiredSkillTaskEntity { RequiredSkill ForeignId(SkillEntity) }
RewardedCountTaskEntity { Count Int, RewardId ForeignId(RewardEntity) }

ObjectiveEntity IEntity & HasPrimary(ObjectiveEntity) & HasName & HasTitle & {
  RequiredSkill RequiredSkillTaskEntity
  MaxSteps      GridStepsTaskEntity
  GoalSum       RewardedCountTaskEntity
  FirstScore    RewardedCountTaskEntity
  SecondScore   RewardedCountTaskEntity
  ThirdScore    RewardedCountTaskEntity
  LocationId    ForeignId(LocationEntity)
  Image         ImageModel
}

UserLevelStateType "Locked" | "Opened" | "InProgress" | "Completed"

UserNumberBoardObjectiveEntity ExtendsEntity(ObjectiveEntity, UserNumberBoardObjectiveEntity) & CardTraits & HasCompleted & HasTouched & {
  UserId         ForeignId(UserEntity)
  Score          Int
  Steps          Int
  State          UserLevelStateType
  IsFirstReward  Bool
  IsSecondReward Bool
  IsThirdReward  Bool
}

ChapterEntity IEntity & HasPrimary(ChapterEntity) & HasName & HasTitle & {
  Image         ImageModel
  ObjectivesIds List(ForeignId(ObjectiveEntity))
}

UserChapterEntity ExtendsEntity(ChapterEntity, UserChapterEntity) & CardTraits & HasCompleted & HasViewed & {
  UserId ForeignId(UserEntity)
}

SolutionEntity IEntity & HasPrimary(SolutionEntity) & HasDescription & {
  Vision   ForeignId(ChapterEntity)
  Chapters List(ForeignId(ChapterEntity))
  Tasks    List(ObjectiveEntity)
}

TaskProgressType "Pending" | "Active" | "Done" | "Failed"
TaskEntity       IEntity & HasPrimary(TaskEntity)
TimedTaskEntity  ExtendsEntity(TaskEntity, TimedTaskEntity)
DailyTaskEntity  ExtendsEntity(TimedTaskEntity, DailyTaskEntity)
WeeklyTaskEntity ExtendsEntity(TimedTaskEntity, WeeklyTaskEntity)
MonthlyTaskEntity ExtendsEntity(TimedTaskEntity, MonthlyTaskEntity)

UserTaskEntity IEntity & HasPrimary(UserTaskEntity) & HasDescription & {
  Progress TaskProgressType
}

// --- Weather & World Environment ---

PrecipitationEntity { Precipitation Float }
LightEntity         { Light Float }
TemperatureEntity   { Temperature Float }
WindEntity          { Direction VectorFloat3, Wind Float }

WorldEntity IEntity & HasPrimary(WorldEntity)

WorldContextEntity IEntity & HasPrimary(WorldContextEntity) & {
  WorldId   ForeignId(WorldEntity)
  ContextId Str
  Context   IContext
}


// =============================================================================
// 12. USERS, AUTHENTICATION, ACL, ENTERPRISE DOMAINS & INTERNATIONALIZATION
// =============================================================================

NamingConventionType "Western" | "Eastern" | "Patronymic" | "Mononym"

PersonNameTraits {
  FullName          Str
  NickName          Option(Str)
  DisplayName       Str
  LegalName         Option(Str)
  FirstName         Str
  MiddleName        Option(Str)
  FamilyName        Str
  LastName          Str
  Patronymic        Option(Str)
  ParentName        Option(Str)
  MaidenName        Option(Str)
  HonorificPrefix   Option(Str)
  GenerationalSuffix Option(Str)
  SortingName       Str
  NamingConvention  NamingConventionType
}

UserEntity IEntity & HasPrimary(UserEntity) & HasName & HasTitle & {
  UserObjectiveId Str
  UserWorldId     Str
  IsEnable        Bool
}

UserProfile IEntity & HasCreatedAt & HasUpdatedAt & {
  UserId       IdRef(UserEntity)
  Name         Str
  Avatar       Str
  ContactEmail Str
}

// --- Security, Auth & ACL ---

AccessLevel  "DENIED" | "VIEWER" | "EDITOR" | "OWNER"
AccessPolicy {
  Subject     KeyEdge(IEntity, IEntity)
  Resource    KeyEdge(IEntity, IEntity)
  AccessLevel AccessLevel
}

AuthProviderType "google" | "apple" | "credentials" | "github"
DeviceType       "mobile" | "desktop" | "tablet"
TokenTypeAuth    "VERIFY_EMAIL" | "RESET_PASSWORD" | "MAGIC_LINK"
AuthAction       "LOGIN" | "LOGOUT" | "REGISTER" | "PASSWORD_RESET" | "MFA_CHALLENGE"

SecurityProfile {
  IsBanned            Bool
  BanReason           Option(Str)
  FailedLoginAttempts Int
  LockedUntil         Option(DateTime)
  TwoFactorEnabled    Bool
  TwoFactorSecret     Option(Str)
  PasswordChangedAt   Option(DateTime)
}

AuthProvider {
  Provider          AuthProviderType
  ProviderAccountId Str
  Email             Option(Str)
  AccessToken       Option(Str)
  RefreshToken      Option(Str)
}

AuthCredential {
  Provider     IdRef(AuthProvider)
  PasswordHash Option(Str)
}

AuthSession {
  SessionToken Str
  UserAgent    Option(Str)
  IpAddress    Option(Str)
  DeviceType   Option(DeviceType)
  Location     Option(Str)
  ExpiresAt    DateTime
}

RecoveryCode {
  CodeHash Str
  IsUsed   Bool
  UsedAt   Option(DateTime)
}

VerificationToken {
  Identifier Str
  Token      Str
  Type       TokenTypeAuth
  Payload    Option(Json)
  ExpiresAt  DateTime
}

AuthEvent {
  Action    AuthAction
  IpAddress Option(Str)
  UserAgent Option(Str)
  CreatedAt DateTime
}

UserAuth IEntity & {
  UserId        IdRef(UserEntity)
  Securities    List(IdRef(SecurityProfile))
  Providers     List(IdRef(AuthProvider))
  Sessions      List(IdRef(AuthSession))
  RecoveryCodes List(IdRef(RecoveryCode))
  AuthEvents    List(IdRef(AuthEvent))
}

// --- Cloud, Finance & Supply Chain Domains ---

CloudProvider      IEntity & HasName & { Region Str }
CloudInstance      IEntity & { ProviderId Str, Status Str, IpAddress Str }
CloudStorageBucket IEntity & HasName & { ProviderId Str, SizeBytes Int }

Company     IEntity & HasName
Domain      IEntity & HasName & { Type Str, Company IdRef(Company) }
Bank        IEntity & HasName
Person      IEntity & PersonNameTraits
Shareholder IEntity & { EntityRef IdRef(Person | Company), Shares Int }
Account     IEntity & { Owner IdRef(Person | Company), Bank IdRef(Bank), Balance Float }
Transaction IEntity & { From IdRef(Account), To IdRef(Account), Amount Float, Timestamp DateTime }

Supplier  IEntity & HasName
Warehouse IEntity & HasName & { Location BoundRectangle(Float) }
Sensor    IEntity & { Type Str, Value Float }

Part IEntity & HasName & {
  SuppliedBy  List(IdRef(Supplier))
  IsPartOf    List(IdRef(Part))
  ShippedVia  List(IdRef(Supplier))
  InstalledOn List(IdRef(Part))
}

// --- Application & Config ---

AdvertisementEntity { GameId Str, BannerId Str, IsBannerAdActive Bool }
MarketEntity        { PageUrl Str, IsMarketEnable Bool }
SupportEntity       { Email Str }

GameConfigEntity {
  AdvertisementConfig AdvertisementEntity
  MarketConfig        MarketEntity
  SupportConfig       SupportEntity
}

ApplicationEntity IEntity & HasPrimary(ApplicationEntity) & {
  ThemeIdCurrent            ForeignId(ThemeEntity)
  UserIdCurrent             ForeignId(UserEntity)
  ApplicationVersionCurrent Str
}

// --- Internationalization (i18n) ---

Locale {
  Name Str
  Code Str
  Iso  Str
  Dir  "ltr" | "rtl"
}

TextInternationalisationEntity IEntity & HasPrimary(TextInternationalisationEntity) & {
  En Str
  Ru Str
  Uk Str
  Ch Str
  Sp Str
  Fr Str
  Ar Str
}

InternationalisationController {
  Locale       Str
  LocaleChange Channel(Str)
}


// =============================================================================
// 13. SYSTEM, FILE SYSTEM, GIT, RUNTIMES, CLUSTER & PERFORMANCE
// =============================================================================

PlatformType "Editor" | "Android" | "Ios" | "Windows" | "Linux" | "Web"

AbsolutePathString Str
RelativePathString Str
PathString         AbsolutePathString | RelativePathString
FilePathString     PathString
DirPathString      PathString
SourcePathString   DirPathString
Url                Str

HasPath       { Path PathString }
HasDirPath    { DirPath DirPathString }
HasFileName   { FileName Str }
HasFilePath   { FilePath FilePathString }
HasSourcePath { SourcePath SourcePathString }

FsNodeType "DIRECTORY" | "FILE_JSON" | "FILE_STORAGE_URL" | "FILE_BINARY"

FsNode IEntity & HasPrimary(FsNode) & CrudDateTime & {
  FsNodeType    FsNodeType
  Name          Char256
  ContentJson   Option(Json)
  ContentBinary Option(List(Byte))
  ParentId      Option(IdRef(FsNode))
  Ancestors     List(IdRef(FsNode))
}

CycleDetectedError { Message Str, NodeId Str }

// --- Git Version Control ---

GitFileChanges {
  Created  List(Str)
  Modified List(Str)
  Deleted  List(Str)
}

GitCommitInfo {
  Hash       Str
  Date       Str
  AuthorName Str
  Message    Str
}

GitStatus {
  LocalBranch  Str
  RemoteBranch Str
  RemoteDiff   Str
  Clean        Bool
  Changes      GitFileChanges
}

// --- Runtimes, Containers & Execution ---

DockerImage {
  From    Str
  Workdir Str
  Copy    List(Str)
  Run     List(Str)
  Cmd     List(Str)
}

DownloadInfo { Filename Str, Url Url }

RuntimeProvider {
  RuntimeName     Str
  DefaultVersion  Str
  GetDownloadInfo Fn(Str, Str, Str) [ DownloadInfo ]
  Setup           Fn(Str, Str) [ Void ]
  Install         Fn(Str, Str, Str) [ Void ]
  Remove          Fn(Str, Str, Str) [ Void ]
  ListPackages    Fn(Str, Str) [ List(Str) ]
  Run             Fn(Str, Str, Str, Str, List(Str)) [ Str ]
}

RunRequest {
  FilePathOrPackageName Str
  PathWithFunctionName  Str
  Params                List(Str)
}

WorkerEnvironment { WorkerId Str }
WorkerEvent(T)    { Id "get" | "set", Ctx T }

// --- Performance & Complexity ---

PerformanceType "None" | "InActive" | "LaidBack" | "Focused" | "Fatigue" | "Anxiety" | "Breakdown"
HardwareLimitation "Read_ByIndex" | "Search_ByValue" | "InsertDelete" | "MemoryFootprint" | "CacheLocality"

PerformanceRecord {
  TimeDataSize   Int
  TimeMs         Float
  MemoryDataSize Int
  MemoryBytes    Int
}

PerformancePrediction {
  TimeText    Str
  TimeMs      Float
  MemoryText  Str
  MemoryBytes Int
}

WeightedMovingAverageRecorder {
  History    List(PerformanceRecord)
  MaxHistory Int
}


// =============================================================================
// 14. ONTOLOGICAL TYPESTATE & PURE DOMAIN TRANSITIONS (BEHAVIORS)
// =============================================================================

// --- Vector & Spatial Operations ---

AddVec3(A VectorFloat3, B VectorFloat3) [
  VectorFloat3 {
    X (A.X + B.X)
    Y (A.Y + B.Y)
    Z (A.Z + B.Z)
  }
]

ScaleVec3(V VectorFloat3, Factor Float) [
  VectorFloat3 {
    X (X * Factor)
    Y (Y * Factor)
    Z (Z * Factor)
  }
]

IsNeighborCell(Target VectorInt3, Neighbor VectorInt3) [
((Target.X - Neighbor.X) . Math.Abs <= 1) &&
((Target.Y - Neighbor.Y) . Math.Abs <= 1) &&
((Target.Z - Neighbor.Z) . Math.Abs <= 1)
]

// --- Curve & Animation Evaluation ---

EvaluateLinear(Progress Float) [ Progress ]

EvaluateInverted(Progress Float) [ 1.0 - Progress ]

EvaluateDecelerate(Progress Float) [
Inv (1.0 - Progress)
1.0 - (Inv * Inv)
]

UpdateTimeline(Tl AnimationTimeLine, Delta Float) [
IsPlaying . {
false [ Tl ]
true  [
NextTime (CurrentTime + Delta)
NextTime . {
[ _ >= TotalTime ] [ Tl & { CurrentTime TotalTime, IsPlaying false } ]
_                  [ Tl & { CurrentTime NextTime } ]
}
]
}
]

// --- Clicker Generator Typestate Transitions ---

HeatCoolingSystem(Cs CoolingSystem, Amount Float) [
Cs & { HeatLevel (HeatLevel + Amount) }
]

UpdateCoolingSystem(Cs CoolingSystem) [
CoolAmount (IsActive . { true [ CoolingAbility ], false [ PassiveCoolingAbility ] })
NextHeat   (HeatLevel - CoolAmount)
NextHeat . {
[ _ <= 0.0 ] [ Cs & { HeatLevel 0.0 } ]
_            [ Cs & { HeatLevel NextHeat } ]
}
]

CheckOverheat(Os OverheatSystem) [
Os.Cooling.HeatLevel . {
[ _ > Os.MaxHeat ] [ OverheatException { Reason "Max heat exceeded" } ]
_                  [ Os ]
}
]

GatherResources(Gs GatheringSystem) [
Gain (IsActive . { true [ GatheringAbility ], false [ PassiveGatheringAbility ] })
Gs & {
Collect (Collect + Gain)
Cooling (Cooling . HeatCoolingSystem(GatheringHeatProducing))
}
]

ProduceResources(Ps ProducingSystem) [
Ps.Gathering.Collect . {
[ _ < ConsumingCapacity ] [ ProducingTakeMoreThenAbleException { Reason "Not enough gathered resources" } ]
_ [
Ps & {
Produce   (Produce + ProduceAbility)
Gathering (Gathering & { Collect (Gathering.Collect - ConsumingCapacity) })
Cooling   (Cooling . HeatCoolingSystem(GeneratingHeatProducing))
}
]
}
]

// --- Game Board & Objective Transitions ---

OpenObjective(Level UserNumberBoardObjectiveEntity) [
Level & { IsOpened true, State "Opened" }
]

MakeBoardStep(Level UserNumberBoardObjectiveEntity & { IsOpened true }) [
Level & {
Steps     (Steps + 1)
IsTouched true
IsDirty   true
State     "InProgress"
}
]

UndoBoardStep(Level UserNumberBoardObjectiveEntity & { State "InProgress" }) [
Steps . {
[ _ > 0 ] [ Level & { Steps (Steps - 1) } ]
_         [ Level ]
}
]

CompleteObjective(Level UserNumberBoardObjectiveEntity, FinalScore Int, Objective ObjectiveEntity) [
Level & {
Score          FinalScore
IsCompleted    true
State          "Completed"
IsFirstReward  (FinalScore >= Objective.FirstScore.Count)
IsSecondReward (FinalScore >= Objective.SecondScore.Count)
IsThirdReward  (FinalScore >= Objective.ThirdScore.Count)
}
]

ResetObjective(Level UserNumberBoardObjectiveEntity) [
Level & {
Steps       0
Score       0
IsCompleted false
State       "Opened"
}
]

// --- Achievements, Ranks, Skills & Trophies Transitions ---

TouchEntity(E HasTouched) [ E & { IsTouched true } ]

UnlockAchievement(Ua UserAchievementEntity) [
Ua & { IsAchieved true, IsOpened true, IsDirty true }
]

ClaimAchievementReward(Ua UserAchievementEntity & { IsAchieved true, IsReceived false }) [
Ua & { IsReceived true, IsViewed true, IsDirty false }
]

CompleteSkill(Us UserSkillEntity & { IsOpened true }) [
Us & { IsCompleted true, IsReceived true, IsDirty true }
]

EvaluateUserRank(Ur UserRankEntity, CurrentScore Int, RankSpec RankEntity) [
CurrentScore . {
[ _ >= RankSpec.RequiredScore ] [ Ur & { IsAchieved true, IsCompleted true, IsOpened true } ]
_                               [ Ur ]
}
]

// --- Router Navigation Transitions ---

NavigateToRoute(State RouteNavigateState, NextPath RoutePath(RouteValue)) [
State & {
IsRouting false
Path      NextPath
Event     Some(RouteEnterEvent { Path NextPath })
}
]

// --- File System Cycle Validation ---

ValidateFsNodeCycle(OldNode FsNode, NewNode FsNode) [
NewNode.Ancestors . Stream.Filter([ _.Id == OldNode.Id ]) . {
None [ NewNode ]
Cons [ CycleDetectedError { Message "FileSystem hierarchy cycle detected", NodeId OldNode.Id } ]
}
]

// --- Cloud Infrastructure Transitions ---

ProvisionInstance(Provider CloudProvider, Ip Str) [
CloudInstance {
Id         "inst_{Provider.Id}"
ProviderId Provider.Id
Status     "RUNNING"
IpAddress  Ip
}
]

TerminateInstance(Instance CloudInstance & { Status "RUNNING" }) [
Instance & { Status "TERMINATED" }
]

CreateStorageBucket(Provider CloudProvider, BucketName Str) [
CloudStorageBucket {
Id         "bkt_{BucketName}"
ProviderId Provider.Id
Name       BucketName
SizeBytes  0
}
]
