_ meta
_ primitive
_ structure
_ math
_ space
_ energy
_ state

// =============================================================================
// Units, Colors, Paint & Design Tokens
// =============================================================================

MetricType "px" | "rem" | "em" | "vh" | "vw" | "percent" | "m" | "cm" | "mm" | "pt" | "dp"
MetricUnit { Value Float, Type MetricType }
Vector2Metric Vector2(MetricUnit)

Color4f        { R Float, G Float, B Float, A Float }
Color4b        { R Byte, G Byte, B Byte, A Byte }
Color3f        (Float, Float, Float)
RgbaColorFloat Color4f
ColorRGBA      Color4f

FontWeight "thin" | "light" | "regular" | "medium" | "semibold" | "bold" | "black"
FontStyle  "normal" | "italic" | "oblique" | "bold" | "underline" | "strikethrough"
TextAlign  "left" | "center" | "right" | "justify"

TypographyToken {
  FontFamily    String
  FontSizePx    Float
  LineHeight    Float
  FontWeight    FontWeight
  LetterSpacing Float
}

SpacingScale {
  Xs  Float
  Sm  Float
  Md  Float
  Lg  Float
  Xl  Float
  Xxl Float
}

ShadowToken {
  OffsetX Float
  OffsetY Float
  Blur    Float
  Spread  Float
  Color   Color
}

BorderToken {
  Width  Float
  Style  "solid" | "dashed" | "dotted" | "double" | "none"
  Radius Float
  Color  Color
}

ThemePalette {
  Primary    Color
  Secondary  Color
  Accent     Color
  Background Color
  Surface    Color
  Text       Color
  Success    Color
  Warning    Color
  Error      Color
  Info       Color
}

ThemeColorPalette {
  ColorFarFar       RgbaColorFloat
  ColorFar          RgbaColorFloat
  Color             RgbaColorFloat
  ColorNear         RgbaColorFloat
  ColorNearNear     RgbaColorFloat
  ColorDisabledFar  RgbaColorFloat
  ColorDisabled     RgbaColorFloat
  ColorDisabledNear RgbaColorFloat
  OnColor           RgbaColorFloat
}

// =============================================================================
// Universal UI Node (UIN) & Layout Engines (Grid, Flex, Flow, Anchored, Fixed)
// =============================================================================

LayoutAlign "Start" | "Center" | "End" | "Stretch" | "SpaceBetween" | "SpaceAround" | "SpaceEvenly"
RectGravity "Center" | "Bottom" | "Right" | "Top" | "Left"

PaddingAttribute IAttribute & { XStart Float, XFinish Float, YStart Float, YFinish Float }
SpacingAttribute IAttribute & { Spacing Float }

GridTrackSize {
  Kind  String
  Min   MetricUnit
  Max   MetricUnit
  Limit MetricUnit
  Count Int
}

GridContainerLayout {
  Kind           "Grid"
  Columns        List(GridTrackSize)
  Rows           List(GridTrackSize)
  AutoColumns    List(GridTrackSize)
  AutoRows       List(GridTrackSize)
  AutoFlow       String
  TemplateAreas  List(String)
  ColumnGap      MetricUnit
  RowGap         MetricUnit
  JustifyContent String
  AlignContent   String
  JustifyItems   String
  AlignItems     String
}

GridItemPlacement {
  ColumnStart Int
  ColumnEnd   Int
  RowStart    Int
  RowEnd      Int
  Area        String
  JustifySelf String
  AlignSelf   String
}

FlexLayout {
  Kind           "Flex"
  Direction      String
  Wrap           String
  JustifyContent String
  AlignItems     String
  AlignContent   String
  Gap            MetricUnit
}

FlexItemPlacement {
  Grow      Float
  Shrink    Float
  Basis     MetricUnit
  Order     Int
  AlignSelf String
}

FlowLayout {
  Kind        "Flow"
  Display     String
  FloatMode   String
  ClearMode   String
  BreakBefore String
  BreakAfter  String
  BreakInside String
}

