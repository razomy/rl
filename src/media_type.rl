{ Record } semantic

// 1. Media Types (из исходного примера)
Extension String
MimeType String
Category String
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


// 2. Unicode & Emojis
Emoji String
EmojiName String
CodePoint String

EmojiItem Record & {
  Emoji
  EmojiName
  Category
  CodePoint
}

EmojiItemExample RecordExample(EmojiItem {
  emoji "🚀"
  emoji_name "rocket"
  category "Travel & Places"
  code_point "U+1F680"
})


// 3. Programming Languages
ProgrammingLanguageName String
Alias String
Extensions Array(String)
Paradigm String

ProgrammingLanguage Record & {
  name ProgrammingLanguageName
  Alias
  Extensions
  Paradigm
}

RecordExample(ProgrammingLanguage {
  name "Python"
  slug "python"
  extensions (".py", ".pyw")
  paradigm "Multi-paradigm"
})


// 4. Countries & Subdivisions
CountryName String
Alpha2 String
Alpha3 String
NumericCode String
PhoneCode String
CurrencyCode String

Country Record & {
  CountryName
  Alpha2
  Alpha3
  NumericCode
  PhoneCode
  CurrencyCode
}

RecordExample(Country {
  country_name "Canada"
  alpha2 "CA"
  alpha3 "CAN"
  numeric_code "124"
  phone_code "+1"
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


// 6. Cities & Geo-Coordinates
CityName String
Latitude Float
Longitude Float
TimezoneName String

GeoLocation Record & {
  CityName
  CountryName
  Latitude
  Longitude
  TimezoneName
}

RecordExample(GeoLocation {
  city_name "Tokyo"
  country_name "Japan"
  latitude 35.6762
  longitude 139.6503
  timezone_name "Asia/Tokyo"
})


// 7. Jobs & Occupations
JobTitle String
Department String
SocCode String

JobOccupation Record & {
  JobTitle
  Department
  SocCode
}

RecordExample(JobOccupation {
  job_title "Software Engineer"
  department "Technology"
  soc_code "15-1252"
})


// 8. Currencies & Financial Data
CurrencySymbol String
Decimals Int
CountryCodes [String]

Currency Record & {
  CurrencyCode
  CountryName
  CurrencySymbol
  Decimals
  CountryCodes
}

RecordExample(Currency {
  currency_code "EUR"
  country_name "Euro"
  currency_symbol "€"
  decimals 2
  country_codes ["FR", "DE", "IT"]
})


// 9. Timezones & Calendars
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


// 10. Postal & Zip Code Formats
PostalRegex String
FormatExample String

PostalCodeFormat Record & {
  Alpha2
  PostalRegex
  FormatExample
}

RecordExample(PostalCodeFormat {
  alpha2 "US"
  postal_regex "^\\d{5}(-\\d{4})?$"
  format_example "90210"
})


// 11. Phone Number Dialing Codes
DialCode String
PhoneNumberLength Int

CallingCode Record & {
  CountryName
  Alpha2
  DialCode
  PhoneNumberLength
}

RecordExample(CallingCode {
  country_name "United Kingdom"
  alpha2 "GB"
  dial_code "+44"
  phone_number_length 10
})


// 12. Colors & Design Palettes
ColorName String
HexColor String
RgbColor String
HslColor String

ColorPalette Record & {
  ColorName
  HexColor
  RgbColor
  HslColor
}

RecordExample(ColorPalette {
  color_name "Tailwind Blue 500"
  hex_color "#3b82f6"
  rgb_color "59, 130, 246"
  hsl_color "217, 91%, 60%"
})


// 13. File Extensions & Icons
FileIcon String

FileExtensionInfo Record & {
  Extension
  MimeType
  FileIcon
  Category
}

RecordExample(FileExtensionInfo {
  extension "md"
  mime_type "text/markdown"
  file_icon "file-code"
  category "Text"
})


// 14. Domain TLDs
Tld String
TldType String
Registry String

TopLevelDomain Record & {
  Tld
  TldType
  Registry
}

RecordExample(TopLevelDomain {
  tld ".io"
  tld_type "gTLD"
  registry "Internet Assigned Numbers Authority"
})


// 15. User-Agent Strings & Browsers
Browser String
OperatingSystem String
DeviceType String
SampleUserAgent String

UserAgentProfile Record & {
  Browser
  OperatingSystem
  DeviceType
  SampleUserAgent
}

RecordExample(UserAgentProfile {
  browser "Chrome"
  operating_system "Windows"
  device_type "Desktop"
  sample_user_agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36..."
})


// 16. Units of Measurement
UnitName String
UnitSymbol String
Dimension String
SiBase String

MeasurementUnit Record & {
  UnitName
  UnitSymbol
  Dimension
  SiBase
}

RecordExample(MeasurementUnit {
  unit_name "Kilogram"
  unit_symbol "kg"
  dimension "Mass"
  si_base "kg"
})


// 17. Dietary & Allergens
FoodItem String
DietFlags Array(String)
Allergens Array(String)

DietaryProfile Record & {
  FoodItem
  DietFlags
  Allergens
}

RecordExample(DietaryProfile {
  food_item "Peanut Butter"
  diet_flags ("Vegan", "Vegetarian", "Keto")
  allergens ("Peanuts")
})


// 18. Universities & Higher Education
InstitutionName String
Domain String
WebPage String

University Record & {
  InstitutionName
  CountryName
  Domain
  WebPage
}

RecordExample(University {
  institution_name "Harvard University"
  country_name "United States"
  domain "harvard.edu"
  web_page "https://www.harvard.edu"
})

// 19. Airports & Airlines
IataCode String
IcaoCode String
AirportName String

Airport Record & {
  IataCode
  IcaoCode
  AirportName
  CityName
}

RecordExample(Airport {
  iata_code "JFK"
  icao_code "KJFK"
  airport_name "John F. Kennedy International Airport"
  city_name "New York"
})


// 20. Content & Dummy (Lorem Ipsum)
ContentType String
ContentBody String

DummyContent Record & {
  ContentType
  ContentBody
}

RecordExample(DummyContent {
  content_type "tech_buzzwords"
  content_body "Leverage agile cloud-native microservices for seamless CI/CD pipelines."
})


// 21. HTTP Status Codes
StatusCode Int
StatusPhrase String
Description String

HttpStatusCode Record & {
  StatusCode
  StatusPhrase
  Category
  Description
}

RecordExample(HttpStatusCode {
  status_code 404
  status_phrase "Not Found"
  category "Client Error"
  description "The requested resource could not be found."
})


// 22. Zodiac & Astrology
ZodiacSign String
AstrologyElement String
ZodiacSymbol String
DateRange String

Zodiac Record & {
  ZodiacSign
  AstrologyElement
  ZodiacSymbol
  DateRange
}

RecordExample(Zodiac {
  zodiac_sign "Aries"
  astrology_element "Fire"
  zodiac_symbol "Ram"
  date_range "Mar 21 - Apr 19"
})


// 23. Mock Data (Faker - Person Profile)
FirstName String
LastName String
EmailAddress String
AvatarUrl String
PhoneNumber String

PersonProfile Record & {
  FirstName
  LastName
  EmailAddress
  AvatarUrl
  PhoneNumber
}

RecordExample(PersonProfile {
  first_name "Alex"
  last_name "Mercer"
  email_address "alex.mercer@example.com"
  avatar_url "https://images.example.com/avatar/12.jpg"
  phone_number "+1-555-0199"
})


// 24. Mock Data (Faker - Address & Location)
StreetAddress String
SecondaryAddress String
ZipCode String

AddressMock Record & {
  StreetAddress
  SecondaryAddress
  CityName
  ZipCode
  CountryName
}

RecordExample(AddressMock {
  street_address "742 Evergreen Terrace"
  secondary_address "Apt. 4B"
  city_name "Springfield"
  zip_code "97477"
  country_name "United States"
})


// 25. Mock Data (Faker - Payment & Credit Card)
CardIssuer String
CardNumber String
CvvCode String
ExpiryDate String

CreditCard Record & {
  CardIssuer
  CardNumber
  CvvCode
  ExpiryDate
}

RecordExample(CreditCard {
  card_issuer "Visa"
  card_number "4532-xxxx-xxxx-8891"
  cvv_code "742"
  expiry_date "09/28"
})
