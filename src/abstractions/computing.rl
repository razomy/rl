_ primitive
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

#
Project CLI, Build Tooling & Runtimes (merged from project.rl & runtimes.rl)
#

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
  Schema Project.Interaction.Schema(String)
}

LaunchCli {
  Launcher String
  Command  String
  BuildCommand(Name String) [ "{Launcher} {Command} {Name}" ]
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
    Repository String
    Tag        String
    Digest     Option(String)
  }
  ContainerState "created" | "running" | "paused" | "restarting" | "removing" | "exited" | "dead"
  Container {
    ContainerId String
    Image       ContainerImage
    State       ContainerState
    Ports       Map(Int, Int)
    EnvVars     Map(String, String)
    Volumes     List(String)
  }
}

#
Level 1: Physical Input & UI Elements
#

Coordinates Point2D
BoundingBox Rectangle

CursorState {
  Position  Coordinates
  IsVisible Bool
  Shape     "default" | "pointer" | "text" | "wait" | "crosshair" | "move" | "not-allowed"
}

ClickType "single" | "double" | "right" | "middle" | "long-press"

UIElement Thing & {
  ElementId  String
  TagName    String
  Bounds     BoundingBox
  IsEnabled  Bool
  IsVisible  Bool
  IsFocused  Bool
  TextValue  Option(String)
  AriaRole   Option(String)
}
ButtonElement   UIElement
InputField      UIElement & { Placeholder Option(String), Value String, InputType "text" | "password" | "email" | "number" | "search" }
CheckboxElement UIElement & { IsChecked Bool }
SelectElement   UIElement & { Options List(String), SelectedOption Option(String) }
CanvasElement   UIElement

UIEvent {
  Source    UIElement
  EventType String
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
  Content  String
  Encoding String
  Length   Count
}

KeyModifier "Ctrl" | "Alt" | "Shift" | "Meta"
KeyCombination {
  Modifiers List(KeyModifier)
  Key       String
}

SystemCommand {
  Command   String
  Arguments List(String)
  ExitCode  Option(Int)
}

#
Level 2: System & Environment Management
#

PowerState "on" | "off" | "reboot" | "sleep" | "hibernate"

System Thing & {
  Hostname     String
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
  Username  String
  Secret    String
  Method    "password" | "pin" | "biometric" | "token" | "oauth" | "passkey" | "ssh-key"
}

SecuritySystem Thing & {
  Provider     String
  AuthMethods  List(String)
  MfaRequired  Bool
}

AuthToken {
  Token     String
  ExpiresAt DateTime
  Scopes    List(String)
}

WindowAction "open" | "close" | "minimize" | "maximize" | "restore" | "resize" | "move" | "focus"

Window UIElement & {
  Title        String
  ProcessId    Int
  State        "normal" | "minimized" | "maximized" | "fullscreen"
  ZIndex       Int
}

Parameter String
Value     Primitive

SystemSettings {
  Volume           Int
  Brightness       Int
  WifiEnabled      Bool
  BluetoothEnabled Bool
  Theme            "light" | "dark" | "system"
  Locale           String
}
ConfigState SystemSettings

MaintenanceTask "install_package" | "remove_package" | "update_os" | "clear_cache" | "empty_trash" | "security_scan" | "disk_cleanup"

OperatingSystem SoftwareApplication & {
  KernelVersion String
  Distribution  String
}

SystemHealth {
  Status           "healthy" | "warning" | "critical"
  DiskFreeBytes    Int
  PendingUpdates   Count
  ThreatsDetected  Count
  LastCheckedAt    DateTime
}

#
Level 3: File System & Data Operations
#

ContentStream {
  MimeType MimeType
  Size     Int
  Data     String
}

NewData {
  Payload   String
  Overwrite Bool
}

SourceLocation String
TargetLocation String
OperationType  "copy" | "cut" | "paste" | "rename" | "archive" | "extract" | "move" | "symlink"

FileEntry Thing & {
  Path        String
  Size        Int
  IsDirectory Bool
  Permissions String
  ModifiedAt  DateTime
}

FileSystemState {
  RootPath  String
  Entries   List(FileEntry)
  FreeSpace Int
}

Storage Thing & {
  MountPoint String
  FileSystem "ext4" | "apfs" | "ntfs" | "fat32" | "zfs" | "btrfs" | "xfs"
  Capacity   Int
}

Query     String
ThingList List(Thing)

#
Level 4: Web & Network Operations
#

Browser WebApplication & {
  CurrentUrl URL
  Tabs       List(WebPage)
  History    List(URL)
}

SearchEngine WebApplication & {
  Endpoint URL
  Provider String
}
SearchQuery {
  Text    String
  Filters Map(String, String)
  Limit   Count
}
SearchResults {
  Query      SearchQuery
  Items      List(WebPage)
  TotalCount Count
}

DataObject MediaObject & {
  Checksum String
}
SourceNode      URL | String
DestinationNode URL | String
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
  SessionId String
  User      Agent
  AuthToken AuthToken
  CreatedAt DateTime
}

#
Level 5: Digital Communication & Social
#

Recipient      Agent
MessageContent {
  Subject     Option(String)
  Body        String
  Attachments List(MediaObject)
}
MessageStatus {
  MessageId   String
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
  SessionId    String
  Participants ParticipantList
  Stream       MediaStream
  StartedAt    DateTime
  IsActive     Bool
}

SocialObject    SocialMediaPosting | Comment | MediaObject
InteractionType "post" | "comment" | "like" | "dislike" | "repost" | "bookmark" | "report"

#
Level 6: Applied Tasks
#

MediaContent MediaObject
Experience {
  Consumer    Agent
  Media       MediaContent
  Progress    Float
  CompletedAt Option(DateTime)
}

Document       DigitalDocument
TextOperations List("insert" | "delete" | "replace" | "format_bold" | "format_italic" | "align" | "paginate")

Formulas List(String)
AnalyticsResult {
  Summary Map(String, Float)
  Charts  List(ImageObject)
}

RawMedia      MediaObject
EditingTools  List(String)
MediaArtifact MediaObject

SourceCode SoftwareSourceCode
Compiler   SoftwareApplication
Executable SoftwareApplication & {
  BinaryPath String
  TargetArch String
}

GameEnvironment VideoGame
GameActions     List(String)
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
  ReceiptId     String
  Order         Order
  PaidAmount    MonetaryAmount
  PaymentMethod PaymentMethod
  Timestamp     DateTime
}
