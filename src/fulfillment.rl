#
Concrete Offers, shipping Details, Reservations & Commerce Transitions
#

AggregateOffer Offer & {
  HighPrice  Real
  LowPrice   Real
  OfferCount Count
  Offers     List(Offer)
}

OfferForLease    Offer & { BusinessFunction "LeaseOut" }
OfferForPurchase Offer & { BusinessFunction "Sell" }

Demand Intangible & {
  ItemOffered        Thing
  Seeks              Thing
  PriceSpecification Option(PriceSpecification)
  Availability       ItemAvailability
  ValidFrom          Option(DateTime)
  ValidThrough       Option(DateTime)
}

OfferShippingDetails StructuredValue & {
  DeliveryTime        Option(ShippingDeliveryTime)
  DoesNotShip         Option(Bool)
  ShippingDestination Option(DefinedRegion)
  ShippingLabel       Option(String)
  ShippingRate        Option(MonetaryAmount)
}

ShippingDeliveryTime StructuredValue & {
  BusinessDays Option(OpeningHoursSpecification)
  CutoffTime   Option(TimeOfDay)
  HandlingTime Option(QuantitativeValue)
  TransitTime  Option(QuantitativeValue)
}

DefinedRegion StructuredValue & {
  AddressCountry Option(String)
  AddressRegion  Option(String)
  PostalCode     Option(String)
}

BusReservation               Reservation
EventReservation             Reservation
FlightReservation            Reservation & { BoardingGroup Option(String), passengerPriorityStatus Option(String), passengerSequenceNumber Option(String), securityScreening Option(String) }
FoodEstablishmentReservation Reservation & { PartySize Count, startTime DateTime, endTime DateTime }
LodgingReservation           Reservation & { CheckinTime DateTime, checkoutTime DateTime, lodgingUnitType Option(String), numAdults Count, numChildren Count }
RentalCarReservation         Reservation & { PickupLocation Place, dropoffLocation Place, pickupTime DateTime, dropoffTime DateTime }
ReservationPackage           Reservation & { SubReservation List(Reservation) }
TaxiReservation              Reservation & { PartySize Count, pickupLocation Place, pickupTime DateTime }
TrainReservation             Reservation
BoatReservation              Reservation

ReserveStock(o Order) [
  Amount . {
    [ _ > 0 ] [ o & Reserved { ReservedAt 1620000000 } ]
    _         [ OutOfStock { Reason "Warehouse empty" } ]
  }
]

ChargePayment(o Order) [
  Amount . {
    [ _ < 50000 ] [ o & Paid { TransactionId "tx_001" } ]
    _             [ NoMoney { Reason "Insufficient funds" } ]
  }
]

ExecuteFulfillment(InitialOrder) [
  InitialOrder
  . ReserveStock
  . ChargePayment
]

ShipToCustomer(Order & Reserved & Paid) [
  "Shipping order {Id}. Transaction {TransactionId} confirmed." . Shell.Log
]

MakeOffer(s Agent, i Thing, p Price) [ Offer { Seller S, itemOffered I, price P, Availability "InStock" } ]
SellOut(o Offer & { Availability "InStock" }) [ o & { Availability "SoldOut" } ]
Restock(o Offer) [ o & { Availability "InStock" } ]
PlaceOrder(c Agent, o Offer) [ Order { Customer C, seller O.Seller, acceptedOffer List1(O), orderDate Now, OrderStatus "OrderPaymentDue" } ]
ProcessOrder(o Order & { OrderStatus "OrderPaymentDue" }) [ o & { OrderStatus "OrderProcessing" } ]
ShipOrder(o Order & { OrderStatus "OrderProcessing" }, d ParcelDelivery) [ o & { OrderStatus "OrderInTransit", orderDelivery D } ]
DeliverOrder(o Order & { OrderStatus "OrderInTransit" }) [ o & { OrderStatus "OrderDelivered" } ]
ReturnOrder(o Order & { OrderStatus "OrderDelivered" }) [ o & { OrderStatus "OrderReturned" } ]
CancelOrder(o Order) [
  OrderStatus . {
    "OrderDelivered" [ O ]
    _                [ o & { OrderStatus "OrderCancelled" } ]
  }
]
IssueInvoice(o Order) [ Invoice { Customer O.Customer, provider O.Seller, referencesOrder List1(O), PaymentStatus "PaymentDue" } ]
SettleInvoice(i Invoice & { PaymentStatus "PaymentDue" }) [ i & { PaymentStatus "PaymentComplete" } ]
DeclineInvoice(i Invoice) [ i & { PaymentStatus "PaymentDeclined" } ]
Reserve(a Agent, f Thing) [ Reservation { UnderName A, reservationFor F, bookingTime Now, ReservationStatus "ReservationPending" } ]
ConfirmReservation(r Reservation & { ReservationStatus "ReservationPending" }) [ r & { ReservationStatus "ReservationConfirmed" } ]
CancelReservation(r Reservation) [ r & { ReservationStatus "ReservationCancelled", modifiedTime Now } ]
IssueTicket(r Reservation & { ReservationStatus "ReservationConfirmed" }) [ r & { ReservedTicket Ticket { UnderName R.UnderName, dateIssued Now } } ]
