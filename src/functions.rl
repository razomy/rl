
#
Arithmetic, Elementary, Trigonometric & Vector Functions
#

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
    And     (X && Y)
    Or      (X || Y)
    Xor     ((X || Y) && !(X && Y))
    Nand    (!(X && Y))
    Nor     (!(X || Y))
    Not     (!X)
    Eq      (Val == 42)
    Neq     (Val != 0)
    Gt      (Val > 10)
    Gte     (Val >= 10)
    Lt      (Val < 100)
    Lte     (Val <= 100)
    InRange (Val . (1..100))
  }
]

Math {
  Abs(X Float) [
    X . {
      [ _ < 0.0 ] [ 0.0 - X ]
      _           [ X ]
    }
  ]

  Sign(X Float) [
    X . {
      [ _ > 0.0 ] [ 1 ]
      [ _ < 0.0 ] [ -1 ]
      _           [ 0 ]
    }
  ]

  Min(A Float, B Float) [
    (A < B) . {
      true  [ A ]
      false [ B ]
    }
  ]

  Max(A Float, B Float) [
    (A > B) . {
      true  [ A ]
      false [ B ]
    }
  ]

  Clamp(Val Float, Low Float, High Float) [
    Val . Math.Max(Low) . Math.Min(High)
  ]

  Lerp(Start Float, End Float, T Float) [
    Start + (End - Start) * T
  ]

  InverseLerp(Start Float, End Float, Val Float) [
    (Val - Start) / (End - Start)
  ]

  Remap(Val Float, InMin Float, InMax Float, OutMin Float, OutMax Float) [
    Math.Lerp(OutMin, OutMax, Math.InverseLerp(InMin, InMax, Val))
  ]

  Smoothstep(Edge0 Float, Edge1 Float, X Float) [
    T (Math.Clamp((X - Edge0) / (Edge1 - Edge0), 0.0, 1.0))
    T * T * (3.0 - 2.0 * T)
  ]

  Floor(X Float) [ X . native_math_floor ]
  Ceil(X Float)  [ X . native_math_ceil ]
  Round(X Float) [ X . native_math_round ]
  Trunc(X Float) [ X . native_math_trunc ]
  Sqrt(X Float)  [ X . native_math_sqrt ]
  Cbrt(X Float)  [ X . native_math_cbrt ]
  Exp(X Float)   [ X . native_math_exp ]
  Ln(X Float)    [ X . native_math_ln ]
  Log10(X Float) [ X . native_math_log10 ]
  Log2(X Float)  [ X . native_math_log2 ]

  Sin(X Float)            [ X . native_math_sin ]
  Cos(X Float)            [ X . native_math_cos ]
  Tan(X Float)            [ X . native_math_tan ]
  Asin(X Float)           [ X . native_math_asin ]
  Acos(X Float)           [ X . native_math_acos ]
  Atan(X Float)           [ X . native_math_atan ]
  Atan2(Y Float, X Float) [ (Y, X) . native_math_atan2 ]
  Sinh(X Float)           [ X . native_math_sinh ]
  Cosh(X Float)           [ X . native_math_cosh ]
  Tanh(X Float)           [ X . native_math_tanh ]

  DegToRad(Deg Float) [ Deg * PI / 180.0 ]
  RadToDeg(Rad Float) [ Rad * 180.0 / PI ]

  Factorial(N Int) [
    N . {
      [ _ <= 1 ] [ 1 ]
      _          [ N * Math.Factorial(N - 1) ]
    }
  ]

  Gcd(A Int, B Int) [
    B . {
      0 [ A ]
      _ [ Math.Gcd(B, A % B) ]
    }
  ]

  Lcm(A Int, B Int) [
    (A * B) / Math.Gcd(A, B)
  ]

  Fibonacci(N Int) [
    N . {
      0 [ 0 ]
      1 [ 1 ]
      _ [ Math.Fibonacci(N - 1) + Math.Fibonacci(N - 2) ]
    }
  ]
}

AddVec3(A VectorFloat3, B VectorFloat3) [
  VectorFloat3 { X (A.X + B.X), Y (A.Y + B.Y), Z (A.Z + B.Z) }
]

SubVec3(A VectorFloat3, B VectorFloat3) [
  VectorFloat3 { X (A.X - B.X), Y (A.Y - B.Y), Z (A.Z - B.Z) }
]

ScaleVec3(V VectorFloat3, Factor Float) [
  VectorFloat3 { X (V.X * Factor), Y (V.Y * Factor), Z (V.Z * Factor) }
]

DotVec3(A VectorFloat3, B VectorFloat3) [
  (A.X * B.X) + (A.Y * B.Y) + (A.Z * B.Z)
]

CrossVec3(A VectorFloat3, B VectorFloat3) [
  VectorFloat3 {
    X (A.Y * B.Z - A.Z * B.Y)
    Y (A.Z * B.X - A.X * B.Z)
    Z (A.X * B.Y - A.Y * B.X)
  }
]

ComplexAdd(A Complex, B Complex) [
  Complex { Real (A.Real + B.Real), Imaginary (A.Imaginary + B.Imaginary) }
]

ComplexMul(A Complex, B Complex) [
  Complex {
    Real      (A.Real * B.Real - A.Imaginary * B.Imaginary)
    Imaginary (A.Real * B.Imaginary + A.Imaginary * B.Real)
  }
]

ComplexConjugate(C Complex) [
  Complex { Real C.Real, Imaginary (0.0 - C.Imaginary) }
]
