#
Razomy Language Grammar Specification (V4.0)
#

_ lexeme

// =============================================================================
// 0. GRAMMAR COMBINATORS
// =============================================================================

Kleene(T) Any   // 0 or more repetitions (T*)
Many(T)   T & Kleene(T) // 1 or more repetitions (T+)
Opt(T)    T | None      // Optional (T?)
Nl        Kleene(Crlf)  // Optional newlines for multiline expressions


// =============================================================================
// 1. ATOMIC LITERALS & PATHS (User.Id, _.Age, -1)
// =============================================================================

Literal FloatLiteral
| NumberLiteral
| StringLiteral
| BooleanLiteral

PathRoot Identifier
| Underscore
| NumberLiteral

PathNode Identifier | NumberLiteral | (Minus & NumberLiteral)

// Supports: User.Name, Jonn.0, Jonn.-1
Path PathRoot & Kleene(Dot & PathNode)


// =============================================================================
// 2. THREE BRACKETS: SLOT (), FORM {}, FLOW []
// =============================================================================

Separator Crlf | Semicolon | Comma

// () — Slot: Tuples, arguments, isolated expressions
SlotItem  Declaration
Slot      LParen & Kleene(Separator | SlotItem) & RParen

// {} — Form: Data structures, pattern routers, type maps
FormItem  Declaration
FormBlock LBrace & Kleene(Separator | FormItem) & RBrace

// [] — Flow: Morphisms, pipelines, predicates, streams
FlowSeparator Crlf | Semicolon | Comma
FlowItem      Declaration
FlowBlock     LBracket & Kleene(FlowSeparator | FlowItem) & RBracket


// =============================================================================
// 3. PRIMARY & POSTFIX EXPRESSIONS
// =============================================================================

AtomExpr Literal
| Path
| Slot
| FormBlock
| FlowBlock

// Postfix allows chaining: User(T) { ... } [ ... ] or Fn(A)(B)
PostfixSuffix Slot
| FormBlock
| FlowBlock

PrimaryExpr AtomExpr & Kleene(PostfixSuffix)

// Unary Operators (!X, -5)
UnaryOp   Bang | Minus
UnaryExpr (Kleene(UnaryOp) & PrimaryExpr)


// =============================================================================
// 4. VALUE & ARITHMETIC HIERARCHY
// =============================================================================

// Power (**)
PowExpr UnaryExpr & Kleene(Nl & Pow & Nl & UnaryExpr)

// Multiplicative (*, %) — Note: '/' is moved to Type/Value subtraction
MulOp   Mul | Mod
MulExpr PowExpr & Kleene(Nl & MulOp & Nl & PowExpr)

// Additive (+, -)
AddOp   Plus | Minus
AddExpr MulExpr & Kleene(Nl & AddOp & Nl & MulExpr)

// Bitwise Shifts (<<, >>)
ShiftOp   ShiftL | ShiftR
ShiftExpr AddExpr & Kleene(Nl & ShiftOp & Nl & AddExpr)

// Comparisons (==, !=, <, >, <=, >=)
CompareOp   EqEq | NotEq | LAngle | RAngle | Lte | Gte
CompareExpr ShiftExpr & Kleene(Nl & CompareOp & Nl & ShiftExpr)

// Boolean Logic (&&, ||)
LogicOp   AndAnd | OrOr
LogicExpr CompareExpr & Kleene(Nl & LogicOp & Nl & CompareExpr)


// =============================================================================
// 5. ALGEBRA OF TYPES & MORPHISMS (/, &, |)
// =============================================================================
// Applies equally to Forms (Data) and Flows (Processes)!

// 1. Subtraction / Division (A / B) — Highest algebraic precedence
SubtractExpr LogicExpr & Kleene(Nl & Slash & Nl & LogicExpr)

// 2. Intersection / Parallel Merge (A & B)
MergeExpr SubtractExpr & Kleene(Nl & Amp & Nl & SubtractExpr)

// 3. Union / Fallback Sum (A | B)
UnionExpr MergeExpr & Kleene(Nl & Pipe & Nl & MergeExpr)


// =============================================================================
// 6. PIPELINE MORPHISM CHAIN (., .., .?, .&, .>, .|)
// =============================================================================
// Lowest precedence: binds algebraic types and flows into execution chains.

PipelineOp | PipeDot     // Sequential composition (A . B)
| DotRange    // Stream Map / Range (A .. B)
| DotQm       // Filter / Guard (A .? B)
| DotAmp      // Enrich context (A .& B)
| DotGt       // Tap side-effect (A .> B)
| DotPipe     // Explicit parallel fan-out (A .| B)

PipelineExpr UnionExpr & Kleene(Nl & PipelineOp & Nl & UnionExpr)


// =============================================================================
// 7. DECLARATIONS & FILE ROOT
// =============================================================================

// A Declaration is either:
// 1. A standalone PipelineExpression (e.g., inside a Flow: `A . B . C`)
// 2. A Named/Typed Binding (e.g., `User { Name String }`, `Age Int`, `A & B [ ... ]`)
Declaration PipelineExpr & Kleene(PipelineExpr)

RazomyFile [
  Kleene(Separator | Declaration)
]

Parse [ _ . RazomyFile]
