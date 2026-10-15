_ meta
_ primitives
_ structures

// =============================================================================
// Database, Storage Engines, Queries & Transactions
// =============================================================================

DbEngine "postgres" | "mysql" | "sqlite" | "mongodb" | "redis" | "clickhouse" | "dynamodb" | "qdrant"

DbConfig {
  Engine       DbEngine
  Host         Str
  Port         Int
  Database     Str
  Username     Str
  Password     Str
  PoolSize     Int
  SslEnabled   Bool
}

IsolationLevel "read_uncommitted" | "read_committed" | "repeatable_read" | "serializable"

DbTransaction {
  TxId           Str
  Isolation      IsolationLevel
  StartedAt      Int
  IsCommitted    Bool
  IsRolledBack   Bool
}

DbError {
  Code    Str
  Message Str
  Query   Option(Str)
}

SortOrder "ASC" | "DESC"
FilterOp  "=" | "!=" | ">" | ">=" | "<" | "<=" | "IN" | "LIKE" | "IS_NULL" | "IS_NOT_NULL"

QueryFilter {
  Field    Str
  Operator FilterOp
  Value    Any
}

QuerySpec {
  Table   Str
  Select  List(Str)
  Where   List(QueryFilter)
  OrderBy Map(Str, SortOrder)
  Limit   Option(Int)
  Offset  Option(Int)
}

Migration {
  Version     Int
  Name        Str
  UpSql       Str
  DownSql     Str
  AppliedAt   Option(Int)
}

// Vector Search (Embeddings)
VectorRecord {
  Id        Str
  Embedding List(Float)
  Metadata  Map(Str, Any)
}

// Domain Models
Cart {
  CartId Str
  Amount Int
}

Db {
  Connect(Cfg DbConfig)             [ Cfg . native_db_connect ]
  Execute(Sql Str, Params List(Any))[ (Sql, Params) . native_db_execute ]
  Query(Spec QuerySpec)             [ Spec . native_db_query ]

  BeginTx(Isolation IsolationLevel) [ Isolation . native_db_begin_tx ]
  CommitTx(Tx DbTransaction)        [ Tx . native_db_commit_tx ]
  RollbackTx(Tx DbTransaction)      [ Tx . native_db_rollback_tx ]

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