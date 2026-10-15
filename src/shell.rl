_ meta
_ primitives
_ structures

// =============================================================================
// Shell, Process & OS Environment
// =============================================================================

ProcessSignal "SIGINT" | "SIGTERM" | "SIGKILL" | "SIGHUP" | "SIGQUIT" | "SIGUSR1" | "SIGUSR2"

ProcessOutput {
  ExitCode Int
  Stdout   Str
  Stderr   Str
}

ProcessInfo {
  Pid      Int
  Ppid     Int
  Command  Str
  CpuUsage Float
  MemBytes Int
}

Env {
  Get(Key Str)              [ Key . native_env_get ]
  Set(Key Str, Val Str)     [ (Key, Val) . native_env_set ]
  Remove(Key Str)           [ Key . native_env_remove ]
  All()                     [ native_env_all ]
  CurrentDir()              [ native_env_cwd ]
  HomeDir()                 [ native_env_home ]
  TempDir()                 [ native_env_temp ]
  Args()                    [ native_env_args ]
}

Shell {
  Log(Msg)                  [ Msg . native_print ]
  Warn(Msg)                 [ "[WARN] {Msg}" . native_print_err ]
  Error(Msg)                [ "[ERROR] {Msg}" . native_print_err ]
  ReadLine()                [ native_stdin_read_line ]
  Exec(Cmd Str)             [ Cmd . native_exec ]
  Spawn(Cmd Str, Args List(Str)) [ (Cmd, Args) . native_process_spawn ]
  Kill(Pid Int, Sig ProcessSignal) [ (Pid, Sig) . native_process_kill ]
  Exit(Code Int)            [ Code . native_process_exit ]
}