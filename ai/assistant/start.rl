// =============================================================================
// МИГРАЦИЯ: АВТОНОМНЫЙ ПАЙПЛАЙН СБОРКИ И AI-FIX (СПЕЦИФИКАЦИЯ V2.1)
// =============================================================================

// --- 1. СИСТЕМНЫЙ СЛОЙ И СПИСКИ ---

Int {}
Str {}
Nil {}
Cons(T) { Head T, Tail List(T) }
List(T) Nil | Cons(T)

Shell {
    Log(Msg)  [ Msg . native_print ]
    Exec(Cmd) [ Cmd . native_exec ]
}


// --- 2. ДОМЕННЫЙ СЛОЙ: СООБЩЕНИЯ И КОНТЕКСТ ---

TextMessage { Text Str }
ToolMessage { Name Str }
Message     TextMessage | ToolMessage

AiContext {
    SourceDir Str
    Messages  List(Message)
}


// --- 3. РЕЗУЛЬТАТЫ СБОРКИ И УТОЧНЯЮЩИЕ ТИПЫ (REFINEMENTS) ---

BuildSuccess { Status Str }
BuildError   { Log Str, Size Int }
BuildResult  BuildSuccess | BuildError

// Бывшие IsSmallError / IsLargeError выражаются через предикаты уточнения
SmallError BuildError & [ _.Size <= 500 ]
LargeError BuildError & [ _.Size > 500 ]


// --- 4. ДЕЙСТВИЯ И ДЕКОМПОЗИЦИЯ ---

RunBuild [ "npm run build" . Shell.Exec ]

// Преобразование крупной ошибки (дробление контекста по двойным пробелам)
SplitByDoubleSpaces(LargeError) [
    Log . native_split_double_spaces
]


// --- 5. AI ФИКС И ЦИКЛ ПОПЫТОК (ITERATE LIMIT) ---

AiFix(Err, Retries) [
    Retries . {
        0 [ "Превышен лимит попыток исправления." . Shell.Log ]

        _ [
            // Формируем декларативный контекст для агента
            AiContext {
                SourceDir "."
                Messages  Cons {
                    Head ToolMessage { Name "read_file" }
                    Tail Cons {
                        Head ToolMessage { Name "write_file" }
                        Tail Cons {
                            Head TextMessage {
                                Text "You are an AI expert. Context: {Err.Log}"
                            }
                            Tail Nil
                        }
                    }
                }
            }
            . native_ai_solve
            .> [ "Применяем сгенерированный фикс..." . Shell.Log ]
            .  RunBuild
            . {
                BuildSuccess [
                    "Сборка успешно починена и завершена!" . Shell.Log
                ]

                // Если сборка снова упала — уменьшаем счетчик рекурсии
                BuildError(NextErr) [
                    "Ошибка не устранена. Осталось попыток: {Retries - 1}" . Shell.Log
                    . AiFix(NextErr, Retries - 1)
                ]
            }
        ]
    }
]


// --- 6. ТОЧКА ВХОДА (START) ---

Start [
    RunBuild . {
        // Успех сборки
        BuildSuccess [
            "Сборка успешно завершена!" . Shell.Log
        ]

        // Маленькая ошибка сразу отправляется в AI-цикл (лимит 3 попытки)
        SmallError(Err) [
            "Обнаружена небольшая ошибка (до 500 символов). Запуск AI..." . Shell.Log
            . AiFix(Err, 3)
        ]

        // Крупная ошибка предварительно декомпозируется
        LargeError(Err) [
            "Обнаружена объемная ошибка. Дробление лога..." . Shell.Log
            . Err
            . SplitByDoubleSpaces
            . AiFix(Err, 5)
        ]
    }
]