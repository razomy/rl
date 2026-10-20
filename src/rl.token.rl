#
Whitespace, Comments & Literal Patterns
#

WhiteSpace   "[ \\t\\f]+"
Crlf         "\\r?\\n"

LineComment  "//[^\\r\\n]*"
DocComment   "#[\\r\\n][^#]*#"
BlockComment "#[^#]*#"

True          "true"
False         "false"

Identifier    "[a-zA-Z][a-zA-Z0-9_]*|_[a-zA-Z0-9_]+"

FloatLiteral  "[0-9]+\\.[0-9]+"
NumberLiteral "0x[0-9a-fA-F]+|[0-9]+"

StringLiteral "\"([^\"\\\\]|\\\\.)*\"|'([^'\\\\]|\\\\.)*'"

BadCharacter  "[^]"
