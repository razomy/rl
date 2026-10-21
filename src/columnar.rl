#
Columnar Storage, chunked Grids, WAL, graph Topology & Vector Search
#

NodeId  Int
EdgeId  String
FieldId Int
OpCode  "SET_FIELD" | "ADD_NODE" | "CONNECT_EDGE" | "CLEAR_ELEMENT"
DbLayer "SYNTAX" | "SEMANTIC" | "TOPOLOGY" | "EXECUTION"

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
  Core         CoreDB
  NodeFirstOut Column
  NodeFirstIn  Column
  EdgeFrom     Column
  EdgeTo       Column
  EdgeLayer    Column
  EdgeNextOut  Column
  EdgeNextIn   Column
}

EventActionType "Create" | "Read" | "Update" | "Delete"
ConfigEvent     { Type EventActionType, path List(String), value Any }
EventSourcing   { Events List(ConfigEvent) }

DistanceMetric "Cosine" | "Euclidean" | "DotProduct" | "Manhattan" | "Hamming"

VectorRecord {
  Id        String
  Embedding List(Float)
  Metadata  Map(String, Any)
}

VectorIndexConfig {
  CollectionName  String
  Dimensions      Int
  Metric          DistanceMetric
  HnswM           Int
  HnswEfConstruct Int
}

ChunkSection { Id String, text String }
ChunkFile    { FilePath String, content String, commitId String, chunks List(ChunkSection) }

RagDbConfig {
  Neo4jUri       String
  Neo4jUser      String
  Neo4jPassword  String
  EmbeddingModel String
  VectorDim      Int
}
