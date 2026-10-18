_ primitive
_ primitive

#
Core Traits & Structural Mixins
#

PrimaryId(T) { Id String }
ForeignId(T) { Id String }
IdRef(T)     { Id String }

IResource        {}
IAttribute       {}
IEntity          { Id String }
Identifiable     { Id String }
Auditable        { CreatedAt Int, UpdatedAt Int }
Versioned        { Version Int }
SoftDeletable    { DeletedAt Option(Int), IsDeleted Bool }
Timestamped      Auditable & SoftDeletable
Named            { Name String }
Tagged           { Tags List(String) }
Metadata         { MetaMap Map(String, Any) }

HasId(T)         { Id T }
HasPrimary(T)    { PrimaryId PrimaryId(T) }
HasForeign(T)    { EntityId ForeignId(T) }
HasName          { Name String }
HasFullName      { FullName String }
HasTitle         { Title String }
HasDescription   { Description String }
HasSlug          { Slug String }
HasValue(T)      { Value T }
HasCount         { Count Int }
HasRange         { From Int, To Int }
HasMetadata      { Metadata Any }

// State Flag Traits
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

ExtendsEntity(TBase, TSelf)      IEntity & HasPrimary(TSelf) & HasForeign(TBase)
ExtendsCountEntity(TBase, TSelf) ExtendsEntity(TBase, TSelf) & HasCount
ExtendsRangeEntity(TBase, TSelf) ExtendsEntity(TBase, TSelf) & HasRange

#
Tuples, Indexing, Spans & Memory Sharing
#

Tuple(T)        ()
Pair(A, B)      { First A, Second B }
Triple(A, B, C) { First A, Second B, Third C }

FixedVector(T, N) {
  Data   Tuple(T)
  Length N
}

Offset         { Value Int }
Index          { Value Int }
OutIndex       { Value Int }
IndexOrOut     Index | OutIndex
OrderDirection "ASC" | "DESC"

IndexRange {
  Start Int
  Size  Int
}

IndexMaskSegment {
  Offset      Int
  BaseIndices List(Int)
}

