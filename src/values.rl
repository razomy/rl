#
Concrete Structured Values & Price Specifications
#

QuantitativeValue         StructuredValue & { Value Real, MinValue Real, MaxValue Real, UnitCode String, UnitText String }
PropertyValue             StructuredValue & { PropertyID String, Value Any, UnitCode String }
GeoCoordinates            StructuredValue & GeoCoordinate & { Address }
GeoShape_                 StructuredValue & { Box String, Circle String, Line String, Polygon String }
GeoCircle_                GeoShape_ & { GeoMidpoint GeoCoordinates, GeoRadius Distance_ }
PostalAddress             StructuredValue & Address & { PostOfficeBoxNumber String, AddressCountry String }
ContactPoint_             StructuredValue & ContactPoint & { ContactType String, AreaServed String, AvailableLanguage Language, HoursAvailable OpeningHoursSpecification }
OpeningHoursSpecification StructuredValue & { DayOfWeek, Opens TimeOfDay, Closes TimeOfDay, ValidFrom Date, ValidThrough Date }
MonetaryAmount            StructuredValue & Money & { MinValue Real, MaxValue Real, ValidFrom Date, ValidThrough Date }
ExchangeRateSpecification StructuredValue & { Currency, CurrentExchangeRate UnitPriceSpecification }
InteractionCounter        StructuredValue & { InteractionType String, UserInteractionCount Count }
NutritionInformation      StructuredValue & { Calories, FatContent Mass_, ProteinContent Mass_, CarbohydrateContent Mass_, SugarContent Mass_, SodiumContent Mass_, ServingSize String }
DatedMoneySpecification   StructuredValue & { Amount Real, Currency, StartDate Date, EndDate Date }
EngineSpecification       StructuredValue & { FuelType String, EngineDisplacement QuantitativeValue, EnginePower QuantitativeValue, Torque QuantitativeValue }
RepaymentSpecification    StructuredValue & { DownPayment MonetaryAmount, LoanPaymentAmount MonetaryAmount, NumberOfLoanPayments Count }
WarrantyPromise           StructuredValue & { DurationOfWarranty QuantitativeValue, WarrantyScope }
TypeAndQuantityNode       StructuredValue & { AmountOfThisGood Real, TypeOfGood Thing, UnitCode String }
OwnershipInfo             StructuredValue & { AcquiredFrom Thing, OwnedFrom DateTime, OwnedThrough DateTime, TypeOfGood Thing }
CDCPMDRecord              StructuredValue & { CvdCollectionDate DateTime, CvdNumBeds Count, CvdNumVent Count }

UnitPriceSpecification      PriceSpecification & { BillingIncrement Real, ReferenceQuantity QuantitativeValue, PriceType String }
DeliveryChargeSpecification PriceSpecification & { AppliesToDeliveryMethod DeliveryMethod, AreaServed String }
PaymentChargeSpecification  PriceSpecification & { AppliesToPaymentMethod PaymentMethod }
CompoundPriceSpecification  PriceSpecification & { PriceComponent List(UnitPriceSpecification) }