AnchoredLayout {
  Kind             "Anchored"
  AnchorMin        VectorFloat2
  AnchorMax        VectorFloat2
  Pivot            VectorFloat2
  AnchoredPosition VectorFloat2
  SizeDelta        VectorFloat2
}

FixedLayout {
  Kind   "Fixed"
  X      MetricUnit
  Y      MetricUnit
  Width  MetricUnit
  Height MetricUnit
}

UILayoutEngine GridContainerLayout | FlexLayout | FlowLayout | AnchoredLayout | FixedLayout

UISizing {
  Width       MetricUnit
  Height      MetricUnit
  MinWidth    MetricUnit
  MaxWidth    MetricUnit
  MinHeight   MetricUnit
  MaxHeight   MetricUnit
  AspectRatio Float
  BoxSizing   String
}

UIPositioning { Mode String, Insets PaddingAttribute, ZIndex Int }
UIOverflow    { X String, Y String }

SolidPaint    { Kind "Solid", Color ColorRGBA, Opacity Float }
GradientStop  { Offset Float, Color ColorRGBA }
GradientPaint { Kind "Gradient", Angle Float, Stops List(GradientStop) }
ImagePaint    { Kind "Image", Uri String, Fit String, Position Vector2Metric, Repeat String }
UIPaint       SolidPaint | GradientPaint | ImagePaint

BorderSide { Width MetricUnit, Style String, Color ColorRGBA }
UIBorders  { Top BorderSide, Right BorderSide, Bottom BorderSide, Left BorderSide, Radii List(MetricUnit) }

UIShadow {
  Kind         String
  Offset       Vector2Metric
  BlurRadius   MetricUnit
  SpreadRadius MetricUnit
  Color        ColorRGBA
}

UIFilters {
  Blur         MetricUnit
  BackdropBlur MetricUnit
  Opacity      Float
  Grayscale    Float
  Contrast     Float
  Brightness   Float
  Saturate     Float
  BlendMode    String
}

UITransforms {
  Origin       VectorFloat3
  Translate    VectorFloat3
  Scale        VectorFloat3
  Rotate       VectorFloat3
  Skew         VectorFloat2
  RawMatrix4x4 List(Float)
}

Typography {
  FontFamily     List(String)
  FontSize       MetricUnit
  FontWeight     Int
  FontStyle      String
  LineHeight     MetricUnit
  LetterSpacing  MetricUnit
  WordSpacing    MetricUnit
  TextAlign      String
  VerticalAlign  String
  TextTransform  String
  TextDecoration String
  WhiteSpace     String
  WordBreak      String
  TextOverflow   String
  MaxLines       Int
  TextShadow     List(UIShadow)
  Color          UIPaint
}

UITransition {
  Property       String
  DurationMs     Int
  DelayMs        Int
  TimingFunction String
}

UIStyleBag {
  Sizing      UISizing
  Positioning UIPositioning
  Margin      PaddingAttribute
  Padding     PaddingAttribute
  Overflow    UIOverflow
  Backgrounds List(UIPaint)
  Borders     UIBorders
  Shadows     List(UIShadow)
  Filters     UIFilters
  Transforms  UITransforms
  Transitions List(UITransition)
  Cursor      String
  Opacity     Float
  Visible     Bool
}

UIEventBinding    { Event String, ActionId String, Payload Any }
UIInteractionSpec { Focusable Bool, TabIndex Int, Events List(UIEventBinding) }

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

SurfaceUin        IUIBaseUin & { Kind "SurfaceUin", Width MetricUnit, Height MetricUnit, Dpi Int }
ContainerUin      IUIBaseUin & { Kind "ContainerUin" }
TextLeafUin       IUIBaseUin & { Kind "TextLeafUin", Content String, Typo Typography }
VectorShapeUin    IUIBaseUin & { Kind "VectorShapeUin", PathCommands String, FillPaint Option(UIPaint), StrokePaint Option(UIPaint), StrokeWidth Option(MetricUnit) }
MediaAssetUin     IUIBaseUin & { Kind "MediaAssetUin", SourceUri String, ImageFit "cover" | "contain" | "fill" | "none" }
TableContainerUin IUIBaseUin & { Kind "TableContainerUin", ColumnWidths List(MetricUnit) }
TableRowUin       IUIBaseUin & { Kind "TableRowUin", IsHeader Bool }
TableCellUin      IUIBaseUin & { Kind "TableCellUin", ColSpan Int, RowSpan Int }
UIControlType     "button" | "text-input" | "checkbox" | "radio" | "select" | "slider"
ControlUin        IUIBaseUin & { Kind "ControlUin", ControlType UIControlType, Value Any, Placeholder Option(String), Disabled Bool, ReadOnly Bool }
ProjectionUin     IUIBaseUin & { Kind "ProjectionUin", SlotName Option(String), ComponentDefinitionId Option(String) }

