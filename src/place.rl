_ thing
_ enumeration
_ intangible

#
1. Place (schema.org)
#

Place Thing & {
  Address                    PostalAddress
  Geo                        GeoCoordinates
  GeoShape_                  GeoShape_
  ContainedInPlace           Place
  ContainsPlace              List(Place)
  OpeningHoursSpecification  OpeningHoursSpecification
  Telephone                  Phone
  FaxNumber                  Phone
  MaximumAttendeeCapacity    Count
  HasMap                     Url
  Logo                       Image
  Photo                      Image
  PublicAccess               Bool
  SmokingAllowed             Bool
  IsAccessibleForFree        Bool
  AmenityFeature             List(PropertyValue)
  AggregateRating            AggregateRating
  Review                     List(Any)
  Slogan                     String
  TourBookingPage            Url
  BranchCode                 String
}

#
2. Administrative Areas, Countries & World Cities
#

AdministrativeArea Place
Country            AdministrativeArea & { CountryCode String, Currency Currency, OfficialLanguage Language }
State              AdministrativeArea
City               AdministrativeArea & { Population Count }
SchoolDistrict     AdministrativeArea

Ukraine       Country & { Name "Ukraine",        CountryCode "UA" }
Poland        Country & { Name "Poland",         CountryCode "PL" }
Germany       Country & { Name "Germany",        CountryCode "DE" }
France        Country & { Name "France",         CountryCode "FR" }
Spain         Country & { Name "Spain",          CountryCode "ES" }
Italy         Country & { Name "Italy",          CountryCode "IT" }
UnitedKingdom Country & { Name "United Kingdom", CountryCode "GB" }
UnitedStates  Country & { Name "United States",  CountryCode "US" }
Canada        Country & { Name "Canada",         CountryCode "CA" }
Mexico        Country & { Name "Mexico",         CountryCode "MX" }
Brazil        Country & { Name "Brazil",         CountryCode "BR" }
Argentina     Country & { Name "Argentina",      CountryCode "AR" }
China         Country & { Name "China",          CountryCode "CN" }
Japan         Country & { Name "Japan",          CountryCode "JP" }
India         Country & { Name "India",          CountryCode "IN" }
SouthKorea    Country & { Name "South Korea",    CountryCode "KR" }
Australia     Country & { Name "Australia",      CountryCode "AU" }
Egypt         Country & { Name "Egypt",          CountryCode "EG" }
Nigeria       Country & { Name "Nigeria",        CountryCode "NG" }
SouthAfrica   Country & { Name "South Africa",   CountryCode "ZA" }
Turkey        Country & { Name "Turkey",         CountryCode "TR" }
Israel        Country & { Name "Israel",         CountryCode "IL" }
Sweden        Country & { Name "Sweden",         CountryCode "SE" }
Norway        Country & { Name "Norway",         CountryCode "NO" }
Netherlands   Country & { Name "Netherlands",    CountryCode "NL" }
Switzerland   Country & { Name "Switzerland",    CountryCode "CH" }
Singapore     Country & { Name "Singapore",      CountryCode "SG" }
UnitedArabEmirates Country & { Name "United Arab Emirates", CountryCode "AE" }

Kyiv          City & { Name "Kyiv",          ContainedInPlace Ukraine }
Lviv          City & { Name "Lviv",          ContainedInPlace Ukraine }
Warsaw        City & { Name "Warsaw",        ContainedInPlace Poland }
Berlin        City & { Name "Berlin",        ContainedInPlace Germany }
Paris         City & { Name "Paris",         ContainedInPlace France }
Madrid        City & { Name "Madrid",        ContainedInPlace Spain }
Rome          City & { Name "Rome",          ContainedInPlace Italy }
London        City & { Name "London",        ContainedInPlace UnitedKingdom }
NewYork       City & { Name "New York",      ContainedInPlace UnitedStates }
SanFrancisco  City & { Name "San Francisco", ContainedInPlace UnitedStates }
Toronto       City & { Name "Toronto",       ContainedInPlace Canada }
Tokyo         City & { Name "Tokyo",         ContainedInPlace Japan }
Seoul         City & { Name "Seoul",         ContainedInPlace SouthKorea }
Beijing       City & { Name "Beijing",       ContainedInPlace China }
Sydney        City & { Name "Sydney",        ContainedInPlace Australia }
Zurich        City & { Name "Zurich",        ContainedInPlace Switzerland }

#
3. Natural Places, Landforms & Accommodations
#

Landform_        Place & { Landform Landform }
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
TouristAttraction  Place & { AvailableLanguage Language, TouristType Audience }
TouristDestination Place & { IncludesAttraction List(TouristAttraction) }

Accommodation Place & { FloorSize QuantitativeValue, NumberOfRooms Count, PetsAllowed Bool, Bed BedDetails, AccommodationCategory String }
Apartment               Accommodation
CampingPitch            Accommodation
House_                  Accommodation
SingleFamilyResidence   House_
Room_                   Accommodation
HotelRoom               Room_
MeetingRoom             Room_
Suite                   Accommodation
Residence               Place
ApartmentComplex        Residence & { NumberOfAccommodationUnits Count, PetsAllowed Bool }
GatedResidenceCommunity Residence
Store_                  Place

#
4. Civic Structures & Public Infrastructure
#

CivicStructure Place & { OpeningHours String }

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

#
5. Place & Civic Structure Transitions
#

Contain(Outer Place, Inner Place) [ Inner & { ContainedInPlace Outer } ]
Relocate(P Place, G GeoCoordinates) [ P & { Geo G } ]
OpenToPublic(P Place) [ P & { PublicAccess true } ]
CloseToPublic(P Place) [ P & { PublicAccess false } ]
Annex(C Country, A AdministrativeArea) [ A & { ContainedInPlace C } ]
Open(C CivicStructure) [ C & { PublicAccess true } ]
Close(C CivicStructure) [ C & { PublicAccess false } ]
Consecrate(P PlaceOfWorship) [ P & { PublicAccess true } ]
