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
  FontFamily    Str
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
  Kind  Str
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
  AutoFlow       Str
  TemplateAreas  List(Str)
  ColumnGap      MetricUnit
  RowGap         MetricUnit
  JustifyContent Str
  AlignContent   Str
  JustifyItems   Str
  AlignItems     Str
}

GridItemPlacement {
  ColumnStart Int
  ColumnEnd   Int
  RowStart    Int
  RowEnd      Int
  Area        Str
  JustifySelf Str
  AlignSelf   Str
}

FlexLayout {
  Kind           "Flex"
  Direction      Str
  Wrap           Str
  JustifyContent Str
  AlignItems     Str
  AlignContent   Str
  Gap            MetricUnit
}

FlexItemPlacement {
  Grow      Float
  Shrink    Float
  Basis     MetricUnit
  Order     Int
  AlignSelf Str
}

FlowLayout {
  Kind        "Flow"
  Display     Str
  FloatMode   Str
  ClearMode   Str
  BreakBefore Str
  BreakAfter  Str
  BreakInside Str
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
  BoxSizing   Str
}

UIPositioning { Mode Str, Insets PaddingAttribute, ZIndex Int }
UIOverflow    { X Str, Y Str }

SolidPaint    { Kind "Solid", Color ColorRGBA, Opacity Float }
GradientStop  { Offset Float, Color ColorRGBA }
GradientPaint { Kind "Gradient", Angle Float, Stops List(GradientStop) }
ImagePaint    { Kind "Image", Uri Str, Fit Str, Position Vector2Metric, Repeat Str }
UIPaint       SolidPaint | GradientPaint | ImagePaint

BorderSide { Width MetricUnit, Style Str, Color ColorRGBA }
UIBorders  { Top BorderSide, Right BorderSide, Bottom BorderSide, Left BorderSide, Radii List(MetricUnit) }

UIShadow {
  Kind         Str
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
  BlendMode    Str
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
  FontFamily     List(Str)
  FontSize       MetricUnit
  FontWeight     Int
  FontStyle      Str
  LineHeight     MetricUnit
  LetterSpacing  MetricUnit
  WordSpacing    MetricUnit
  TextAlign      Str
  VerticalAlign  Str
  TextTransform  Str
  TextDecoration Str
  WhiteSpace     Str
  WordBreak      Str
  TextOverflow   Str
  MaxLines       Int
  TextShadow     List(UIShadow)
  Color          UIPaint
}

UITransition {
  Property       Str
  DurationMs     Int
  DelayMs        Int
  TimingFunction Str
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
  Cursor      Str
  Opacity     Float
  Visible     Bool
}

UIEventBinding    { Event Str, ActionId Str, Payload Any }
UIInteractionSpec { Focusable Bool, TabIndex Int, Events List(UIEventBinding) }

