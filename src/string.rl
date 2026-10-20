#
Concrete Character & String Refinements & Abstract String & Regex Patterns
#

Char            String & [ _.Length == 1 ]
Char64          String & [ _.Length <= 64 ]
Char128         String & [ _.Length <= 128 ]
Char256         String & [ _.Length <= 256 ]
InlineString    String
FixedString     String
MultilineString String
NonEmptyStr     String & NonEmpty
AsciiStr        String
Utf8Str         String
HexStr          String & [ _ . Regex.Matches("^[0-9a-fA-F]+$") ]
Base64Str       String & [ _ . Regex.Matches("^[A-Za-z0-9+/=]+$") ]
SlugStr         String & [ _ . Regex.Matches("^[a-z0-9]+(-[a-z0-9]+)*$") ]
EmailStr        String & [ _ . Regex.Matches("^[^@]+@[^@]+\\.[^@]+$") ]

StringPrimitive Char | Char64 | Char128 | Char256 | InlineString | MultilineString | FixedString | String

RegexPattern {
  Pattern String
  Flags   String
}

RegexMatch {
  FullMatch String
  Groups    List(String)
  Index     Int
}

#
String Operations Module
#

String {
  Length(S String)                          [ S . native_str_len ]
  IsEmpty(S String)                         [ S . Length == 0 ]
  Trim(S String)                            [ S . native_str_trim ]
  TrimStart(S String)                       [ S . native_str_trim_start ]
  TrimEnd(S String)                         [ S . native_str_trim_end ]
  ToUpper(S String)                         [ S . native_str_to_upper ]
  ToLower(S String)                         [ S . native_str_to_lower ]
  Capitalize(S String)                      [ S . native_str_capitalize ]
  CamelCase(S String)                       [ S . native_str_camel_case ]
  SnakeCase(S String)                       [ S . native_str_snake_case ]
  KebabCase(S String)                       [ S . native_str_kebab_case ]
  PascalCase(S String)                      [ S . native_str_pascal_case ]
  Split(S String, Delim String)             [ (S, Delim) . native_str_split ]
  Join(Items List(String), Sep String)      [ (Items, Sep) . native_str_join ]
  Lines(S String)                           [ S . Split("\n") ]
  Words(S String)                           [ S . Trim . Split(" ") ]
  StartsWith(S String, Prefix String)       [ (S, Prefix) . native_str_starts_with ]
  EndsWith(S String, Suffix String)         [ (S, Suffix) . native_str_ends_with ]
  Contains(S String, Sub String)            [ (S, Sub) . native_str_contains ]
  IndexOf(S String, Sub String)             [ (S, Sub) . native_str_index_of ]
  Substring(S String, Start Int, End Int)   [ (S, Start, End) . native_str_substring ]
  Replace(S String, From String, To String) [ (S, From, To) . native_str_replace ]
  Repeat(S String, Count Int)               [ (S, Count) . native_str_repeat ]
  PadStart(S String, Len Int, Pad String)   [ (S, Len, Pad) . native_str_pad_start ]
  PadEnd(S String, Len Int, Pad String)     [ (S, Len, Pad) . native_str_pad_end ]
  Reverse(S String)                         [ S . native_str_reverse ]
  ToInt(S String)                           [ S . native_str_to_int ]
  ToFloat(S String)                         [ S . native_str_to_float ]
}

StringOps(First String, Last String) [
  Full "{First} {Last}"
  Full
  . Trim
  . ToUpper
  . Split(" ")
]
