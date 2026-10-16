_ meta
_ primitive
_ structure
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
  Text String
  Kind MorphemeKind
}

Lexeme {
  Lemma        String
  PartOfSpeech PartOfSpeech
  Language     Language
}

InflectedWord {
  SurfaceForm  String
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
  Subject   String
  Verb      String
  Object    Option(String)
  Modifiers List(String)
}

// Semantic Frame (Subject - Action - Object - Details)
ObjectActed(Object String, Acted String, Status String, Details String) [
  "{Object} {Acted} {Status} {Details}"
]
