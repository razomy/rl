{ Record } semantic

// ==========================================
// Общие переиспользуемые типы (Shared Fields)
// ==========================================
Name String
Category String
Description String
Symbol String
Alpha2 String
CurrencyCode String


// 1. Media Types
Extension String
MimeType String
IsBinary Bool

MediaType Record & {
  Extension
  MimeType
  Category
  IsBinary
}

RecordExample(MediaType {
  extension "pdf"
  mime_type "application/pdf"
  category "Document"
  is_binary true
})


// 2. Unicode & Emojis (переименовано в UnicodeCharacter)
Glyph String
CodePoint String

UnicodeCharacter Record & {
  Glyph
  Name
  Category
  CodePoint
}

RecordExample(UnicodeCharacter {
  glyph "🚀"
  name "Rocket"
  category "Travel & Places"
  code_point "U+1F680"
})


// 3. Programming Languages
Slug String
Extensions Array(String)
Paradigm String

ProgrammingLanguage Record & {
  Name
  Slug
  Extensions
  Paradigm
}

RecordExample(ProgrammingLanguage {
  name "Python"
  slug "python"
  extensions [".py", ".pyw"]
  paradigm "Multi-paradigm"
})


// 4. Countries
Alpha3 String
NumericCode String
DialCode String

Country Record & {
  Name
  Alpha2
  Alpha3
  NumericCode
  DialCode
  CurrencyCode
}

RecordExample(Country {
  name "Canada"
  alpha2 "CA"
  alpha3 "CAN"
  numeric_code "124"
  dial_code "+1"
  currency_code "CAD"
})


// 5. Locales and Languages (BCP 47)
LocaleCode String
Language String
Territory String
Script String
IsRtl Bool

Locale Record & {
  LocaleCode
  Language
  Territory
  Script
  IsRtl
}

RecordExample(Locale {
  locale_code "es-MX"
  language "Spanish"
  territory "Mexico"
  script "Latn"
  is_rtl false
})


// 6. Jobs & Occupations (переименовано в Occupation)
Department String
SocCode String

Occupation Record & {
  Name
  Department
  SocCode
}

RecordExample(Occupation {
  name "Software Engineer"
  department "Technology"
  soc_code "15-1252"
})


// 7. Currencies & Financial Data
Decimals Int
Countries Array(String)

Currency Record & {
  CurrencyCode
  Name
  Symbol
  Decimals
  Countries
}

RecordExample(Currency {
  currency_code "EUR"
  name "Euro"
  symbol "€"
  decimals 2
  countries ["FR", "DE", "IT"]
})


// 8. Timezones
TzIdentifier String
UtcOffset String
HasDst Bool

Timezone Record & {
  TzIdentifier
  UtcOffset
  HasDst
}

RecordExample(Timezone {
  tz_identifier "America/New_York"
  utc_offset "-05:00"
  has_dst true
})


// 9. Postal & Zip Code Formats (переименовано в PostalFormat)
RegexPattern String
FormatExample String

PostalFormat Record & {
  Alpha2
  RegexPattern
  FormatExample
}

RecordExample(PostalFormat {
  alpha2 "US"
  regex_pattern "^\\d{5}(-\\d{4})?$"
  format_example "90210"
})


// 10. Phone Number Dialing Codes (переименовано в TelecomPrefix)
CountryName String
NationalNumberLength Int

TelecomPrefix Record & {
  CountryName
  Alpha2
  DialCode
  NationalNumberLength
}

RecordExample(TelecomPrefix {
  country_name "United Kingdom"
  alpha2 "GB"
  dial_code "+44"
  national_number_length 10
})


// 11. Colors (переименовано в Color)
HexCode String
RgbValue String
HslValue String

Color Record & {
  Name
  HexCode
  RgbValue
  HslValue
}

RecordExample(Color {
  name "Tailwind Blue 500"
  hex_code "#3b82f6"
  rgb_value "59, 130, 246"
  hsl_value "217, 91%, 60%"
})


// 12. Domain TLDs
Tld String
Registry String

TopLevelDomain Record & {
  Tld
  Category
  Registry
}

RecordExample(TopLevelDomain {
  tld ".io"
  category "ccTLD"
  registry "Internet Computer Bureau"
})


// 13. User-Agent Strings & Browsers (переименовано в UserAgent)
Browser String
OperatingSystem String
DeviceType String
UserAgentString String

UserAgent Record & {
  Browser
  OperatingSystem
  DeviceType
  UserAgentString
}

RecordExample(UserAgent {
  browser "Chrome"
  operating_system "Windows"
  device_type "Desktop"
  user_agent_string "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36..."
})


// 14. Units of Measurement
Dimension String
SiBaseUnit String

MeasurementUnit Record & {
  Name
  Symbol
  Dimension
  SiBaseUnit
}

RecordExample(MeasurementUnit {
  name "Kilogram"
  symbol "kg"
  dimension "Mass"
  si_base_unit "kg"
})


// 15. Universities & Higher Education
Domain String
WebsiteUrl String

University Record & {
  Name
  CountryName
  Domain
  WebsiteUrl
}

RecordExample(University {
  name "Harvard University"
  country_name "United States"
  domain "harvard.edu"
  website_url "https://www.harvard.edu"
})


// 16. Airports
IataCode String
IcaoCode String
CityName String

Airport Record & {
  IataCode
  IcaoCode
  Name
  CityName
  CountryName
}

RecordExample(Airport {
  iata_code "JFK"
  icao_code "KJFK"
  name "John F. Kennedy International Airport"
  city_name "New York"
  country_name "United States"
})


// 17. HTTP Status Codes (переименовано в HttpStatus)
StatusCode Int
ReasonPhrase String

HttpStatus Record & {
  StatusCode
  ReasonPhrase
  Category
  Description
}

RecordExample(HttpStatus {
  status_code 404
  reason_phrase "Not Found"
  category "Client Error"
  description "The requested resource could not be found."
})


// 18. Zodiac & Astrology (переименовано в ZodiacSign)
Element String
DateRange String

ZodiacSign Record & {
  Name
  Element
  Symbol
  DateRange
}

RecordExample(ZodiacSign {
  name "Aries"
  element "Fire"
  symbol "Ram"
  date_range "Mar 21 - Apr 19"
})


// ==========================================
// Список всех таблиц
// ==========================================
Tables
  MediaType
  UnicodeCharacter
  ProgrammingLanguage
  Country
  Locale
  Occupation
  Currency
  Timezone
  PostalFormat
  TelecomPrefix
  Color
  TopLevelDomain
  UserAgent
  MeasurementUnit
  University
  Airport
  HttpStatus
  ZodiacSign
