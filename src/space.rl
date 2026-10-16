_ primitive
_ primitive
_ structure
_ math
_ quantity

#
Coordinates, Vectors & Bounds
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
Orientation { Yaw Angle, Pitch Angle, Roll Angle }
Pose        { Position, Orientation }

Area     Measure(Real & NonNegative, SquareMetre)
Volume   Measure(Real & NonNegative, CubicMetre)
Distance Length & [ _.Value >= 0 ]
Width    Length
Height   Length
Depth    Length
Radius   Length
Size     { Width, Height, Depth }

Rcti  { Xmin Int, Xmax Int, Ymin Int, Ymax Int }
Rctf  { Xmin Float, Xmax Float, Ymin Float, Ymax Float }
RectI { XMin Int, XMax Int, YMin Int, YMax Int }
RectF { XMin Float, XMax Float, YMin Float, YMax Float }

Bounds(T) {
  Min T
  Max T
}

Bounds2f { Min Vec2f, Max Vec2f }
Bounds3f { Min Vec3f, Max Vec3f }
BoundBox { Corners List(Vec3f) }

BoundX(U)         { StartX U, FinishX U }
BoundY(U)         { StartY U, FinishY U }
BoundRectangle(U) BoundX(U) & BoundY(U)

ISize1 { XLength Float }
ISize2 ISize1 & { YWidth Float }
ISize3 ISize2 & { ZHeight Float }

SizeAttribute     IAttribute & ISize3
PositionAttribute IAttribute & VectorFloat3
PivotAttribute    IAttribute & VectorFloat3
RotationAttribute IAttribute & { XDeg Float, YDeg Float, ZDeg Float }
ScaleAttribute    IAttribute & { XScale Float, YScale Float, ZScale Float }

AnchorAttribute IAttribute & {
  XStart  Float
  YStart  Float
  ZStart  Float
  XFinish Float
  YFinish Float
  ZFinish Float
}

Transform3d {
  Position VectorFloat3
  Rotation Quaternion
  Scale    VectorFloat3
}

FlexibleTransform Transform3d & {
  Anchors AnchorAttribute
  Size    SizeAttribute
  Pivot   PivotAttribute
}

#
Rays, Planes, Frustums & Coordinate Systems
#

Ray2D   { Origin Point2D, Direction Vector2D }
Ray3D   { Origin Point3D, Direction Vector3D, MaxDistance Float }
Plane3D { Normal Vector3D, Distance Float }
Frustum { Planes (Plane3D, Plane3D, Plane3D, Plane3D, Plane3D, Plane3D) }

SphericalAxis       "RadialDistance" | "PolarAngle" | "AzimuthalAngle"
SphericalCoordinate { Radial Float, Polar Float, Azimuthal Float }
CylindricalCoord    { Radial Float, Azimuth Float, Z Float }
BarycentricCoord    { U Float, V Float, W Float }
UvCoord             { U Float, V Float }

#
Directions
#

CardinalDirection "north" | "east" | "south" | "west"
CompassDirection  CardinalDirection | "northeast" | "southeast" | "southwest" | "northwest"
RelativeDirection "up" | "down" | "left" | "right" | "forward" | "backward" | "inside" | "outside"
AxisSigned        "PosX" | "PosY" | "PosZ" | "NegX" | "NegY" | "NegZ"
Direction         CompassDirection | RelativeDirection | Vector3D
Bearing           Range(0, 360) & Real

#
Geography & Geodesy
#

Latitude  Range(-90, 90) & Real
Longitude Range(-180, 180) & Real
Elevation Length

GeoCoordinate { Latitude, Longitude, Elevation }
GeoPath       List(GeoCoordinate)
GeoBox        { SouthWest GeoCoordinate, NorthEast GeoCoordinate }
GeoCircle     { Center GeoCoordinate, Radius }
GeoPolygon    { Vertices List(GeoCoordinate) }
GeoShape      GeoBox | GeoCircle | GeoPolygon | GeoPath

UtmCoordinate { ZoneNumber Int, ZoneLetter Char, Easting Float, Northing Float }
GeoHash       String

#
Shapes (2D & 3D)
#

Circle         { Center Point2D, Radius }
Rectangle      { Corner Point2D, Width, Height }
Rect           Rectangle
Triangle       { A Point2D, B Point2D, C Point2D }
Polygon        { Vertices List(Point2D) }
Ellipse        { Center Point2D, SemiMajor Length, SemiMinor Length }
Capsule2D      { Start Point2D, End Point2D, Radius Length }
BezierCurve2D  { P0 Point2D, P1 Point2D, P2 Point2D, P3 Point2D }
RegularPolygon { Center Point2D, Radius Length, Sides Count }
Hexagon        RegularPolygon & { Sides 6 }
Shape2D        Circle | Rectangle | Triangle | Polygon | Ellipse | Capsule2D | RegularPolygon

Sphere         { Center Point3D, Radius }
Cuboid         { Corner Point3D, Size }
Cylinder       { Base Point3D, Radius, Height }
Cone           { Base Point3D, Radius, Height }
Capsule3D      { Start Point3D, End Point3D, Radius Length }
Torus          { Center Point3D, MajorRadius Length, MinorRadius Length }
Tetrahedron    { V0 Point3D, V1 Point3D, V2 Point3D, V3 Point3D }
Octahedron     { Center Point3D, Radius Length }
Dodecahedron   { Center Point3D, Radius Length }
Icosahedron    { Center Point3D, Radius Length }
HexagonalPrism { Base Hexagon, Height Length }
Mesh           { Vertices List(Point3D), Faces List(List(Index)) }
Shape3D        Sphere | Cuboid | Cylinder | Cone | Capsule3D | Torus | Tetrahedron | Octahedron | Dodecahedron | Icosahedron | HexagonalPrism | Mesh

Shape Shape2D | Shape3D

CalculateArea(S Shape2D) [
  S . {
    Circle    [ 3.141592653589793 * Radius * Radius ]
    Rectangle [ Width * Height ]
    Ellipse   [ 3.141592653589793 * SemiMajor * SemiMinor ]
  }
]

#
Spatial Partitioning (QuadTree & Octree)
#

QuadTreeNode(T) {
  Bounds   RectF
  Items    List(T)
  Children Option((QuadTreeNode(T), QuadTreeNode(T), QuadTreeNode(T), QuadTreeNode(T)))
}

QuadTree(T) {
  Root     Option(QuadTreeNode(T))
  Bounds   RectF
  Capacity Int
}

OctreeNode(T) {
  Bounds   Bounds3f
  Items    List(T)
  Children Option(List(OctreeNode(T)))
}

Octree(T) {
  Root     Option(OctreeNode(T))
  Bounds   Bounds3f
  Capacity Int
}

#
Spatial States & Transitions
#

Located    { Position }
Bounded    { Shape }
Contained  { Container Any }
Adjacent   { Neighbor Any }
Moving     { Position, Velocity Vector3D }
Stationary { Position }

Translate(P Point3D, V Vector3D) [
  Point3D { X (X + V.X), Y (Y + V.Y), Z (Z + V.Z) }
]

Move(L Located, V Vector3D) [
  L & Located { Position (Position . Translate(V)) }
]

Accelerate(S Stationary, V Vector3D) [
  S / Stationary & Moving { Position, Velocity V }
]

Halt(M Moving) [
  M / Moving & Stationary { Position }
]

Put(Item Any, Into Any) [
  Item & Contained { Container Into }
]

Remove(C Contained) [
  C / Contained
]
