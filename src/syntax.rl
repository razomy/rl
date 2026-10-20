#
Abstract Grammar Combinators
#

Kleene(T) Any           // 0 or more repetitions (T*)
Many(T)   T & Kleene(T) // 1 or more repetitions (T+)
Opt(T)    T | None      // Optional (T?)
Nl        Kleene(Crlf)  // Optional newlines for multiline expressions
Separator Crlf | Semicolon | Comma
FlowSeparator Crlf | Semicolon | Comma
