// --- Системные типы и интерфейсы ---
ty shell
  fn log(message: str)
  fn command(command: str): err | null

// --- Сообщения и контекст ---

ty message = any

ty text_message
  extends message

  text: str

ty tool_message
  extends message

  name: str

ty any_message = text_message | tool_message

ty ai_context
  source_dir: str
  messages: any_message[] = []

  fn add(msg: any_message)
    .messages.push(msg)

fn create_ai_context(source_dir: str): ai_context
  return ai_context
    source_dir: source_dir
    messages: []

// --- Логика ИИ ---

ty ai
  context: ai_context
  source_dir: str = "."

  fn message_from_error(error: str): text_message
    return text_message
      text: error

  fn add_tool(name: str)
    .context.add:
      tool_message
        name: name

  fn add_prompt(prompt: str)
    .context.add:
      text_message
        text: prompt

  fn iterate(limit: int = 100)
    // Запуск цикла рассуждений агента (ReAct/Tool execution)
    loop limit
      match .step()
        is complete => break
        is error    => break

  fn fix(error: str)
    .context = create_ai_context(.source_dir)

    // Добавление ошибки и инструментов
    .context.add(.message_from_error(error))
    .add_tool("read_file")
    .add_tool("write_file")

    .add_prompt($"You are an AI expert. Context: {error}")
    .iterate(limit: 100)

// --- Обработка ошибок сборки ---

fn is_small(error: str): bool
  return error.length < 500

fn handle_error(err: str)
  match err
    is_small =>
      ai.fix(err)
    else =>
      // Если лог ошибки большой — делим на фрагменты
      err.split_by_double_spaces()
        .iterate(limit: 100) -> chunk:
          ai.fix(chunk)

fn success()
  shell.log("Build completed successfully!")

fn fix_build()
  // Пытаемся собрать проект, в случае ошибки — чиним
  match shell.command("npm run build")
    is err(e) =>
      handle_error(e)
      // Повторная проверка после исправления:
      match shell.command("npm run build")
        is err(_) => shell.log("Failed to fix build automatically.")
        else      => success()
    else =>
      success()

// --- Точка входа ---

fn start()
  fix_build()