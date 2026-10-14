_ meta
_ primitives
_ structures
_ core.quantity

// =============================================================================
// Coordinates and vectors
// =============================================================================

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

// =============================================================================
// Directions
// =============================================================================

CardinalDirection "north" | "east" | "south" | "west"
CompassDirection CardinalDirection | "northeast" | "southeast" | "southwest" | "northwest"
RelativeDirection "up" | "down" | "left" | "right" | "forward" | "backward" | "inside" | "outside"
Direction CompassDirection | RelativeDirection | Vector3D
Bearing Range(0, 360) & Real

// =============================================================================
// Geography
// =============================================================================

Latitude  Range(-90, 90) & Real
Longitude Range(-180, 180) & Real
Elevation Length

GeoCoordinate { Latitude, Longitude, Elevation }
GeoPath       List(GeoCoordinate)
GeoBox        { SouthWest GeoCoordinate, NorthEast GeoCoordinate }
GeoCircle     { Center GeoCoordinate, Radius }
GeoPolygon    { Vertices List(GeoCoordinate) }
GeoShape      GeoBox | GeoCircle | GeoPolygon | GeoPath

// =============================================================================
// Shapes
// =============================================================================

Circle    { Center Point2D, Radius }
Rectangle { Corner Point2D, Width, Height }
Triangle  { A Point2D, B Point2D, C Point2D }
Polygon   { Vertices List(Point2D) }
Ellipse   { Center Point2D, SemiMajor Length, SemiMinor Length }
Shape2D   Circle | Rectangle | Triangle | Polygon | Ellipse

Sphere   { Center Point3D, Radius }
Cuboid   { Corner Point3D, Size }
Cylinder { Base Point3D, Radius, Height }
Cone     { Base Point3D, Radius, Height }
Torus    { Center Point3D, MajorRadius Length, MinorRadius Length }
Mesh     { Vertices List(Point3D), Faces List(List(Index)) }
Shape3D  Sphere | Cuboid | Cylinder | Cone | Torus | Mesh

Shape Shape2D | Shape3D

// =============================================================================
// Spatial states
// =============================================================================

Located   { Position }
Bounded   { Shape }
Contained { Container Any }
Adjacent  { Neighbor Any }
Moving    { Position, Velocity Vector3D }
Stationary { Position }

// =============================================================================
// Transitions
// =============================================================================

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
