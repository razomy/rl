#
Ratings, Audiences, Roles, Lists, Trips, financial Products & Transitions
#

AggregateRating   Rating & { ItemReviewed Thing, ratingCount Count, reviewCount Count }
EndorsementRating Rating

Brand               Intangible & { Logo Image, slogan String, AggregateRating }
BusinessAudience    Audience & { NumberOfEmployees QuantitativeValue, yearlyRevenue QuantitativeValue }
EducationalAudience Audience & { EducationalRole String }
MedicalAudience     Audience
PeopleAudience      Audience & { RequiredGender GenderType, requiredMinAge Count, requiredMaxAge Count, suggestedAge QuantitativeValue }
ParentAudience      PeopleAudience & { ChildMinAge Count, childMaxAge Count }
Researcher          Audience
Patient_            Audience

Language_         Intangible & Language
ComputerLanguage  Intangible & { Name }
Occupation        Intangible & { Skills List(String), qualifications List(String), estimatedSalary MonetaryAmount, occupationLocation String }
JobPosting        Intangible & { Title, hiringOrganization Agent, jobLocation String, baseSalary MonetaryAmount, datePosted Date, validThrough Date, employmentType String, responsibilities Text }
MonetaryGrant     Grant_ & { Amount MonetaryAmount }
OrganizationRole  Role_ & { NumberedPosition Count }
EmployeeRole      OrganizationRole & { BaseSalary MonetaryAmount, salaryCurrency Currency }
PerformanceRole   Role_ & { CharacterName String }
LinkRole          Role_ & { LinkRelationship String, inLanguage Language }
CreativeWorkSeries_ Series_
EventSeries       Series_
Schedule_         Intangible & Schedule & { ByDay DayOfWeek, startTime TimeOfDay, endTime TimeOfDay, repeatFrequency Duration_ }
HowToItem         ListItem & { RequiredQuantity QuantitativeValue }
HowToSupply       HowToItem & { EstimatedCost MonetaryAmount }
HowToTool         HowToItem
BreadcrumbList    ItemList
OfferCatalog      ItemList
HowToSection      ItemList
HowToStep         ItemList & ListItem
DefinedTerm       Intangible & { TermCode String, inDefinedTermSet DefinedTermSet }
DefinedTermSet    Thing & { HasDefinedTerm List(DefinedTerm) }
CategoryCode      DefinedTerm & { CodeValue String }
EntryPoint        Intangible & { UrlTemplate String, actionPlatform String, httpMethod String, contentType String }
VirtualLocation   Intangible
SpeakableSpecification Intangible & { CssSelector CssSelectorType, xpath XPathType }
AlignmentObject   Intangible & { AlignmentType String, educationalFramework String, targetName String, targetUrl Url }
BedDetails        Intangible & { NumberOfBeds Count, typeOfBed String }
Class_            Intangible
Property_         Intangible & { DomainIncludes Class_, rangeIncludes Class_, inverseOf Property_ }
DataFeedItem      Intangible & { DateCreated DateTime, dateModified DateTime, item Thing }
DigitalDocumentPermission Intangible & { Grantee Agent, permissionType DigitalDocumentPermissionType }
Enumeration_      Intangible & { SupersededBy Enumeration_ }
GameServer        Intangible & { Game Thing, playersOnline Count, serverStatus GameServerStatus }
HealthInsurancePlan Intangible & { HealthPlanId String, healthPlanMarketingUrl Url }
MenuItem          Intangible & { Offers List(Thing), NutritionInformation, suitableForDiet RestrictedDiet }
MerchantReturnPolicy Intangible & { MerchantReturnDays Count, returnPolicyCategory MerchantReturnEnumeration, returnFees ReturnFeesEnumeration }
ParcelDelivery    Intangible & { DeliveryAddress PostalAddress, expectedArrivalFrom DateTime, expectedArrivalUntil DateTime, trackingNumber String, trackingUrl Url, carrier Agent }
GovernmentPermit  Permit
ProgramMembership Intangible & { HostingOrganization Agent, membershipNumber String, programName String, member Agent }
Quotation_        Intangible
ServiceChannel    Intangible & { AvailableLanguage Language, serviceUrl Url, servicePhone ContactPoint_ }
Seat              Intangible & { SeatNumber String, seatRow String, seatSection String }
Flight_           Intangible
StatisticalPopulation Intangible & { PopulationType Class_ }
Observation       Intangible & { MeasuredProperty Property_, measuredValue Any, observationDate DateTime }
MediaSubscription Intangible & { Authenticator Agent, expectsAcceptanceOf Thing }

BusTrip     Trip & { BusName String, busNumber String, arrivalBusStop String, departureBusStop String }
Flight      Trip & { FlightNumber String, airline Agent, arrivalAirport String, departureAirport String, aircraft String, boardingPolicy BoardingPolicyType }
TrainTrip   Trip & { TrainName String, trainNumber String, arrivalStation String, departureStation String }
BoatTrip    Trip & { ArrivalBoatTerminal String, departureBoatTerminal String }
TouristTrip Trip & { TouristType Audience }

BroadcastService         Service & { BroadcastDisplayName String, broadcastFrequency String }
CableOrSatelliteService  Service
FinancialProduct         Service & { AnnualPercentageRate Real, interestRate Real, feesAndCommissionsSpecification Text }
BankAccount_             FinancialProduct & { AccountMinimumInflow MonetaryAmount, accountOverdraftLimit MonetaryAmount }
DepositAccount           BankAccount_
CurrencyConversionService FinancialProduct
InvestmentOrDeposit      FinancialProduct & { Amount MonetaryAmount }
BrokerageAccount         InvestmentOrDeposit
InvestmentFund           InvestmentOrDeposit
LoanOrCredit             FinancialProduct & { LoanTerm QuantitativeValue, loanType String, requiredCollateral Thing, recourseLoan Bool }
CreditCard_              LoanOrCredit & PaymentCard
MortgageLoan             LoanOrCredit & { DomiciledMortgage Bool, loanMortgageMandateAmount MonetaryAmount }
PaymentCard              FinancialProduct & { CashBack Real, contactlessPayment Bool, floorLimit MonetaryAmount }
PaymentService           FinancialProduct
FoodService              Service
GovernmentService        Service & { ServiceOperator Agent, Jurisdiction }
Taxi                     TaxiService
TaxiService              Service
WebAPI                   Service & { Documentation Url }

Rate(t Thing, v Real, a Agent) [ Rating { RatingValue V, author A, BestRating 5, WorstRating 1 } ]
Aggregate(r AggregateRating, n Rating) [
    R & {
        RatingValue ((RatingValue * RatingCount + N.RatingValue) / (RatingCount + 1))
        RatingCount (RatingCount + 1)
    }
]
AddItem(l ItemList, i Thing) [ l & { ItemListElement (Cons { Head I, tail ItemListElement }), NumberOfItems (NumberOfItems + 1) } ]
PostJob(o Agent, j JobPosting) [ j & { HiringOrganization O, datePosted Today } ]
