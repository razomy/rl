#
Concrete Numeric Types & SIMD Buffers
#

// Signed Integers
{ Byte } primitive
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

Number Object
NumberPrimitive IntPrimitive | UIntPrimitive | FloatPrimitive | Number

EvenInt    Int & [ (_ % 2) == 0 ]
OddInt     Int & [ (_ % 2) != 0 ]

// SIMD & Binary Buffers
Vector64   Vector(Number)
Vector128  Vector(Number)
Vector256  Vector(Number)
Vector512  Vector(Number)
ByteArray  List(Byte)
BitField   U64
