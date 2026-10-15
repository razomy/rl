_ meta
_ primitive
_ structure
_ string
_ language
_ shell
_ computing
_ hir

// =============================================================================
// 1. AI / ML Core Entities, Neural Networks, Optimizers & Hyperparameters
// =============================================================================

ModelModality "text" | "vision" | "audio" | "video" | "multimodal" | "embedding" | "code" | "reinforcement" | "tabular" | "graph" | "3d"
ModelProvider "openai" | "anthropic" | "google" | "meta" | "mistral" | "deepseek" | "cohere" | "xai" | "huggingface" | "local"

ActivationFunction "ReLU" | "LeakyReLU" | "GELU" | "SiLU" | "Swish" | "Sigmoid" | "Tanh" | "Softmax" | "Softplus" | "ELU" | "Mish"
LossFunction       "CrossEntropy" | "BinaryCrossEntropy" | "MSE" | "MAE" | "Huber" | "KLDivergence" | "Contrastive" | "Triplet" | "CTC" | "Focal"
OptimizerType      "SGD" | "Adam" | "AdamW" | "RMSprop" | "Adagrad" | "Lion" | "Muon" | "SOAP" | "LBFGS"
PrecisionFormat    "FP64" | "FP32" | "TF32" | "FP16" | "BF16" | "FP8_E4M3" | "FP8_E5M2" | "INT8" | "INT4" | "NF4"

NeuralLayerType
  "Linear" | "Conv1D" | "Conv2D" | "Conv3D" | "DepthwiseConv2D" | "TransposeConv2D"
  | "MaxPool" | "AvgPool" | "AdaptiveAvgPool"
  | "BatchNorm" | "LayerNorm" | "RMSNorm" | "GroupNorm"
  | "Dropout" | "Embedding" | "PositionalEncoding" | "RoPE"
  | "RNN" | "LSTM" | "GRU" | "MambaSSM"
  | "MultiHeadAttention" | "GroupedQueryAttention" | "FlashAttention" | "CrossAttention"
  | "MoERouter" | "FeedForwardSwiGLU" | "ResidualConnection"

NeuralLayer {
  Name        Str
  LayerType   NeuralLayerType
  InputShape  List(Int)
  OutputShape List(Int)
  Parameters  Count
  Trainable   Bool
}

TrainingHyperparameters {
  LearningRate       Float
  WeightDecay        Float
  BatchSize          Int
  GradientAccumSteps Int
  MaxEpochs          Int
  WarmupSteps        Int
  MaxGradNorm        Float
  Optimizer          OptimizerType
  Loss               LossFunction
  Precision          PrecisionFormat
  Seed               Int
}

LoRAConfig {
  Rank          Int
  Alpha         Float
  Dropout       Float
  TargetModules List(Str)
}

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
  ReasoningTokens  Int
}

// =============================================================================
// 2. Reinforcement Learning (MDP, Policies, Value Functions)
// =============================================================================

RLAlgorithm "DQN" | "PPO" | "SAC" | "TD3" | "DDPG" | "A2C" | "A3C" | "GRPO" | "DPO" | "RLHF" | "AlphaZero" | "MuZero"

ExperienceReplayTransition {
  State     Any
  Action    Any
  Reward    Float
  NextState Any
  Done      Bool
}

MarkovDecisionProcess {
  DiscountFactorGamma Float
  Horizon             Int
  ActionSpace         Str
  ObservationSpace    Str
}

// =============================================================================
// 3. Messages, Prompts, Tools, Interaction Graph & Context
// =============================================================================

MessageRole      "system" | "user" | "assistant" | "tool" | "developer"
SenderType       "SYSTEM" | "USER" | "MODEL" | "TOOL"
MessageTextType  "thinking" | "text" | "example"
CodeLanguageType "ts" | "py" | "js" | "sh" | "rl" | "cs" | "rust" | "go" | "cpp"
AgentTaskType    "do" | "goto" | "repeat" | "subtask"

