#
Abstract Lexer Categories & Tokenization Pipeline
#

Lexeme Any

Brackets    Any
Delimiters    Any
Pipelines   Any
CompositeOp   Any
AtomicOp    Any
Operator    Pipelines | CompositeOp | AtomicOp
BooleanLiteral True | False

Tokenize [_ .. Lexeme]
