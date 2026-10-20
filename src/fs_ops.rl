#
File System Operations & Bracket Resource Management
#

ValidateFsNodeCycle(OldNode FsNode, NewNode FsNode) [
  NewNode.Ancestors . Filter([ _.Id == OldNode.Id ]) . {
    None [ NewNode ]
    Cons [ CycleDetectedError { Message "FileSystem hierarchy cycle detected", NodeId OldNode.Id } ]
  }
]

Fs {
  Open(Path String)                            [ Path . native_fs_open ]
  OpenWithMode(Path String, Mode FileOpenMode) [ (Path, Mode) . native_fs_open_mode ]
  Read(F FileHandle)                           [ Fd . native_fs_read ]
  Write(F FileHandle, Data String)             [ (Fd, Data) . native_fs_write ]
  Close(F FileHandle)                          [ Fd . native_fs_close ]
  ReadFile(Path String)                        [ Path . native_fs_read_file ]
  WriteFile(Path String, Data String)          [ (Path, Data) . native_fs_write_file ]
  AppendFile(Path String, Data String)         [ (Path, Data) . native_fs_append_file ]
  Exists(Path String)                          [ Path . native_fs_exists ]
  Stat(Path String)                            [ Path . native_fs_stat ]
  Remove(Path String)                          [ Path . native_fs_remove ]
  Copy(Src String, Dst String)                 [ (Src, Dst) . native_fs_copy ]
  Rename(Src String, Dst String)               [ (Src, Dst) . native_fs_rename ]
  Mkdir(Path String)                           [ Path . native_fs_mkdir ]
  MkdirAll(Path String)                        [ Path . native_fs_mkdir_all ]
  ReadDir(Path String)                         [ Path . native_fs_read_dir ]
  Watch(Path String, OnEvent)                  [ (Path, OnEvent) . native_fs_watch ]

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
