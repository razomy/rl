
#
Graphs, Matrices, Tensors, Deltas & Algebraic Catamorphisms
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

DAG(T, W)               Graph(T, W) & { IsAcyclic True }
BipartiteGraph(U, V, W) { LeftSet List(Vertex(U)), RightSet List(Vertex(V)), Edges List(Edge(W)) }
Hyperedge(T)            { Id String, Nodes List(Vertex(T)), Weight Float }
Hypergraph(T)           { Vertices List(Vertex(T)), Hyperedges List(Hyperedge(T)) }
EdgeListGraph(N, E)     { Nodes List(N), Edges List((E, E)) }
GraphAdjacencyMatrix(T) { Vertices List(T), Matrix List(List(Float)) }
GraphAdjacencyList(T)   { AdjacencyMap Map(T, List(T)) }

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

// Algebraic Expressions & Catamorphisms
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

// Collection Operations & Transitions
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
