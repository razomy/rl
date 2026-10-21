#
Mathematical Constants, Vectors, Matrices & Quaternions
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

AngleRadian    { Radian Float }
AngleDegree    { Degree Float }
AngleCartesian { Cos Float, sin Float }

Quaternion {
  W Float
  X Float
  Y Float
  Z Float
}
Quat Quaternion

EulerOrder "XYZ" | "XZY" | "YXZ" | "YZX" | "ZXY" | "ZYX"
EulerXYZ   { X Float, y Float, z Float }
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
  A2 Float, ab Float, ac Float, ad Float
  B2 Float, bc Float, bd Float
  C2 Float, cd Float
  D2 Float
}

SphericalHarmonicsL2 {
  L0  Float3
  L1a Float3
  L1b Float3
  L1c Float3
  L2  List(Float3)
}
