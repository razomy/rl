#
Environment & Shell Operations
#

Env {
  Get(Key String)          [ Key . native_env_get ]
  Set(Key String, Val String) [ (Key, Val) . native_env_set ]
  Remove(Key String)       [ Key . native_env_remove ]
  All()                    [ native_env_all ]
  CurrentDir()             [ native_env_cwd ]
  HomeDir()                [ native_env_home ]
  TempDir()                [ native_env_temp ]
  Args()                   [ native_env_args ]
}

Shell {
  Log(Msg)                         [ Msg . native_print ]
  Warn(Msg)                        [ "[WARN] {Msg}" . native_print_err ]
  Error(Msg)                       [ "[ERROR] {Msg}" . native_print_err ]
  ReadLine()                       [ native_stdin_read_line ]
  Exec(Cmd String)                 [ Cmd . native_exec ]
  Spawn(Cmd String, Args List(String)) [ (Cmd, Args) . native_process_spawn ]
  Kill(Pid Int, Sig ProcessSignal) [ (Pid, Sig) . native_process_kill ]
  Exit(Code Int)                   [ Code . native_process_exit ]
}
