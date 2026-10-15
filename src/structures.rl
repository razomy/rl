_ primitives

Identifiable { Id Str }
Auditable    { CreatedAt Int, UpdatedAt Int }

// Tuples
Point2D (Float, Float)
Origin  (0.0, 0.0)
Tuple(T) ()

// Generic Collections and Data Structures
None {}
Cons(T) {
  Head T
  Tail List(T)
}
List(T) None | Cons(T)

Leaf {}
Node(T) {
  Value T
  Left  Tree(T)
  Right Tree(T)
}
Tree(T) Leaf | Node(T)

Map(K, V) { (K) V }
Set(T)    { (T) Bool }

Some(T)   { Value T }
Option(T) Some(T) | None

// Algebraic Expressions
Num(Val)  { Value Val }
Add(L, R) { Left L, Right R }
Mul(L, R) { Left L, Right R }
Expr      Num | Add(Expr, Expr) | Mul(Expr, Expr)
