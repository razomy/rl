#
Concrete Build Tooling (Npm, Cargo) & Docker Containers
#

Npm {
  Cli LaunchCliAndCliSchema {
    Launcher     "npm run"
    Command      ""
    BuildCommand LaunchCli.BuildCommand
    Format       BuildCommand("check")
    Lint         BuildCommand("lint")
    Run          BuildCommand("dev")
    Test         BuildCommand("test")
    Build        BuildCommand("build")
    Publish      BuildCommand("publish")
    Clean        BuildCommand("clean")
  }
}

Cargo {
  Cli LaunchCliAndCliSchema {
    Launcher     "cargo"
    Command      ""
    BuildCommand LaunchCli.BuildCommand
    Format       "cargo fmt"
    Lint         "cargo clippy"
    Run          "cargo run"
    Test         "cargo test"
    Build        "cargo build --release"
    Publish      "cargo publish"
    Clean        "cargo clean"
  }
}

Docker {
  ContainerImage {
    Repository String
    Tag        String
    Digest     Option(String)
  }
  ContainerState "created" | "running" | "paused" | "restarting" | "removing" | "exited" | "dead"
  Container {
    ContainerId String
    Image       ContainerImage
    State       ContainerState
    Ports       Map(Int, Int)
    EnvVars     Map(String, String)
    Volumes     List(String)
  }
}
