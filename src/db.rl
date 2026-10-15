_ meta
_ primitive
_ structure
_ network

// =============================================================================
// Database, Storage Engines, Queries & Transactions
// =============================================================================

DbEngine "postgres" | "mysql" | "sqlite" | "mongodb" | "redis" | "clickhouse" | "dynamodb" | "qdrant" | "neo4j" | "cassandra" | "cockroachdb" | "duckdb" | "rocksdb"

DbConfig {
  Engine     DbEngine

  Database   Str
  Username   Str
  Password   Str
  PoolSize   Int
  SslEnabled Bool
} & NetworkNode

IsolationLevel "read_uncommitted" | "read_committed" | "repeatable_read" | "serializable" | "snapshot"

DbTransaction {
  TxId         Str
  Isolation    IsolationLevel
  StartedAt    Int
  IsCommitted  Bool
  IsRolledBack Bool
}

DbError {
  Code    Str
  Message Str
  Query   Option(Str)
}

SortOrder "ASC" | "DESC"
FilterOp  "=" | "!=" | ">" | ">=" | "<" | "<=" | "IN" | "NOT_IN" | "LIKE" | "ILIKE" | "IS_NULL" | "IS_NOT_NULL" | "BETWEEN" | "CONTAINS"

QueryFilter {
  Field    Str
  Operator FilterOp
  Value    Any
}

JoinType "INNER" | "LEFT" | "RIGHT" | "FULL" | "CROSS"
QueryJoin {
  JoinType     JoinType
  TargetTable  Str
  OnLeftField  Str
  OnRightField Str
}

QuerySpec {
  Table   Str
  Select  List(Str)
  Joins   List(QueryJoin)
  Where   List(QueryFilter)
  GroupBy List(Str)
  OrderBy Map(Str, SortOrder)
  Limit   Option(Int)
  Offset  Option(Int)
}

Migration {
  Version   Int
  Name      Str
  UpSql     Str
  DownSql   Str
  AppliedAt Option(Int)
}

// =============================================================================
// High-Performance Columnar, Chunked & Graph Topology Storage
// =============================================================================

NodeId  Int
EdgeId  Str
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

// =============================================================================
// Event Sourcing, Vector Search & RAG Database
// =============================================================================

EventActionType "Create" | "Read" | "Update" | "Delete"
ConfigEvent     { Type EventActionType, Path List(Str), Value Any }
EventSourcing   { Events List(ConfigEvent) }

DistanceMetric "Cosine" | "Euclidean" | "DotProduct" | "Manhattan" | "Hamming"

VectorRecord {
  Id        Str
  Embedding List(Float)
  Metadata  Map(Str, Any)
}

VectorIndexConfig {
  CollectionName Str
  Dimensions     Int
  Metric         DistanceMetric
  HnswM          Int
  HnswEfConstruct Int
}

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
// Domain Models & DB Operations
// =============================================================================

Cart {
  CartId Str
  Amount Int
}

Db {
  Connect(Cfg DbConfig)              [ Cfg . native_db_connect ]
  Execute(Sql Str, Params List(Any)) [ (Sql, Params) . native_db_execute ]
  Query(Spec QuerySpec)              [ Spec . native_db_query ]

  BeginTx(Isolation IsolationLevel)  [ Isolation . native_db_begin_tx ]
  CommitTx(Tx DbTransaction)         [ Tx . native_db_commit_tx ]
  RollbackTx(Tx DbTransaction)       [ Tx . native_db_rollback_tx ]

  FindUser(Id) [
    { Id Id, Name "Alice", Age 25 }
  ]

  FindCart(Ctx) [
    Ctx . {
      Identifiable [ Cart { CartId "c101", Amount 2500 } ]
    }
  ]

  FindUserByToken(Token) [
    { Id "u1", Name "Alice", Age 25, Role "user", PasswordHash "hash" }
  ]
}
