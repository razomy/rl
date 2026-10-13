_ abstracts.chat
_ abstracts.core
_ ai.assistant.api


// --- 4. ДЕЙСТВИЯ (ACTIONS) И ШАГИ ВЕРИФИКАЦИИ ---

Project {
  Interaction {
    Schema(T) {
      Format T
      Run T
      Test T
      Build T
      Publish T
    }
  }
}

Cli {
  Schema Project.Interaction.Schema(String)
}


Npm {
  Cli {
    Launcher "npm run"
    BuildCommand(name) ["{Launcher} {name}"]
  } & Cli.Schema {
    Format BuildCommand("check")
    Run BuildCommand("dev")
    Test BuildCommand("test")
    Build BuildCommand("build")
    Publish BuildCommand("publish")
  }
}


RunBuild [
  Npm.Cli.Build
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

SuccesText(Object, Action, Agectiove) []
SuccesTextT SuccesText("Сборка", "собрана", "успешно", "с первого раза!")
LogSuccesTextT SuccesTextT . Shell.Log

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
    BuildSuccess [ LogSuccesTextT ]
    BuildError(Err) [ Err . HandleBuildFailure ]
  }
]
