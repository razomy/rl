shell
 log(message:str)
 command(command:str)err|null
success
 shell log "Build complete success" // str is one prompt
ai
 context
  source dir
  messages
  create()
   .context = ai context
 message from error(error:str)
  context messages add
   text
    text=error
 add tool (name:str)
  context messages add
   tool
    name // name = name
 fix(error:str)
  context create
  .context source dir = .source dir
   getAiContextFromError ErrorMessage
   addTool
    ReadFile
    WriteFile
   addPrompt "You are ai expert you recevie context {AiContextFromError Result}" // template str(join array branches)
  iterateAi
   limit 100
error
 .error
 switch
  is small ai fix
  else
   split by double spaces
   iterate
    ai fix
    limit 100
fix build
 shell command "npm run build"
 switch
  is error error
  else success
start
 fix build
