sc Start 
  . Run 
  . IsSuccess<error> {
    . Fix
}

sc Shell

fn start() as Start, 
  return [
  fix_build
  isSuccess<error> {
    error_log,
    success_log
  }
]

fn start_with_ai()  = start
  self.isSuccess.Fix.replace(error_log, handle_error)

md shell
  fn log(message: str) as Shell
  fn command(command: str): err | null

fn run_build() as Run, Shell
  shell.command("npm run build")

fn isSuccess(res, yes, no) as IsSuccess
      match res
        is err(_) => mo
        else      => yes

fn success_log() as IsSuccess.Done, Shell
  shell.log("Build completed successfully!")

fn error_log() as IsSuccess.Fix.Done, Shell
  shell.log("Failed to fix build automatically.")

// --- Сообщения и контекст

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

fn iterate(step, limit: int = 100)
  loop limit
    match step()
      is complete => break
      is error    => break

md ai
  context: ai_context
  source_dir: str = "."

  fn fix(error: str)
    context = create_ai_context(.source_dir)
    context
      .add(.message_from_error(error))
      .add_tool("read_file")
      .add_tool("write_file")
      .add_prompt($"You are an AI expert. Context: {error}")
    .iterate(limit: 100)

// --- Обработка ошибок сборки ---
fn is_small(error: str): bool
  return error.length < 500

fn largeError(error: str, fix): bool
  err.split_by_double_spaces()
    .iterate(limit: 100) -> chunk:
      fix(chunk)

fn handle_error(err: str)  as IsSuccess.Fix
  match err
    is_small => ai.fix(err)
    else =>
      // Если лог ошибки большой — делим на фрагменты

