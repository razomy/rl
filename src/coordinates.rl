#
Concrete Bounds, Rays, Planes, Directions & Geodesy
#

Rcti  { Xmin Int, Xmax Int, Ymin Int, Ymax Int }
Rctf  { Xmin Float, Xmax Float, Ymin Float, Ymax Float }
RectI { XMin Int, XMax Int, YMin Int, YMax Int }
RectF { XMin Float, XMax Float, YMin Float, YMax Float }

Bounds2f { Min Vec2f, Max Vec2f }
Bounds3f { Min Vec3f, Max Vec3f }
BoundBox { Corners List(Vec3f) }

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

FlexibleTransform Transform3d & {
  Anchors AnchorAttribute
  Size    SizeAttribute
  Pivot   PivotAttribute
}

Ray2D   { Origin Point2D, Direction Vector2D }
Ray3D   { Origin Point3D, Direction Vector3D, MaxDistance Float }
Plane3D { Normal Vector3D, Distance Float }
Frustum { Planes (Plane3D, Plane3D, Plane3D, Plane3D, Plane3D, Plane3D) }

SphericalAxis       "RadialDistance" | "PolarAngle" | "AzimuthalAngle"
SphericalCoordinate { Radial Float, Polar Float, Azimuthal Float }
CylindricalCoord    { Radial Float, Azimuth Float, Z Float }
BarycentricCoord    { U Float, V Float, W Float }
UvCoord             { U Float, V Float }

CardinalDirection "north" | "east" | "south" | "west"
CompassDirection  CardinalDirection | "northeast" | "southeast" | "southwest" | "northwest"
RelativeDirection "up" | "down" | "left" | "right" | "forward" | "backward" | "inside" | "outside"
AxisSigned        "PosX" | "PosY" | "PosZ" | "NegX" | "NegY" | "NegZ"
Direction         CompassDirection | RelativeDirection | Vector3D
Bearing           Range(0, 360) & Real

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
