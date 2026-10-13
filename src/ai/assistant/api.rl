_ abstracts.chat
_ abstracts.core

AiContext {
  SourceDir String
  Messages  List(Message)
}

BuildSuccess { Status String }
BuildError   { Log String, Size Int }
BuildResult  BuildSuccess | BuildError

SmallError   BuildError & [ _.Size <= 500 ]
LargeError   BuildError & [ _.Size > 500 ]

// Профиль задачи для исправления: объединяет обработанный лог и бюджет попыток
TaskPolicy {
  CleanLog String
  Retries  Int
}

// --- 3. МИКРО-СЕРВИСЫ: ТУЛЫ, ПРОМПТЫ И КОНТЕКСТ ---

// Легко добавить новые тулы, не трогая остальной код
StandardDevTools [
  List2(
    ToolMessage { Name "read_file" }
    ToolMessage { Name "write_file" }
  )
]

BuildSystemPrompt(ErrorLog String) [
  TextMessage {
    Text "You are an AI expert. Fix this build error: {ErrorLog}"
  }
]

// Чистая сборка контекста из лога и набора тулов
CreateAiContext(ErrorLog String) [
  AiContext {
    SourceDir "."
    Messages  Cons {
      Head (ErrorLog . BuildSystemPrompt)
      Tail StandardDevTools
    }
  }
]

