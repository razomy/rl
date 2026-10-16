_ primitive
_ primitive
_ structure

#
Mathematical Constants
#

PI           3.141592653589793
TAU          6.283185307179586
HALF_PI      1.5707963267948966
E            2.718281828459045
PHI          1.618033988749895
SQRT2        1.4142135623730951
SQRT3        1.7320508075688772
LN2          0.6931471805599453
LN10         2.302585092994046
EPSILON      1e-7
INFINITY     1e308
NEG_INFINITY -1e308

#
Fixed-Dimension Tuples, Vectors & Matrices
#

Int2   (Int, Int)
Int3   (Int, Int, Int)
Int4   (Int, Int, Int, Int)
Float2 (Float, Float)
Float3 (Float, Float, Float)
Float4 (Float, Float, Float, Float)

Vec2i Int2
Vec3i Int3
Vec4i Int4
Vec2f Float2
Vec3f Float3
Vec4f Float4

Vector1(T) { X T }
Vector2(T) { X T, Y T }
Vector3(T) { X T, Y T, Z T }
Vector4(T) { X T, Y T, Z T, W T }

VectorFloat1 Vector1(Float)
VectorFloat2 Vector2(Float)
VectorFloat3 Vector3(Float)
VectorFloat4 Vector4(Float)
VectorInt1   Vector1(Int)
VectorInt2   Vector2(Int)
VectorInt3   Vector3(Int)

Float2x2 (Float2, Float2)
Float3x3 (Float3, Float3, Float3)
Float4x2 (Float2, Float2, Float2, Float2)
Float4x4 (Float4, Float4, Float4, Float4)

Mat2x2 Float2x2
Mat3x3 Float3x3
Mat4x4 Float4x4

#
Rotations, Quaternions, Dual Quaternions & Spatial Algebra
#

AngleRadian    { Radian Float }
AngleDegree    { Degree Float }
AngleCartesian { Cos Float, Sin Float }

Quaternion {
  W Float
  X Float
  Y Float
  Z Float
}
Quat Quaternion

EulerOrder "XYZ" | "XZY" | "YXZ" | "YZX" | "ZXY" | "ZYX"
EulerXYZ   { X Float, Y Float, Z Float }
Euler      Float3

AxisAngle {
  Axis  Float3
  Angle Float
}

DualQuaternion {
  Quat        Quaternion
  Trans       Quaternion
  Scale       Float4x4
  ScaleWeight Float
  QuatWeight  Float
}
DualQuat DualQuaternion

Transform {
  X Float4
  Y Float4
  Z Float4
}

SpaceTransform {
  LocalToTarget Float4x4
  TargetToLocal Float4x4
}

Quadric {
  A2 Float, Ab Float, Ac Float, Ad Float
  B2 Float, Bc Float, Bd Float
  C2 Float, Cd Float
  D2 Float
}

SphericalHarmonicsL2 {
  L0  Float3
  L1a Float3
  L1b Float3
  L1c Float3
  L2  List(Float3)
}

#
Advanced Number Types & Curves
#

Complex {
  Real      Float
  Imaginary Float
}

Rational {
  Numerator   Int
  Denominator Int & NonZeroNumber
}

IntervalMath {
  Min Float
  Max Float
} & [ _.Max >= _.Min ]

Polynomial {
  Coefficients List(Float)
}

ICurve            { Evaluate Any }
LinearCurve       ICurve
DecelerateCurve   ICurve
InvertedCurve     ICurve
BounceInCurve     ICurve
BounceOutCurve    ICurve
BounceInOutCurve  ICurve
ElasticInCurve    ICurve & { Period Float }
ElasticOutCurve   ICurve & { Period Float }
ElasticInOutCurve ICurve & { Period Float }

CubicCurve ICurve & {
  X1         Float
  Y1         Float
  X2         Float
  Y2         Float
  ErrorBound Float
}

#
Procedural Noise & Voronoi Math
#

NoiseType "Perlin" | "Simplex" | "Worley" | "Voronoi" | "Value" | "Gabor" | "Wavelet" | "White"
FractalType "None" | "FBM" | "Multifractal" | "HybridMultifractal" | "HeteroTerrain" | "RidgedMultifractal"

VoronoiParams {
  Scale       Float
  Detail      Float
  Roughness   Float
  Lacunarity  Float
  Smoothness  Float
  Exponent    Float
  Randomness  Float
  MaxDistance Float
  Normalize   Bool
  Feature     Int
  Metric      Int
}

VoronoiOutput {
  Distance Float
  Color    Float3
  Position Float4
}

#
Arithmetic, Bitwise & Logic Operations
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

#
Elementary, Vector & Transcendental Functions
#

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

#
Vector & Complex Algebra Operations
#

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

#
Statistics & Probability Distributions
#

DescriptiveStats {
  Count    Int
  Mean     Float
  Median   Float
  Mode     Float
  Variance Float
  StdDev   Float
  Min      Float
  Max      Float
  Skewness Float
  Kurtosis Float
}

NormalDistribution      { Mean Float, StdDev Float }
LogNormalDistribution   { Mu Float, Sigma Float }
UniformDistribution     { Min Float, Max Float }
ExponentialDistribution { Rate Float }
PoissonDistribution     { Lambda Float }
BinomialDistribution    { Trials Int, Probability Float }
BetaDistribution        { Alpha Float, Beta Float }
GammaDistribution       { Shape Float, Scale Float }
ChiSquaredDistribution  { DegreesOfFreedom Int }
StudentTDistribution    { DegreesOfFreedom Float }
ParetoDistribution      { Scale Float, Shape Float }

Distribution
  NormalDistribution | LogNormalDistribution | UniformDistribution | ExponentialDistribution
  | PoissonDistribution | BinomialDistribution | BetaDistribution | GammaDistribution
  | ChiSquaredDistribution | StudentTDistribution | ParetoDistribution
