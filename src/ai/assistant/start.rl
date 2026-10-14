_ string
_ grammar
_ meta
_ shell
_ runtimes
_ ctx

// --- 4. ДЕЙСТВИЯ (ACTIONS) И ШАГИ ВЕРИФИКАЦИИ ---

RunBuild [
  Npm.Cli.Build
  . Shell.Exec
  BuildResult
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
CreateTaskByError(Err BuildError) [
  Err
  . {
    SmallError [
      Task { Message Err.Text }
    ]
    LargeError [
      Task { Message [Err . ChunkLargeLog] }
    ]
  }
]

// Универсальный движок рекурсии, не знающий деталей сборки.
// Принимает текущую задачу TaskPolicy.

DoTask(Task Task){
  Task
  . Message
  . AttemptFix
}

RetryLoop(Task Task, Retries) [
  Retries {
    0 [ "Превышен лимит попыток. Остановка." . Shell.Log . return ]
    _ [ "Попытка неудачна. Осталось попыток: {Retries - 1}" . Shell.Log ]
  }
  Task
  . DoTask
  . {
    BuildSuccess [
      "Сборка успешно починена!"
      . Shell.Log
    ]
    BuildError(NewErr) [
      RetryLoop(NewErr, Retries - 1)
    ]
  }
]


SuccesText ObjectActed("Сборка", "собрана", "успешно", "с первого раза!")
LogSuccesText SuccesText . Shell.Log

// --- 6. ЧИСТЫЙ ОРКЕСТРАТОР (ВЕРХНИЙ УРОВЕНЬ) ---

// Оркестратор читается как английский текст
HandleBuildFailure(Err BuildError) [
  "Сборка упала (байт лога: {Size}). Запуск пайплайна восстановления..."
  . Shell.Log
  Err
  . CreateTaskByError
  . RetryLoop
]

Start [
  RunBuild
  . {
    BuildSuccess [ LogSuccesText ]
    BuildError[ _ . HandleBuildFailure ]
  }
]
