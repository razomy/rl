#
Regular Expression Operations
#

Regex {
  Compile(pat String)                           [ RegexPattern { Pattern pat, Flags "" } ]
  Matches(input String, pat String)             [ _ . native_regex_matches ]
  Find(input String, pat String)                [ _ . native_regex_find ]
  FindAll(input String, pat String)             [ _ . native_regex_find_all ]
  Replace(input String, pat String, repl String)[ _ . native_regex_replace ]
}
