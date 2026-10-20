#
Concrete Database Engines & DB Client Operations
#

DbEngine "postgres" | "mysql" | "sqlite" | "mongodb" | "redis" | "clickhouse" | "dynamodb" | "qdrant" | "neo4j" | "cassandra" | "cockroachdb" | "duckdb" | "rocksdb"

Cart {
  CartId String
  Amount Int
}

Db {
  Connect(Cfg DbConfig)                 [ Cfg . native_db_connect ]
  Execute(Sql String, Params List(Any)) [ (Sql, Params) . native_db_execute ]
  Query(Spec QuerySpec)                 [ Spec . native_db_query ]

  BeginTx(Isolation IsolationLevel)     [ Isolation . native_db_begin_tx ]
  CommitTx(Tx DbTransaction)            [ Tx . native_db_commit_tx ]
  RollbackTx(Tx DbTransaction)          [ Tx . native_db_rollback_tx ]

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
