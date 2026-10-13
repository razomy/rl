// System operators add to parser
return "return"

// System layer
default {}

Error default
Array <T> & default
EmptyString { default "" }
String EmptyString

Shell {
    Log { <T> }
    Command { <T> }
}

IsError { <T> instanceof Error }

ErrorMatch {
    match <T> {
        IsError(T) { <TOnError> }
        () { <TOnDefault> }
    }
}

IterateLimit {
    Loop {
        <IsLimit> {
            return
        }
        ErrorMatch {
            <T>
        }
    }
}

// Tech Layer
SourceDir String & { default "." }

// Domain Layer
Text String
Name String

Message {}
TextMessage Message & { Text }
ToolMessage Message & { Name }
AnyMessage TextMessage | ToolMessage
AnyMessages Array<AnyMessage>

AiContext {
    SourceDir
    AnyMessages
}

// --- 5. Конкретные действия (Actions) ---
SuccessLog { Shell.Log("Build completed successfully!") }
ErrorLog { Shell.Log("Failed to fix build automatically.") }
RunBuild { Shell.Command("npm run build") }

IsSmallError { <T> "<=" 500 }

SplitByDoubleSpaces {
    <T String>
}

IsLargeError {
    <T>
    SplitByDoubleSpaces()
    IterateLimit(AiFix())
}

AiFix {
    <TError>
    AiContext {
        AnyMessages {
            ToolMessage("read_file")
            ToolMessage("write_file")
            TextMessage($"You are an AI expert. Context {TError}")
        }
    }
    IterateLimit()
}

// --- 6. Основная точка входа ---

Start {
    result RunBuild

    ErrorMatch(
        T result
        TOnError {
            match result {
                IsSmallError() { AiFix(error result) }
                IsLargeError() { IsLargeError(error result) }
            }
        }
        TOnDefault {
            SuccessLog()
        }
    )
}
