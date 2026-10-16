_ meta

// =============================================================================
// Fundamental Primitives & Refinements
// =============================================================================

Null       None
Undefined  None
UnitType   {}
Never      None

Bool       false
True       Bool & [ _ == true ]
False      Bool & [ _ == false ]

Byte       0x00
SymbolType Any
Bigint     Number

// Generic Vector
Vector(T)  T & {}

// Signed Integers
I8         Number & [ _ >= -128 ] & [ _ <= 127 ]
I16        Number & [ _ >= -32768 ] & [ _ <= 32767 ]
I32        Number & [ _ >= -2147483648 ] & [ _ <= 2147483647 ]
I64        Bigint
I128       Bigint
ISize      I64
Int        I32
Long       I64
Short      I16
IntPrimitive I8 | I16 | I32 | I64 | I128 | ISize | Int | Long | Short

// Unsigned Integers
U8         Number & [ _ >= 0 ] & [ _ <= 255 ]
U16        Number & [ _ >= 0 ] & [ _ <= 65535 ]
U32        Number & [ _ >= 0 ] & [ _ <= 4294967295 ]
U64        Bigint & [ _ >= 0 ]
U128       Bigint & [ _ >= 0 ]
USize      U64
UInt       U32
ULong      U64
UIntPrimitive U8 | U16 | U32 | U64 | U128 | USize | UInt | ULong

// Floating Point & Decimals
F16        Number
F32        Number
F64        Number
F128       Number
Float      F64
Double     F64
Decimal    Number
FloatPrimitive F16 | F32 | F64 | F128 | Float | Double | Decimal

Number     0
NumberPrimitive IntPrimitive | UIntPrimitive | FloatPrimitive | Number

// Numeric Refinements
PositiveNumber    Number & [ _ > 0 ]
NonNegativeNumber Number & [ _ >= 0 ]
NegativeNumber    Number & [ _ < 0 ]
NonZeroNumber     Number & [ _ != 0 ]
EvenInt           Int & [ (_ % 2) == 0 ]
OddInt            Int & [ (_ % 2) != 0 ]

// Strings & Characters
Char            String & [ _.Length == 1 ]
Char64          String & [ _.Length <= 64 ]
Char128         String & [ _.Length <= 128 ]
Char256         String & [ _.Length <= 256 ]
InlineString    String
FixedString     String
MultilineString String
NonEmptyStr     String & [ _.Length > 0 ]
AsciiStr        String
Utf8Str         String
HexStr          String & [ _ . Regex.Matches("^[0-9a-fA-F]+$") ]
Base64Str       String & [ _ . Regex.Matches("^[A-Za-z0-9+/=]+$") ]
SlugStr         String & [ _ . Regex.Matches("^[a-z0-9]+(-[a-z0-9]+)*$") ]

StringPrimitive Char | Char64 | Char128 | Char256 | InlineString | MultilineString | FixedString | String | String

// SIMD & Binary Buffers
Vector64   Vector(Number)
Vector128  Vector(Number)
Vector256  Vector(Number)
Vector512  Vector(Number)
ByteArray  List(Byte)
BitField   U64

// Enums
EnumInt    Int
EnumString String

Primitive     String | Int | Float | Bool | Byte
AllPrimitives StringPrimitive | NumberPrimitive | Bool | Null | Undefined | SymbolType | Byte
