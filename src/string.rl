_ meta
_ primitives
_ structures

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
  Pattern Str
  Flags   Str
}

RegexMatch {
  FullMatch Str
  Groups    List(Str)
  Index     Int
}

Regex {
  Compile(Pat Str)              [ RegexPattern { Pattern Pat, Flags "" } ]
  Matches(Input Str, Pat Str)   [ (Input, Pat) . native_regex_matches ]
  Find(Input Str, Pat Str)      [ (Input, Pat) . native_regex_find ]
  FindAll(Input Str, Pat Str)   [ (Input, Pat) . native_regex_find_all ]
  Replace(Input Str, Pat Str, Repl Str) [ (Input, Pat, Repl) . native_regex_replace ]
}

// =============================================================================
// String Operations Module
// =============================================================================

Str {
  Length(S Str)                 [ S . native_str_len ]
  IsEmpty(S Str)                [ S . Str.Length == 0 ]
  Trim(S Str)                   [ S . native_str_trim ]
  TrimStart(S Str)              [ S . native_str_trim_start ]
  TrimEnd(S Str)                [ S . native_str_trim_end ]
  ToUpper(S Str)                [ S . native_str_to_upper ]
  ToLower(S Str)                [ S . native_str_to_lower ]
  Capitalize(S Str)             [ S . native_str_capitalize ]
  CamelCase(S Str)              [ S . native_str_camel_case ]
  SnakeCase(S Str)              [ S . native_str_snake_case ]
  KebabCase(S Str)              [ S . native_str_kebab_case ]
  PascalCase(S Str)             [ S . native_str_pascal_case ]
  Split(S Str, Delim Str)       [ (S, Delim) . native_str_split ]
  Join(Items List(Str), Sep Str)[ (Items, Sep) . native_str_join ]
  Lines(S Str)                  [ S . Str.Split("\n") ]
  Words(S Str)                  [ S . Str.Trim . Str.Split(" ") ]
  StartsWith(S Str, Prefix Str) [ (S, Prefix) . native_str_starts_with ]
  EndsWith(S Str, Suffix Str)   [ (S, Suffix) . native_str_ends_with ]
  Contains(S Str, Sub Str)      [ (S, Sub) . native_str_contains ]
  IndexOf(S Str, Sub Str)       [ (S, Sub) . native_str_index_of ]
  Substring(S Str, Start Int, End Int) [ (S, Start, End) . native_str_substring ]
  Replace(S Str, From Str, To Str)     [ (S, From, To) . native_str_replace ]
  Repeat(S Str, Count Int)      [ (S, Count) . native_str_repeat ]
  PadStart(S Str, Len Int, Pad Str)    [ (S, Len, Pad) . native_str_pad_start ]
  PadEnd(S Str, Len Int, Pad Str)      [ (S, Len, Pad) . native_str_pad_end ]
  Reverse(S Str)                [ S . native_str_reverse ]
  ToInt(S Str)                  [ S . native_str_to_int ]
  ToFloat(S Str)                [ S . native_str_to_float ]
}

// =============================================================================
// Serialization Formats (JSON, YAML, TOML, CSV, XML)
// =============================================================================

Json {
  Parse(Raw Str)        [ Raw . native_json_parse ]
  Encode(Entity Any)    [ Entity . native_json_encode ]
  FormatValue(Val Any)  [ Val . native_json_format_value ]
}

Yaml {
  Parse(Raw Str)        [ Raw . native_yaml_parse ]
  Encode(Entity Any)    [ Entity . native_yaml_encode ]
}

Csv {
  Parse(Raw Str)        [ Raw . native_csv_parse ]
  Encode(Rows List(Any))[ Rows . native_csv_encode ]
}

StringOps(First Str, Last Str) [
  Full "{First} {Last}"
  Full
  . Str.Trim
  . Str.ToUpper
  . Str.Split(" ")
]