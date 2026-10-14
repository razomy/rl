Project {
  Interaction {
    Schema(T) {
      Format T
      Run T
      Test T
      Build T
      Publish T
    }
  }
}

Cli {
  Schema Project.Interaction.Schema(String)
}

LaunchCli {
  Launcher String
  Command String
  BuildCommand(name) ["{Launcher} {Command} {name}"]
}

LaunchCliAndCliSchema LaunchCli & Cli.Schema
