_ primitives

FileHandle { Fd Int, Path Str }
IoError    { Msg Str }

Fs {
  Open(Path Str)            [ Path . native_fs_open ]
  Read(F FileHandle)        [ Fd . native_fs_read ]
  Close(F FileHandle)       [ Fd . native_fs_close ]

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
