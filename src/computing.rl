// =============================================================================
// Computing, UI, Operating System, File System & Network Entities
// =============================================================================

// Level 1: Physical Input & UI Elements
CursorState {
  Position  Coordinates
  IsVisible Bool
  Shape     "default" | "pointer" | "text" | "wait" | "crosshair" | "move" | "not-allowed"
}

ClickType "single" | "double" | "right" | "middle" | "long-press"

UIElement Thing & {
  ElementId  Str
  TagName    Str
  Bounds     BoundingBox
  IsEnabled  Bool
  IsVisible  Bool
  IsFocused  Bool
  TextValue  Option(Str)
  AriaRole   Option(Str)
}
ButtonElement   UIElement
InputField      UIElement & { Placeholder Option(Str), Value Str, InputType "text" | "password" | "email" | "number" | "search" }
CheckboxElement UIElement & { IsChecked Bool }
SelectElement   UIElement & { Options List(Str), SelectedOption Option(Str) }
CanvasElement   UIElement

UIEvent {
  Source    UIElement
  EventType Str
  Timestamp DateTime
}

UIState {
  ActiveElement Option(UIElement)
  Elements      List(UIElement)
  Viewport      ViewportState
}

StartCoords Coordinates
EndCoords   Coordinates

Direction "up" | "down" | "left" | "right"

Viewport {
  Width   Float
  Height  Float
  ScrollX Float
  ScrollY Float
  Zoom    Float
}
ViewportState Viewport

TextData {
  Content  Str
  Encoding Str
  Length   Count
}

KeyModifier "Ctrl" | "Alt" | "Shift" | "Meta"
KeyCombination {
  Modifiers List(KeyModifier)
  Key       Str
}

SystemCommand {
  Command   Str
  Arguments List(Str)
  ExitCode  Option(Int)
}

// Level 2: System & Environment Management
PowerState "on" | "off" | "reboot" | "sleep" | "hibernate"

System Thing & {
  Hostname     Str
  Architecture "x86_64" | "arm64" | "riscv64"
  CpuCount     Count
  MemoryTotal  Int
}

SystemState {
  Power       PowerState
  Uptime      Duration
  CpuUsage    Float
  MemoryUsage Float
}

Credentials {
  Username  Str
  Secret    Str
  Method    "password" | "pin" | "biometric" | "token" | "oauth" | "passkey"
}

SecuritySystem Thing & {
  Provider     Str
  AuthMethods  List(Str)
  MfaRequired  Bool
}

AuthToken {
  Token     Str
  ExpiresAt DateTime
  Scopes    List(Str)
}

WindowAction "open" | "close" | "minimize" | "maximize" | "restore" | "resize" | "move" | "focus"

Window UIElement & {
  Title        Str
  ProcessId    Int
  State        "normal" | "minimized" | "maximized" | "fullscreen"
  ZIndex       Int
}

Parameter Str
Value     Primitive

SystemSettings {
  Volume      Int
  Brightness  Int
  WifiEnabled Bool
  BluetoothEnabled Bool
  Theme       "light" | "dark" | "system"
  Locale      Str
}
ConfigState SystemSettings

MaintenanceTask "install_package" | "remove_package" | "update_os" | "clear_cache" | "empty_trash" | "security_scan" | "disk_cleanup"

OperatingSystem SoftwareApplication & {
  KernelVersion Str
  Distribution  Str
}

SystemHealth {
  Status           "healthy" | "warning" | "critical"
  DiskFreeBytes    Int
  PendingUpdates   Count
  ThreatsDetected  Count
  LastCheckedAt    DateTime
}

// Level 3: File System & Data Operations
ContentStream {
  MimeType MimeType
  Size     Int
  Data     Str
}

NewData {
  Payload   Str
  Overwrite Bool
}

SourceLocation Str
TargetLocation Str
OperationType  "copy" | "cut" | "paste" | "rename" | "archive" | "extract" | "move" | "symlink"

FileEntry Thing & {
  Path        Str
  Size        Int
  IsDirectory Bool
  Permissions Str
  ModifiedAt  DateTime
}

FileSystemState {
  RootPath  Str
  Entries   List(FileEntry)
  FreeSpace Int
}

Storage Thing & {
  MountPoint Str
  FileSystem "ext4" | "apfs" | "ntfs" | "fat32" | "zfs" | "btrfs"
  Capacity   Int
}

Query     Str
ThingList List(Thing)

// Level 4: Web & Network Operations
Browser WebApplication & {
  CurrentUrl URL
  Tabs       List(WebPage)
  History    List(URL)
}

SearchEngine WebApplication & {
  Endpoint URL
  Provider Str
}
SearchQuery {
  Text    Str
  Filters Map(Str, Str)
  Limit   Count
}
SearchResults {
  Query      SearchQuery
  Items      List(WebPage)
  TotalCount Count
}

DataObject MediaObject & {
  Checksum Str
}
SourceNode      URL | Str
DestinationNode URL | Str
TransferStatus {
  BytesTransferred Int
  TotalBytes       Int
  Direction        "upload" | "download"
  State            "pending" | "in_progress" | "completed" | "failed"
}

WebService Service & {
  BaseUrl URL
}
Session {
  SessionId Str
  User      Agent
  AuthToken AuthToken
  CreatedAt DateTime
}

// Level 5: Digital Communication & Social
Recipient      Agent
MessageContent {
  Subject     Option(Str)
  Body        Str
  Attachments List(MediaObject)
}
MessageStatus {
  MessageId   Str
  State       "queued" | "sent" | "delivered" | "read" | "failed"
  Timestamp   DateTime
}

ParticipantList List(Agent)
MediaStream {
  HasAudio    Bool
  HasVideo    Bool
  ScreenShare Bool
  BitrateKbps Int
}
CallSession {
  SessionId    Str
  Participants ParticipantList
  Stream       MediaStream
  StartedAt    DateTime
  IsActive     Bool
}

SocialObject    SocialMediaPosting | Comment | MediaObject
InteractionType "post" | "comment" | "like" | "dislike" | "repost" | "bookmark" | "report"

// Level 6: Applied Tasks
MediaContent MediaObject
Experience {
  Consumer    Agent
  Media       MediaContent
  Progress    Float
  CompletedAt Option(DateTime)
}

Document       DigitalDocument
TextOperations List("insert" | "delete" | "replace" | "format_bold" | "format_italic" | "align" | "paginate")

Formulas List(Str)
AnalyticsResult {
  Summary Map(Str, Float)
  Charts  List(ImageObject)
}

RawMedia      MediaObject
EditingTools  List(Str)
MediaArtifact MediaObject

SourceCode SoftwareSourceCode
Compiler   SoftwareApplication
Executable SoftwareApplication & {
  BinaryPath Str
  TargetArch Str
}

GameEnvironment VideoGame
GameActions     List(Str)
GameState {
  Score     Int
  Level     Int
  Position  Coordinates
  Inventory List(Thing)
  IsRunning Bool
}

ECommercePlatform WebApplication
CartItem {
  Product  Product
  Quantity Count
  Price    Float
}
Cart {
  CartId   Str
  Items    List(CartItem)
  Amount   Int
  Currency Str
}
PaymentMethod "credit_card" | "debit_card" | "bank_transfer" | "digital_wallet" | "crypto" | "cash_on_delivery"
OrderReceipt {
  ReceiptId     Str
  Order         Order
  PaidAmount    MonetaryAmount
  PaymentMethod PaymentMethod
  Timestamp     DateTime
}
