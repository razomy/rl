#
1. Atomic Literals & Paths (User.Id, _.Age, -1)
#

Literal FloatLiteral
| NumberLiteral
| StringLiteral
| BooleanLiteral

PathRoot Identifier
| Underscore
| NumberLiteral

PathNode Identifier | NumberLiteral | (Minus & NumberLiteral)

Path PathRoot & Kleene(Dot & PathNode)#
2. Three Brackets: Slot (), form Object, Flow []
#

SlotItem  Declaration
Slot      LParen & Kleene(Separator | SlotItem) & RParen

FormItem  Declaration
FormBlock LBrace & Kleene(Separator | FormItem) & RBrace

FlowItem  Declaration
FlowBlock LBracket & Kleene(FlowSeparator | FlowItem) & RBracket#
3. Primary, Postfix & Value Expressions
#

AtomExpr Literal
| Path
| Slot
| FormBlock
| FlowBlock

PostfixSuffix Slot
| FormBlock
| FlowBlock

PrimaryExpr AtomExpr & Kleene(PostfixSuffix)

UnaryOp   Bang | Minus
UnaryExpr (Kleene(UnaryOp) & PrimaryExpr)

PowExpr UnaryExpr & Kleene(Nl & Pow & Nl & UnaryExpr)

MulOp   Mul | Mod
MulExpr PowExpr & Kleene(Nl & MulOp & Nl & PowExpr)

AddOp   Plus | Minus
AddExpr MulExpr & Kleene(Nl & AddOp & Nl & MulExpr)

ShiftOp   ShiftL | ShiftR
ShiftExpr AddExpr & Kleene(Nl & ShiftOp & Nl & AddExpr)

CompareOp   EqEq | NotEq | LAngle | RAngle | Lte | Gte
CompareExpr ShiftExpr & Kleene(Nl & CompareOp & Nl & ShiftExpr)

LogicOp   AndAnd | OrOr
LogicExpr CompareExpr & Kleene(Nl & LogicOp & Nl & CompareExpr)

#
Algebra of Types & Morphisms (/, &, |)
#

SubtractExpr LogicExpr & Kleene(Nl & Slash & Nl & LogicExpr)
MergeExpr    SubtractExpr & Kleene(Nl & Amp & Nl & SubtractExpr)
UnionExpr    MergeExpr & Kleene(Nl & Pipe & Nl & MergeExpr)#
Pipeline Morphism Chain (., .., .?, .&, .>, .|) & Declarations
#

PipelineOp | PipeDot
| DotRange
| DotQm
| DotAmp
| DotGt
| DotPipe

PipelineExpr UnionExpr & Kleene(Nl & PipelineOp & Nl & UnionExpr)

Declaration PipelineExpr & Kleene(PipelineExpr)

RazomyFile [
  Kleene(Separator | Declaration)
]

Parse [ _ . RazomyFile]
