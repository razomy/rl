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
String Char & {
  Length(s String)                          [ _ . native_str_len ]
  IsEmpty(s String)                         [ _ . Length == 0 ]
  Trim(s String)                            [ _ . native_str_trim ]
  TrimStart(s String)                       [ _ . native_str_trim_start ]
  TrimEnd(s String)                         [ _ . native_str_trim_end ]
  ToUpper(s String)                         [ _ . native_str_to_upper ]
  ToLower(s String)                         [ _ . native_str_to_lower ]
  Capitalize(s String)                      [ _ . native_str_capitalize ]
  CamelCase(s String)                       [ _ . native_str_camel_case ]
  SnakeCase(s String)                       [ _ . native_str_snake_case ]
  KebabCase(s String)                       [ _ . native_str_kebab_case ]
  PascalCase(s String)                      [ _ . native_str_pascal_case ]
  Split(s String, delim String)             [ _ . native_str_split ]
  Join(items List(String), sep String)  [ _ . native_str_join ]
  Lines(s String)                           [ _ . Split("\n") ]
  Words(s String)                           [ _ . Trim . Split(" ") ]
  StartsWith(s String, prefix String)       [ _ . native_str_starts_with ]
  EndsWith(s String, suffix String)         [ _ . native_str_ends_with ]
  Contains(s String, sub String)            [ _ . native_str_contains ]
  IndexOf(s String, sub String)             [ _ . native_str_index_of ]
  Substring(s String, start Int, end Int)   [ _ . native_str_substring ]
  Replace(s String, from String, to String) [ _ . native_str_replace ]
  Repeat(s String, count Int)               [ _ . native_str_repeat ]
  PadStart(s String, len Int, pad String)   [ _ . native_str_pad_start ]
  PadEnd(s String, len Int, pad String)     [ _ . native_str_pad_end ]
  Reverse(s String)                         [ _ . native_str_reverse ]
  ToInt(s String)                           [ _ . native_str_to_int ]
  ToFloat(s String)                         [ _ . native_str_to_float ]
}

StringOps(first String, last String) [
  "{First} {Last}"
  . Trim
  . ToUpper
  . Split(" ")
]
