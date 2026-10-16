_ meta
_ primitive
_ structure
_ string
_ stream

// =============================================================================
// File System, Paths, Streams, FsNode Hierarchy & Git Version Control
// =============================================================================

AbsolutePathString String
RelativePathString String
PathString         AbsolutePathString | RelativePathString
FilePathString     PathString
DirPathString      PathString
SourcePathString   DirPathString

HasPath       { Path PathString }
HasDirPath    { DirPath DirPathString }
HasFileName   { FileName String }
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
  Created  List(String)
  Modified List(String)
  Deleted  List(String)
  Renamed  List((String, String))
}

GitCommitInfo {
  Hash        String
  AuthorName  String
  AuthorEmail String
  Date        String
  Message     String
  ParentHashes List(String)
}

GitStatus {
  LocalBranch  String
  RemoteBranch String
  RemoteDiff   String
  Clean        Bool
  Changes      GitFileChanges
}

// =============================================================================
// I/O Errors, Path & Fs Operations
// =============================================================================

IoErrorKind "not_found" | "permission_denied" | "already_exists" | "invalid_data" | "timed_out" | "eof" | "unknown"
IoError {
  Kind IoErrorKind
  Msg  String
  Path Option(String)
}

Path {
  Join(Parts List(String)) [ Parts . native_path_join ]
  Dirname(P String)        [ P . native_path_dirname ]
  Basename(P String)       [ P . native_path_basename ]
  Extension(P String)      [ P . native_path_ext ]
  Resolve(P String)        [ P . native_path_resolve ]
  IsAbsolute(P String)     [ P . native_path_is_abs ]
}

Fs {
  Open(Path String)                            [ Path . native_fs_open ]
  OpenWithMode(Path String, Mode FileOpenMode) [ (Path, Mode) . native_fs_open_mode ]
  Read(F FileHandle)                        [ Fd . native_fs_read ]
  Write(F FileHandle, Data String)             [ (Fd, Data) . native_fs_write ]
  Close(F FileHandle)                       [ Fd . native_fs_close ]
  ReadFile(Path String)                        [ Path . native_fs_read_file ]
  WriteFile(Path String, Data String)             [ (Path, Data) . native_fs_write_file ]
  AppendFile(Path String, Data String)            [ (Path, Data) . native_fs_append_file ]
  Exists(Path String)                          [ Path . native_fs_exists ]
  Stat(Path String)                            [ Path . native_fs_stat ]
  Remove(Path String)                          [ Path . native_fs_remove ]
  Copy(Src String, Dst String)                    [ (Src, Dst) . native_fs_copy ]
  Rename(Src String, Dst String)                  [ (Src, Dst) . native_fs_rename ]
  Mkdir(Path String)                           [ Path . native_fs_mkdir ]
  MkdirAll(Path String)                        [ Path . native_fs_mkdir_all ]
  ReadDir(Path String)                         [ Path . native_fs_read_dir ]
  Watch(Path String, OnEvent)                  [ (Path, OnEvent) . native_fs_watch ]

  // Bracket pattern: guarantees resource cleanup regardless of outcome
  WithFile(Path String, Action) [
    Path . Fs.Open . {
      FileHandle(F) [
        F . Action
        .> [ F . Fs.Close ]
      ]
    }
  ]
}

ReadConfig(Path String) [
  Fs.WithFile(Path, F [
    F . Fs.Read . Json.Parse
  ])
]
