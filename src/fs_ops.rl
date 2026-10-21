#
File System Operations & Bracket Resource Management
#

ValidateFsNodeCycle(oldNode FsNode, newNode FsNode) [
  NewNode.Ancestors . Filter([ _.Id == OldNode.Id ]) . {
    None [ NewNode ]
    Cons [ CycleDetectedError { Message "FileSystem hierarchy cycle detected", nodeId OldNode.Id } ]
  }
]

Fs {
  Open(path String)                            [ Path . native_fs_open ]
  OpenWithMode(path String, mode FileOpenMode) [ (Path, Mode) . native_fs_open_mode ]
  Read(f FileHandle)                           [ Fd . native_fs_read ]
  Write(f FileHandle, data String)             [ (Fd, Data) . native_fs_write ]
  Close(f FileHandle)                          [ Fd . native_fs_close ]
  ReadFile(path String)                        [ Path . native_fs_read_file ]
  WriteFile(path String, data String)          [ (Path, Data) . native_fs_write_file ]
  AppendFile(path String, data String)         [ (Path, Data) . native_fs_append_file ]
  Exists(path String)                          [ Path . native_fs_exists ]
  Stat(path String)                            [ Path . native_fs_stat ]
  Remove(path String)                          [ Path . native_fs_remove ]
  Copy(src String, dst String)                 [ (Src, Dst) . native_fs_copy ]
  Rename(src String, dst String)               [ (Src, Dst) . native_fs_rename ]
  Mkdir(path String)                           [ Path . native_fs_mkdir ]
  MkdirAll(path String)                        [ Path . native_fs_mkdir_all ]
  ReadDir(path String)                         [ Path . native_fs_read_dir ]
  Watch(path String, OnEvent)                  [ (Path, OnEvent) . native_fs_watch ]

  WithFile(path String, Action) [
    Path . Fs.Open . {
      FileHandle(F) [
        F . Action
        .> [ F . Fs.Close ]
      ]
    }
  ]
}

ReadConfig(path String) [
  Fs.WithFile(Path, F [
    F . Fs.Read . Json.Parse
  ])
]
