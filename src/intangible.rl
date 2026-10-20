#
Abstract Intangible, StructuredValue, PriceSpecification, Rating, Audience, Role, Trip & Service
#

Intangible Thing

Quantity_ Intangible & Measure(Real, Unit)
Distance_ Quantity_ & { Unit Metre }
Duration_ Quantity_ & { Unit Second }
Energy_   Quantity_ & { Unit Joule }
Mass_     Quantity_ & { Unit Kilogram }

StructuredValue Intangible

PriceSpecification StructuredValue & Price & {
  MinPrice              Real
  MaxPrice              Real
  ValidFrom             Date
  ValidThrough          Date
  ValueAddedTaxIncluded Bool
  EligibleQuantity      QuantitativeValue
}

Rating Intangible & { RatingValue Real, BestRating Real, WorstRating Real, Author Agent, ReviewAspect String }
Audience Intangible & { AudienceType String, GeographicArea String }
Grant_ Intangible & { Funder Agent, FundedItem Thing }
Role_ Intangible & { RoleName String, StartDate Date, EndDate Date }
Series_ Intangible
ItemList Intangible & { ItemListElement List(Thing), NumberOfItems Count, ItemListOrder "Ascending" | "Descending" | "Unordered" }
ListItem Intangible & { Item Thing, Position Count, NextItem ListItem, PreviousItem ListItem }
Permit Intangible & { IssuedBy Agent, ValidFor Duration_, ValidFrom DateTime, ValidUntil Date, PermitAudience Audience }
Trip Intangible & { ArrivalTime DateTime, DepartureTime DateTime, Itinerary ItemList, Provider Agent }
Service Intangible & { ServiceType String, Provider Agent, AreaServed String, Audience, Brand, AggregateRating, HoursAvailable OpeningHoursSpecification, Offers List(Thing) }
