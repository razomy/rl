#
Concrete Syntax Tree (CST) & Lexer Token Types
#

TokenType "VALUE" | "WHITESPACES" | "ASSIGN" | "SEPERATE" | "INDENT" | "DEDENT" | "NEWLINE" | "SEMICOLON" | "EOF"

TokenCsn { Kind "TokenCsn", Token Token, Span Span }
GroupCsn { Kind "GroupCsn", Children List(CsNode) }
CsNode   TokenCsn | GroupCsn
