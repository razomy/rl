_ meta
_ primitives

// =============================================================================
// Core Traits & Structural Mixins
// =============================================================================

Identifiable { Id Str }
Auditable    { CreatedAt Int, UpdatedAt Int }
Versioned    { Version Int }
SoftDeletable { DeletedAt Option(Int), IsDeleted Bool }
Timestamped  Auditable & SoftDeletable
Named        { Name Str }
Tagged       { Tags List(Str) }
Metadata     { MetaMap Map(Str, Any) }

// =============================================================================
// Tuples & Fixed Vectors
// =============================================================================

Tuple(T) ()
Pair(A, B)   { First A, Second B }
Triple(A, B, C) { First A, Second B, Third C }

FixedVector(T, N) {
  Data   Tuple(T)
  Length N
}

// =============================================================================
// Option, Result & Either (Algebraic Sum Types)
// =============================================================================

Some(T)   { Value T }
Option(T) Some(T) | None

Ok(T)        { Value T }
Err(E)       { Error E }
Result(T, E) Ok(T) | Err(E)

Left(L)      { Value L }
Right(R)     { Value R }
Either(L, R) Left(L) | Right(R)

// =============================================================================
// Lists, Sequences & NonEmpty Collections
// =============================================================================

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

PriorityNode(T) { Priority Int, Item T }
PriorityQueue(T) {
  Heap List(PriorityNode(T))
  Size Int
}

// =============================================================================
// Maps, Sets & Bags
// =============================================================================

Map(K, V)      { (K) V }
Set(T)         { (T) Bool }
MultiMap(K, V) { (K) List(V) }
Bag(T)         { (T) Int }
BiMap(K, V)    { Forward Map(K, V), Backward Map(V, K) }

// =============================================================================
// Trees &Tries
// =============================================================================

Leaf {}
Node(T) {
  Value T
  Left  Tree(T)
  Right Tree(T)
}
Tree(T) Leaf | Node(T)

RoseNode(T) {
  Value    T
  Children List(RoseNode(T))
}
RoseTree(T) RoseNode(T)

TrieNode(V) {
  Value    Option(V)
  Children Map(Char, TrieNode(V))
  IsTerminal Bool
}
Trie(V) TrieNode(V)

BTreeNode(K, V) {
  Keys     List(K)
  Values   List(V)
  Children List(BTreeNode(K, V))
  IsLeaf   Bool
}

// =============================================================================
// Graphs & Networks
// =============================================================================

Vertex(T) {
  Id    Str
  Value T
}

Edge(W) {
  From       Str
  To         Str
  Weight     W
  IsDirected Bool
}

Graph(T, W) {
  Vertices List(Vertex(T))
  Edges    List(Edge(W))
}

DAG(T, W) Graph(T, W) & { IsAcyclic True }

// =============================================================================
// Matrices & Tensors
// =============================================================================

Matrix(T) {
  Rows Int
  Cols Int
  Data List(List(T))
}

Tensor(T) {
  Shape List(Int)
  Data  List(T)
}

// =============================================================================
// Algebraic Expressions & Catamorphisms
// =============================================================================

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

// =============================================================================
// Collection Operations & Transitions
// =============================================================================

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