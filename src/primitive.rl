#
Abstract Primitives & Unified Refinements
#
Any Any
None None

Object Any

Number Object
Char Object
String { Length Number } & Char

Null       None
Undefined  None
UnitType   Object
Never      None

Bool       false
True       Bool & [ _ == true ]
False      Bool & [ _ == false ]

Byte       0x00
SymbolType Any
Bigint     Number

Vector(T)  T & Object

// Unified Numeric & Collection Refinements (deduplicated from primitive, quantity, auth)
Positive          [ _ > 0 ]
NonNegative       [ _ >= 0 ]
Negative          [ _ < 0 ]
NonZero           [ _ != 0 ]
Range(Min, Max)   [ _ >= Min ] & [ _ <= Max ]
NonEmpty          [ _.Length > 0 ]

PositiveNumber    Number & Positive
NonNegativeNumber Number & NonNegative
NegativeNumber    Number & Negative
NonZeroNumber     Number & NonZero

EnumInt    Int
EnumString String

Primitive     String | Int | Float | Bool | Byte
AllPrimitives StringPrimitive | NumberPrimitive | Bool | Null | Undefined | SymbolType | Byte
