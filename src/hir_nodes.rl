#
Concrete HIR Nodes (Expressions, Flow & Declarations)
#

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
