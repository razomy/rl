_ thing
_ enumeration

// =============================================================================
// Intangible
// =============================================================================

Intangible Thing

// Quantities and structured values
Quantity_    Intangible & Measure(Real, Unit)
Distance_    Quantity_ & { Unit Metre }
Duration_    Quantity_ & { Unit Second }
Energy_      Quantity_ & { Unit Joule }
Mass_        Quantity_ & { Unit Kilogram }

StructuredValue Intangible
QuantitativeValue StructuredValue & { Value Real, MinValue Real, MaxValue Real, UnitCode String, UnitText String }
PropertyValue     StructuredValue & { PropertyID String, Value Any, UnitCode String }
GeoCoordinates    StructuredValue & GeoCoordinate & { Address }
GeoShape_         StructuredValue & { Box String, Circle String, Line String, Polygon String }
GeoCircle_        GeoShape_ & { GeoMidpoint GeoCoordinates, GeoRadius Distance_ }
PostalAddress     StructuredValue & Address & { PostOfficeBoxNumber String, AddressCountry String }
ContactPoint_     StructuredValue & ContactPoint & { ContactType String, AreaServed String, AvailableLanguage Language, HoursAvailable OpeningHoursSpecification }
OpeningHoursSpecification StructuredValue & { DayOfWeek, Opens TimeOfDay, Closes TimeOfDay, ValidFrom Date, ValidThrough Date }
MonetaryAmount    StructuredValue & Money & { MinValue Real, MaxValue Real, ValidFrom Date, ValidThrough Date }
ExchangeRateSpecification StructuredValue & { Currency, CurrentExchangeRate UnitPriceSpecification }
InteractionCounter StructuredValue & { InteractionType String, UserInteractionCount Count }
NutritionInformation StructuredValue & { Calories, FatContent Mass_, ProteinContent Mass_, CarbohydrateContent Mass_, SugarContent Mass_, SodiumContent Mass_, ServingSize String }
DatedMoneySpecification StructuredValue & { Amount Real, Currency, StartDate Date, EndDate Date }
EngineSpecification StructuredValue & { FuelType String, EngineDisplacement QuantitativeValue, EnginePower QuantitativeValue, Torque QuantitativeValue }
RepaymentSpecification StructuredValue & { DownPayment MonetaryAmount, LoanPaymentAmount MonetaryAmount, NumberOfLoanPayments Count }
WarrantyPromise StructuredValue & { DurationOfWarranty QuantitativeValue, WarrantyScope }
TypeAndQuantityNode StructuredValue & { AmountOfThisGood Real, TypeOfGood Thing, UnitCode String }
OwnershipInfo StructuredValue & { AcquiredFrom Thing, OwnedFrom DateTime, OwnedThrough DateTime, TypeOfGood Thing }
CDCPMDRecord StructuredValue & { CvdCollectionDate DateTime, CvdNumBeds Count, CvdNumVent Count }

PriceSpecification StructuredValue & Price & { MinPrice Real, MaxPrice Real, ValidFrom Date, ValidThrough Date, ValueAddedTaxIncluded Bool, EligibleQuantity QuantitativeValue }
UnitPriceSpecification     PriceSpecification & { BillingIncrement Real, ReferenceQuantity QuantitativeValue, PriceType String }
DeliveryChargeSpecification PriceSpecification & { AppliesToDeliveryMethod DeliveryMethod, AreaServed String }
PaymentChargeSpecification PriceSpecification & { AppliesToPaymentMethod PaymentMethod }
CompoundPriceSpecification PriceSpecification & { PriceComponent List(UnitPriceSpecification) }

// Ratings
Rating Intangible & { RatingValue Real, BestRating Real, WorstRating Real, Author Agent, ReviewAspect String }
AggregateRating Rating & { ItemReviewed Thing, RatingCount Count, ReviewCount Count }
EndorsementRating Rating

