shell
 i script // i o alies to input
 o Error | null // | two branches
 log message:String
 command command:String // : is comand{String} branh
success 
 shell log "Build complete success" // string is one prompt
aiFix 
 createContext 
  loadProject
  getAiContextFromError ErrorMessage
  addTool 
   ReadFile
   WriteFile
  addPrompt "You are ai expert you recevie context {AiContextFromError Result}" // template string(join array branches)
 iterateAi 
  limit 100
error 
 getMessage
 switch 
  isSmall aiFix
  else 
   splitByDobuleSpaces
   iterate 
    aiFix
    limit 100
fixBuild
 shell command "npm run build"
 switch 
  isError error
   else success
start
 fixBuild
