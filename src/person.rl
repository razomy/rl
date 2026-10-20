#
Abstract Person (schema.org & HumanAgent)
#

GivenName       Name
FamilyName      Name
AdditionalName  Name
HonorificPrefix String
HonorificSuffix String
JobTitle        String
Nationality     Country
BirthDate       Date
DeathDate       Date
Gender          GenderType

Person Thing & HumanAgent & {
    GivenName
    FamilyName
    AdditionalName
    HonorificPrefix
    HonorificSuffix
    Gender
    BirthDate
    BirthPlace Place
    DeathDate
    DeathPlace Place
    Age
    Nationality
    Address PostalAddress
    HomeLocation Place
    WorkLocation Place
    Email
    Telephone Phone
    JobTitle
    HasOccupation Occupation
    WorksFor List(Organization)
    AffiliatedWith List(Organization)
    MemberOf List(Organization)
    AlumniOf List(EducationalOrganization)
    Parent List(Person)
    Children List(Person)
    Sibling List(Person)
    Spouse Person
    RelatedTo List(Person)
    Knows List(Person)
    Colleague List(Person)
    Follows List(Person)
    Funder List(Agent)
    Sponsor List(Agent)
    Award List(String)
    KnowsAbout List(String)
    KnowsLanguage List(Language)
    Height QuantitativeValue
    Weight QuantitativeValue
    NetWorth MonetaryAmount
    TaxID
    VatID
    Owns List(OwnershipInfo)
    Seeks List(Thing)
    MakesOffer List(Thing)
    PerformerIn List(Thing)
}
