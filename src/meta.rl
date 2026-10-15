Number Number
String {Length Number} & String
Char Char
None None
Any Any

// Meta and Reflection forms
Meta {
  TypeOf(Entity) [ Entity . native_meta_type ]
  FieldsOf(Entity) [ Entity . native_meta_fields ]
}

DeriveJson(TargetForm) [
  TargetForm & {
    ToJson() [
      Self . Meta.FieldsOf . Stream.Map(Field [
        "\"{Field.Name}\": {Field.Value . Json.FormatValue}"
      ])
      . Str.Join(", ")
      . (Inner [ "\{ {Inner} \}" ])
    ]
  }
]

// Operators and control flow primitives
return Any
