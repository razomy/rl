// --- 1. Определение типов и структур данных ---

Default {}
// Используем синтаксис ключ значение для свойств шаблона
DefaultStr str & { Default "" }
SourceDir DefaultStr & { Default "." }

Text DefaultStr
Name DefaultStr
Message {}

TextMessage Message & { text Text }
ToolMessage Message & { name Name }

// Исправлена опечатка (было TextMessage | TextMessage)
AnyMessage TextMessage | ToolMessage
AnyMessages Array<AnyMessage>

AiContext {
  SourceDir
  AnyMessages
}

// --- 2. Системные модули ---

Shell {
  // <T> - это входной слот (аргумент) шаблона
  Log { Process.Log(<T>) }
  Command { Process.Execute(<T>) }
}

// --- 3. Предикаты и паттерн-матчинг ---

// Компактное определение условия
IsError { <T> instanceof Error }

MatchYesNo {
  match <Query> {
    // Вызываем IsError, передавая ему Query в слот T
    IsError(T <Query>) { <Yes> }
    Default { <No> }
  }
}

// --- 4. Циклы и итерации ---

Loop {
  <Do>()
  if <BreakCondition>() { return }
  // Рекурсивный вызов шаблона с передачей тех же параметров
  Loop{
    Do <Do>
    BreakCondition <BreakCondition>
  }
}

For {
  // Внутреннее состояние лучше инициализировать до цикла
  i = 0
  Loop(
    Do {
      <Do>()
      i = i + 1
    }
    BreakCondition {
     i more <Limit>
   }
  )
}

TrueIterate {
  loop(limit 100) {
    // <Step> - это шаблон, который мы вызываем на каждой итерации
    match <Step>() {
      complete { break }
      error { break }
    }
  }
}

// --- 5. Конкретные действия (Actions) ---

// Вызов шаблона Shell.Log с передачей параметра T
SuccessLog { Shell.Log(T "Build completed successfully!") }
ErrorLog { Shell.Log(T "Failed to fix build automatically.") }
RunBuild { Shell.Command(T "npm run build") }

IsSmallError { <error Error> less 500 }

IsLargeError {
  <error Error>
    split_by_double_spaces()
    // Передаем шаблон AiFix в качестве параметра Step
    TrueIterate(Step { AiFix(error _) })
}

AiFix {
  // Инстанцируем контекст через ()
  context = AiContext()
  
  context
    add(<error>)
    add_tool("read_file")
    add_tool("write_file")
    // Интерполяция строк со слотом <error>
    add_prompt($"You are an AI expert. Context {<error>}")
    iterate(limit 100)
}

// --- 6. Основная точка входа ---

Start {
  result RunBuild()
  
  MatchYesNo(
    Query result
    Yes {
      match result {
        IsSmallError() { AiFix(error result) }
        IsLargeError() { IsLargeError(error result) }
      }
    }
    No {
      SuccessLog()
    }
  )
}