IMessageNode IEntity

TextMn   IMessageNode & { Kind "TextMn", Text Str, TextType MessageTextType, IsDone Bool }
CodeMn   IMessageNode & { Kind "CodeMn", Text Str, CodeLanguage CodeLanguageType }
EntityMn IMessageNode & { Kind "EntityMn", Entity IdRef(IEntity) }
TaskMn   IMessageNode & { Kind "TaskMn", TaskType AgentTaskType, IsDone Bool, SubTasks List(IdRef(TaskMn)) }
SenderMn IMessageNode & { Kind "SenderMn", SenderType SenderType }

IToolNode IMessageNode & { FunctionSpec FunctionHirn }
RequestMn IToolNode    & { Kind "RequestMn", Args List(Any) }
ResultMn  IToolNode    & { Kind "ResultMn", Result Any }
ToolMn    IToolNode    & { Kind "ToolMn" }

AnyMn TextMn | CodeMn | EntityMn | TaskMn | RequestMn | ResultMn | ToolMn

InteractionTurn IEntity & {
  Kind     "InteractionTurn"
  Sender   IdRef(SenderMn)
  Messages List(IdRef(AnyMn))
}

InteractionEntity IEntity & {
  InteractionTurns List(InteractionTurn)
}

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

LlmException            { ActualResult Str, ExpectedResult Str }
MustUseToolLlmException LlmException
MaxAttemptLlmException  LlmException
PanicAnswerLlmException LlmException
TypedAnswerLlmException LlmException
ToolExecuteLlmException LlmException

// =============================================================================
// 4. Multi-Agent Architecture & Autonomous Code Refactoring
// =============================================================================

DeveloperTask    { FileName Str, Instructions Str }
ArchitecturePlan { GlobalStrategy Str, Tasks List(DeveloperTask) }

FileOperationAction "CREATE" | "UPDATE" | "DELETE" | "RENAME"

FileOperation {
  Action  FileOperationAction
  Path    Str
  Content Str
  Reason  Str
}

BackupPaths {
  Dir              Str
  RawLogPath       Str
  JsonlOpsPath     Str
  JsonSnapshotPath Str
}

RefactorConfig {
  TargetDir            Str
  SystemPrompt         Str
  TaskPrompt           Str
  Model                Str
  IgnoreList           List(Str)
  ApplyImmediately     Bool
  CleanupCacheAfterRun Bool
  MaxContinuationTurns Int
  MaxFullFilesInCache  Int
  BackupDirName        Str
}

// =============================================================================
// 5. RAG (Retrieval-Augmented Generation) & Embeddings
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
// 6. Build Verification & Self-Healing Agent
// =============================================================================

CompileError { Code Int, Log Str }
BuildSuccess { Status Str, Artifact Str }
BuildError   { Text Str, Size Int }
BuildResult  BuildSuccess | CompileError | BuildError

FatalError CompileError & [ _.Code >= 500 ]
Warning    CompileError & [ _.Code < 500 ]
SmallError BuildError & [ _.Size <= 500 ]
LargeError BuildError & [ _.Size > 500 ]

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
  Call(Query)          [ Query . native_ai_llm_request ]
  Embed(Text Str)      [ Text . native_ai_embed ]
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
    BuildSuccess    [ LogSuccessText ]
    BuildError(Err) [ Err . HandleBuildFailure ]
  }
]

NormalizeTextFlow(InputText Str, AgentInstance) [
  InputText . {
    "1. Has typos or unknown words? (pymorphy3)"       [ AgentInstance . NormalizeTextFlow ]
    "2. Missing clear Subject+Verb structure? (SpaCy)" [ AgentInstance . NormalizeTextFlow ]
    "3. Has ambiguous pronouns (it, this, there)?"     [ AgentInstance . NormalizeTextFlow ]
    "4. High perplexity or metaphor? (KenLM)"          [ AgentInstance . NormalizeTextFlow ]
    _                                                  [ InputText ]
  }
]
