Run<T = None> = fn(T)
MatchBool<T = None> = if query(T) yes(T) else no(T)
Fix<T = None> = fn(T)
Shell<T = None> = fn(T)
IsSuccess<T = None> = MatchBool<T>
Start<T> = Run<T> . IsSuccess<T> { Fix<T> }

Message = {}
TextMessage = Message & {text: str}
ToolMessage = Message & {name: str}
AnyMessage = text_message | tool_message

shell
  log Shell = (message str)
  command Shell = (command str) err | null

run_build Run = () // #, Shell<str>#
  shell.command("npm run build")

isSuccess MatchBool = (query, yes, no)
      match query
        is err(_) => yes
        else      => no

success_log IsSuccess.Fix.Done = ()
  shell.log("Build completed successfully!")

error_log IsSuccess.Fix.Done = () 
  shell.log("Failed to fix build automatically.")

ai_context
  source_dir: str
  messages: any_message[] = []

iterate(step, limit: int = 100)
  loop limit
    match step()
      is complete => break
      is error    => break

ai
  context: ai_context
  source_dir: str = "."

ai_fix(error: str)
  context = create_ai_context(.source_dir)
  context
    .add(.message_from_error(error))
    .add_tool("read_file")
    .add_tool("write_file")
    .add_prompt($"You are an AI expert. Context: {error}")
  .iterate(limit: 100)

is_small(error: str): bool
  return error.length < 500

largeError(error: str, fix): bool
  err.split_by_double_spaces()
    .iterate(limit: 100) -> chunk:
      fix(chunk)

handle_error(err: str)  as IsSuccess.Fix
  match err
    is_small => ai.fix(err)
    else =>
      // Если лог ошибки большой — делим на фрагменты

start Start = [
  fix_build
  isSuccess {
    error_log,
    success_log
  }
]

start_with_ai()  = start
  self.isSuccess.Fix.replace(error_log, handle_error)
