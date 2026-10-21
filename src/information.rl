#
Abstract Language, Text, Identifiers, Addressing, Media, Messages & Information
#

LanguageCode String
Script "latin" | "cyrillic" | "greek" | "arabic" | "hebrew" | "devanagari" | "han" | "hiragana"
    | "katakana" | "hangul" | "thai" | "georgian" | "armenian" | "bengali" | "tamil" | "ethiopic"
LanguageFamily "indo-european" | "sino-tibetan" | "afro-asiatic" | "austronesian" | "niger-congo"
    | "dravidian" | "turkic" | "uralic" | "japonic" | "koreanic" | "constructed" | "formal"

Language {
    Name
    LanguageCode
    Script
    LanguageFamily
}

Symbol    { Glyph Char, meaning String }
Word      { Spelling String, Language }
Sentence  { Words List(Word) }
Text      { Content String, Language }
Paragraph Text
Title     String
Summary   Text
Keyword   String

PartOfSpeech "noun" | "verb" | "adjective" | "adverb" | "pronoun" | "preposition" | "conjunction"
    | "interjection" | "article" | "numeral"

Identifier { Scheme String, value String }

Email      String
Phone      String
Handle     String
IpAddress  String
DomainName String
PostalCode String

Address {
    StreetAddress String
    Locality      String
    Region        String
    PostalCode
    CountryCode   String
}

ContactPoint { Email, Phone, Url, Address }

MimeType String
Encoding "utf-8" | "utf-16" | "ascii" | "base64" | "binary"

Data {
    MimeType
    Encoding
    DataSize
    Checksum String
}

MediaKind  "text" | "image" | "audio" | "video" | "3d" | "interactive"
Resolution { Width Count, height Count }

Media {
    MediaKind
    Format
    Url
    Data
    Duration
    Resolution
}

Signal   { Frequency, payload Data }
Channel_ "speech" | "writing" | "gesture" | "mail" | "phone" | "email" | "chat" | "broadcast" | "web"

Message {
    Sender    Agent
    Receivers List(Agent)
    Text
    Channel_
    SentAt    Instant
}

Draft     Object
Published { PublishedAt Instant, Url }
Retracted { RetractedAt Instant, reason String }
Sent      { SentAt Instant }
Delivered { DeliveredAt Instant }
Read      { ReadAt Instant }

Information { Content Any, source Agent, confidence Fraction }
Record      { Identifier, fields Any, created Instant }
Catalog     { Records List(Record) }
Archive     Catalog
