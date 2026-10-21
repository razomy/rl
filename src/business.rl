#
Concrete Organizations, local Businesses, retail Stores & Transitions
#

Airline                  Organization & { IataCode String, boardingPolicy BoardingPolicyType }
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
MedicalOrganization      Organization & { HealthPlanNetworkId String, isAcceptingNewPatients Bool, medicalSpecialty MedicalSpecialty }
DiagnosticLab            MedicalOrganization
VeterinaryCare           MedicalOrganization
NGO                      Organization
NewsMediaOrganization    Organization & { Masthead Url, correctionsPolicy Url, diversityPolicy Url }
OnlineBusiness           Organization
OnlineStore              OnlineBusiness
PerformingGroup          Organization
DanceGroup               PerformingGroup
MusicGroup               PerformingGroup & { Genre String, album List(Thing), track List(Thing) }
TheaterGroup             PerformingGroup
PoliticalParty           Organization
Project                  Organization
FundingAgency            Project
ResearchProject          Project
ResearchOrganization     Organization
SearchRescueOrganization Organization
SportsOrganization       Organization & { Sport String }
SportsTeam               SportsOrganization & { Athlete List(Agent), coach List(Agent) }
WorkersUnion             Organization

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

EntertainmentBusiness LocalBusiness
AdultEntertainment    EntertainmentBusiness
AmusementPark         EntertainmentBusiness
ArtGallery            EntertainmentBusiness
Casino                EntertainmentBusiness
ComedyClub            EntertainmentBusiness
MovieTheater_         EntertainmentBusiness
NightClub             EntertainmentBusiness

FinancialService  LocalBusiness
AccountingService FinancialService
AutomatedTeller   FinancialService
BankOrCreditUnion FinancialService
InsuranceAgency   FinancialService

FoodEstablishment  LocalBusiness & { AcceptsReservations Bool, hasMenu Url, servesCuisine List(String), starRating Rating }
Bakery             FoodEstablishment
BarOrPub           FoodEstablishment
Brewery            FoodEstablishment
CafeOrCoffeeShop   FoodEstablishment
Distillery         FoodEstablishment
FastFoodRestaurant FoodEstablishment
IceCreamShop       FoodEstablishment
Restaurant         FoodEstablishment
Winery             FoodEstablishment

HealthAndBeautyBusiness LocalBusiness
BeautySalon             HealthAndBeautyBusiness
DaySpa                  HealthAndBeautyBusiness
HairSalon               HealthAndBeautyBusiness
HealthClub              HealthAndBeautyBusiness
NailSalon               HealthAndBeautyBusiness
TattooParlor            HealthAndBeautyBusiness

HomeAndConstructionBusiness LocalBusiness
Electrician                 HomeAndConstructionBusiness
GeneralContractor           HomeAndConstructionBusiness
HVACBusiness                HomeAndConstructionBusiness
HousePainter                HomeAndConstructionBusiness
Locksmith                   HomeAndConstructionBusiness
MovingCompany               HomeAndConstructionBusiness
Plumber                     HomeAndConstructionBusiness
RoofingContractor           HomeAndConstructionBusiness

LegalService        LocalBusiness
Attorney            LegalService
Notary              LegalService
ProfessionalService LocalBusiness
RealEstateAgent     LocalBusiness

LodgingBusiness LocalBusiness & { CheckinTime TimeOfDay, checkoutTime TimeOfDay, numberOfRooms Count, petsAllowed Bool, starRating Rating }
BedAndBreakfast LodgingBusiness
Campground_     LodgingBusiness
Hostel          LodgingBusiness
Hotel           LodgingBusiness
Motel           LodgingBusiness
Resort          LodgingBusiness
SkiResort       Resort
VacationRental  LodgingBusiness

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

SportsActivityLocation LocalBusiness
BowlingAlley           SportsActivityLocation
ExerciseGym            SportsActivityLocation
GolfCourse             SportsActivityLocation
PublicSwimmingPool     SportsActivityLocation
SportsClub             SportsActivityLocation
StadiumOrArena_        SportsActivityLocation
TennisComplex          SportsActivityLocation

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

Found(f Agent, n Name) [ Organization { Name N, founder List1(F), foundingDate Today } ]
Dissolve_(o Organization) [ o & { DissolutionDate Today } ]
Merge(a Organization, b Organization) [ Organization & A & B & { SubOrganization List2(A, B) } ]
Acquire_(parent Organization, child Organization) [ Child & { ParentOrganization Parent } ]
SpinOff(o Organization, n Name) [ Organization { Name N, parentOrganization O, foundingDate Today } ]
Rebrand(o Organization, b Brand) [ o & { Brand B } ]
GoPublic(c Corporation, ticker String) [ c & { TickerSymbol Ticker } ]
AddMember(o Organization, m Agent) [ o & { Member (Cons { Head M, tail Member }) } ]

OpenBusiness(b LocalBusiness, h String) [ b & { OpeningHours H, PublicAccess true } ]
CloseBusiness(b LocalBusiness) [ b & { PublicAccess false, dissolutionDate Today } ]
AcceptPayment(b LocalBusiness, m PaymentMethod) [ b & { PaymentAccepted (Cons { Head M, tail PaymentAccepted }) } ]
ChangePriceRange(b LocalBusiness, r PriceRange) [ b & { PriceRange R } ]
