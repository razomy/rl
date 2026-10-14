_ message
_ meta
_ structures

AiContext {
  SourceDir String
  Messages  List(Message)
}

BuildSuccess Any
BuildError   { Text Text }
BuildResult  BuildSuccess | BuildError

SmallError   BuildError & [ _.Text <= 500 ]
LargeError   BuildError & [ _.Text > 500 ]

// Профиль задачи для исправления: объединяет обработанный лог и бюджет попыток
Task {
  Message String
}

// --- 3. МИКРО-СЕРВИСЫ: ТУЛЫ, ПРОМПТЫ И КОНТЕКСТ ---

// Легко добавить новые тулы, не трогая остальной код
StandardDevTools List(
    ToolMessage { Name "read_file" }
    ToolMessage { Name "write_file" }
)

BuildSystemPrompt(ErrorLog String) [
  TextMessage {
    Text "You are an AI expert. Fix this build error: {ErrorLog}"
  }
]

// Чистая сборка контекста из лога и набора тулов
CreateAiContext(ErrorLog String) [
  AiContext {
    SourceDir "."
    Messages List2(
      ErrorLog
      BuildSystemPrompt
    )
  }
]
