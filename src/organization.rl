_ thing
_ enumerations
_ intangible
_ place

// =============================================================================
// Organization
// =============================================================================

LegalName String
TaxID     String
VatID     String
Duns      String
LeiCode   String
NaicsCode String
IsicV4    String

Organization Thing & Agent & {
    LegalName
    Address PostalAddress
    Email
    Telephone Phone
    FaxNumber Phone
    Logo Image
    Brand
    ContactPoint ContactPoint_
    Founder List(Agent)
    FoundingDate Date
    FoundingLocation Place
    DissolutionDate Date
    Employee List(Agent)
    NumberOfEmployees QuantitativeValue
    Member List(Agent)
    MemberOf List(Organization)
    ParentOrganization Organization
    SubOrganization List(Organization)
    Department List(Organization)
    Location Place
    AreaServed Place
    TaxID
    VatID
    Duns
    LeiCode
    NaicsCode
    IsicV4
    AggregateRating
    Award List(String)
    Funder List(Agent)
    Sponsor List(Agent)
    HasOfferCatalog OfferCatalog
    MakesOffer List(Thing)
    Seeks List(Thing)
    KnowsAbout List(String)
    KnowsLanguage List(Language)
    Slogan String
    NonprofitStatus NonprofitType
    PublishingPrinciples Url
    EthicsPolicy Url
}

// =============================================================================
// Subtypes
// =============================================================================

Airline       Organization & { IataCode String, BoardingPolicy BoardingPolicyType }
Consortium    Organization
Corporation   Organization & { TickerSymbol String }
Cooperative   Organization
EducationalOrganization Organization & { Alumni List(Agent) }
CollegeOrUniversity EducationalOrganization
ElementarySchool    EducationalOrganization
HighSchool          EducationalOrganization
MiddleSchool        EducationalOrganization
Preschool           EducationalOrganization
School              EducationalOrganization
FundingScheme Organization
GovernmentOrganization Organization
LibrarySystem Organization
MedicalOrganization Organization & { HealthPlanNetworkId String, IsAcceptingNewPatients Bool, MedicalSpecialty }
DiagnosticLab   MedicalOrganization
VeterinaryCare  MedicalOrganization
NGO           Organization
NewsMediaOrganization Organization & { Masthead Url, CorrectionsPolicy Url, DiversityPolicy Url }
OnlineBusiness Organization
OnlineStore    OnlineBusiness
PerformingGroup Organization
DanceGroup     PerformingGroup
MusicGroup     PerformingGroup & { Genre String, Album List(Thing), Track List(Thing) }
TheaterGroup   PerformingGroup
PoliticalParty Organization
Project       Organization
FundingAgency Project
ResearchProject Project
ResearchOrganization Organization
SearchRescueOrganization Organization
SportsOrganization Organization & { Sport String }
SportsTeam     SportsOrganization & { Athlete List(Agent), Coach List(Agent) }
WorkersUnion  Organization

// =============================================================================
// Transitions
// =============================================================================

Found(F Agent, N Name) [ Organization { Name N, Founder List1(F), FoundingDate Today } ]
Dissolve_(O Organization) [ O & { DissolutionDate Today } ]
Merge(A Organization, B Organization) [ Organization & A & B & { SubOrganization List2(A, B) } ]
Acquire_(Parent Organization, Child Organization) [ Child & { ParentOrganization Parent } ]
SpinOff(O Organization, N Name) [ Organization { Name N, ParentOrganization O, FoundingDate Today } ]
Rebrand(O Organization, B Brand) [ O & { Brand B } ]
GoPublic(C Corporation, Ticker String) [ C & { TickerSymbol Ticker } ]
AddMember(O Organization, M Agent) [ O & { Member (Cons { Head M, Tail Member }) } ]
