#
Abstract Linguistic Morpheme, Lexeme, inflected Word & Syntax Phrase
#

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
  SurfaceForm String
  Lexeme      Lexeme
  Case        Option(GrammaticalCase)
  Number      Option(GrammaticalNumber)
  Gender      Option(GrammaticalGender)
  Person      Option(GrammaticalPerson)
  Tense       Option(VerbTense)
  Aspect      Option(VerbAspect)
  Mood        Option(VerbMood)
  Voice       Option(VerbVoice)
}

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
