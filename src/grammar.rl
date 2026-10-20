#
Concrete Grammatical Categories & Semantic Frame
#

GrammaticalCase    "nominative" | "genitive" | "dative" | "accusative" | "instrumental" | "prepositional" | "vocative" | "ablative"
GrammaticalNumber  "singular" | "dual" | "plural"
GrammaticalGender  "masculine" | "feminine" | "neuter" | "common"
GrammaticalPerson  "first" | "second" | "third"
VerbTense          "past" | "present" | "future"
VerbAspect         "imperfective" | "perfective" | "progressive" | "perfect"
VerbMood           "indicative" | "imperative" | "subjunctive" | "conditional" | "infinitive"
VerbVoice          "active" | "passive" | "middle" | "reflexive"
DegreeOfComparison "positive" | "comparative" | "superlative"
MorphemeKind       "root" | "prefix" | "suffix" | "infix" | "ending" | "clitic"
SyntacticRole      "subject" | "predicate" | "direct-object" | "indirect-object" | "adverbial" | "attribute" | "complement" | "determiner"

ObjectActed(Object String, Acted String, Status String, Details String) [
  "{Object} {Acted} {Status} {Details}"
]
