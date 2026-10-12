Default {}
DefaultStr str & {Default ""}
SourceDir DefaultStr & {Default "."}
Text DefaultStr
Name DefaultStr
Message {}
TextMessage Message & {Text}
ToolMessage Message & {Name}
AnyMessage TextMessage | TextMessage
AnyMessages Array<AnyMessage>
AiContext {SourceDir,AnyMessages}

Shell {
  Log {Process.Log(<T>)}
  Command {Process.Execute(<T>)}
}

isError T instanceof Error

MatchYesNo {
    match <Query> {
        <isError isError> {<Yes>}
        else {<No>}
   }
}

Loop {
 <Do>
 <Break return>
 Loop(Do, Break)
}

For {
  Loop(
    Do {
      <Do>
      i <i> + 1
    }
  )
}

TrueIterate {
  loop (
  limit=100
  ) {
    match (<step>){
      case (<complete>){break}
      case (<error>){break}
    }
  }
}

SuccessLog {shell.log(T="Build completed successfully!")}
ErrorLog {shell.log(T="Failed to fix build automatically.")}
RunBuild {shell.command(T="npm run build")}
IsSmallError {<error:Error>.length < 500}
IsLargeError {
    <error:Error>
    .split_by_double_spaces()
    .TrueIterate(step <Fix>(_))
}

AiFix {
  context AiContext()
  context
    .add(<error>)
    .add_tool("read_file")
    .add_tool("write_file")
    .add_prompt($"You are an AI expert. Context: {error}")
  .iterate(limit: 100)
}

start {
  fix_build
  isSuccess {
    handle_error {
      MatchYesNo {
        IsSmallError {Fix}
        IsLargeError {},
      }
    }
    success_log
  }
}

start()