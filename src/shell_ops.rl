#
Environment & Shell Operations
#

Env {
  Get(key String)          [ Key . native_env_get ]
  Set(key String, val String) [ (Key, Val) . native_env_set ]
  Remove(key String)       [ Key . native_env_remove ]
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
  Exec(cmd String)                 [ Cmd . native_exec ]
  Spawn(cmd String, args List(String)) [ (Cmd, Args) . native_process_spawn ]
  Kill(pid Int, sig ProcessSignal) [ (Pid, Sig) . native_process_kill ]
  Exit(code Int)                   [ Code . native_process_exit ]
}
