#
UI Component Taxonomy
#

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

Tabs           Navigation & { ActiveTabId String, Items List(Any) }
Breadcrumbs    Navigation & { Items List(String), Separator String }
Navbar         Navigation & { Sticky Bool, BrandTitle String, Links List(String) }
Sidebar        Navigation & { Collapsed Bool, Width Float, Items List(Any) }
Pagination     Navigation & { CurrentPage Int, TotalPages Int, PageSize Int }
Stepper        Navigation & { ActiveStep Int, Steps List(String) }
Dropdown       Menu & Navigation & { Open Bool, Items List(Any) }
ContextMenu    Menu & Overlay & { Position Point2D, Items List(Any) }
CommandPalette Overlay & Navigation & { Open Bool, Query String, Commands List(Any) }
