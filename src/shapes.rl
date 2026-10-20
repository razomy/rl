#
2D & 3D Geometric Shapes, Spatial Partitioning & Transitions
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
