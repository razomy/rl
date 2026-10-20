_ primitive
_ structure
_ quantity
_ time
_ agent

#
Languages and writing
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

English    Language & { Name "english",    LanguageCode "en", Script "latin",      LanguageFamily "indo-european" }
Spanish    Language & { Name "spanish",    LanguageCode "es", Script "latin",      LanguageFamily "indo-european" }
French     Language & { Name "french",     LanguageCode "fr", Script "latin",      LanguageFamily "indo-european" }
German     Language & { Name "german",     LanguageCode "de", Script "latin",      LanguageFamily "indo-european" }
Italian    Language & { Name "italian",    LanguageCode "it", Script "latin",      LanguageFamily "indo-european" }
Portuguese Language & { Name "portuguese", LanguageCode "pt", Script "latin",      LanguageFamily "indo-european" }
Ukrainian  Language & { Name "ukrainian",  LanguageCode "uk", Script "cyrillic",   LanguageFamily "indo-european" }
Russian    Language & { Name "russian",    LanguageCode "ru", Script "cyrillic",   LanguageFamily "indo-european" }
Polish     Language & { Name "polish",     LanguageCode "pl", Script "latin",      LanguageFamily "indo-european" }
Greek      Language & { Name "greek",      LanguageCode "el", Script "greek",      LanguageFamily "indo-european" }
Hindi      Language & { Name "hindi",      LanguageCode "hi", Script "devanagari", LanguageFamily "indo-european" }
Bengali    Language & { Name "bengali",    LanguageCode "bn", Script "bengali",    LanguageFamily "indo-european" }
Persian    Language & { Name "persian",    LanguageCode "fa", Script "arabic",     LanguageFamily "indo-european" }
Chinese    Language & { Name "chinese",    LanguageCode "zh", Script "han",        LanguageFamily "sino-tibetan" }
Japanese   Language & { Name "japanese",   LanguageCode "ja", Script "han",        LanguageFamily "japonic" }
Korean     Language & { Name "korean",     LanguageCode "ko", Script "hangul",     LanguageFamily "koreanic" }
Arabic     Language & { Name "arabic",     LanguageCode "ar", Script "arabic",     LanguageFamily "afro-asiatic" }
Hebrew     Language & { Name "hebrew",     LanguageCode "he", Script "hebrew",     LanguageFamily "afro-asiatic" }
Turkish    Language & { Name "turkish",    LanguageCode "tr", Script "latin",      LanguageFamily "turkic" }
Finnish    Language & { Name "finnish",    LanguageCode "fi", Script "latin",      LanguageFamily "uralic" }
Hungarian  Language & { Name "hungarian",  LanguageCode "hu", Script "latin",      LanguageFamily "uralic" }
Swahili    Language & { Name "swahili",    LanguageCode "sw", Script "latin",      LanguageFamily "niger-congo" }
Indonesian Language & { Name "indonesian", LanguageCode "id", Script "latin",      LanguageFamily "austronesian" }
Tamil      Language & { Name "tamil",      LanguageCode "ta", Script "tamil",      LanguageFamily "dravidian" }
Thai       Language & { Name "thai",       LanguageCode "th", Script "thai",       LanguageFamily "formal" }
Esperanto  Language & { Name "esperanto",  LanguageCode "eo", Script "latin",      LanguageFamily "constructed" }

Symbol    { Glyph Char, Meaning String }
Word      { Spelling String, Language }
Sentence  { Words List(Word) }
Text      { Content String, Language }
Paragraph Text
Title     String
Summary   Text
Keyword   String

PartOfSpeech "noun" | "verb" | "adjective" | "adverb" | "pronoun" | "preposition" | "conjunction"
    | "interjection" | "article" | "numeral"

#
Identity and addressing
#

Identifier { Scheme String, Value String }
Uuid   Identifier & { Scheme "uuid" }
Isbn   Identifier & { Scheme "isbn" }
Issn   Identifier & { Scheme "issn" }
Doi    Identifier & { Scheme "doi" }
Gtin   Identifier & { Scheme "gtin" }
Iban   Identifier & { Scheme "iban" }
Vin    Identifier & { Scheme "vin" }

Url        String & [ _ . ("http" | "https" | "ftp" | "mailto" | "file") ]
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

#
Data and media
#

MimeType String
Encoding "utf-8" | "utf-16" | "ascii" | "base64" | "binary"
Format "text" | "json" | "xml" | "csv" | "html" | "markdown" | "pdf" | "png" | "jpeg" | "gif"
    | "svg" | "mp3" | "wav" | "mp4" | "webm" | "zip"

Data {
    MimeType
    Encoding
    DataSize
    Checksum String
}

MediaKind "text" | "image" | "audio" | "video" | "3d" | "interactive"
Resolution { Width Count, Height Count }

Media {
    MediaKind
    Format
    Url
    Data
    Duration
    Resolution
}

Image Media & { MediaKind "image" }
Audio Media & { MediaKind "audio" }
Video Media & { MediaKind "video" }

Signal { Frequency, Payload Data }
Channel_ "speech" | "writing" | "gesture" | "mail" | "phone" | "email" | "chat" | "broadcast" | "web"

Message {
    Sender    Agent
    Receivers List(Agent)
    Text
    Channel_
    SentAt    Instant
}

Draft      {}
Published  { PublishedAt Instant, Url }
Retracted  { RetractedAt Instant, Reason String }
Sent       { SentAt Instant }
Delivered  { DeliveredAt Instant }
Read       { ReadAt Instant }

Information { Content Any, Source Agent, Confidence Fraction }
Record      { Identifier, Fields Any, Created Instant }
Catalog     { Records List(Record) }
Archive     Catalog

#
Transitions
#

Write(A Agent, Content String, L Language) [ Text { Content, Language L } & Draft {} ]
Publish(D Draft, U Url) [ D / Draft & Published { PublishedAt Now, Url U } ]
Retract(P Published, Reason String) [ P / Published & Retracted { RetractedAt Now, Reason } ]
Translate(T Text, Target Language) [ Text { Content T.Content, Language Target } ]
Summarize(T Text) [ Summary { Content T.Content, Language T.Language } ]
Send(M Message) [ M & Sent { SentAt Now } ]
Deliver(M Message & Sent) [ M & Delivered { DeliveredAt Now } ]
MarkRead(M Message & Delivered) [ M & Read { ReadAt Now } ]
Encode(D Data, E Encoding) [ D & { Encoding E } ]
Assign(X Any, I Identifier) [ X & { Identifier I } ]
Archive_(R Record, C Catalog) [ C & { Records (Cons { Head R, Tail Records }) } ]
