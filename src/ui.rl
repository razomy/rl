#
Abstract UI Node, Layout Engine, Component Categories & Animation Contracts
#

MetricType "px" | "rem" | "em" | "vh" | "vw" | "percent" | "m" | "cm" | "mm" | "pt" | "dp"
MetricUnit { Value Float, Type MetricType }
Vector2Metric Vector2(MetricUnit)

Color4f        { R Float, G Float, B Float, A Float }
Color4b        { R Byte, G Byte, B Byte, A Byte }
Color3f        (Float, Float, Float)
RgbaColorFloat Color4f
ColorRGBA      Color4f

IUIBaseUin {
  Id              String
  Name            Option(String)
  Parent          Option(IdRef(UIUin))
  Children        List(IdRef(UIUin))
  ContainerLayout Option(UILayoutEngine)
  GridPlacement   Option(GridItemPlacement)
  FlexPlacement   Option(FlexItemPlacement)
  Style           Option(UIStyleBag)
  Interaction     Option(UIInteractionSpec)
}

Category   Any
Layout     Category
Forms      Category
Overlay    Category
Display    Category
Disclosure Category
Feedback   Category
Status     Category
Menu       Category
Navigation Category
DataViz    Category
MediaUi    Category

IAnimationHandler { Handle Any }
IAnimationTrack {
  From   Float
  Length Float
  To     Float
}

RouteValue   { Slug String, Payload Any }
RoutePath(T) { Segments List(T) }
RouteChange  Change(RoutePath(RouteValue))
IRouteEvent  IEvent & { Path RoutePath(RouteValue) }
