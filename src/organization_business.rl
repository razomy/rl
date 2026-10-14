_ schema.thing
_ schema.intangible
_ schema.place
_ schema.organization

// =============================================================================
// LocalBusiness
// =============================================================================

PriceRange String
LocalBusiness Organization & Place & {
    CurrenciesAccepted List(Currency)
    OpeningHours String
    PaymentAccepted List(PaymentMethod)
    PriceRange
}

AnimalShelter LocalBusiness
ArchiveOrganization LocalBusiness
DryCleaningOrLaundry LocalBusiness
EmergencyService LocalBusiness
FireStation_    EmergencyService
Hospital_       EmergencyService
PoliceStation_  EmergencyService
EmploymentAgency LocalBusiness
GovernmentOffice LocalBusiness
PostOffice      GovernmentOffice
InternetCafe    LocalBusiness
Library         LocalBusiness
RecyclingCenter LocalBusiness
SelfStorage     LocalBusiness
ShoppingCenter  LocalBusiness
TouristInformationCenter LocalBusiness
TravelAgency    LocalBusiness
ChildCare       LocalBusiness
Dentist         LocalBusiness
RadioStation    LocalBusiness
TelevisionStation LocalBusiness

// Automotive
AutomotiveBusiness LocalBusiness
AutoBodyShop    AutomotiveBusiness
AutoDealer      AutomotiveBusiness
AutoPartsStore  AutomotiveBusiness
AutoRental      AutomotiveBusiness
AutoRepair      AutomotiveBusiness
AutoWash        AutomotiveBusiness
GasStation      AutomotiveBusiness
MotorcycleDealer AutomotiveBusiness
MotorcycleRepair AutomotiveBusiness

// Entertainment
EntertainmentBusiness LocalBusiness
AdultEntertainment EntertainmentBusiness
AmusementPark   EntertainmentBusiness
ArtGallery      EntertainmentBusiness
Casino          EntertainmentBusiness
ComedyClub      EntertainmentBusiness
MovieTheater_   EntertainmentBusiness
NightClub       EntertainmentBusiness

// Financial
FinancialService LocalBusiness
AccountingService FinancialService
AutomatedTeller FinancialService
BankOrCreditUnion FinancialService
InsuranceAgency FinancialService

// Food
FoodEstablishment LocalBusiness & { AcceptsReservations Bool, HasMenu Url, ServesCuisine List(String), StarRating Rating }
Bakery          FoodEstablishment
BarOrPub        FoodEstablishment
Brewery         FoodEstablishment
CafeOrCoffeeShop FoodEstablishment
Distillery      FoodEstablishment
FastFoodRestaurant FoodEstablishment
IceCreamShop    FoodEstablishment
Restaurant      FoodEstablishment
Winery          FoodEstablishment

// Health and beauty
HealthAndBeautyBusiness LocalBusiness
BeautySalon     HealthAndBeautyBusiness
DaySpa          HealthAndBeautyBusiness
HairSalon       HealthAndBeautyBusiness
HealthClub      HealthAndBeautyBusiness
NailSalon       HealthAndBeautyBusiness
TattooParlor    HealthAndBeautyBusiness

// Home and construction
HomeAndConstructionBusiness LocalBusiness
Electrician     HomeAndConstructionBusiness
GeneralContractor HomeAndConstructionBusiness
HVACBusiness    HomeAndConstructionBusiness
HousePainter    HomeAndConstructionBusiness
Locksmith       HomeAndConstructionBusiness
MovingCompany   HomeAndConstructionBusiness
Plumber         HomeAndConstructionBusiness
RoofingContractor HomeAndConstructionBusiness

// Legal and professional
LegalService    LocalBusiness
Attorney        LegalService
Notary          LegalService
ProfessionalService LocalBusiness
RealEstateAgent LocalBusiness

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

// Medical
MedicalBusiness LocalBusiness
CommunityHealth MedicalBusiness
Dermatology_    MedicalBusiness
DietNutrition_  MedicalBusiness
Emergency_      MedicalBusiness
Geriatric_      MedicalBusiness
Gynecologic_    MedicalBusiness
MedicalClinic   MedicalBusiness
Midwifery_      MedicalBusiness
Nursing_        MedicalBusiness
Obstetric_      MedicalBusiness
Oncologic_      MedicalBusiness
Optician        MedicalBusiness
Optometric_     MedicalBusiness
Otolaryngologic_ MedicalBusiness
Pediatric_      MedicalBusiness
Pharmacy        MedicalBusiness
Physician       MedicalBusiness
Physiotherapy_  MedicalBusiness
PlasticSurgery_ MedicalBusiness
Podiatric_      MedicalBusiness
PrimaryCare_    MedicalBusiness
Psychiatric_    MedicalBusiness
PublicHealth_   MedicalBusiness

// Sports
SportsActivityLocation LocalBusiness
BowlingAlley    SportsActivityLocation
ExerciseGym     SportsActivityLocation
GolfCourse      SportsActivityLocation
PublicSwimmingPool SportsActivityLocation
SportsClub      SportsActivityLocation
StadiumOrArena_ SportsActivityLocation
TennisComplex   SportsActivityLocation

// Stores
Store LocalBusiness
BikeStore       Store
BookStore       Store
ClothingStore   Store
ComputerStore   Store
ConvenienceStore Store
DepartmentStore Store
ElectronicsStore Store
Florist         Store
FurnitureStore  Store
GardenStore     Store
GroceryStore    Store
HardwareStore   Store
HobbyShop       Store
HomeGoodsStore  Store
JewelryStore    Store
LiquorStore     Store
MensClothingStore Store
MobilePhoneStore Store
MovieRentalStore Store
MusicStore      Store
OfficeEquipmentStore Store
OutletStore     Store
PawnShop        Store
PetStore        Store
ShoeStore       Store
SportingGoodsStore Store
TireShop        Store
ToyStore        Store
WholesaleStore  Store

// =============================================================================
// Transitions
// =============================================================================

OpenBusiness(B LocalBusiness, H String) [ B & { OpeningHours H, PublicAccess true } ]
CloseBusiness(B LocalBusiness) [ B & { PublicAccess false, DissolutionDate Today } ]
AcceptPayment(B LocalBusiness, M PaymentMethod) [ B & { PaymentAccepted (Cons { Head M, Tail PaymentAccepted }) } ]
ChangePriceRange(B LocalBusiness, R PriceRange) [ B & { PriceRange R } ]
