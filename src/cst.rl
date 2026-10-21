#
Concrete Syntax Tree (CST) & Lexer Token Types
#

TokenType "VALUE" | "WHITESPACES" | "ASSIGN" | "SEPERATE" | "INDENT" | "DEDENT" | "NEWLINE" | "SEMICOLON" | "EOF"

TokenCsn { Kind "TokenCsn", token Token, span Span }
GroupCsn { Kind "GroupCsn", children List(CsNode) }
CsNode   TokenCsn | GroupCsn
