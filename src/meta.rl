// =============================================================================
// Core Metaprogramming, Reflection, Type Algebra & Compiler Directives
// =============================================================================

Any    Any
None   None

Property    Any
Expression  Any

Tuple(T)    Any
Object     Tuple(Property)
Function   Object & Tuple(Expression)
Type       Tuple(Object | Function)

Number Number & Object
String { Length Number } & Object & String

// Control flow & Meta primitives
return Any
Self   Any

// Type-level Peano Naturals
Zero    {}
Succ(N) { Prev N }
One     Succ(Zero)
Two     Succ(One)
Three   Succ(Two)
Four    Succ(Three)
Five    Succ(Four)

// Field and Type Descriptors
FieldDescriptor {
  Name       String
  Type       String
  Value      Any
  IsOptional Bool
  Annotations List(String)
}

TypeDescriptor {
  TypeName   String
  Lineage    List(String)
  Fields     List(FieldDescriptor)
  IsUnion    Bool
  IsGeneric  Bool
}

// Reflection & Introspection API
Meta {
  TypeOf(Entity)        [ Entity . native_meta_type ]
  FieldsOf(Entity)      [ Entity . native_meta_fields ]
  LineageOf(Entity)     [ Entity . native_meta_lineage ]
  HasField(Entity, Key) [ Entity . native_meta_has_field(Key) ]
  GetField(Entity, Key) [ Entity . native_meta_get_field(Key) ]
  SetField(Entity, Key, Val) [ Entity . native_meta_set_field(Key, Val) ]
  SizeOf(Entity)        [ Entity . native_meta_sizeof ]
  HashOf(Entity)        [ Entity . native_meta_hash ]
  Clone(Entity)         [ Entity . native_meta_clone ]
  Equals(A, B)          [ (A, B) . native_meta_equals ]
}

// Compiler & Schema Decorators / Modifiers
Deprecated { Reason String, Since String }
Experimental { Feature String }
ReadOnly {}
Serializable {}
Transient {}
Indexed {}
Unique {}
PrimaryKey {}

// AST Macros & Derives
DeriveJson(TargetForm) [
  TargetForm & {
    ToJson() [
      Self . Meta.FieldsOf . Stream.Map(Field [
        "\"{Field.Name}\": {Field.Value . Json.FormatValue}"
      ])
      . String.Join(", ")
      . (Inner [ "\{ {Inner} \}" ])
    ]
  }
]

DeriveClone(TargetForm) [
  TargetForm & {
    Clone() [ Self . Meta.Clone ]
  }
]

DeriveEq(TargetForm) [
  TargetForm & {
    Equals(Other) [ Meta.Equals(Self, Other) ]
  }
]

DeriveHash(TargetForm) [
  TargetForm & {
    Hash() [ Self . Meta.HashOf ]
  }
]

DeriveDebug(TargetForm) [
  TargetForm & {
    ToDebugString() [
      Self . Meta.FieldsOf . Stream.Map(F [
        "{F.Name}: {F.Value}"
      ])
      . String.Join(", ")
      . (FieldsStr [ "{Self . Meta.TypeOf} \{ {FieldsStr} \}" ])
    ]
  }
]

InspectEntity(Entity) [
  Entity . Meta.TypeOf . {
    TypeName [ "Inspecting type: {TypeName}" . Shell.Log ]
  }
  Entity . Meta.FieldsOf . Stream.ForEach(F [
    "Field {F.Name} has type {F.Type} and value {F.Value}" . Shell.Log
  ])
]
