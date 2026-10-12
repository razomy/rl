Run<T = None> = fn(T)
MatchBool<T = None> = if query(T) yes(T) else no(T)
Fix<T = None> = fn(T)
Shell<T = None> = fn(T)
IsSuccess<T = None> = MatchBool<T>
Start<T> = Run<T> . IsSuccess<T> { Fix<T> }

SourceDir str = "."
Message = {}
TextMessage = Message & {text: str}
ToolMessage = Message & {name: str}
AnyMessage = TextMessage | ToolMessage
AnyMessages = AnyMessage[]
AiContext
  SourceDir
  AnyMessages

shell
  log Shell = process.log(message)
  command Shell = process.execute(command str) is err | null

isSuccess MatchBool = match query
        is err(_) => yes
        else      => no

iterate = {
  loop limit=100 {
    match step()
      is complete => break
      is error    => break
}}

success_log IsSuccess.Fix.Done = shell.log("Build completed successfully!")
error_log IsSuccess.Fix.Done = shell.log("Failed to fix build automatically.")
run_build Run = shell.command("npm run build") //, Shell<str>

ai_fix(error: str)
  context = create_ai_context(.source_dir)
  context
    .add(.message_from_error(error))
    .add_tool("read_file")
    .add_tool("write_file")
    .add_prompt($"You are an AI expert. Context: {error}")
  .iterate(limit: 100)

is_small = error.length < 500

largeError = err.split_by_double_spaces()
    .iterate(limit: 100) -> chunk: fix(chunk)

handle_error IsSuccess.Fix =
  match err
    is_small => Fix
    else => Done

start Start = [
  fix_build
  isSuccess {
    error_log,
    success_log
  }
]

start_with_ai() = start
  self.isSuccess.Fix.replace(error_log, ai_fix)
