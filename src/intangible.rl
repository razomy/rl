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

Rating Intangible & { RatingValue Real, bestRating Real, worstRating Real, author Agent, reviewAspect String }
Audience Intangible & { AudienceType String, geographicArea String }
Grant_ Intangible & { Funder Agent, fundedItem Thing }
Role_ Intangible & { RoleName String, startDate Date, endDate Date }
Series_ Intangible
ItemList Intangible & { ItemListElement List(Thing), numberOfItems Count, ItemListOrder "Ascending" | "Descending" | "Unordered" }
ListItem Intangible & { Item Thing, position Count, nextItem ListItem, previousItem ListItem }
Permit Intangible & { IssuedBy Agent, validFor Duration_, validFrom DateTime, validUntil Date, permitAudience Audience }
Trip Intangible & { ArrivalTime DateTime, departureTime DateTime, itinerary ItemList, provider Agent }
Service Intangible & { ServiceType String, provider Agent, areaServed String, Audience, Brand, AggregateRating, hoursAvailable OpeningHoursSpecification, offers List(Thing) }
