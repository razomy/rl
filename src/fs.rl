_ meta
_ primitive
_ structure
_ string
_ stream

// =============================================================================
// File System, Paths, Streams, FsNode Hierarchy & Git Version Control
// =============================================================================

AbsolutePathString Str
RelativePathString Str
PathString         AbsolutePathString | RelativePathString
FilePathString     PathString
DirPathString      PathString
SourcePathString   DirPathString

HasPath       { Path PathString }
HasDirPath    { DirPath DirPathString }
HasFileName   { FileName Str }
HasFilePath   { FilePath FilePathString }
HasSourcePath { SourcePath SourcePathString }

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
  Path        Str
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
  Path Str
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

CycleDetectedError { Message Str, NodeId Str }

ValidateFsNodeCycle(OldNode FsNode, NewNode FsNode) [
  NewNode.Ancestors . Stream.Filter([ _.Id == OldNode.Id ]) . {
    None [ NewNode ]
    Cons [ CycleDetectedError { Message "FileSystem hierarchy cycle detected", NodeId OldNode.Id } ]
  }
]

// =============================================================================
// Git Version Control
// =============================================================================

GitFileChanges {
  Created  List(Str)
  Modified List(Str)
  Deleted  List(Str)
  Renamed  List((Str, Str))
}

GitCommitInfo {
  Hash        Str
  AuthorName  Str
  AuthorEmail Str
  Date        Str
  Message     Str
  ParentHashes List(Str)
}

GitStatus {
  LocalBranch  Str
  RemoteBranch Str
  RemoteDiff   Str
  Clean        Bool
  Changes      GitFileChanges
}

// =============================================================================
// I/O Errors, Path & Fs Operations
// =============================================================================

IoErrorKind "not_found" | "permission_denied" | "already_exists" | "invalid_data" | "timed_out" | "eof" | "unknown"
IoError {
  Kind IoErrorKind
  Msg  Str
  Path Option(Str)
}

Path {
  Join(Parts List(Str)) [ Parts . native_path_join ]
  Dirname(P Str)        [ P . native_path_dirname ]
  Basename(P Str)       [ P . native_path_basename ]
  Extension(P Str)      [ P . native_path_ext ]
  Resolve(P Str)        [ P . native_path_resolve ]
  IsAbsolute(P Str)     [ P . native_path_is_abs ]
}

Fs {
  Open(Path Str)                            [ Path . native_fs_open ]
  OpenWithMode(Path Str, Mode FileOpenMode) [ (Path, Mode) . native_fs_open_mode ]
  Read(F FileHandle)                        [ Fd . native_fs_read ]
  Write(F FileHandle, Data Str)             [ (Fd, Data) . native_fs_write ]
  Close(F FileHandle)                       [ Fd . native_fs_close ]
  ReadFile(Path Str)                        [ Path . native_fs_read_file ]
  WriteFile(Path Str, Data Str)             [ (Path, Data) . native_fs_write_file ]
  AppendFile(Path Str, Data Str)            [ (Path, Data) . native_fs_append_file ]
  Exists(Path Str)                          [ Path . native_fs_exists ]
  Stat(Path Str)                            [ Path . native_fs_stat ]
  Remove(Path Str)                          [ Path . native_fs_remove ]
  Copy(Src Str, Dst Str)                    [ (Src, Dst) . native_fs_copy ]
  Rename(Src Str, Dst Str)                  [ (Src, Dst) . native_fs_rename ]
  Mkdir(Path Str)                           [ Path . native_fs_mkdir ]
  MkdirAll(Path Str)                        [ Path . native_fs_mkdir_all ]
  ReadDir(Path Str)                         [ Path . native_fs_read_dir ]
  Watch(Path Str, OnEvent)                  [ (Path, OnEvent) . native_fs_watch ]

  // Bracket pattern: guarantees resource cleanup regardless of outcome
  WithFile(Path Str, Action) [
    Path . Fs.Open . {
      FileHandle(F) [
        F . Action
        .> [ F . Fs.Close ]
      ]
    }
  ]
}

ReadConfig(Path Str) [
  Fs.WithFile(Path, F [
    F . Fs.Read . Json.Parse
  ])
]
