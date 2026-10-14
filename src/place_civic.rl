_ thing
_ intangible
_ place

// =============================================================================
// CivicStructure and subtypes
// =============================================================================

CivicStructure Place & { OpeningHours String }

Airport         CivicStructure & { IataCode String, IcaoCode String }
Aquarium        CivicStructure
Beach           CivicStructure
BoatTerminal    CivicStructure
Bridge          CivicStructure
BusStation      CivicStructure
BusStop         CivicStructure
Campground      CivicStructure
Cemetery        CivicStructure
Crematorium     CivicStructure
EducationalOrganizationBuilding CivicStructure
EventVenue      CivicStructure
FireStation     CivicStructure
GovernmentBuilding CivicStructure
CityHall        GovernmentBuilding
Courthouse      GovernmentBuilding
DefenceEstablishment GovernmentBuilding
Embassy         GovernmentBuilding
LegislativeBuilding GovernmentBuilding
Hospital        CivicStructure
MovieTheater    CivicStructure & { ScreenCount Count }
Museum          CivicStructure
MusicVenue      CivicStructure
Park            CivicStructure
ParkingFacility CivicStructure
PerformingArtsTheater CivicStructure
PlaceOfWorship  CivicStructure
BuddhistTemple  PlaceOfWorship
Church          PlaceOfWorship
CatholicChurch  Church
HinduTemple     PlaceOfWorship
Mosque          PlaceOfWorship
Synagogue       PlaceOfWorship
Playground      CivicStructure
PoliceStation   CivicStructure
PublicToilet    CivicStructure
RVPark          CivicStructure
StadiumOrArena  CivicStructure
SubwayStation   CivicStructure
TaxiStand       CivicStructure
TrainStation    CivicStructure
Zoo             CivicStructure
School_         CivicStructure
Library_        CivicStructure

// =============================================================================
// Transitions
// =============================================================================

Open(C CivicStructure) [ C & { PublicAccess true } ]
Close(C CivicStructure) [ C & { PublicAccess false } ]
Consecrate(P PlaceOfWorship) [ P & { PublicAccess true } ]
