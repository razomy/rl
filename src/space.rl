#
Abstract Spatial Coordinates, Bounds, Transforms & Spatial States
#

X Real
Y Real
Z Real

Point2D  { X, Y }
Point3D  { X, Y, Z }
Vector2D { X, Y }
Vector3D { X, Y, Z }
Origin   Point3D & { X 0, Y 0, Z 0 }

Position    Point3D
Orientation { Yaw Angle, pitch Angle, roll Angle }
Pose        { Position, Orientation }

Area     Measure(Real & NonNegative, SquareMetre)
Volume   Measure(Real & NonNegative, CubicMetre)
Distance Length & [ _.Value >= 0 ]
Width    Length
Height   Length
Depth    Length
Radius   Length
Size     { Width, Height, Depth }

Bounds(T) {
  Min T
  Max T
}

BoundX(U)         { StartX U, finishX U }
BoundY(U)         { StartY U, finishY U }
BoundRectangle(U) BoundX(U) & BoundY(U)

ISize1 { XLength Float }
ISize2 ISize1 & { YWidth Float }
ISize3 ISize2 & { ZHeight Float }

Transform3d {
  Position VectorFloat3
  Rotation Quaternion
  Scale    VectorFloat3
}

Located    { Position }
Bounded    { Shape }
Contained  { Container Any }
Adjacent   { Neighbor Any }
Moving     { Position, velocity Vector3D }
Stationary { Position }
