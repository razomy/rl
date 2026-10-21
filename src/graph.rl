#
Graphs, Matrices, Tensors, Deltas & Algebraic Catamorphisms
#

OrderedEdge {
  VLow  Int
  VHigh Int
}

KeyEdge(TFrom, TTo) { From TFrom, to TTo }

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
BipartiteGraph(U, V, W) { LeftSet List(Vertex(U)), rightSet List(Vertex(V)), edges List(Edge(W)) }
Hyperedge(T)            { Id String, nodes List(Vertex(T)), weight Float }
Hypergraph(T)           { Vertices List(Vertex(T)), hyperedges List(Hyperedge(T)) }
EdgeListGraph(N, E)     { Nodes List(N), edges List((E, E)) }
GraphAdjacencyMatrix(T) { Vertices List(T), matrix List(List(Float)) }
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

RemoveDeltaString { Offset Int, removeLength Int }
AddDeltaString    { Offset Int, addValue String }
DeltaString       RemoveDeltaString | AddDeltaString

RemoveDeltaVrd { Path List(String), afterPath List(String), remove Bool }
AddDeltaVrd    { Path List(String), afterPath List(String), add VrdOrValue(String) }
DeltaVrd       RemoveDeltaVrd | AddDeltaVrd
