#
Concrete Database Engines & DB Client Operations
#

DbEngine "postgres" | "mysql" | "sqlite" | "mongodb" | "redis" | "clickhouse" | "dynamodb" | "qdrant" | "neo4j" | "cassandra" | "cockroachdb" | "duckdb" | "rocksdb"

Cart {
  CartId String
  Amount Int
}

Db {
  Connect(cfg DbConfig)                 [ Cfg . native_db_connect ]
  Execute(sql String, params List(Any)) [ (Sql, Params) . native_db_execute ]
  Query(spec QuerySpec)                 [ Spec . native_db_query ]

  BeginTx(isolation IsolationLevel)     [ Isolation . native_db_begin_tx ]
  CommitTx(tx DbTransaction)            [ Tx . native_db_commit_tx ]
  RollbackTx(tx DbTransaction)          [ Tx . native_db_rollback_tx ]

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
