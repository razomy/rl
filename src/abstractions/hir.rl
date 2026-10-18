_ primitive
_ primitive
_ structure

#
1. Lexer Tokens, Spans & Concrete Syntax Tree (CST)
#

TokenType "VALUE" | "WHITESPACES" | "ASSIGN" | "SEPERATE" | "INDENT" | "DEDENT" | "NEWLINE" | "SEMICOLON" | "EOF"

Token {
  Type  TokenType
  Value String
}

Span {
  Offset Int
  Length Int
}

TokenCsn { Kind "TokenCsn", Token Token, Span Span }
GroupCsn { Kind "GroupCsn", Children List(CsNode) }
CsNode   TokenCsn | GroupCsn

#
2. High-Level Intermediate Representation (HIR) Ontology
#
// 0. Panic:        Try / Throw
// 1. State:        Literal, Sequence, Record, Template
// 2. Operation:    Unary, Binary, Cast
// 3. Flow (Logic): Match, Loop, Block
// 4. FlowOperator: Return, Break, Continue, Yield, MatchArm
// 5. Declaration:  Shape (Struct/Class/Interface), Function (Lambda/Method), Module
// 6. Binding:      Symbol Binding (Const/Alias/Import), Assign
// 7. Access:       Reference, Member, Call
// 8. Modifier:     Capabilities & Qualifiers
// 9. Layer:        Meta, Docs, Annotations

ISyntax       {}
HasFnHashId   { FnHashId String }
SyntaxRole    "Declaration" | "Expression" | "Statement" | "Shape" | "Binding" | "Operator"
SemanticLayer "Utils" | "System" | "Application" | "Domain"

IHirNode ISyntax & {
  SyntaxRole    SyntaxRole
  SemanticLayer SemanticLayer
}

// --- Data, Expressions & Control Flow ---

LiteralHirn IHirNode & {
  Kind  "Literal"
  Value Any
}

OperatorHirn IHirNode & {
  Kind     "Operator"
  Operator String
  Operands List(IdRef(HirType))
}

BranchHirn IHirNode & {
  Kind    "Branch"
  Pattern IdRef(HirType)
  Value   IdRef(HirType)
}

MatchHirn IHirNode & {
  Kind     "Match"
  Target   IdRef(HirType)
  Branches List(IdRef(BranchHirn))
}

GoOperator "break" | "continue" | "yield" | "return" | "throw"

GoHirn IHirNode & {
  Kind     "Go"
  Operator GoOperator
  Value    Option(IdRef(HirType))
}

LoopHirn IHirNode & {
  Kind      "Loop"
  Condition Option(IdRef(HirType))
  Block     IdRef(BlockHirn)
}

BlockHirn IHirNode & {
  Kind       "Block"
  Statements List(IdRef(HirType))
}

// --- Declarations, Bindings, Functions, Structs & References ---

IIdentityHirn IHirNode & {
  Name      Option(String)
  Modifiers List(IdRef(HirType))
}

DocCommentHirn {
  Description String
}

FunctionDocExampleHirn {
  Code     String
  Expected String
}

FunctionDocHirn {
  Title             Option(String)
  Description       Option(String)
  ReturnDescription Option(String)
  Examples          List(FunctionDocExampleHirn)
}

BindingHirn(T) IIdentityHirn & {
  Kind  "Binding"
  Shape Option(IdRef(ReferenceHirn))
  Value Option(T)
  Doc   Option(DocCommentHirn)
}

FunctionHirn IIdentityHirn & HasFnHashId & {
  Kind        "Function"
  Parameters  List(IdRef(BindingHirn(HirType)))
  ReturnShape Option(IdRef(ReferenceHirn))
  Block       Option(IdRef(HirType))
  Doc         Option(FunctionDocHirn)
}

StructHirn IIdentityHirn & {
  Kind       "Struct"
  Properties List(IdRef(HirType))
  Doc        Option(DocCommentHirn)
}

ReferenceHirn IHirNode & {
  Kind      "Reference"
  Target    Option(IdRef(HirType))
  Property  Option(IdRef(HirType))
  Arguments List(IdRef(HirType))
}

HirType
  LiteralHirn
  | OperatorHirn
  | BlockHirn
  | MatchHirn
  | BranchHirn
  | LoopHirn
  | GoHirn
  | BindingHirn(Any)
  | FunctionHirn
  | StructHirn
  | ReferenceHirn

HirNode HirType

#
3. Semantic Graph & Compiler Context
#

SemanticNode(T) {
  Hir T
}

SemanticContext {
  NodeMap     Map(String, HirNode)
  Root        HirNode
  SemanticMap Map(String, SemanticNode(HirNode))
}
