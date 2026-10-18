_ thing
_ enumeration
_ intangible
_ place

#
1. Organization (schema.org)
#

LegalName String
TaxID     String
VatID     String
Duns      String
LeiCode   String
NaicsCode String
IsicV4    String

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

#
2. Organization Subtypes
#

Airline                  Organization & { IataCode String, BoardingPolicy BoardingPolicyType }
Consortium               Organization
Corporation              Organization & { TickerSymbol String }
Cooperative              Organization
EducationalOrganization  Organization & { Alumni List(Agent) }
CollegeOrUniversity      EducationalOrganization
ElementarySchool         EducationalOrganization
HighSchool               EducationalOrganization
MiddleSchool             EducationalOrganization
Preschool                EducationalOrganization
School                   EducationalOrganization
FundingScheme            Organization
GovernmentOrganization   Organization
LibrarySystem            Organization
MedicalOrganization      Organization & { HealthPlanNetworkId String, IsAcceptingNewPatients Bool, MedicalSpecialty MedicalSpecialty }
DiagnosticLab            MedicalOrganization
VeterinaryCare           MedicalOrganization
NGO                      Organization
NewsMediaOrganization    Organization & { Masthead Url, CorrectionsPolicy Url, DiversityPolicy Url }
OnlineBusiness           Organization
OnlineStore              OnlineBusiness
PerformingGroup          Organization
DanceGroup               PerformingGroup
MusicGroup               PerformingGroup & { Genre String, Album List(Thing), Track List(Thing) }
TheaterGroup             PerformingGroup
PoliticalParty           Organization
Project                  Organization
FundingAgency            Project
ResearchProject          Project
ResearchOrganization     Organization
SearchRescueOrganization Organization
SportsOrganization       Organization & { Sport String }
SportsTeam               SportsOrganization & { Athlete List(Agent), Coach List(Agent) }
WorkersUnion             Organization

#
3. LocalBusiness & Commercial Establishments
#

PriceRange String

LocalBusiness Organization & Place & {
  CurrenciesAccepted List(Currency)
  OpeningHours       String
  PaymentAccepted    List(PaymentMethod)
  PriceRange         PriceRange
}

AnimalShelter            LocalBusiness
ArchiveOrganization      LocalBusiness
DryCleaningOrLaundry     LocalBusiness
EmergencyService         LocalBusiness
FireStation_             EmergencyService
Hospital_                EmergencyService
PoliceStation_           EmergencyService
EmploymentAgency         LocalBusiness
GovernmentOffice         LocalBusiness
PostOffice               GovernmentOffice
InternetCafe             LocalBusiness
Library                  LocalBusiness
RecyclingCenter          LocalBusiness
SelfStorage              LocalBusiness
ShoppingCenter           LocalBusiness
TouristInformationCenter LocalBusiness
TravelAgency             LocalBusiness
ChildCare                LocalBusiness
Dentist                  LocalBusiness
RadioStation             LocalBusiness
TelevisionStation        LocalBusiness

// Automotive
AutomotiveBusiness LocalBusiness
AutoBodyShop       AutomotiveBusiness
AutoDealer         AutomotiveBusiness
AutoPartsStore     AutomotiveBusiness
AutoRental         AutomotiveBusiness
AutoRepair         AutomotiveBusiness
AutoWash           AutomotiveBusiness
GasStation         AutomotiveBusiness
MotorcycleDealer   AutomotiveBusiness
MotorcycleRepair   AutomotiveBusiness

// Entertainment
EntertainmentBusiness LocalBusiness
AdultEntertainment    EntertainmentBusiness
AmusementPark         EntertainmentBusiness
ArtGallery            EntertainmentBusiness
Casino                EntertainmentBusiness
ComedyClub            EntertainmentBusiness
MovieTheater_         EntertainmentBusiness
NightClub             EntertainmentBusiness

// Financial
FinancialService  LocalBusiness
AccountingService FinancialService
AutomatedTeller   FinancialService
BankOrCreditUnion FinancialService
InsuranceAgency   FinancialService

// Food & Beverage
FoodEstablishment  LocalBusiness & { AcceptsReservations Bool, HasMenu Url, ServesCuisine List(String), StarRating Rating }
Bakery             FoodEstablishment
BarOrPub           FoodEstablishment
Brewery            FoodEstablishment
CafeOrCoffeeShop   FoodEstablishment
Distillery         FoodEstablishment
FastFoodRestaurant FoodEstablishment
IceCreamShop       FoodEstablishment
Restaurant         FoodEstablishment
Winery             FoodEstablishment

// Health and Beauty
HealthAndBeautyBusiness LocalBusiness
BeautySalon             HealthAndBeautyBusiness
DaySpa                  HealthAndBeautyBusiness
HairSalon               HealthAndBeautyBusiness
HealthClub              HealthAndBeautyBusiness
NailSalon               HealthAndBeautyBusiness
TattooParlor            HealthAndBeautyBusiness