IUIBaseUin {
  Id              Str
  Name            Option(Str)
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
TextLeafUin       IUIBaseUin & { Kind "TextLeafUin", Content Str, Typo Typography }
VectorShapeUin    IUIBaseUin & { Kind "VectorShapeUin", PathCommands Str, FillPaint Option(UIPaint), StrokePaint Option(UIPaint), StrokeWidth Option(MetricUnit) }
MediaAssetUin     IUIBaseUin & { Kind "MediaAssetUin", SourceUri Str, ImageFit "cover" | "contain" | "fill" | "none" }
TableContainerUin IUIBaseUin & { Kind "TableContainerUin", ColumnWidths List(MetricUnit) }
TableRowUin       IUIBaseUin & { Kind "TableRowUin", IsHeader Bool }
TableCellUin      IUIBaseUin & { Kind "TableCellUin", ColSpan Int, RowSpan Int }
UIControlType     "button" | "text-input" | "checkbox" | "radio" | "select" | "slider"
ControlUin        IUIBaseUin & { Kind "ControlUin", ControlType UIControlType, Value Any, Placeholder Option(Str), Disabled Bool, ReadOnly Bool }
ProjectionUin     IUIBaseUin & { Kind "ProjectionUin", SlotName Option(Str), ComponentDefinitionId Option(Str) }

UIUin SurfaceUin | ContainerUin | TextLeafUin | VectorShapeUin | MediaAssetUin | TableContainerUin | TableRowUin | TableCellUin | ControlUin | ProjectionUin

UIDocumentUin {
  Id     Str
  Title  Str
  RootId Str
  Nodes  Map(Str, UIUin)
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

Button        Forms & { Label Str, Variant ButtonVariant, Disabled Bool, Loading Bool }
IconButton    Button & { IconName Str }
Input         Forms & { Value Str, Placeholder Str, Disabled Bool, ReadOnly Bool }
PasswordInput Input & { ShowToggle Bool }
NumberInput   Forms & { Value Float, Min Float, Max Float, Step Float }
Textarea      Forms & { Value Str, Rows Int, MaxLength Int }
Select        Forms & { Options List(Str), Value Option(Str), Multiple Bool }
Combobox      Select & { SearchQuery Str }
Checkbox      Forms & { Checked Bool, Indeterminate Bool, Label Str }
Radio         Forms & { Checked Bool, GroupName Str, Value Str }
Switch        Forms & { Checked Bool, Label Str }
Slider        Forms & { Value Float, Min Float, Max Float, Step Float }
DatePicker    Forms & { SelectedDate Option(Str), MinDate Option(Str), MaxDate Option(Str) }
ColorPicker   Forms & { SelectedColor Color }
FileUpload    Forms & { Accept List(Str), MaxSizeBytes Int, Multiple Bool }
Form          Forms & { Fields List(Any), IsValid Bool, IsSubmitting Bool }

// Data Display & Visualization Components
Table      Display & { Columns List(Str), Rows List(Any), SortColumn Option(Str) }
DataGrid   Table & { PageSize Int, CurrentPage Int, Virtualized Bool }
Card       Display & { Title Option(Str), Subtitle Option(Str), Elevated Bool }
Avatar     Display & { Src Option(Str), Initials Str, Size Float, Status Option(Str) }
Badge      Display & { Text Str, Variant "neutral" | "success" | "warning" | "error" | "info" }
TagChip    Display & { Label Str, Closable Bool }
TreeView   Display & { Nodes List(Any), ExpandedIds List(Str) }
TimelineUi Display & { Items List(Any) }
CodeBlock  Display & { Code Str, Language Str, ShowLineNumbers Bool }
StatMetric Display & { Label Str, Value Str, Delta Option(Float) }

ChartType "line" | "bar" | "pie" | "doughnut" | "scatter" | "area" | "radar" | "heatmap" | "candlestick" | "sankey" | "treemap" | "funnel" | "gauge"
Chart     DataViz & { Type ChartType, Series List(Any), Labels List(Str) }

// Feedback, Status & Overlay Components
Alert     Feedback & Status & { Severity "info" | "success" | "warning" | "error", Title Str, Message Str }
Dialog    Overlay & Feedback & Status & { Open Bool, Title Str, Closable Bool }
Modal     Dialog & { BackdropBlur Bool }
Drawer    Overlay & { Open Bool, Placement "left" | "right" | "top" | "bottom" }
Progress  Feedback & Status & { Value Float, Max Float, Indeterminate Bool }
Spinner   Feedback & Status & { Size Float }
Skeleton  Feedback & { Width Float, Height Float, Animated Bool }
Toast     Feedback & Status & { Message Str, DurationMs Int, Position Str }
Popover   Overlay & Disclosure & { Open Bool, Trigger Any }
Tooltip   Overlay & Disclosure & { Content Str, DelayMs Int }
Accordion Overlay & Disclosure & { Sections List(Any), AllowMultiple Bool }

// Navigation & Menu Components
Tabs           Navigation & { ActiveTabId Str, Items List(Any) }
Breadcrumbs    Navigation & { Items List(Str), Separator Str }
Navbar         Navigation & { Sticky Bool, BrandTitle Str, Links List(Str) }
Sidebar        Navigation & { Collapsed Bool, Width Float, Items List(Any) }
Pagination     Navigation & { CurrentPage Int, TotalPages Int, PageSize Int }
Stepper        Navigation & { ActiveStep Int, Steps List(Str) }
Dropdown       Menu & Navigation & { Open Bool, Items List(Any) }
ContextMenu    Menu & Overlay & { Position Point2D, Items List(Any) }
CommandPalette Overlay & Navigation & { Open Bool, Query Str, Commands List(Any) }

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
RouteValue { Slug Str, Payload Any }
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
