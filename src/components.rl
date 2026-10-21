#
UI Component Taxonomy
#

FlexDirection  "row" | "row-reverse" | "column" | "column-reverse"
AlignItems     "start" | "center" | "end" | "stretch" | "baseline"
JustifyContent "start" | "center" | "end" | "space-between" | "space-around" | "space-evenly"

Container  Layout & { MaxWidth Float, centered Bool, padding Float }
Grid       Layout & { Columns Int, rows Int, gap Float }
Flex       Layout & { Direction FlexDirection, align AlignItems, justify JustifyContent, gap Float, wrap Bool }
Stack      Layout & { Axis "vertical" | "horizontal", spacing Float }
SplitPane  Layout & { Orientation "horizontal" | "vertical", ratio Float }
ScrollArea Layout & { ScrollX Bool, scrollY Bool }
Divider    Layout & { Orientation "horizontal" | "vertical" }
Spacer     Layout & { Size Float }

ButtonVariant "solid" | "outline" | "ghost" | "link" | "danger"

Button        Forms & { Label String, variant ButtonVariant, disabled Bool, loading Bool }
IconButton    Button & { IconName String }
Input         Forms & { Value String, placeholder String, disabled Bool, readOnly Bool }
PasswordInput Input & { ShowToggle Bool }
NumberInput   Forms & { Value Float, min Float, max Float, step Float }
Textarea      Forms & { Value String, rows Int, maxLength Int }
Select        Forms & { Options List(String), value Option(String), multiple Bool }
Combobox      Select & { SearchQuery String }
Checkbox      Forms & { Checked Bool, indeterminate Bool, label String }
Radio         Forms & { Checked Bool, groupName String, value String }
Switch        Forms & { Checked Bool, label String }
Slider        Forms & { Value Float, min Float, max Float, step Float }
DatePicker    Forms & { SelectedDate Option(String), minDate Option(String), maxDate Option(String) }
ColorPicker   Forms & { SelectedColor Color }
FileUpload    Forms & { Accept List(String), maxSizeBytes Int, multiple Bool }
Form          Forms & { Fields List(Any), isValid Bool, isSubmitting Bool }

Table      Display & { Columns List(String), rows List(Any), sortColumn Option(String) }
DataGrid   Table & { PageSize Int, currentPage Int, virtualized Bool }
Card       Display & { Title Option(String), subtitle Option(String), elevated Bool }
Avatar     Display & { Src Option(String), initials String, size Float, status Option(String) }
Badge      Display & { Text String, Variant "neutral" | "success" | "warning" | "error" | "info" }
TagChip    Display & { Label String, closable Bool }
TreeView   Display & { Nodes List(Any), expandedIds List(String) }
TimelineUi Display & { Items List(Any) }
CodeBlock  Display & { Code String, language String, showLineNumbers Bool }
StatMetric Display & { Label String, value String, delta Option(Float) }

ChartType "line" | "bar" | "pie" | "doughnut" | "scatter" | "area" | "radar" | "heatmap" | "candlestick" | "sankey" | "treemap" | "funnel" | "gauge"
Chart     DataViz & { Type ChartType, series List(Any), labels List(String) }

Alert     Feedback & Status & { Severity "info" | "success" | "warning" | "error", title String, message String }
Dialog    Overlay & Feedback & Status & { Open Bool, title String, closable Bool }
Modal     Dialog & { BackdropBlur Bool }
Drawer    Overlay & { Open Bool, Placement "left" | "right" | "top" | "bottom" }
Progress  Feedback & Status & { Value Float, max Float, indeterminate Bool }
Spinner   Feedback & Status & { Size Float }
Skeleton  Feedback & { Width Float, height Float, animated Bool }
Toast     Feedback & Status & { Message String, durationMs Int, position String }
Popover   Overlay & Disclosure & { Open Bool, trigger Any }
Tooltip   Overlay & Disclosure & { Content String, delayMs Int }
Accordion Overlay & Disclosure & { Sections List(Any), allowMultiple Bool }

Tabs           Navigation & { ActiveTabId String, items List(Any) }
Breadcrumbs    Navigation & { Items List(String), separator String }
Navbar         Navigation & { Sticky Bool, brandTitle String, links List(String) }
Sidebar        Navigation & { Collapsed Bool, width Float, items List(Any) }
Pagination     Navigation & { CurrentPage Int, totalPages Int, pageSize Int }
Stepper        Navigation & { ActiveStep Int, steps List(String) }
Dropdown       Menu & Navigation & { Open Bool, items List(Any) }
ContextMenu    Menu & Overlay & { Position Point2D, items List(Any) }
CommandPalette Overlay & Navigation & { Open Bool, query String, commands List(Any) }
