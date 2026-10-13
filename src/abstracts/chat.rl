_ abstracts.core

// --- 2. ДОМЕН: СООБЩЕНИЯ И СТРУКТУРЫ ДАННЫХ ---

TextMessage { Text String }
ToolMessage { Name String }
Message     TextMessage | ToolMessage
