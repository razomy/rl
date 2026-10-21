#
Concrete Bounds, Rays, Planes, Directions & Geodesy
#

Rcti  { Xmin Int, xmax Int, ymin Int, ymax Int }
Rctf  { Xmin Float, xmax Float, ymin Float, ymax Float }
RectI { XMin Int, xMax Int, yMin Int, yMax Int }
RectF { XMin Float, xMax Float, yMin Float, yMax Float }

Bounds2f { Min Vec2f, max Vec2f }
Bounds3f { Min Vec3f, max Vec3f }
BoundBox { Corners List(Vec3f) }

SizeAttribute     IAttribute & ISize3
PositionAttribute IAttribute & VectorFloat3
PivotAttribute    IAttribute & VectorFloat3
RotationAttribute IAttribute & { XDeg Float, yDeg Float, zDeg Float }
ScaleAttribute    IAttribute & { XScale Float, yScale Float, zScale Float }

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

Ray2D   { Origin Point2D, direction Vector2D }
Ray3D   { Origin Point3D, direction Vector3D, maxDistance Float }
Plane3D { Normal Vector3D, distance Float }
Frustum { Planes (Plane3D, Plane3D, Plane3D, Plane3D, Plane3D, Plane3D) }

SphericalAxis       "RadialDistance" | "PolarAngle" | "AzimuthalAngle"
SphericalCoordinate { Radial Float, polar Float, azimuthal Float }
CylindricalCoord    { Radial Float, azimuth Float, z Float }
BarycentricCoord    { U Float, v Float, w Float }
UvCoord             { U Float, v Float }

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
GeoBox        { SouthWest GeoCoordinate, northEast GeoCoordinate }
GeoCircle     { Center GeoCoordinate, Radius }
GeoPolygon    { Vertices List(GeoCoordinate) }
GeoShape      GeoBox | GeoCircle | GeoPolygon | GeoPath

UtmCoordinate { ZoneNumber Int, zoneLetter Char, easting Float, northing Float }
GeoHash       String
