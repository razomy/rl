_ meta
_ primitives
_ structures

// =============================================================================
// Mathematical Constants
// =============================================================================

PI          3.141592653589793
TAU         6.283185307179586
E           2.718281828459045
PHI         1.618033988749895
SQRT2       1.4142135623730951
SQRT3       1.7320508075688772
LN2         0.6931471805599453
LN10        2.302585092994046
INFINITY    1e308
NEG_INFINITY -1e308

// =============================================================================
// Advanced Number Types
// =============================================================================

Complex {
  Real      Float
  Imaginary Float
}

Rational {
  Numerator   Int
  Denominator Int & NonZeroNumber
}

Quaternion {
  W Float
  X Float
  Y Float
  Z Float
}

IntervalMath {
  Min Float
  Max Float
} & [ _.Max >= _.Min ]

Polynomial {
  Coefficients List(Float)
}

// =============================================================================
// Arithmetic, Bitwise & Logic Operations
// =============================================================================

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

// =============================================================================
// Elementary & Transcendental Functions
// =============================================================================

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

  // Trigonometry
  Sin(X Float)   [ X . native_math_sin ]
  Cos(X Float)   [ X . native_math_cos ]
  Tan(X Float)   [ X . native_math_tan ]
  Asin(X Float)  [ X . native_math_asin ]
  Acos(X Float)  [ X . native_math_acos ]
  Atan(X Float)  [ X . native_math_atan ]
  Atan2(Y Float, X Float) [ (Y, X) . native_math_atan2 ]
  Sinh(X Float)  [ X . native_math_sinh ]
  Cosh(X Float)  [ X . native_math_cosh ]
  Tanh(X Float)  [ X . native_math_tanh ]

  DegToRad(Deg Float) [ Deg * PI / 180.0 ]
  RadToDeg(Rad Float) [ Rad * 180.0 / PI ]

  // Number Theory & Combinatorics
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

// =============================================================================
// Complex & Linear Algebra Operations
// =============================================================================

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

// =============================================================================
// Statistics & Probability Distributions
// =============================================================================

DescriptiveStats {
  Count    Int
  Mean     Float
  Median   Float
  Mode     Float
  Variance Float
  StdDev   Float
  Min      Float
  Max      Float
}

NormalDistribution   { Mean Float, StdDev Float }
UniformDistribution  { Min Float, Max Float }
PoissonDistribution  { Lambda Float }
BinomialDistribution { Trials Int, Probability Float }
Distribution         NormalDistribution | UniformDistribution | PoissonDistribution | BinomialDistribution