_ primitive
_ primitive
_ structure

// =============================================================================
// Character Constants & Lexemes (merged from chars.rl)
// =============================================================================

// Split & Delimiters
SPACE        ' '
TAB          '\t'
NEWLINE      '\n'
CARRIAGE_RET '\r'
DOT          '.'
COMMA        ','
COLON        ':'
SEMICOLON    ';'
EQUALS       '='
PIPE         '|'
PERCENT      '%'

// Join & Operators
DASH         '-'
UNDERSCORE   '_'
PLUS         '+'
CARET        '^'
TILDE        '~'
ASTERISK     '*'
AMPERSAND    '&'
AT_SIGN      '@'

// Grouping & Quotes
DOUBLE_QUOTE '"'
SINGLE_QUOTE '\''
BACKTICK     '`'
ANGLE_OPEN   '<'
ANGLE_CLOSE  '>'
PAREN_OPEN   '('
PAREN_CLOSE  ')'
BRACKET_OPEN '['
BRACKET_CLOSE ']'
BRACE_OPEN   '{'
BRACE_CLOSE  '}'

// Slashes & Punctuation
SLASH        '/'
BACKSLASH    '\\'
EXCLAMATION  '!'
QUESTION     '?'
HASH         '#'
DOLLAR       '$'

// =============================================================================
// Regular Expressions & Pattern Matching
// =============================================================================

RegexPattern {
  Pattern String
  Flags   String
}

RegexMatch {
  FullMatch String
  Groups    List(String)
  Index     Int
}

Regex {
  Compile(Pat String)              [ RegexPattern { Pattern Pat, Flags "" } ]
  Matches(Input String, Pat String)   [ (Input, Pat) . native_regex_matches ]
  Find(Input String, Pat String)      [ (Input, Pat) . native_regex_find ]
  FindAll(Input String, Pat String)   [ (Input, Pat) . native_regex_find_all ]
  Replace(Input String, Pat String, Repl String) [ (Input, Pat, Repl) . native_regex_replace ]
}

// =============================================================================
// String Operations Module
// =============================================================================

String {
  Length(S String)                 [ S . native_str_len ]
  IsEmpty(S String)                [ S . Length == 0 ]
  Trim(S String)                   [ S . native_str_trim ]
  TrimStart(S String)              [ S . native_str_trim_start ]
  TrimEnd(S String)                [ S . native_str_trim_end ]
  ToUpper(S String)                [ S . native_str_to_upper ]
  ToLower(S String)                [ S . native_str_to_lower ]
  Capitalize(S String)             [ S . native_str_capitalize ]
  CamelCase(S String)              [ S . native_str_camel_case ]
  SnakeCase(S String)              [ S . native_str_snake_case ]
  KebabCase(S String)              [ S . native_str_kebab_case ]
  PascalCase(S String)             [ S . native_str_pascal_case ]
  Split(S String, Delim String)       [ (S, Delim) . native_str_split ]
  Join(Items List(String), Sep String)[ (Items, Sep) . native_str_join ]
  Lines(S String)                  [ S . Split("\n") ]
  Words(S String)                  [ S . Trim . Split(" ") ]
  StartsWith(S String, Prefix String) [ (S, Prefix) . native_str_starts_with ]
  EndsWith(S String, Suffix String)   [ (S, Suffix) . native_str_ends_with ]
  Contains(S String, Sub String)      [ (S, Sub) . native_str_contains ]
  IndexOf(S String, Sub String)       [ (S, Sub) . native_str_index_of ]
  Substring(S String, Start Int, End Int) [ (S, Start, End) . native_str_substring ]
  Replace(S String, From String, To String)     [ (S, From, To) . native_str_replace ]
  Repeat(S String, Count Int)      [ (S, Count) . native_str_repeat ]
  PadStart(S String, Len Int, Pad String)    [ (S, Len, Pad) . native_str_pad_start ]
  PadEnd(S String, Len Int, Pad String)      [ (S, Len, Pad) . native_str_pad_end ]
  Reverse(S String)                [ S . native_str_reverse ]
  ToInt(S String)                  [ S . native_str_to_int ]
  ToFloat(S String)                [ S . native_str_to_float ]
}

// =============================================================================
// Serialization Formats (JSON, YAML, TOML, CSV, XML)
// =============================================================================

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

StringOps(First String, Last String) [
  Full "{First} {Last}"
  Full
  . Trim
  . ToUpper
  . Split(" ")
]
