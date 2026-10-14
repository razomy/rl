_ project

Npm {
  Cli LaunchCliAndCliSchema {
    Launcher "npm run"
    Command String
    BuildCommand LaunchCli.BuildCommand
    Format BuildCommand("check")
    Run BuildCommand("dev")
    Test BuildCommand("test")
    Build BuildCommand("build")
    Publish BuildCommand("publish")
  }
}