// Brand, audience, language, etc
Brand      Intangible & { Logo Image, Slogan String, AggregateRating }
Audience   Intangible & { AudienceType String, GeographicArea String }
BusinessAudience Audience & { NumberOfEmployees QuantitativeValue, YearlyRevenue QuantitativeValue }
EducationalAudience Audience & { EducationalRole String }
MedicalAudience Audience
PeopleAudience Audience & { RequiredGender GenderType, RequiredMinAge Count, RequiredMaxAge Count, SuggestedAge QuantitativeValue }
ParentAudience PeopleAudience & { ChildMinAge Count, ChildMaxAge Count }
Researcher Audience
Patient_ Audience

Language_  Intangible & Language
ComputerLanguage Intangible & { Name }
Occupation Intangible & { Skills List(String), Qualifications List(String), EstimatedSalary MonetaryAmount, OccupationLocation String }
JobPosting Intangible & { Title, HiringOrganization Agent, JobLocation String, BaseSalary MonetaryAmount, DatePosted Date, ValidThrough Date, EmploymentType String, Responsibilities Text }
Grant_     Intangible & { Funder Agent, FundedItem Thing }
MonetaryGrant Grant_ & { Amount MonetaryAmount }
Role_      Intangible & { RoleName String, StartDate Date, EndDate Date }
OrganizationRole Role_ & { NumberedPosition Count }
EmployeeRole OrganizationRole & { BaseSalary MonetaryAmount, SalaryCurrency Currency }
PerformanceRole Role_ & { CharacterName String }
LinkRole Role_ & { LinkRelationship String, InLanguage Language }
Series_    Intangible
CreativeWorkSeries_ Series_
EventSeries Series_
Schedule_  Intangible & Schedule & { ByDay DayOfWeek, StartTime TimeOfDay, EndTime TimeOfDay, RepeatFrequency Duration_ }
ItemList   Intangible & { ItemListElement List(Thing), NumberOfItems Count, ItemListOrder "Ascending" | "Descending" | "Unordered" }
ListItem   Intangible & { Item Thing, Position Count, NextItem ListItem, PreviousItem ListItem }
HowToItem  ListItem & { RequiredQuantity QuantitativeValue }
HowToSupply HowToItem & { EstimatedCost MonetaryAmount }
HowToTool  HowToItem
BreadcrumbList ItemList
OfferCatalog ItemList
HowToSection ItemList
HowToStep    ItemList & ListItem
DefinedTerm Intangible & { TermCode String, InDefinedTermSet DefinedTermSet }
DefinedTermSet Thing & { HasDefinedTerm List(DefinedTerm) }
CategoryCode DefinedTerm & { CodeValue String }
EntryPoint Intangible & { UrlTemplate String, ActionPlatform String, HttpMethod String, ContentType String }
VirtualLocation Intangible
SpeakableSpecification Intangible & { CssSelector CssSelectorType, Xpath XPathType }
AlignmentObject Intangible & { AlignmentType String, EducationalFramework String, TargetName String, TargetUrl Url }
BedDetails Intangible & { NumberOfBeds Count, TypeOfBed String }
Class_ Intangible
Property_ Intangible & { DomainIncludes Class_, RangeIncludes Class_, InverseOf Property_ }
DataFeedItem Intangible & { DateCreated DateTime, DateModified DateTime, Item Thing }
DigitalDocumentPermission Intangible & { Grantee Agent, PermissionType DigitalDocumentPermissionType }
Enumeration_ Intangible & { SupersededBy Enumeration_ }
GameServer Intangible & { Game Thing, PlayersOnline Count, ServerStatus GameServerStatus }
HealthInsurancePlan Intangible & { HealthPlanId String, HealthPlanMarketingUrl Url }
MenuItem Intangible & { Offers List(Thing), NutritionInformation, SuitableForDiet RestrictedDiet }
MerchantReturnPolicy Intangible & { MerchantReturnDays Count, ReturnPolicyCategory MerchantReturnEnumeration, ReturnFees ReturnFeesEnumeration }
ParcelDelivery Intangible & { DeliveryAddress PostalAddress, ExpectedArrivalFrom DateTime, ExpectedArrivalUntil DateTime, TrackingNumber String, TrackingUrl Url, Carrier Agent }
Permit Intangible & { IssuedBy Agent, ValidFor Duration_, ValidFrom DateTime, ValidUntil Date, PermitAudience Audience }
GovernmentPermit Permit
ProgramMembership Intangible & { HostingOrganization Agent, MembershipNumber String, ProgramName String, Member Agent }
Quotation_ Intangible
ServiceChannel Intangible & { AvailableLanguage Language, ServiceUrl Url, ServicePhone ContactPoint_ }
Seat Intangible & { SeatNumber String, SeatRow String, SeatSection String }
Flight_ Intangible
StatisticalPopulation Intangible & { PopulationType Class_ }
Observation Intangible & { MeasuredProperty Property_, MeasuredValue Any, ObservationDate DateTime }
MediaSubscription Intangible & { Authenticator Agent, ExpectsAcceptanceOf Thing }
Trip Intangible & { ArrivalTime DateTime, DepartureTime DateTime, Itinerary ItemList, Provider Agent }
BusTrip    Trip & { BusName String, BusNumber String, ArrivalBusStop String, DepartureBusStop String }
Flight     Trip & { FlightNumber String, Airline Agent, ArrivalAirport String, DepartureAirport String, Aircraft String, BoardingPolicy BoardingPolicyType }
TrainTrip  Trip & { TrainName String, TrainNumber String, ArrivalStation String, DepartureStation String }
BoatTrip   Trip & { ArrivalBoatTerminal String, DepartureBoatTerminal String }
TouristTrip Trip & { TouristType Audience }
Service    Intangible & { ServiceType String, Provider Agent, AreaServed String, Audience, Brand, AggregateRating, HoursAvailable OpeningHoursSpecification, Offers List(Thing) }
BroadcastService Service & { BroadcastDisplayName String, BroadcastFrequency String }
CableOrSatelliteService Service
FinancialProduct Service & { AnnualPercentageRate Real, InterestRate Real, FeesAndCommissionsSpecification Text }
BankAccount_ FinancialProduct & { AccountMinimumInflow MonetaryAmount, AccountOverdraftLimit MonetaryAmount }
DepositAccount BankAccount_
CurrencyConversionService FinancialProduct
InvestmentOrDeposit FinancialProduct & { Amount MonetaryAmount }
BrokerageAccount InvestmentOrDeposit
InvestmentFund InvestmentOrDeposit
LoanOrCredit FinancialProduct & { LoanTerm QuantitativeValue, LoanType String, RequiredCollateral Thing, RecourseLoan Bool }
CreditCard_ LoanOrCredit & PaymentCard
MortgageLoan LoanOrCredit & { DomiciledMortgage Bool, LoanMortgageMandateAmount MonetaryAmount }
PaymentCard FinancialProduct & { CashBack Real, ContactlessPayment Bool, FloorLimit MonetaryAmount }
PaymentService FinancialProduct
FoodService Service
GovernmentService Service & { ServiceOperator Agent, Jurisdiction }
Taxi TaxiService
TaxiService Service
WebAPI Service & { Documentation Url }

// =============================================================================
// Transitions
// =============================================================================

Rate(T Thing, V Real, A Agent) [ Rating { RatingValue V, Author A, BestRating 5, WorstRating 1 } ]
Aggregate(R AggregateRating, N Rating) [
    R & {
        RatingValue ((RatingValue * RatingCount + N.RatingValue) / (RatingCount + 1))
        RatingCount (RatingCount + 1)
    }
]
AddItem(L ItemList, I Thing) [ L & { ItemListElement (Cons { Head I, Tail ItemListElement }), NumberOfItems (NumberOfItems + 1) } ]
PostJob(O Agent, J JobPosting) [ J & { HiringOrganization O, DatePosted Today } ]
