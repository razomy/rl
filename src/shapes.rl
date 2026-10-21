#
2D & 3D Geometric Shapes, spatial Partitioning & Transitions
#

Circle         { Center Point2D, Radius }
Rectangle      { Corner Point2D, Width, Height }
Rect           Rectangle
Triangle       { A Point2D, b Point2D, c Point2D }
Polygon        { Vertices List(Point2D) }
Ellipse        { Center Point2D, semiMajor Length, semiMinor Length }
Capsule2D      { Start Point2D, end Point2D, radius Length }
BezierCurve2D  { P0 Point2D, p1 Point2D, p2 Point2D, p3 Point2D }
RegularPolygon { Center Point2D, radius Length, sides Count }
Hexagon        RegularPolygon & { Sides 6 }
Shape2D        Circle | Rectangle | Triangle | Polygon | Ellipse | Capsule2D | RegularPolygon

Sphere         { Center Point3D, Radius }
Cuboid         { Corner Point3D, Size }
Cylinder       { Base Point3D, Radius, Height }
Cone           { Base Point3D, Radius, Height }
Capsule3D      { Start Point3D, end Point3D, radius Length }
Torus          { Center Point3D, majorRadius Length, minorRadius Length }
Tetrahedron    { V0 Point3D, v1 Point3D, v2 Point3D, v3 Point3D }
Octahedron     { Center Point3D, radius Length }
Dodecahedron   { Center Point3D, radius Length }
Icosahedron    { Center Point3D, radius Length }
HexagonalPrism { Base Hexagon, height Length }
Mesh           { Vertices List(Point3D), faces List(List(Index)) }
Shape3D        Sphere | Cuboid | Cylinder | Cone | Capsule3D | Torus | Tetrahedron | Octahedron | Dodecahedron | Icosahedron | HexagonalPrism | Mesh

Shape Shape2D | Shape3D

CalculateArea(s Shape2D) [
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

Translate(p Point3D, v Vector3D) [
  Point3D { X (X + V.X), Y (Y + V.Y), Z (Z + V.Z) }
]

Move(l Located, v Vector3D) [
  L & Located { Position (Position . Translate(V)) }
]

Accelerate(s Stationary, v Vector3D) [
  S / Stationary & Moving { Position, velocity V }
]

Halt(m Moving) [
  M / Moving & Stationary { Position }
]

Put(item Any, into Any) [
  Item & Contained { Container Into }
]

Remove(c Contained) [
  C / Contained
]
