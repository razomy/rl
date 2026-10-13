Null None
Undefined None
Bool Bool
SymbolType Any
Bigint Number

Vector(T) T & {}

// Целые числа
I8 Number
I16 Number
I32 Number
I64 Bigint
I128 Bigint
Int I32
Long I64
IntPrimitive I8 | I16 | I32 | I64 | I128 | Int | Long

// Беззнаковые целые числа
U8 Number
U16 Number
U32 Number
U64 Bigint
U128 Bigint
UIntPrimitive U8 | U16 | U32 | U64 | U128

// Числа с плавающей точкой
F32 Number
F64 Number
Float F32
Double F32
FloatPrimitive F32 | F64 | Float | Double

Number Number
NumberPrimitive IntPrimitive | UIntPrimitive | FloatPrimitive | Number

// Строки
Char String
Char64 String
Char128 String
Char256 String
Vector128 Vector(Number)
InlineString String
FixedString String
MultilineString String
String String
StringPrimitive Char | InlineString | MultilineString | FixedString | String

EnumInt Number
EnumString String

AllPrimitives StringPrimitive | NumberPrimitive | Bool | Null | Undefined | SymbolType
