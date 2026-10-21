#
Pipeline, Composite & Atomic Operators
#

DotGt       ".>"                  // Tap pipeline (side-effect)
DotAmp      ".&"                  // Enrich pipeline (merge result)
DotPipe     ".|"                  // Explicit parallel pipeline
DotQm       ".?"                  // Filter / Safe guard pipeline
DotRange    ".."                  // Map over stream / Range generator

PipeDot     "\\.(?=[ \\t\\r\\n\\{\\[\\(])"
Dot         "."

EqEq        "=="
NotEq       "!="
Lte         "<="
Gte         ">="
AndAnd      "&&"
OrOr        "||"
Pow         "**"
ShiftL      "<<"
ShiftR      ">>"

Plus        "+"
Minus       "-"
Mul         "*"
Slash       "/"                   // Division (Math) & Subtraction (type Algebra)
Mod         "%"
Pipe        "|"                   // Union (Types & Flows)
Amp         "&"                   // Intersection / Merge (Types & Flows)
Qm          "?"
Bang        "!"
Eq          "="
LAngle      "<"
RAngle      ">"
