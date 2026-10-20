#
Abstract AI / ML Core Entities, MDP, Interaction Graph, Context & RAG
#

NeuralLayer {
  Name        String
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
  TargetModules List(String)
}

ModelConfig {
  Provider         ModelProvider
  ModelName        String
  Modalities       List(ModelModality)
  ContextWindow    Int
  MaxOutputTokens  Int
  Temperature      Float
  TopP             Float
  TopK             Int
  FrequencyPenalty Float
  PresencePenalty  Float
  StopSequences    List(String)
}

TokenUsage {
  PromptTokens     Int
  CompletionTokens Int
  TotalTokens      Int
  CachedTokens     Int
  ReasoningTokens  Int
}

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
  ActionSpace         String
  ObservationSpace    String
}

IMessageNode IEntity
IToolNode    IMessageNode & { FunctionSpec FunctionHirn }

InteractionTurn IEntity & {
  Kind     "InteractionTurn"
  Sender   IdRef(SenderMn)
  Messages List(IdRef(AnyMn))
}

InteractionEntity IEntity & {
  InteractionTurns List(InteractionTurn)
}

ToolParameter {
  Name        String
  Type        String
  Description String
  Required    Bool
}

ToolDefinition {
  Name        String
  Description String
  Parameters  List(ToolParameter)
}

AiContext {
  SourceDir    String
  Model        Option(ModelConfig)
  SystemPrompt String
  Messages     List(Message)
  Tools        List(ToolDefinition)
}

AiQuery {
  SystemPrompt String
  UserPrompt   String
}

AiResponse {
  Content     String
  Diff        String
  Explanation String
  ToolCalls   List(ToolMessage)
  Usage       Option(TokenUsage)
}

LlmException { ActualResult String, ExpectedResult String }

DocumentChunk {
  ChunkId   String
  SourceUri String
  Content   String
  Embedding List(Float)
  Score     Float
}

KnowledgeBase {
  Name   String
  Chunks List(DocumentChunk)
}
