#
Abstract Lexer Categories & Tokenization Pipeline
#

Brackets    LBrace | RBrace | LBracket | RBracket | LParen | RParen
Delimiters  Comma | Semicolon | Colon | Underscore
Pipelines   DotGt | DotAmp | DotPipe | DotQm | DotRange | PipeDot
CompositeOp EqEq | NotEq | Lte | Gte | AndAnd | OrOr | Pow | ShiftL | ShiftR
AtomicOp    Plus | Minus | Mul | Slash | Mod | Pipe | Amp | Qm | Bang | Eq | LAngle | RAngle
Operator    Pipelines | CompositeOp | AtomicOp

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
