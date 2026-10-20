#
General, Commerce, Event & Action Enumerations
#

DayOfWeek "Monday" | "Tuesday" | "Wednesday" | "Thursday" | "Friday" | "Saturday" | "Sunday" | "PublicHolidays"

ItemAvailability "InStock" | "OutOfStock" | "PreOrder" | "PreSale" | "BackOrder" | "Discontinued"
    | "InStoreOnly" | "OnlineOnly" | "LimitedAvailability" | "SoldOut" | "Reserved" | "MadeToOrder"

OfferItemCondition "NewCondition" | "UsedCondition" | "RefurbishedCondition" | "DamagedCondition"

EventStatusType "EventScheduled" | "EventCancelled" | "EventPostponed" | "EventRescheduled" | "EventMovedOnline"
EventAttendanceModeEnumeration "OfflineEventAttendanceMode" | "OnlineEventAttendanceMode" | "MixedEventAttendanceMode"

ActionStatusType "PotentialActionStatus" | "ActiveActionStatus" | "CompletedActionStatus" | "FailedActionStatus"

GenderType "Female" | "Male" | "NonBinary" | "Other"

OrderStatus "OrderPaymentDue" | "OrderProcessing" | "OrderInTransit" | "OrderDelivered"
    | "OrderPickupAvailable" | "OrderProblem" | "OrderReturned" | "OrderCancelled"

PaymentStatusType "PaymentDue" | "PaymentPastDue" | "PaymentComplete" | "PaymentAutomaticallyApplied" | "PaymentDeclined"

PaymentMethod "Cash" | "CreditCard" | "DebitCard" | "BankTransfer" | "PayPal" | "GoogleCheckout"
    | "DirectDebit" | "Invoice" | "COD" | "Crypto" | "ByBankTransferInAdvance"

ReservationStatusType "ReservationPending" | "ReservationConfirmed" | "ReservationHold" | "ReservationCancelled"

DeliveryMethod "OnSitePickup" | "ParcelService" | "Mail" | "DirectDownload" | "Freight"

BusinessFunction "Sell" | "LeaseOut" | "Repair" | "Maintain" | "ConstructionInstallation" | "Dispose" | "ProvideService" | "Buy"

ContactPointOption "TollFree" | "HearingImpairedSupported"
MapCategoryType "ParkingMap" | "SeatingMap" | "TransitMap" | "VenueMap"
RestrictedDiet "DiabeticDiet" | "GlutenFreeDiet" | "HalalDiet" | "HinduDiet" | "KosherDiet"
    | "LowCalorieDiet" | "LowFatDiet" | "LowLactoseDiet" | "LowSaltDiet" | "VeganDiet" | "VegetarianDiet"
ReturnFeesEnumeration "FreeReturn" | "OriginalShippingFees" | "RestockingFees" | "ReturnShippingFees"
MerchantReturnEnumeration "MerchantReturnFiniteReturnWindow" | "MerchantReturnNotPermitted" | "MerchantReturnUnlimitedWindow"
WarrantyScope "Labor" | "Parts" | "LaborAndParts"
SteeringPositionValue "LeftHandDriving" | "RightHandDriving"
CarUsageType "DrivingSchoolVehicleUsage" | "RentalVehicleUsage" | "TaxiVehicleUsage"
RsvpResponseType "RsvpResponseYes" | "RsvpResponseNo" | "RsvpResponseMaybe"
BoardingPolicyType "GroupBoardingPolicy" | "ZoneBoardingPolicy"
LegalForceStatus "InForce" | "NotInForce" | "PartiallyInForce"
NonprofitType "Nonprofit501c3" | "Nonprofit501c4" | "Nonprofit501c6" | "UnincorporatedAssociationCharity" | "LimitedByGuaranteeCharity"
