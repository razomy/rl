#
Abstract Schema Node Modifiers, Primitives & Reusable Command Directives
#

Mult Any
Opt  Any
Skip Any

File       Any
FileUrl    String
CommandStr String
Folder     Any
Chunk      ".chunk"
drawio     ".drawio"
csv        ".csv"

MultOpt     Mult & Opt
SkipMultOpt Skip & Mult & Opt

DoCmd           "do" & FileUrl & MultOpt
StartInlineCmd  "start" & FileUrl & MultOpt
StartCompanyCmd "start_company" & FileUrl & MultOpt
ReadInlineCmd   "read" & FileUrl & MultOpt
RunCmd          "run" & CommandStr & MultOpt

ScopeRule {
  ScopeName {
    FileRegex String & Mult
  } & Mult
}