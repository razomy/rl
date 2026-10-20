#
Abstract Organization & LocalBusiness (schema.org)
#

LegalName  String
TaxID      String
VatID      String
Duns       String
LeiCode    String
NaicsCode  String
IsicV4     String
PriceRange String

Organization Thing & Agent & {
  LegalName            LegalName
  Address              PostalAddress
  Email                Email
  Telephone            Phone
  FaxNumber            Phone
  Logo                 Image
  Brand                Brand
  ContactPoint         ContactPoint_
  Founder              List(Agent)
  FoundingDate         Date
  FoundingLocation     Place
  DissolutionDate      Date
  Employee             List(Agent)
  NumberOfEmployees    QuantitativeValue
  Member               List(Agent)
  MemberOf             List(Organization)
  ParentOrganization   Organization
  SubOrganization      List(Organization)
  Department           List(Organization)
  Location             Place
  AreaServed           Place
  TaxID                TaxID
  VatID                VatID
  Duns                 Duns
  LeiCode              LeiCode
  NaicsCode            NaicsCode
  IsicV4               IsicV4
  AggregateRating      AggregateRating
  Award                List(String)
  Funder               List(Agent)
  Sponsor              List(Agent)
  HasOfferCatalog      OfferCatalog
  MakesOffer           List(Thing)
  Seeks                List(Thing)
  KnowsAbout           List(String)
  KnowsLanguage        List(Language)
  Slogan               String
  NonprofitStatus      NonprofitType
  PublishingPrinciples Url
  EthicsPolicy         Url
}

LocalBusiness Organization & Place & {
  CurrenciesAccepted List(Currency)
  OpeningHours       String
  PaymentAccepted    List(PaymentMethod)
  PriceRange         PriceRange
}
