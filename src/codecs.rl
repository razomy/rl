#
JSON, YAML & CSV Codecs
#

Json {
  Parse(raw String)     [ Raw . native_json_parse ]
  Encode(entity Any)    [ Entity . native_json_encode ]
  FormatValue(val Any)  [ Val . native_json_format_value ]
}

Yaml {
  Parse(raw String)     [ Raw . native_yaml_parse ]
  Encode(entity Any)    [ Entity . native_yaml_encode ]
}

Csv {
  Parse(raw String)     [ Raw . native_csv_parse ]
  Encode(rows List(Any))[ Rows . native_csv_encode ]
}