UIUin SurfaceUin | ContainerUin | TextLeafUin | VectorShapeUin | MediaAssetUin | TableContainerUin | TableRowUin | TableCellUin | ControlUin | ProjectionUin

UIDocumentUin {
  Id     String
  Title  String
  RootId String
  Nodes  Map(String, UIUin)
}

// =============================================================================
// UI Component Taxonomy
// =============================================================================

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

// Layout Components
FlexDirection  "row" | "row-reverse" | "column" | "column-reverse"
AlignItems     "start" | "center" | "end" | "stretch" | "baseline"
JustifyContent "start" | "center" | "end" | "space-between" | "space-around" | "space-evenly"

Container  Layout & { MaxWidth Float, Centered Bool, Padding Float }
Grid       Layout & { Columns Int, Rows Int, Gap Float }
Flex       Layout & { Direction FlexDirection, Align AlignItems, Justify JustifyContent, Gap Float, Wrap Bool }
Stack      Layout & { Axis "vertical" | "horizontal", Spacing Float }
SplitPane  Layout & { Orientation "horizontal" | "vertical", Ratio Float }
ScrollArea Layout & { ScrollX Bool, ScrollY Bool }
Divider    Layout & { Orientation "horizontal" | "vertical" }
Spacer     Layout & { Size Float }

// Form & Input Components
ButtonVariant "solid" | "outline" | "ghost" | "link" | "danger"

Button        Forms & { Label String, Variant ButtonVariant, Disabled Bool, Loading Bool }
IconButton    Button & { IconName String }
Input         Forms & { Value String, Placeholder String, Disabled Bool, ReadOnly Bool }
PasswordInput Input & { ShowToggle Bool }
NumberInput   Forms & { Value Float, Min Float, Max Float, Step Float }
Textarea      Forms & { Value String, Rows Int, MaxLength Int }
Select        Forms & { Options List(String), Value Option(String), Multiple Bool }
Combobox      Select & { SearchQuery String }
Checkbox      Forms & { Checked Bool, Indeterminate Bool, Label String }
Radio         Forms & { Checked Bool, GroupName String, Value String }
Switch        Forms & { Checked Bool, Label String }
Slider        Forms & { Value Float, Min Float, Max Float, Step Float }
DatePicker    Forms & { SelectedDate Option(String), MinDate Option(String), MaxDate Option(String) }
ColorPicker   Forms & { SelectedColor Color }
FileUpload    Forms & { Accept List(String), MaxSizeBytes Int, Multiple Bool }
Form          Forms & { Fields List(Any), IsValid Bool, IsSubmitting Bool }

// Data Display & Visualization Components
Table      Display & { Columns List(String), Rows List(Any), SortColumn Option(String) }
DataGrid   Table & { PageSize Int, CurrentPage Int, Virtualized Bool }
Card       Display & { Title Option(String), Subtitle Option(String), Elevated Bool }
Avatar     Display & { Src Option(String), Initials String, Size Float, Status Option(String) }
Badge      Display & { Text String, Variant "neutral" | "success" | "warning" | "error" | "info" }
TagChip    Display & { Label String, Closable Bool }
TreeView   Display & { Nodes List(Any), ExpandedIds List(String) }
TimelineUi Display & { Items List(Any) }
CodeBlock  Display & { Code String, Language String, ShowLineNumbers Bool }
StatMetric Display & { Label String, Value String, Delta Option(Float) }

