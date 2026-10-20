#
Abstract File System Nodes, Handles, Permissions & I/O Errors
#

FileOpenMode "read" | "write" | "append" | "read_write" | "create" | "truncate"

FilePermissions {
  OwnerRead   Bool
  OwnerWrite  Bool
  OwnerExec   Bool
  GroupRead   Bool
  GroupWrite  Bool
  GroupExec   Bool
  OthersRead  Bool
  OthersWrite Bool
  OthersExec  Bool
  OctalMode   Int
}

FileStat {
  Path        String
  Size        Int
  IsFile      Bool
  IsDirectory Bool
  IsSymlink   Bool
  Permissions FilePermissions
  CreatedAt   Int
  ModifiedAt  Int
  AccessedAt  Int
}

FileHandle {
  Fd   Int
  Path String
  Mode FileOpenMode
}

FsNodeType "DIRECTORY" | "FILE_JSON" | "FILE_STORAGE_URL" | "FILE_BINARY" | "SYMLINK"

FsNode IEntity & HasPrimary(FsNode) & {
  FsNodeType    FsNodeType
  Name          Char256
  ContentJson   Option(Any)
  ContentBinary Option(List(Byte))
  ParentId      Option(IdRef(FsNode))
  Ancestors     List(IdRef(FsNode))
}

CycleDetectedError { Message String, NodeId String }

IoErrorKind "not_found" | "permission_denied" | "already_exists" | "invalid_data" | "timed_out" | "eof" | "unknown"
IoError {
  Kind IoErrorKind
  Msg  String
  Path Option(String)
}
