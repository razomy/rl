#
Razomy Language Lexer Specification (V4.0)
#

// =============================================================================
// 1. BRACKETS & DELIMITERS
// =============================================================================

LBrace      "{"
RBrace      "}"
LBracket    "["
RBracket    "]"
LParen      "("
RParen      ")"

Brackets    LBrace | RBrace | LBracket | RBracket | LParen | RParen

Comma       ","
Semicolon   ";"
Colon       ":"
Underscore  "_"

Delimiters  Comma | Semicolon | Colon | Underscore


// =============================================================================
// 2. PIPELINE & COMPOSITE OPERATORS (Matched first by longest match)
// =============================================================================

// Pipeline family
DotGt       ".>"                  // Tap pipeline (side-effect)
DotAmp      ".&"                  // Enrich pipeline (merge result)
DotPipe     ".|"                  // Explicit parallel pipeline
DotQm       ".?"                  // Filter / Safe guard pipeline
DotRange    ".."                  // Map over stream / Range generator

// Contextual Pipeline Dot (followed by whitespace, newline, or opening bracket)
PipeDot     "\\.(?=[ \\t\\r\\n\\{\\[\\(])"

// Member access / Namespace dot (User.Id)
Dot         "."

Pipelines   DotGt | DotAmp | DotPipe | DotQm | DotRange | PipeDot

// Comparison & Logic Operators
EqEq        "=="
NotEq       "!="
Lte         "<="
Gte         ">="
AndAnd      "&&"
OrOr        "||"
Pow         "**"
ShiftL      "<<"
ShiftR      ">>"

CompositeOp EqEq | NotEq | Lte | Gte | AndAnd | OrOr | Pow | ShiftL | ShiftR


// =============================================================================
// 3. ATOMIC OPERATORS (Math & Set/Type Algebra)
// =============================================================================

Plus        "+"
Minus       "-"
Mul         "*"
Slash       "/"                   // Division (Math) & Subtraction (Type Algebra)
Mod         "%"
Pipe        "|"                   // Union (Types & Flows)
Amp         "&"                   // Intersection / Merge (Types & Flows)
Qm          "?"
Bang        "!"
Eq          "="
LAngle      "<"
RAngle      ">"

AtomicOp    Plus | Minus | Mul | Slash | Mod | Pipe | Amp | Qm | Bang | Eq | LAngle | RAngle

Operator    Pipelines | CompositeOp | AtomicOp


// =============================================================================
// 4. WHITESPACE & COMMENTS
// =============================================================================

WhiteSpace   "[ \\t\\f]+"
Crlf         "\\r?\\n"

LineComment  "//[^\\r\\n]*"
DocComment   "#[\\r\\n][^#]*#"
BlockComment "#[^#]*#"


// =============================================================================
// 5. LITERALS & IDENTIFIERS
// =============================================================================

True          "true"
False         "false"
BooleanLiteral True | False

Identifier    "[a-zA-Z][a-zA-Z0-9_]*|_[a-zA-Z0-9_]+"

// Float must require digits after dot so '1..10' lexes as Number, DotRange, Number
FloatLiteral  "[0-9]+\\.[0-9]+"
NumberLiteral "0x[0-9a-fA-F]+|[0-9]+"

StringLiteral "\"([^\"\\\\]|\\\\.)*\"|'([^'\\\\]|\\\\.)*'"

BadCharacter  "[^]"


// =============================================================================
// 6. LEXER PIPELINE SCOPE
// =============================================================================

Lexeme DocComment
 | BlockComment
 | LineComment
 | Crlf
 | WhiteSpace
 | StringLiteral
 | BooleanLiteral
 | FloatLiteral
 | NumberLiteral
 | Identifier
 | Operator
 | Dot
 | Brackets
 | Delimiters
 | BadCharacter

Tokenize [_ .. Lexeme]
