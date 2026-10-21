#
Abstract Algebraic Data Types, structural Traits & Containers
#

Tuple(T)        Any
Pair(A, B)      { First A, second B }
Triple(A, B, C) { First A, second B, third C }
Array(T)   Tuple

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
BiMap(K, V)    { Forward Map(K, V), backward Map(V, K) }

// Structural Hierarchy Traits
HasOrder(T)        { Prev Option(T), next Option(T) }
HasParent(T)       { Parent Option(T) }
HasChildren(T)     { Children List(T) }
HasChildrenDict(T) { Children Dict(T) }

ProbabilisticDataStructure { Accuracy Float }

// Unified Sort / Order Direction (deduplicated from structure.rl and db.rl)
SortOrder      "ASC" | "DESC"
OrderDirection SortOrder


// Collection Operations & Transitions
OptionMap(opt, fn) [
  opt . {
    None [ None ]
    Some [ Some { Value (Value . fn) } ]
  }
]

OptionUnwrapOr(Opt, Default) [
  _ . {
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

StackPush(s Stack, Item) [
  Stack { Items (Cons { Head Item, tail s.Items }), Size (S.Size + 1) }
]

StackPop(s Stack) [
  s.Items . {
    Nil  [ Pair { First None, second s } ]
    Cons [ Pair { First (Some { Value Head }), Second (Stack { Items Tail, Size (S.Size - 1) }) } ]
  }
]
