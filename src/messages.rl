#
Messages, Tool Nodes, Multi-Agent Refactoring & Self-Healing Build Agent
#

MessageRole      "system" | "user" | "assistant" | "tool" | "developer"
SenderType       "SYSTEM" | "USER" | "MODEL" | "TOOL"
MessageTextType  "thinking" | "text" | "example"
CodeLanguageType "ts" | "py" | "js" | "sh" | "rl" | "cs" | "rust" | "go" | "cpp"
AgentTaskType    "do" | "goto" | "repeat" | "subtask"

TextMn   IMessageNode & { Kind "TextMn", Text String, TextType MessageTextType, IsDone Bool }
CodeMn   IMessageNode & { Kind "CodeMn", Text String, CodeLanguage CodeLanguageType }
EntityMn IMessageNode & { Kind "EntityMn", Entity IdRef(IEntity) }
TaskMn   IMessageNode & { Kind "TaskMn", TaskType AgentTaskType, IsDone Bool, SubTasks List(IdRef(TaskMn)) }
SenderMn IMessageNode & { Kind "SenderMn", SenderType SenderType }

RequestMn IToolNode & { Kind "RequestMn", Args List(Any) }
ResultMn  IToolNode & { Kind "ResultMn", Result Any }
ToolMn    IToolNode & { Kind "ToolMn" }

AnyMn TextMn | CodeMn | EntityMn | TaskMn | RequestMn | ResultMn | ToolMn

TextMessage {
  Role MessageRole
  Text String
}

ToolMessage {
  Name      String
  Arguments Map(String, Any)
  Result    Option(String)
}

Message TextMessage | ToolMessage

MustUseToolLlmException LlmException
MaxAttemptLlmException  LlmException
PanicAnswerLlmException LlmException
TypedAnswerLlmException LlmException
ToolExecuteLlmException LlmException

DeveloperTask    { FileName String, Instructions String }
ArchitecturePlan { GlobalStrategy String, Tasks List(DeveloperTask) }

FileOperationAction "CREATE" | "UPDATE" | "DELETE" | "RENAME"

FileOperation {
  Action  FileOperationAction
  Path    String
  Content String
  Reason  String
}

BackupPaths {
  Dir              String
  RawLogPath       String
  JsonlOpsPath     String
  JsonSnapshotPath String
}

RefactorConfig {
  TargetDir            String
  SystemPrompt         String
  TaskPrompt           String
  Model                String
  IgnoreList           List(String)
  ApplyImmediately     Bool
  CleanupCacheAfterRun Bool
  MaxContinuationTurns Int
  MaxFullFilesInCache  Int
  BackupDirName        String
}

CompileError { Code Int, Log String }
BuildSuccess { Status String, Artifact String }
BuildError   { Text String, Size Int }
BuildResult  BuildSuccess | CompileError | BuildError

FatalError CompileError & [ _.Code >= 500 ]
Warning    CompileError & [ _.Code < 500 ]
SmallError BuildError & [ _.Size <= 500 ]
LargeError BuildError & [ _.Size > 500 ]

Task {
  Message String
}

StandardDevTools List2(
  ToolMessage { Name "read_file" },
  ToolMessage { Name "write_file" }
)

BuildSystemPrompt(ErrorLog String) [
  TextMessage {
    Role "system"
    Text "You are an AI expert. Fix this build error: {ErrorLog}"
  }
]

CreateAiContext(ErrorLog String) [
  AiContext {
    SourceDir    "."
    SystemPrompt "You are an autonomous software engineer."
    Messages     List1(BuildSystemPrompt(ErrorLog))
  }
]

Ai {
  Call(Query)          [ Query . native_ai_llm_request ]
  Embed(Text String)   [ Text . native_ai_embed ]
  Solve(Ctx AiContext) [ Ctx . native_ai_solve ]
}

RunCargoBuild [ "cargo build --release" . Shell.Exec ]

RunNpmBuild [
  Npm.Cli.Build
  . Shell.Exec
]

AgentLoop(Err, Retries Int) [
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
      . RunCargoBuild
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

AttemptFix(ErrorLog String) [
  ErrorLog
  . CreateAiContext
  . Ai.Solve
  .> [ "Applying generated patch..." . Shell.Log ]
  . RunNpmBuild
]

CreateTaskByError(Err BuildError) [
  Err . {
    SmallError [ Task { Message Err.Text } ]
    LargeError [ Task { Message (Err.Text . Substring(0, 500)) } ]
  }
]

DoTask(T Task) [
  T.Message . AttemptFix
]

RetryLoop(T Task, Retries Int) [
  Retries . {
    0 [ "Retry limit exceeded. Stopping." . Shell.Log ]
    _ [
      "Attempt failed. Remaining retries: {Retries - 1}" . Shell.Log
      T . DoTask . {
        BuildSuccess [
          "Build successfully repaired!" . Shell.Log
        ]
        BuildError(NewErr) [
          NewErr . CreateTaskByError . RetryLoop(Retries - 1)
        ]
      }
    ]
  }
]

SuccessText ObjectActed("Сборка", "собрана", "успешно", "с первого раза!")
LogSuccessText [ SuccessText . Shell.Log ]

HandleBuildFailure(Err BuildError) [
  "Build failed (log bytes: {Err.Size}). Starting recovery pipeline..." . Shell.Log
  Err
  . CreateTaskByError
  . RetryLoop(3)
]

StartFixBuild [
  RunNpmBuild . {
    BuildSuccess    [ LogSuccessText ]
    BuildError(Err) [ Err . HandleBuildFailure ]
  }
]

NormalizeTextFlow(InputText String, AgentInstance) [
  InputText . {
    "1. Has typos or unknown words? (pymorphy3)"       [ AgentInstance . NormalizeTextFlow ]
    "2. Missing clear Subject+Verb structure? (SpaCy)" [ AgentInstance . NormalizeTextFlow ]
    "3. Has ambiguous pronouns (it, this, there)?"     [ AgentInstance . NormalizeTextFlow ]
    "4. High perplexity or metaphor? (KenLM)"          [ AgentInstance . NormalizeTextFlow ]
    _                                                  [ InputText ]
  }
]
