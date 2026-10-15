_ primitives
_ shell

CompileError { Code Int, Log Str }
BuildSuccess { Status Str, Artifact Str }
BuildResult  BuildSuccess | CompileError

FatalError CompileError & [ _.Code >= 500 ]
Warning    CompileError & [ _.Code < 500 ]

AiQuery    { SystemPrompt Str, UserPrompt Str }
AiResponse { Diff Str, Explanation Str }

Ai {
  Call(Query) [ Query . native_ai_llm_request ]
}

RunBuild [ "cargo build --release" . Shell.Exec ]

AgentLoop(Err, Retries) [
  Retries . {
    [ _ == 0 ] [ "Retry limit reached. Human intervention required." . Shell.Log ]

    _ [
      AiQuery {
        SystemPrompt "You are an engineer. Fix the compilation error with a git diff patch."
        UserPrompt   "Error log: {Err.Log}. Write a patch."
      }
      . Ai.Call
      .> [ "AI suggests solution: {Explanation}" . Shell.Log ]
      .> [ "git apply {Diff}" . Shell.Exec ]
      . RunBuild
      . {
        BuildSuccess [
          "Build succeeded after applying patch!" . Shell.Log
        ]

        CompileError(NewErr) [
          NewErr
          .> [ "Patch did not help. Starting next attempt..." . Shell.Log ]
          . AgentLoop(Retries - 1)
        ]
      }
    ]
  }
]
