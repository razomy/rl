#
Abstract Process Signals, Output & Info
#

ProcessSignal "SIGINT" | "SIGTERM" | "SIGKILL" | "SIGHUP" | "SIGQUIT" | "SIGUSR1" | "SIGUSR2"

ProcessOutput {
  ExitCode Int
  Stdout   String
  Stderr   String
}

ProcessInfo {
  Pid      Int
  Ppid     Int
  Command  String
  CpuUsage Float
  MemBytes Int
}
