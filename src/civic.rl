#
Concrete Landforms, Accommodations, Civic Structures & Place Transitions
#

BodyOfWater      Landform_
Canal            BodyOfWater
LakeBodyOfWater  BodyOfWater
OceanBodyOfWater BodyOfWater
Pond             BodyOfWater
Reservoir        BodyOfWater
RiverBodyOfWater BodyOfWater
SeaBodyOfWater   BodyOfWater
Waterfall        BodyOfWater
Continent_       Landform_ & { Continent Continent }
Mountain         Landform_ & { Elevation Elevation }
Volcano          Landform_
Island           Landform_
Desert           Landform_
Forest           Landform_
Valley           Landform_
Cave             Landform_
Beach_           Landform_

LandmarksOrHistoricalBuildings Place
TouristAttraction              Place & { AvailableLanguage Language, TouristType Audience }
TouristDestination             Place & { IncludesAttraction List(TouristAttraction) }

Apartment               Accommodation
CampingPitch            Accommodation
House_                  Accommodation
SingleFamilyResidence   House_
Room_                   Accommodation
HotelRoom               Room_
MeetingRoom             Room_
Suite                   Accommodation
ApartmentComplex        Residence & { NumberOfAccommodationUnits Count, PetsAllowed Bool }
GatedResidenceCommunity Residence
Store_                  Place

Airport                         CivicStructure & { IataCode String, IcaoCode String }
Aquarium                        CivicStructure
Beach                           CivicStructure
BoatTerminal                    CivicStructure
Bridge                          CivicStructure
BusStation                      CivicStructure
BusStop                         CivicStructure
Campground                      CivicStructure
Cemetery                        CivicStructure
Crematorium                     CivicStructure
EducationalOrganizationBuilding CivicStructure
EventVenue                      CivicStructure
FireStation                     CivicStructure
GovernmentBuilding              CivicStructure
CityHall                        GovernmentBuilding
Courthouse                      GovernmentBuilding
DefenceEstablishment            GovernmentBuilding
Embassy                         GovernmentBuilding
LegislativeBuilding             GovernmentBuilding
Hospital                        CivicStructure
MovieTheater                    CivicStructure & { ScreenCount Count }
Museum                          CivicStructure
MusicVenue                      CivicStructure
Park                            CivicStructure
ParkingFacility                 CivicStructure
PerformingArtsTheater           CivicStructure
PlaceOfWorship                  CivicStructure
BuddhistTemple                  PlaceOfWorship
Church                          PlaceOfWorship
CatholicChurch                  Church
OrthodoxChurch                  Church
ProtestantChurch                Church
HinduTemple                     PlaceOfWorship
Mosque                          PlaceOfWorship
Synagogue                       PlaceOfWorship
Playground                      CivicStructure
PoliceStation                   CivicStructure
PublicToilet                    CivicStructure
RVPark                          CivicStructure
StadiumOrArena                  CivicStructure
SubwayStation                   CivicStructure
TaxiStand                       CivicStructure
TrainStation                    CivicStructure
Zoo                             CivicStructure
School_                         CivicStructure
Library_                        CivicStructure

Contain(Outer Place, Inner Place) [ Inner & { ContainedInPlace Outer } ]
Relocate(P Place, G GeoCoordinates) [ P & { Geo G } ]
OpenToPublic(P Place) [ P & { PublicAccess true } ]
CloseToPublic(P Place) [ P & { PublicAccess false } ]
Annex(C Country, A AdministrativeArea) [ A & { ContainedInPlace C } ]
Open(C CivicStructure) [ C & { PublicAccess true } ]
Close(C CivicStructure) [ C & { PublicAccess false } ]
Consecrate(P PlaceOfWorship) [ P & { PublicAccess true } ]
