_ primitives

MathOps(A Int, B Int) [
  {
    Add (A + B)
    Sub (A - B)
    Mul (A * B)
    Div (A / B)
    Mod (A % B)
    Pow (A ** B)

    BitAnd (A . bit_and(B))
    BitOr  (A . bit_or(B))
    BitXor (A . bit_xor(B))
    ShiftL (A << 2)
    ShiftR (A >> 2)
  }
]

LogicOps(X Bool, Y Bool, Val Int) [
  {
    And (X && Y)
    Or  (X || Y)
    Not (!X)
    Eq  (Val == 42)
    Neq (Val != 0)
    Gt  (Val > 10)
    Gte (Val >= 10)
    Lt  (Val < 100)
    Lte (Val <= 100)
    InRange (Val . (1..100))
  }
]
