#
Universal UI Node (UIN), Layout Engines & Style Bags
#

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