// Home and Construction
HomeAndConstructionBusiness LocalBusiness
Electrician                 HomeAndConstructionBusiness
GeneralContractor           HomeAndConstructionBusiness
HVACBusiness                HomeAndConstructionBusiness
HousePainter                HomeAndConstructionBusiness
Locksmith                   HomeAndConstructionBusiness
MovingCompany               HomeAndConstructionBusiness
Plumber                     HomeAndConstructionBusiness
RoofingContractor           HomeAndConstructionBusiness

// Legal and Professional
LegalService        LocalBusiness
Attorney            LegalService
Notary              LegalService
ProfessionalService LocalBusiness
RealEstateAgent     LocalBusiness

// Lodging
LodgingBusiness LocalBusiness & { CheckinTime TimeOfDay, CheckoutTime TimeOfDay, NumberOfRooms Count, PetsAllowed Bool, StarRating Rating }
BedAndBreakfast LodgingBusiness
Campground_     LodgingBusiness
Hostel          LodgingBusiness
Hotel           LodgingBusiness
Motel           LodgingBusiness
Resort          LodgingBusiness
SkiResort       Resort
VacationRental  LodgingBusiness

// Medical Business
MedicalBusiness  LocalBusiness
CommunityHealth  MedicalBusiness
Dermatology_     MedicalBusiness
DietNutrition_   MedicalBusiness
Emergency_       MedicalBusiness
Geriatric_       MedicalBusiness
Gynecologic_     MedicalBusiness
MedicalClinic    MedicalBusiness
Midwifery_       MedicalBusiness
Nursing_         MedicalBusiness
Obstetric_       MedicalBusiness
Oncologic_       MedicalBusiness
Optician         MedicalBusiness
Optometric_      MedicalBusiness
Otolaryngologic_ MedicalBusiness
Pediatric_       MedicalBusiness
Pharmacy         MedicalBusiness
Physician        MedicalBusiness
Physiotherapy_   MedicalBusiness
PlasticSurgery_  MedicalBusiness
Podiatric_       MedicalBusiness
PrimaryCare_     MedicalBusiness
Psychiatric_     MedicalBusiness
PublicHealth_    MedicalBusiness

// Sports Locations
SportsActivityLocation LocalBusiness
BowlingAlley           SportsActivityLocation
ExerciseGym            SportsActivityLocation
GolfCourse             SportsActivityLocation
PublicSwimmingPool     SportsActivityLocation
SportsClub             SportsActivityLocation
StadiumOrArena_        SportsActivityLocation
TennisComplex          SportsActivityLocation

// Retail Stores
Store                LocalBusiness
BikeStore            Store
BookStore            Store
ClothingStore        Store
ComputerStore        Store
ConvenienceStore     Store
DepartmentStore      Store
ElectronicsStore     Store
Florist              Store
FurnitureStore       Store
GardenStore          Store
GroceryStore         Store
HardwareStore        Store
HobbyShop            Store
HomeGoodsStore       Store
JewelryStore         Store
LiquorStore          Store
MensClothingStore    Store
MobilePhoneStore     Store
MovieRentalStore     Store
MusicStore           Store
OfficeEquipmentStore Store
OutletStore          Store
PawnShop             Store
PetStore             Store
ShoeStore            Store
SportingGoodsStore   Store
TireShop             Store
ToyStore             Store
WholesaleStore       Store

#
4. Organization & Business Transitions
#

Found(F Agent, N Name) [ Organization { Name N, Founder List1(F), FoundingDate Today } ]
Dissolve_(O Organization) [ O & { DissolutionDate Today } ]
Merge(A Organization, B Organization) [ Organization & A & B & { SubOrganization List2(A, B) } ]
Acquire_(Parent Organization, Child Organization) [ Child & { ParentOrganization Parent } ]
SpinOff(O Organization, N Name) [ Organization { Name N, ParentOrganization O, FoundingDate Today } ]
Rebrand(O Organization, B Brand) [ O & { Brand B } ]
GoPublic(C Corporation, Ticker String) [ C & { TickerSymbol Ticker } ]
AddMember(O Organization, M Agent) [ O & { Member (Cons { Head M, Tail Member }) } ]

OpenBusiness(B LocalBusiness, H String) [ B & { OpeningHours H, PublicAccess true } ]
CloseBusiness(B LocalBusiness) [ B & { PublicAccess false, DissolutionDate Today } ]
AcceptPayment(B LocalBusiness, M PaymentMethod) [ B & { PaymentAccepted (Cons { Head M, Tail PaymentAccepted }) } ]
ChangePriceRange(B LocalBusiness, R PriceRange) [ B & { PriceRange R } ]
