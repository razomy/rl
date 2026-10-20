#
Regular Expression Operations
#

Regex {
  Compile(Pat String)                           [ RegexPattern { Pattern Pat, Flags "" } ]
  Matches(Input String, Pat String)             [ (Input, Pat) . native_regex_matches ]
  Find(Input String, Pat String)                [ (Input, Pat) . native_regex_find ]
  FindAll(Input String, Pat String)             [ (Input, Pat) . native_regex_find_all ]
  Replace(Input String, Pat String, Repl String)[ (Input, Pat, Repl) . native_regex_replace ]
}
