_ thing
_ enumeration
_ intangible
_ place
_ organization

#
Person
#

GivenName      Name
FamilyName     Name
AdditionalName Name
HonorificPrefix String
HonorificSuffix String
JobTitle       String
Nationality    Country
BirthDate      Date
DeathDate      Date
Gender         GenderType

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

Patient Person & { Diagnosis List(Thing), Drug List(Thing), HealthCondition List(Thing) }

Employee_ Person & { WorksFor List1(Organization) }
Student   Person & { AlumniOf List(EducationalOrganization) }
Author_   Person
Athlete   Person
Musician  Person
Actor_    Person

#
Transitions
#

BirthOf(P Person, Where Place) [ P & Alive { Since Now } & { BirthDate Today, BirthPlace Where } ]
DeathOf(P Person & Alive, Where Place) [ P / Alive & { DeathDate Today, DeathPlace Where } ]
Hire(P Person, O Organization, Title String) [ P & { WorksFor (Cons { Head O, Tail WorksFor }), JobTitle Title } ]
Fire(P Person, O Organization) [ P & { WorksFor (WorksFor / O), JobTitle None } ]
Promote(P Person, Title String) [ P & { JobTitle Title } ]
Graduate(P Person, S EducationalOrganization) [ P & { AlumniOf (Cons { Head S, Tail AlumniOf }) } ]
MarryPerson(A Person, B Person) [ List2(A & { Spouse B }, B & { Spouse A }) ]
HaveChild(A Person, B Person, C Person) [ C & { Parent List2(A, B) } ]
Meet(A Person, B Person) [ A & { Knows (Cons { Head B, Tail Knows }) } ]
FollowPerson(A Person, B Person) [ A & { Follows (Cons { Head B, Tail Follows }) } ]
MoveHome(P Person, L Place) [ P & { HomeLocation L } ]
Naturalise(P Person, C Country) [ P & { Nationality C } ]
Admit(P Person) [ Patient & P ]
Discharge_(P Patient) [ P / Patient ]
