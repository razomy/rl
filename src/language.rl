_ meta
_ primitives
_ structures
_ information

// =============================================================================
// Natural Language Grammar, Morphology, Syntax & Semantics
// =============================================================================

GrammaticalCase "nominative" | "genitive" | "dative" | "accusative" | "instrumental" | "prepositional" | "vocative" | "ablative"
GrammaticalNumber "singular" | "dual" | "plural"
GrammaticalGender "masculine" | "feminine" | "neuter" | "common"
GrammaticalPerson "first" | "second" | "third"
VerbTense "past" | "present" | "future"
VerbAspect "imperfective" | "perfective" | "progressive" | "perfect"
VerbMood "indicative" | "imperative" | "subjunctive" | "conditional" | "infinitive"
VerbVoice "active" | "passive" | "middle" | "reflexive"
DegreeOfComparison "positive" | "comparative" | "superlative"

MorphemeKind "root" | "prefix" | "suffix" | "infix" | "ending" | "clitic"
Morpheme {
  Text Str
  Kind MorphemeKind
}

Lexeme {
  Lemma        Str
  PartOfSpeech PartOfSpeech
  Language     Language
}

InflectedWord {
  SurfaceForm  Str
  Lexeme       Lexeme
  Case         Option(GrammaticalCase)
  Number       Option(GrammaticalNumber)
  Gender       Option(GrammaticalGender)
  Person       Option(GrammaticalPerson)
  Tense        Option(VerbTense)
  Aspect       Option(VerbAspect)
  Mood         Option(VerbMood)
  Voice        Option(VerbVoice)
}

// =============================================================================
// Syntactic Roles & Phrase Structure
// =============================================================================

SyntacticRole "subject" | "predicate" | "direct-object" | "indirect-object" | "adverbial" | "attribute" | "complement" | "determiner"

DependencyArc {
  HeadIndex      Int
  DependentIndex Int
  Relation       SyntacticRole
}

SyntaxPhrase {
  Subject   Str
  Verb      Str
  Object    Option(Str)
  Modifiers List(Str)
}

// Semantic Frame (Subject - Action - Object - Details)
ObjectActed(Object Str, Acted Str, Status Str, Details Str) [
  "{Object} {Acted} {Status} {Details}"
]