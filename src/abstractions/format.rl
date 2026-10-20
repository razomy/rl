#
Serialization Formats (JSON, YAML, TOML, CSV, XML)
#

Json {
  Parse(Raw String)        [ Raw . native_json_parse ]
  Encode(Entity Any)    [ Entity . native_json_encode ]
  FormatValue(Val Any)  [ Val . native_json_format_value ]
}

Yaml {
  Parse(Raw String)        [ Raw . native_yaml_parse ]
  Encode(Entity Any)    [ Entity . native_yaml_encode ]
}

Csv {
  Parse(Raw String)        [ Raw . native_csv_parse ]
  Encode(Rows List(Any))[ Rows . native_csv_encode ]
}
