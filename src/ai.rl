_ meta
_ primitives
_ structures
_ string
_ language
_ shell
_ computing

// =============================================================================
// 1. AI / ML Core Entities, Models & Hyperparameters
// =============================================================================

ModelModality "text" | "vision" | "audio" | "video" | "multimodal" | "embedding" | "code" | "reinforcement"
ModelProvider "openai" | "anthropic" | "google" | "meta" | "mistral" | "deepseek" | "local"

ModelConfig {
  Provider         ModelProvider
  ModelName        Str
  Modalities       List(ModelModality)
  ContextWindow    Int
  MaxOutputTokens  Int
  Temperature      Float
  TopP             Float
  TopK             Int
  FrequencyPenalty Float
  PresencePenalty  Float
  StopSequences    List(Str)
}

TokenUsage {
  PromptTokens     Int
  CompletionTokens Int
  TotalTokens      Int
  CachedTokens     Int
}

// =============================================================================
// 2. Messages, Prompts, Tools & Context (merged from message.rl & ai_ctx.rl)
// =============================================================================

MessageRole "system" | "user" | "assistant" | "tool" | "developer"

TextMessage {
  Role MessageRole
  Text Str
}

ToolParameter {
  Name        Str
  Type        Str
  Description Str
  Required    Bool
}

ToolDefinition {
  Name        Str
  Description Str
  Parameters  List(ToolParameter)
}

ToolMessage {
  Name      Str
  Arguments Map(Str, Any)
  Result    Option(Str)
}

Message TextMessage | ToolMessage

AiContext {
  SourceDir    Str
  Model        Option(ModelConfig)
  SystemPrompt Str
  Messages     List(Message)
  Tools        List(ToolDefinition)
}

AiQuery {
  SystemPrompt Str
  UserPrompt   Str
}

AiResponse {
  Content     Str
  Diff        Str
  Explanation Str
  ToolCalls   List(ToolMessage)
  Usage       Option(TokenUsage)
}

// =============================================================================
// 3. RAG (Retrieval-Augmented Generation) & Embeddings
// =============================================================================

DocumentChunk {
  ChunkId   Str
  SourceUri Str
  Content   Str
  Embedding List(Float)
  Score     Float
}

KnowledgeBase {
  Name   Str
  Chunks List(DocumentChunk)
}

// =============================================================================
// 4. Build Verification & Self-Healing Agent (merged from ai.rl & ai_start.rl)
// =============================================================================

CompileError { Code Int, Log Str }
BuildSuccess { Status Str, Artifact Str }
BuildError   { Text Str, Size Int }
BuildResult  BuildSuccess | CompileError | BuildError

FatalError   CompileError & [ _.Code >= 500 ]
Warning      CompileError & [ _.Code < 500 ]
SmallError   BuildError & [ _.Size <= 500 ]
LargeError   BuildError & [ _.Size > 500 ]

Task {
  Message Str
}

StandardDevTools List2(
  ToolMessage { Name "read_file" },
  ToolMessage { Name "write_file" }
)

BuildSystemPrompt(ErrorLog Str) [
  TextMessage {
    Role "system"
    Text "You are an AI expert. Fix this build error: {ErrorLog}"
  }
]

CreateAiContext(ErrorLog Str) [
  AiContext {
    SourceDir    "."
    SystemPrompt "You are an autonomous software engineer."
    Messages     List1(BuildSystemPrompt(ErrorLog))
  }
]

Ai {
  Call(Query)     [ Query . native_ai_llm_request ]
  Embed(Text Str) [ Text . native_ai_embed ]
  Solve(Ctx AiContext) [ Ctx . native_ai_solve ]
}

RunCargoBuild [ "cargo build --release" . Shell.Exec ]

RunNpmBuild [
  Npm.Cli.Build
  . Shell.Exec
]

// Recursive Autonomous Patch Loop
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

// Policy-Driven Task Retry Engine
AttemptFix(ErrorLog Str) [
  ErrorLog
  . CreateAiContext
  . Ai.Solve
  .> [ "Applying generated patch..." . Shell.Log ]
  . RunNpmBuild
]

CreateTaskByError(Err BuildError) [
  Err . {
    SmallError [ Task { Message Err.Text } ]
    LargeError [ Task { Message (Err.Text . Str.Substring(0, 500)) } ]
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
    BuildSuccess     [ LogSuccessText ]
    BuildError(Err)  [ Err . HandleBuildFailure ]
  }
]

// =============================================================================
// 5. NLP Text Normalization Flow (merged from ai_flows.rl)
// =============================================================================

NormalizeTextFlow(InputText Str, AgentInstance) [
  InputText . {
    "1. Has typos or unknown words? (pymorphy3)"       [ AgentInstance . NormalizeTextFlow ]
    "2. Missing clear Subject+Verb structure? (SpaCy)" [ AgentInstance . NormalizeTextFlow ]
    "3. Has ambiguous pronouns (it, this, there)?"     [ AgentInstance . NormalizeTextFlow ]
    "4. High perplexity or metaphor? (KenLM)"          [ AgentInstance . NormalizeTextFlow ]
    _                                                  [ InputText ]
  }
]