ChartType "line" | "bar" | "pie" | "doughnut" | "scatter" | "area" | "radar" | "heatmap" | "candlestick" | "sankey" | "treemap" | "funnel" | "gauge"
Chart     DataViz & { Type ChartType, Series List(Any), Labels List(String) }

// Feedback, Status & Overlay Components
Alert     Feedback & Status & { Severity "info" | "success" | "warning" | "error", Title String, Message String }
Dialog    Overlay & Feedback & Status & { Open Bool, Title String, Closable Bool }
Modal     Dialog & { BackdropBlur Bool }
Drawer    Overlay & { Open Bool, Placement "left" | "right" | "top" | "bottom" }
Progress  Feedback & Status & { Value Float, Max Float, Indeterminate Bool }
Spinner   Feedback & Status & { Size Float }
Skeleton  Feedback & { Width Float, Height Float, Animated Bool }
Toast     Feedback & Status & { Message String, DurationMs Int, Position String }
Popover   Overlay & Disclosure & { Open Bool, Trigger Any }
Tooltip   Overlay & Disclosure & { Content String, DelayMs Int }
Accordion Overlay & Disclosure & { Sections List(Any), AllowMultiple Bool }

// Navigation & Menu Components
Tabs           Navigation & { ActiveTabId String, Items List(Any) }
Breadcrumbs    Navigation & { Items List(String), Separator String }
Navbar         Navigation & { Sticky Bool, BrandTitle String, Links List(String) }
Sidebar        Navigation & { Collapsed Bool, Width Float, Items List(Any) }
Pagination     Navigation & { CurrentPage Int, TotalPages Int, PageSize Int }
Stepper        Navigation & { ActiveStep Int, Steps List(String) }
Dropdown       Menu & Navigation & { Open Bool, Items List(Any) }
ContextMenu    Menu & Overlay & { Position Point2D, Items List(Any) }
CommandPalette Overlay & Navigation & { Open Bool, Query String, Commands List(Any) }

// =============================================================================
// UI Animations, Timelines, Routing & Popups
// =============================================================================

IAnimationHandler      { Handle Any }
CurvedAnimationHandler { Handler IAnimationHandler, Curve ICurve }
ColorHandler           IAnimationHandler & { From RgbaColorFloat, Delta RgbaColorFloat }
VectorHandler          IAnimationHandler & { From VectorFloat3, Delta VectorFloat3 }

IAnimationTrack {
  From   Float
  Length Float
  To     Float
}

DefaultAnimationTrack IAnimationTrack & { Handler IAnimationHandler }
RepeatAnimationTrack  DefaultAnimationTrack & { TrackLength Float, RepeatCount Float }

AnimationTimeLine {
  CurrentTime Float
  TotalTime   Float
  IsPlaying   Bool
  Tracks      List(IAnimationTrack)
}

UpdateTimeline(Tl AnimationTimeLine, Delta Float) [
  IsPlaying . {
    false [ Tl ]
    true  [
      NextTime (CurrentTime + Delta)
      NextTime . {
        [ _ >= TotalTime ] [ Tl & { CurrentTime TotalTime, IsPlaying false } ]
        _                  [ Tl & { CurrentTime NextTime } ]
      }
    ]
  }
]

// Routing
RouteValue { Slug String, Payload Any }
RoutePath(T) { Segments List(T) }
RouteChange  Change(RoutePath(RouteValue))
RouteHistory { ActiveHistory List(RoutePath(RouteValue)), Count Int }

IRouteEvent        IEvent & { Path RoutePath(RouteValue) }
RouteInitEvent     IRouteEvent
RouteEnterEvent    IRouteEvent
RouteLeaveEvent    IRouteEvent
RoutingStartEvent  IRouteEvent
RoutingFinishEvent IRouteEvent

RouteNavigateState {
  IsRouting Bool
  Event     Option(IRouteEvent)
  Path      RoutePath(RouteValue)
}

NavigateToRoute(State RouteNavigateState, NextPath RoutePath(RouteValue)) [
  State & {
    IsRouting false
    Path      NextPath
    Event     Some(RouteEnterEvent { Path NextPath })
  }
]
