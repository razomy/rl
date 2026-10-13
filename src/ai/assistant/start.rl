_ abstracts.core

// --- 2. ДОМЕН: СООБЩЕНИЯ И СТРУКТУРЫ ДАННЫХ ---

TextMessage { Text String }
ToolMessage { Name String }
Message     TextMessage | ToolMessage

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


// --- 4. ДЕЙСТВИЯ (ACTIONS) И ШАГИ ВЕРИФИКАЦИИ ---

RunBuild [
  "npm run build"
  . Shell.Exec
  BuildResult
]

ChunkLargeLog(Err LargeError) [
  Log . native_split_double_spaces
]

// Один изолированный шаг: AI генерирует фикс -> фикс применяется -> билд проверяется
// На входе: String (лог ошибки). На выходе: BuildResult (BuildSuccess | BuildError)
AttemptFix(ErrorLog String) [
  ErrorLog
  . CreateAiContext
  . native_ai_solve
  .> [ "Применяем сгенерированный патч..." . Shell.Log ]
  . RunBuild
]


// --- 5. ДВИЖОК СТРАТЕГИЙ (POLICIES) И ПОВТОРОВ (RETRY ENGINE) ---

// Отображение типа ошибки в конкретную политику исправления
// Хочешь добавить MediumError? Просто добавь одну строчку сюда.
ResolvePolicy(Err BuildError) [
  Err . {
    SmallError [
      TaskPolicy { CleanLog Log, Retries 3 }
    ]
    LargeError [
      TaskPolicy { CleanLog (Err . ChunkLargeLog), Retries 5 }
    ]
  }
]

// Универсальный движок рекурсии, не знающий деталей сборки.
// Принимает текущую задачу TaskPolicy.
RetryLoop(Policy TaskPolicy) [
  Retries . {
    0 [ "Превышен лимит попыток. Остановка." . Shell.Log ]

    _ [
      CleanLog
      . AttemptFix
      . {
        BuildSuccess [
          "Сборка успешно починена!"
          . Shell.Log
        ]

        BuildError(NewErr) [
          "Попытка неудачна. Осталось попыток: {Retries - 1}"
          . Shell.Log
          . TaskPolicy {
            CleanLog NewErr.Log
            Retries  [ Retries - 1 ]
          }
          . RetryLoop
        ]
      }
    ]
  }
]


// --- 6. ЧИСТЫЙ ОРКЕСТРАТОР (ВЕРХНИЙ УРОВЕНЬ) ---

// Оркестратор читается как английский текст
HandleBuildFailure(Err BuildError) [
  "Сборка упала (байт лога: {Size}). Запуск пайплайна восстановления..."
  . Shell.Log
  Err
  . ResolvePolicy
  . RetryLoop
]

Start [
  RunBuild
  . {
    BuildSuccess [ "Сборка собрана успешно с первого раза!" . Shell.Log ]
    BuildError(Err) [ Err . HandleBuildFailure ]
  }
]
