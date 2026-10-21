#
Concrete Structured Values & Price Specifications
#

QuantitativeValue         StructuredValue & { Value Real, minValue Real, maxValue Real, unitCode String, unitText String }
PropertyValue             StructuredValue & { PropertyID String, value Any, unitCode String }
GeoCoordinates            StructuredValue & GeoCoordinate & { Address }
GeoShape_                 StructuredValue & { Box String, circle String, line String, polygon String }
GeoCircle_                GeoShape_ & { GeoMidpoint GeoCoordinates, geoRadius Distance_ }
PostalAddress             StructuredValue & Address & { PostOfficeBoxNumber String, addressCountry String }
ContactPoint_             StructuredValue & ContactPoint & { ContactType String, areaServed String, availableLanguage Language, hoursAvailable OpeningHoursSpecification }
OpeningHoursSpecification StructuredValue & { DayOfWeek, opens TimeOfDay, closes TimeOfDay, validFrom Date, validThrough Date }
MonetaryAmount            StructuredValue & Money & { MinValue Real, maxValue Real, validFrom Date, validThrough Date }
ExchangeRateSpecification StructuredValue & { Currency, currentExchangeRate UnitPriceSpecification }
InteractionCounter        StructuredValue & { InteractionType String, userInteractionCount Count }
NutritionInformation      StructuredValue & { Calories, fatContent Mass_, proteinContent Mass_, carbohydrateContent Mass_, sugarContent Mass_, sodiumContent Mass_, servingSize String }
DatedMoneySpecification   StructuredValue & { Amount Real, Currency, startDate Date, endDate Date }
EngineSpecification       StructuredValue & { FuelType String, engineDisplacement QuantitativeValue, enginePower QuantitativeValue, torque QuantitativeValue }
RepaymentSpecification    StructuredValue & { DownPayment MonetaryAmount, loanPaymentAmount MonetaryAmount, numberOfLoanPayments Count }
WarrantyPromise           StructuredValue & { DurationOfWarranty QuantitativeValue, WarrantyScope }
TypeAndQuantityNode       StructuredValue & { AmountOfThisGood Real, typeOfGood Thing, unitCode String }
OwnershipInfo             StructuredValue & { AcquiredFrom Thing, ownedFrom DateTime, ownedThrough DateTime, typeOfGood Thing }
CDCPMDRecord              StructuredValue & { CvdCollectionDate DateTime, cvdNumBeds Count, cvdNumVent Count }

UnitPriceSpecification      PriceSpecification & { BillingIncrement Real, referenceQuantity QuantitativeValue, priceType String }
DeliveryChargeSpecification PriceSpecification & { AppliesToDeliveryMethod DeliveryMethod, areaServed String }
PaymentChargeSpecification  PriceSpecification & { AppliesToPaymentMethod PaymentMethod }
CompoundPriceSpecification  PriceSpecification & { PriceComponent List(UnitPriceSpecification) }
