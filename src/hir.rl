#
Abstract CST & HIR Interfaces
#

Token {
  Type  TokenType
  Value String
}

Span {
  Offset Int
  Length Int
}

ISyntax       Object
HasFnHashId   { FnHashId String }
SyntaxRole    "Declaration" | "Expression" | "Statement" | "Shape" | "Binding" | "Operator"
SemanticLayer "Utils" | "System" | "Application" | "Domain"

IHirNode ISyntax & {
  SyntaxRole    SyntaxRole
  SemanticLayer SemanticLayer
}

IIdentityHirn IHirNode & {
  Name      Option(String)
  Modifiers List(IdRef(HirType))
}

SemanticNode(T) {
  Hir T
}

SemanticContext {
  NodeMap     Map(String, HirNode)
  Root        HirNode
  SemanticMap Map(String, SemanticNode(HirNode))
}

