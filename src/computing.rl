#
Abstract Computing Entities (UIElement, System, Storage, Session)
#

Coordinates Point2D
BoundingBox Rectangle

UIElement Thing & {
  ElementId String
  TagName   String
  Bounds    BoundingBox
  IsEnabled Bool
  IsVisible Bool
  IsFocused Bool
  TextValue Option(String)
  AriaRole  Option(String)
}

System Thing & {
  Hostname     String
  Architecture "x86_64" | "arm64" | "riscv64" | "wasm32"
  CpuCount     Count
  MemoryTotal  Int
}

Storage Thing & {
  MountPoint String
  FileSystem "ext4" | "apfs" | "ntfs" | "fat32" | "zfs" | "btrfs" | "xfs"
  Capacity   Int
}

Session {
  SessionId String
  User      Agent
  AuthToken AuthToken
  CreatedAt DateTime
}
