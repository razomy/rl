// System layer
Default {}
Error Default
Array <t> & Default
Str { Default "" }

Shell {
  Log { <message> }
  Command { <command> }
}

IsError { <error> instanceof Error }

ErrorMatch {
  match <query> {
    IsError(error query) { <onError> }
    () { <on> }
  }
}


// Tech Layer
SourceDir Str & { Default "." }

// Domain Layer
Text Str
Name Str


Message {}
TextMessage Message & { Text }
ToolMessage Message & { Name }
AnyMessage TextMessage | ToolMessage
AnyMessages Array[AnyMessage]

AiContext {
  SourceDir
  AnyMessages
}

Loop {
  <do>
  if <breakCondition>() { return } // add return as key word
  // Рекурсивный вызов шаблона с передачей тех же параметров
  Loop{
    Do <do>
    breakCondition <breakCondition>
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
SuccessLog { Shell.Log("Build completed successfully!") }
ErrorLog { Shell.Log("Failed to fix build automatically.") }
RunBuild { Shell.Command("npm run build") }

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
