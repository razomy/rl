#
Concrete Offers, Shipping Details, Reservations & Commerce Transitions
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
FlightReservation            Reservation & { BoardingGroup Option(String), PassengerPriorityStatus Option(String), PassengerSequenceNumber Option(String), SecurityScreening Option(String) }
FoodEstablishmentReservation Reservation & { PartySize Count, StartTime DateTime, EndTime DateTime }
LodgingReservation           Reservation & { CheckinTime DateTime, CheckoutTime DateTime, LodgingUnitType Option(String), NumAdults Count, NumChildren Count }
RentalCarReservation         Reservation & { PickupLocation Place, DropoffLocation Place, PickupTime DateTime, DropoffTime DateTime }
ReservationPackage           Reservation & { SubReservation List(Reservation) }
TaxiReservation              Reservation & { PartySize Count, PickupLocation Place, PickupTime DateTime }
TrainReservation             Reservation
BoatReservation              Reservation

ReserveStock(O Order) [
  Amount . {
    [ _ > 0 ] [ O & Reserved { ReservedAt 1620000000 } ]
    _         [ OutOfStock { Reason "Warehouse empty" } ]
  }
]

ChargePayment(O Order) [
  Amount . {
    [ _ < 50000 ] [ O & Paid { TransactionId "tx_001" } ]
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

MakeOffer(S Agent, I Thing, P Price) [ Offer { Seller S, ItemOffered I, Price P, Availability "InStock" } ]
SellOut(O Offer & { Availability "InStock" }) [ O & { Availability "SoldOut" } ]
Restock(O Offer) [ O & { Availability "InStock" } ]
PlaceOrder(C Agent, O Offer) [ Order { Customer C, Seller O.Seller, AcceptedOffer List1(O), OrderDate Now, OrderStatus "OrderPaymentDue" } ]
ProcessOrder(O Order & { OrderStatus "OrderPaymentDue" }) [ O & { OrderStatus "OrderProcessing" } ]
ShipOrder(O Order & { OrderStatus "OrderProcessing" }, D ParcelDelivery) [ O & { OrderStatus "OrderInTransit", OrderDelivery D } ]
DeliverOrder(O Order & { OrderStatus "OrderInTransit" }) [ O & { OrderStatus "OrderDelivered" } ]
ReturnOrder(O Order & { OrderStatus "OrderDelivered" }) [ O & { OrderStatus "OrderReturned" } ]
CancelOrder(O Order) [
  OrderStatus . {
    "OrderDelivered" [ O ]
    _                [ O & { OrderStatus "OrderCancelled" } ]
  }
]
IssueInvoice(O Order) [ Invoice { Customer O.Customer, Provider O.Seller, ReferencesOrder List1(O), PaymentStatus "PaymentDue" } ]
SettleInvoice(I Invoice & { PaymentStatus "PaymentDue" }) [ I & { PaymentStatus "PaymentComplete" } ]
DeclineInvoice(I Invoice) [ I & { PaymentStatus "PaymentDeclined" } ]
Reserve(A Agent, F Thing) [ Reservation { UnderName A, ReservationFor F, BookingTime Now, ReservationStatus "ReservationPending" } ]
ConfirmReservation(R Reservation & { ReservationStatus "ReservationPending" }) [ R & { ReservationStatus "ReservationConfirmed" } ]
CancelReservation(R Reservation) [ R & { ReservationStatus "ReservationCancelled", ModifiedTime Now } ]
IssueTicket(R Reservation & { ReservationStatus "ReservationConfirmed" }) [ R & { ReservedTicket Ticket { UnderName R.UnderName, DateIssued Now } } ]
