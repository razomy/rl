#
Reflection & Introspection API + AST Macros & Derives
#

Meta {
  TypeOf(Entity)             [ Entity . native_meta_type ]
  FieldsOf(Entity)           [ Entity . native_meta_fields ]
  LineageOf(Entity)          [ Entity . native_meta_lineage ]
  HasField(Entity, Key)      [ Entity . native_meta_has_field(Key) ]
  GetField(Entity, Key)      [ Entity . native_meta_get_field(Key) ]
  SetField(Entity, Key, Val) [ Entity . native_meta_set_field(Key, Val) ]
  SizeOf(Entity)             [ Entity . native_meta_sizeof ]
  HashOf(Entity)             [ Entity . native_meta_hash ]
  Clone(Entity)              [ Entity . native_meta_clone ]
  Equals(A, B)               [ (A, B) . native_meta_equals ]
}

DeriveJson(TargetForm) [
  TargetForm & {
    ToJson() [
      Self . Meta.FieldsOf . Map(Field [
        "\"{Field.Name}\": {Field.Value . Json.FormatValue}"
      ])
      . Join(", ")
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
      Self . Meta.FieldsOf . Map(F [
        "{F.Name}: {F.Value}"
      ])
      . Join(", ")
      . (FieldsStr [ "{Self . Meta.TypeOf} \{ {FieldsStr} \}" ])
    ]
  }
]

InspectEntity(Entity) [
  Entity . Meta.TypeOf . {
    TypeName [ "Inspecting type: {TypeName}" . Shell.Log ]
  }
  Entity . Meta.FieldsOf . ForEach(F [
    "Field {F.Name} has type {F.Type} and value {F.Value}" . Shell.Log
  ])
]