IndexMask {
  IndicesNum  Int
  SegmentsNum Int
  Segments    List(IndexMaskSegment)
  BeginInSeg  Int
  EndInSeg    Int
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

GPointer { Type String, Data Any }
GSpan    { Type String, Data Any, Size Int }
GArray   GSpan & { Capacity Int }
GVArray  GSpan & { IsSingle Bool }
GList    { CppType String, Data Any, Size Int }

#
Option, Result & Either (Algebraic Sum Types)
#

Some(T)   { Value T }
Option(T) Some(T) | None

Ok(T)        { Value T }
Err(E)       { Error E }
Result(T, E) Ok(T) | Err(E)

Left(L)      { Value L }
Right(R)     { Value R }
Either(L, R) Left(L) | Right(R)

#
Lists, Linked Lists, Queues, Deques & Buffers
#

Nil  None
Cons(T) {
  Head T
  Tail List(T)
}
List(T) Nil | None | Cons(T)

List1(A)          Cons { Head A, Tail Nil }
List2(A, B)       Cons { Head A, Tail List1(B) }
List3(A, B, C)    Cons { Head A, Tail List2(B, C) }
List4(A, B, C, D) Cons { Head A, Tail List3(B, C, D) }

NonEmptyList(T) {
  Head T
  Tail List(T)
}

DynamicArray(T) List(T)
StaticArray(T)  List(T)

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

Deque(T) {
  Front List(T)
  Back  List(T)
}

Stack(T) {
  Items List(T)
  Size  Int
}

Queue(T) {
  InBox  List(T)
  OutBox List(T)
  Size   Int
}

RingBuffer(T) {
  Buffer   List(T)
  Capacity Int
  ReadIdx  Int
  WriteIdx Int
}

PriorityNode(T) { Priority Float, Item T }
PriorityQueue(T) {
  Heap List(PriorityNode(T))
  Size Int
}

SkipListNode(T) {
  Value   T
  Forward List(SkipListNode(T))
}

SkipList(T) {
  Head     Option(SkipListNode(T))
  MaxLevel Int
}

#
Maps, Sets, Bags, Caches & Virtual Recursive Dictionaries (VRD)
#

Map(K, V)      { (K) V }
Set(T)         { (T) Bool }
MultiMap(K, V) { (K) List(V) }
Bag(T)         { (T) Int }
BiMap(K, V)    { Forward Map(K, V), Backward Map(V, K) }

KeyValue(K, V)      { Key K, Value V }
KeyValueArray(K, V) { Key K, Values List(KvaOrValue(K, V)) }
KvaOrValue(K, V)    KeyValue(K, V) | KeyValueArray(K, V) | V

Dict(T)          Map(String, T)
RecursiveDict(T) Map(String, T | RecursiveDict(T))

Vrd(T)        Map(String, VrdOrValue(T))
VrdOrValue(T) T | Vrd(T)

HashTable(K, V) {
  Buckets List(LinkedList((K, V)))
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

LFUCache(K, V) {
  Capacity    Int
  Values      Map(K, V)
  Frequencies Map(K, Int)
}

#
Probabilistic Data Structures
#

ProbabilisticDataStructure { Accuracy Float }

BloomFilter(T) ProbabilisticDataStructure & {
  BitArray      List(Byte)
  NumHashFuncs  Int
}

CuckooFilter(T) ProbabilisticDataStructure & {
  Buckets    List(Int)
  BucketSize Int
}

HyperLogLog(T) ProbabilisticDataStructure & {
  Registers List(Byte)
  Precision Int
}

CountMinSketch(T) ProbabilisticDataStructure & {
  Depth Int
  Width Int
  Table List(List(Int))
}

#
Trees, Tries, Heaps & Spatial Trees (BVH, KDTree, QuadTree, Octree)
#

HasOrder(T)        { Prev Option(T), Next Option(T) }
HasParent(T)       { Parent Option(T) }
HasChildren(T)     { Children List(T) }
HasChildrenDict(T) { Children Dict(T) }

Leaf {}
Node(T) {
  Value T
  Left  Tree(T)
  Right Tree(T)
}
Tree(T) Leaf | Node(T)

TreeNode(T) HasValue(T) & HasParent(TreeNode(T)) & HasChildren(TreeNode(T)) & HasOrder(TreeNode(T))

RoseNode(T) {
  Value    T
  Children List(RoseNode(T))
}
RoseTree(T) RoseNode(T)

BinaryTreeNode(T) {
  Value T
  Left  Option(BinaryTreeNode(T))
  Right Option(BinaryTreeNode(T))
}
BinaryTree(T) { Root Option(BinaryTreeNode(T)) }

BalancedTreeType "AVL" | "RedBlack" | "Treap" | "Splay" | "WeightBalanced"
BalancedTree(T)  BinaryTree(T) & { TreeType BalancedTreeType }

BTreeNode(K, V) {
  Keys     List(K)
  Values   List(V)
  Children List(BTreeNode(K, V))
  IsLeaf   Bool
}
BTree(K, V) { Root Option(BTreeNode(K, V)), Degree Int }

TrieNode(V) {
  Value      Option(V)
  Children   Map(Char, TrieNode(V))
  IsTerminal Bool
}
Trie(V)     TrieNode(V)
RadixTree(V) Trie(V)
SuffixTree  { Text String, Root TrieNode(Int) }

HeapType       "MinHeap" | "MaxHeap" | "FibonacciHeap" | "PairingHeap" | "BinomialHeap"
Heap(T)        { HeapType HeapType, Array List(T) }
SegmentTree(T) { Array List(T), Size Int }
FenwickTree(T) { Tree List(T), Size Int }
MerkleNode     { Hash String, Left Option(MerkleNode), Right Option(MerkleNode) }
MerkleTree     { Root Option(MerkleNode), Leaves List(String) }

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

BVHTreeAxisRange { Min Float, Max Float }
BVHTreeOverlap   { IndexA Int, IndexB Int }
BVHTreeNearest   { Index Int, Co (Float, Float, Float), No (Float, Float, Float), DistSq Float, Flags Int }
BVHTreeRay       { Origin (Float, Float, Float), Direction (Float, Float, Float), Radius Float }
BVHTreeRayHit    { Index Int, Co (Float, Float, Float), No (Float, Float, Float), Dist Float }

BVHTree {
  Epsilon  Float
  TreeType Int
  Len      Int
}

#
Graphs & Networks
#

OrderedEdge {
  VLow  Int
  VHigh Int
}

KeyEdge(TFrom, TTo) { From TFrom, To TTo }

Vertex(T) {
  Id    String
  Value T
}

Edge(W) {
  From       String
  To         String
  Weight     W
  IsDirected Bool
}

Graph(T, W) {
  Vertices   List(Vertex(T))
  Edges      List(Edge(W))
  IsDirected Bool
  IsWeighted Bool
}

DAG(T, W)                  Graph(T, W) & { IsAcyclic True }
BipartiteGraph(U, V, W)    { LeftSet List(Vertex(U)), RightSet List(Vertex(V)), Edges List(Edge(W)) }
Hyperedge(T)               { Id String, Nodes List(Vertex(T)), Weight Float }
Hypergraph(T)              { Vertices List(Vertex(T)), Hyperedges List(Hyperedge(T)) }
EdgeListGraph(N, E)        { Nodes List(N), Edges List((E, E)) }
GraphAdjacencyMatrix(T)    { Vertices List(T), Matrix List(List(Float)) }
GraphAdjacencyList(T)      { AdjacencyMap Map(T, List(T)) }

#
Matrices, Tensors & Diffs
#

MatrixRow(T)   { Row List(T) }
MatrixModel(T) { Rows List(MatrixRow(T)) }

Matrix(T) {
  Rows Int
  Cols Int
  Data List(List(T))
}

Tensor(T) {
  Shape   List(Int)
  Strides List(Int)
  Data    List(T)
}

SparseMatrixCSR(T) {
  Rows       Int
  Cols       Int
  Values     List(T)
  ColIndices List(Int)
  RowPtr     List(Int)
}

RemoveDeltaString { Offset Int, RemoveLength Int }
AddDeltaString    { Offset Int, AddValue String }
DeltaString       RemoveDeltaString | AddDeltaString

RemoveDeltaVrd { Path List(String), AfterPath List(String), Remove Bool }
AddDeltaVrd    { Path List(String), AfterPath List(String), Add VrdOrValue(String) }
DeltaVrd       RemoveDeltaVrd | AddDeltaVrd

#
Algebraic Expressions & Catamorphisms
#

Num(Val)  { Value Val }
Add(L, R) { Left L, Right R }
Sub(L, R) { Left L, Right R }
Mul(L, R) { Left L, Right R }
Div(L, R) { Left L, Right R }
Expr      Num | Add(Expr, Expr) | Sub(Expr, Expr) | Mul(Expr, Expr) | Div(Expr, Expr)

Algebra {
  OnNum(V)    [ V ]
  OnAdd(A, B) [ A + B ]
  OnSub(A, B) [ A - B ]
  OnMul(A, B) [ A * B ]
  OnDiv(A, B) [ A / B ]
}

Cata(Expression, Alg) [
  Expression . {
    Num [ Alg.OnNum(Value) ]
    Add [ Alg.OnAdd(Left . Cata(Alg), Right . Cata(Alg)) ]
    Sub [ Alg.OnSub(Left . Cata(Alg), Right . Cata(Alg)) ]
    Mul [ Alg.OnMul(Left . Cata(Alg), Right . Cata(Alg)) ]
    Div [ Alg.OnDiv(Left . Cata(Alg), Right . Cata(Alg)) ]
  }
]

#
Collection Operations & Transitions
#

OptionMap(Opt, Fn) [
  Opt . {
    None [ None ]
    Some [ Some { Value (Value . Fn) } ]
  }
]

OptionUnwrapOr(Opt, Default) [
  Opt . {
    None [ Default ]
    Some [ Value ]
  }
]

ResultMap(Res, Fn) [
  Res . {
    Err [ Res ]
    Ok  [ Ok { Value (Value . Fn) } ]
  }
]

ListMap(L, Action) [
  L . {
    None [ None ]
    Nil  [ Nil ]
    Cons [
      Cons {
        Head (Head . Action)
        Tail (Tail . ListMap(Action))
      }
    ]
  }
]

ListFilter(L, Pred) [
  L . {
    None [ None ]
    Nil  [ Nil ]
    Cons [
      (Head . Pred) . {
        true  [ Cons { Head Head, Tail (Tail . ListFilter(Pred)) } ]
        false [ Tail . ListFilter(Pred) ]
      }
    ]
  }
]

ListFold(L, Acc, Op) [
  L . {
    None [ Acc ]
    Nil  [ Acc ]
    Cons [ Tail . ListFold(Op(Acc, Head), Op) ]
  }
]

StackPush(S Stack, Item) [
  Stack { Items (Cons { Head Item, Tail S.Items }), Size (S.Size + 1) }
]

StackPop(S Stack) [
  S.Items . {
    Nil  [ Pair { First None, Second S } ]
    Cons [ Pair { First (Some { Value Head }), Second (Stack { Items Tail, Size (S.Size - 1) }) } ]
  }
]
