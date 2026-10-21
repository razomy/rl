#
Arithmetic, Elementary, Trigonometric & Vector Functions
#

MathOps(a Int, b Int) [
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

LogicOps(x Bool, y Bool, val Int) [
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
  Abs(x Float) [
    X . {
      [ _ < 0.0 ] [ 0.0 - X ]
      _           [ X ]
    }
  ]

  Sign(x Float) [
    X . {
      [ _ > 0.0 ] [ 1 ]
      [ _ < 0.0 ] [ -1 ]
      _           [ 0 ]
    }
  ]

  Min(a Float, b Float) [
    (A < B) . {
      true  [ A ]
      false [ B ]
    }
  ]

  Max(a Float, b Float) [
    (A > B) . {
      true  [ A ]
      false [ B ]
    }
  ]

  Clamp(val Float, low Float, high Float) [
    Val . Math.Max(Low) . Math.Min(High)
  ]

  Lerp(start Float, end Float, t Float) [
    Start + (End - Start) * T
  ]

  InverseLerp(start Float, end Float, val Float) [
    (Val - Start) / (End - Start)
  ]

  Remap(val Float, inMin Float, inMax Float, outMin Float, outMax Float) [
    Math.Lerp(OutMin, OutMax, Math.InverseLerp(InMin, InMax, Val))
  ]

  Smoothstep(edge0 Float, edge1 Float, x Float) [
    T (Math.Clamp((X - Edge0) / (Edge1 - Edge0), 0.0, 1.0))
    T * T * (3.0 - 2.0 * T)
  ]

  Floor(x Float) [ X . native_math_floor ]
  Ceil(x Float)  [ X . native_math_ceil ]
  Round(x Float) [ X . native_math_round ]
  Trunc(x Float) [ X . native_math_trunc ]
  Sqrt(x Float)  [ X . native_math_sqrt ]
  Cbrt(x Float)  [ X . native_math_cbrt ]
  Exp(x Float)   [ X . native_math_exp ]
  Ln(x Float)    [ X . native_math_ln ]
  Log10(x Float) [ X . native_math_log10 ]
  Log2(x Float)  [ X . native_math_log2 ]

  Sin(x Float)            [ X . native_math_sin ]
  Cos(x Float)            [ X . native_math_cos ]
  Tan(x Float)            [ X . native_math_tan ]
  Asin(x Float)           [ X . native_math_asin ]
  Acos(x Float)           [ X . native_math_acos ]
  Atan(x Float)           [ X . native_math_atan ]
  Atan2(y Float, x Float) [ (Y, X) . native_math_atan2 ]
  Sinh(x Float)           [ X . native_math_sinh ]
  Cosh(x Float)           [ X . native_math_cosh ]
  Tanh(x Float)           [ X . native_math_tanh ]

  DegToRad(deg Float) [ Deg * PI / 180.0 ]
  RadToDeg(rad Float) [ Rad * 180.0 / PI ]

  Factorial(n Int) [
    N . {
      [ _ <= 1 ] [ 1 ]
      _          [ N * Math.Factorial(N - 1) ]
    }
  ]

  Gcd(a Int, b Int) [
    B . {
      0 [ A ]
      _ [ Math.Gcd(B, A % B) ]
    }
  ]

  Lcm(a Int, b Int) [
    (A * B) / Math.Gcd(A, B)
  ]

  Fibonacci(n Int) [
    N . {
      0 [ 0 ]
      1 [ 1 ]
      _ [ Math.Fibonacci(N - 1) + Math.Fibonacci(N - 2) ]
    }
  ]
}

AddVec3(a VectorFloat3, b VectorFloat3) [
  VectorFloat3 { X (A.X + B.X), Y (A.Y + B.Y), Z (A.Z + B.Z) }
]

SubVec3(a VectorFloat3, b VectorFloat3) [
  VectorFloat3 { X (A.X - B.X), Y (A.Y - B.Y), Z (A.Z - B.Z) }
]

ScaleVec3(v VectorFloat3, factor Float) [
  VectorFloat3 { X (V.X * Factor), Y (V.Y * Factor), Z (V.Z * Factor) }
]

DotVec3(a VectorFloat3, b VectorFloat3) [
  (A.X * B.X) + (A.Y * B.Y) + (A.Z * B.Z)
]

CrossVec3(a VectorFloat3, b VectorFloat3) [
  VectorFloat3 {
    X (A.Y * B.Z - A.Z * B.Y)
    Y (A.Z * B.X - A.X * B.Z)
    Z (A.X * B.Y - A.Y * B.X)
  }
]

ComplexAdd(a Complex, b Complex) [
  Complex { Real (A.Real + B.Real), Imaginary (A.Imaginary + B.Imaginary) }
]

ComplexMul(a Complex, b Complex) [
  Complex {
    Real      (A.Real * B.Real - A.Imaginary * B.Imaginary)
    Imaginary (A.Real * B.Imaginary + A.Imaginary * B.Real)
  }
]

ComplexConjugate(c Complex) [
  Complex { Real C.Real, Imaginary (0.0 - C.Imaginary) }
]
