_ meta
_ primitive
_ structure
_ quantity
_ time
_ space
_ thing
_ agent
_ creative_work
_ creative_work_media
_ creative_work_code
_ commerce
_ ui

// =============================================================================
// Project CLI, Build Tooling & Runtimes (merged from project.rl & runtimes.rl)
// =============================================================================

Project {
  Interaction {
    Schema(T) {
      Format  T
      Lint    T
      Run     T
      Test    T
      Build   T
      Publish T
      Clean   T
    }
  }
}

Cli {
  Schema Project.Interaction.Schema(Str)
}

LaunchCli {
  Launcher Str
  Command  Str
  BuildCommand(Name Str) [ "{Launcher} {Command} {Name}" ]
}

LaunchCliAndCliSchema LaunchCli & Cli.Schema

Npm {
  Cli LaunchCliAndCliSchema {
    Launcher     "npm run"
    Command      ""
    BuildCommand LaunchCli.BuildCommand
    Format       BuildCommand("check")
    Lint         BuildCommand("lint")
    Run          BuildCommand("dev")
    Test         BuildCommand("test")
    Build        BuildCommand("build")
    Publish      BuildCommand("publish")
    Clean        BuildCommand("clean")
  }
}

Cargo {
  Cli LaunchCliAndCliSchema {
    Launcher     "cargo"
    Command      ""
    BuildCommand LaunchCli.BuildCommand
    Format       "cargo fmt"
    Lint         "cargo clippy"
    Run          "cargo run"
    Test         "cargo test"
    Build        "cargo build --release"
    Publish      "cargo publish"
    Clean        "cargo clean"
  }
}

Docker {
  ContainerImage {
    Repository Str
    Tag        Str
    Digest     Option(Str)
  }
  ContainerState "created" | "running" | "paused" | "restarting" | "removing" | "exited" | "dead"
  Container {
    ContainerId Str
    Image       ContainerImage
    State       ContainerState
    Ports       Map(Int, Int)
    EnvVars     Map(Str, Str)
    Volumes     List(Str)
  }
}

// =============================================================================
// Level 1: Physical Input & UI Elements
// =============================================================================

Coordinates Point2D
BoundingBox Rectangle

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

// =============================================================================
// Level 2: System & Environment Management
// =============================================================================

PowerState "on" | "off" | "reboot" | "sleep" | "hibernate"

System Thing & {
  Hostname     Str
  Architecture "x86_64" | "arm64" | "riscv64" | "wasm32"
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
  Method    "password" | "pin" | "biometric" | "token" | "oauth" | "passkey" | "ssh-key"
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
  Volume           Int
  Brightness       Int
  WifiEnabled      Bool
  BluetoothEnabled Bool
  Theme            "light" | "dark" | "system"
  Locale           Str
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

// =============================================================================
// Level 3: File System & Data Operations
// =============================================================================

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
  FileSystem "ext4" | "apfs" | "ntfs" | "fat32" | "zfs" | "btrfs" | "xfs"
  Capacity   Int
}

Query     Str
ThingList List(Thing)

// =============================================================================
// Level 4: Web & Network Operations
// =============================================================================

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

// =============================================================================
// Level 5: Digital Communication & Social
// =============================================================================

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

// =============================================================================
// Level 6: Applied Tasks
// =============================================================================

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
OrderReceipt {
  ReceiptId     Str
  Order         Order
  PaidAmount    MonetaryAmount
  PaymentMethod PaymentMethod
  Timestamp     DateTime
}
