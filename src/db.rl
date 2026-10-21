#
Abstract Database Config, Transactions & Query Specifications
#

IsolationLevel "read_uncommitted" | "read_committed" | "repeatable_read" | "serializable" | "snapshot"

DbConfig {
  Engine     DbEngine
  Database   String
  Username   String
  Password   String
  PoolSize   Int
  SslEnabled Bool
} & NetworkNode

DbTransaction {
  TxId         String
  Isolation    IsolationLevel
  StartedAt    Int
  IsCommitted  Bool
  IsRolledBack Bool
}

DbError {
  Code    String
  Message String
  Query   Option(String)
}

FilterOp "=" | "!=" | ">" | ">=" | "<" | "<=" | "IN" | "NOT_IN" | "LIKE" | "ILIKE" | "IS_NULL" | "IS_NOT_NULL" | "BETWEEN" | "CONTAINS"

QueryFilter {
  Field    String
  Operator FilterOp
  Value    Any
}

JoinType "INNER" | "LEFT" | "RIGHT" | "FULL" | "CROSS"
QueryJoin {
  JoinType     JoinType
  TargetTable  String
  OnLeftField  String
  OnRightField String
}

QuerySpec {
  Table   String
  Select  List(String)
  Joins   List(QueryJoin)
  Where   List(QueryFilter)
  GroupBy List(String)
  OrderBy Map(String, SortOrder)
  Limit   Option(Int)
  Offset  Option(Int)
}

Migration {
  Version   Int
  Name      String
  UpSql     String
  DownSql   String
  AppliedAt Option(Int)
}
