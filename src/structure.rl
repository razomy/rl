#
Abstract Algebraic Data Types, Structural Traits & Containers
#

Tuple(T)        ()
Pair(A, B)      { First A, Second B }
Triple(A, B, C) { First A, Second B, Third C }

// Algebraic Sum Types
Some(T)   { Value T }
Option(T) Some(T) | None

Ok(T)        { Value T }
Err(E)       { Error E }
Result(T, E) Ok(T) | Err(E)

Left(L)      { Value L }
Right(R)     { Value R }
Either(L, R) Left(L) | Right(R)

// Base List
Nil  None
Cons(T) {
  Head T
  Tail List(T)
}
List(T) Nil | None | Cons(T)

// Base Maps & Sets
Map(K, V)      { (K) V }
Set(T)         { (T) Bool }
MultiMap(K, V) { (K) List(V) }
Bag(T)         { (T) Int }
BiMap(K, V)    { Forward Map(K, V), Backward Map(V, K) }

// Structural Hierarchy Traits
HasOrder(T)        { Prev Option(T), Next Option(T) }
HasParent(T)       { Parent Option(T) }
HasChildren(T)     { Children List(T) }
HasChildrenDict(T) { Children Dict(T) }

ProbabilisticDataStructure { Accuracy Float }

// Unified Sort / Order Direction (deduplicated from structure.rl and db.rl)
SortOrder      "ASC" | "DESC"
OrderDirection SortOrder
