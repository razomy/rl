#
Level 1: Physical Input & UI Elements + Level 2: System & Environment
#

CursorState {
  Position  Coordinates
  IsVisible Bool
  Shape     "default" | "pointer" | "text" | "wait" | "crosshair" | "move" | "not-allowed"
}

ClickType "single" | "double" | "right" | "middle" | "long-press"

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

PowerState "on" | "off" | "reboot" | "sleep" | "hibernate"

SystemState {
  Power       PowerState
  Uptime      Duration
  CpuUsage    Float
  MemoryUsage Float
}

Credentials {
  Username String
  Secret   String
  Method   "password" | "pin" | "biometric" | "token" | "oauth" | "passkey" | "ssh-key"
}

SecuritySystem Thing & {
  Provider    String
  AuthMethods List(String)
  MfaRequired Bool
}

AuthToken {
  Token     String
  ExpiresAt DateTime
  Scopes    List(String)
}

WindowAction "open" | "close" | "minimize" | "maximize" | "restore" | "resize" | "move" | "focus"

Window UIElement & {
  Title     String
  ProcessId Int
  State     "normal" | "minimized" | "maximized" | "fullscreen"
  ZIndex    Int
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
  Status          "healthy" | "warning" | "critical"
  DiskFreeBytes   Int
  PendingUpdates  Count
  ThreatsDetected Count
  LastCheckedAt   DateTime
}
