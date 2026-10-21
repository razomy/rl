#
Abstract Place, AdministrativeArea, Country, City, Landform, Accommodation & CivicStructure
#

Place Thing & {
  Address                   PostalAddress
  Geo                       GeoCoordinates
  GeoShape_                 GeoShape_
  ContainedInPlace          Place
  ContainsPlace             List(Place)
  OpeningHoursSpecification OpeningHoursSpecification
  Telephone                 Phone
  FaxNumber                 Phone
  MaximumAttendeeCapacity   Count
  HasMap                    Url
  Logo                      Image
  Photo                     Image
  PublicAccess              Bool
  SmokingAllowed            Bool
  IsAccessibleForFree       Bool
  AmenityFeature            List(PropertyValue)
  AggregateRating           AggregateRating
  Review                    List(Any)
  Slogan                    String
  TourBookingPage           Url
  BranchCode                String
}

AdministrativeArea Place
Country            AdministrativeArea & { CountryCode String, currency Currency, officialLanguage Language }
State              AdministrativeArea
City               AdministrativeArea & { Population Count }
SchoolDistrict     AdministrativeArea

Landform_      Place & { Landform Landform }
Accommodation  Place & { FloorSize QuantitativeValue, numberOfRooms Count, petsAllowed Bool, bed BedDetails, accommodationCategory String }
Residence      Place
CivicStructure Place & { OpeningHours String }
