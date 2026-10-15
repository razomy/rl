_ meta
_ primitives
_ structures
_ space
_ energy

// =============================================================================
// Design Tokens, Typography, Spacing & Themes
// =============================================================================

FontWeight "thin" | "light" | "regular" | "medium" | "semibold" | "bold" | "black"
FontStyle  "normal" | "italic" | "oblique"
TextAlign  "left" | "center" | "right" | "justify"

TypographyToken {
  FontFamily   Str
  FontSizePx   Float
  LineHeight   Float
  FontWeight   FontWeight
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

// =============================================================================
// Layout Components
// =============================================================================

FlexDirection "row" | "row-reverse" | "column" | "column-reverse"
AlignItems    "start" | "center" | "end" | "stretch" | "baseline"
JustifyContent "start" | "center" | "end" | "space-between" | "space-around" | "space-evenly"

Container Layout & { MaxWidth Float, Centered Bool, Padding Float }
Grid      Layout & { Columns Int, Rows Int, Gap Float }
Flex      Layout & { Direction FlexDirection, Align AlignItems, Justify JustifyContent, Gap Float, Wrap Bool }
Stack     Layout & { Axis "vertical" | "horizontal", Spacing Float }
SplitPane Layout & { Orientation "horizontal" | "vertical", Ratio Float }
ScrollArea Layout & { ScrollX Bool, ScrollY Bool }
Divider   Layout & { Orientation "horizontal" | "vertical" }
Spacer    Layout & { Size Float }

// =============================================================================
// Form & Input Components
// =============================================================================

ButtonVariant "solid" | "outline" | "ghost" | "link" | "danger"

Button      Forms & { Label Str, Variant ButtonVariant, Disabled Bool, Loading Bool }
IconButton  Button & { IconName Str }
Input       Forms & { Value Str, Placeholder Str, Disabled Bool, ReadOnly Bool }
PasswordInput Input & { ShowToggle Bool }
NumberInput Forms & { Value Float, Min Float, Max Float, Step Float }
Textarea    Forms & { Value Str, Rows Int, MaxLength Int }
Select      Forms & { Options List(Str), Value Option(Str), Multiple Bool }
Combobox    Select & { SearchQuery Str }
Checkbox    Forms & { Checked Bool, Indeterminate Bool, Label Str }
Radio       Forms & { Checked Bool, GroupName Str, Value Str }
Switch      Forms & { Checked Bool, Label Str }
Slider      Forms & { Value Float, Min Float, Max Float, Step Float }
DatePicker  Forms & { SelectedDate Option(Str), MinDate Option(Str), MaxDate Option(Str) }
ColorPicker Forms & { SelectedColor Color }
FileUpload  Forms & { Accept List(Str), MaxSizeBytes Int, Multiple Bool }
Form        Forms & { Fields List(Any), IsValid Bool, IsSubmitting Bool }

// =============================================================================
// Data Display & Visualization Components
// =============================================================================

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

// Charts
ChartType "line" | "bar" | "pie" | "doughnut" | "scatter" | "area" | "radar" | "heatmap" | "candlestick"
Chart     DataViz & { Type ChartType, Series List(Any), Labels List(Str) }

// =============================================================================
// Feedback, Status & Overlay Components
// =============================================================================

Alert      Feedback & Status & { Severity "info" | "success" | "warning" | "error", Title Str, Message Str }
Dialog     Overlay & Feedback & Status & { Open Bool, Title Str, Closable Bool }
Modal      Dialog & { BackdropBlur Bool }
Drawer     Overlay & { Open Bool, Placement "left" | "right" | "top" | "bottom" }
Progress   Feedback & Status & { Value Float, Max Float, Indeterminate Bool }
Spinner    Feedback & Status & { Size Float }
Skeleton   Feedback & { Width Float, Height Float, Animated Bool }
Toast      Feedback & Status & { Message Str, DurationMs Int, Position Str }
Popover    Overlay & Disclosure & { Open Bool, Trigger Any }
Tooltip    Overlay & Disclosure & { Content Str, DelayMs Int }
Accordion  Overlay & Disclosure & { Sections List(Any), AllowMultiple Bool }

// =============================================================================
// Navigation & Menu Components
// =============================================================================

Tabs        Navigation & { ActiveTabId Str, Items List(Any) }
Breadcrumbs Navigation & { Items List(Str), Separator Str }
Navbar      Navigation & { Sticky Bool, BrandTitle Str, Links List(Str) }
Sidebar     Navigation & { Collapsed Bool, Width Float, Items List(Any) }
Pagination  Navigation & { CurrentPage Int, TotalPages Int, PageSize Int }
Stepper     Navigation & { ActiveStep Int, Steps List(Str) }
Dropdown    Menu & Navigation & { Open Bool, Items List(Any) }
ContextMenu Menu & Overlay & { Position Point2D, Items List(Any) }
CommandPalette Overlay & Navigation & { Open Bool, Query Str, Commands List(Any) }