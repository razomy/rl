_ thing
_ enumerations
_ intangible

// =============================================================================
// Offers and demand
// =============================================================================

Offer Intangible & {
    Price
    PriceCurrency Currency
    PriceSpecification
    Availability ItemAvailability
    ItemCondition OfferItemCondition
    ItemOffered Thing
    Seller Agent
    ValidFrom DateTime
    ValidThrough DateTime
    AvailableDeliveryMethod DeliveryMethod
    AcceptedPaymentMethod PaymentMethod
    BusinessFunction
    Warranty WarrantyPromise
    HasMerchantReturnPolicy MerchantReturnPolicy
    Sku String
    Gtin
    AggregateRating
}
AggregateOffer Offer & { LowPrice Real, HighPrice Real, OfferCount Count, Offers List(Offer) }
OfferForLease    Offer & { BusinessFunction "LeaseOut" }
OfferForPurchase Offer & { BusinessFunction "Sell" }

Demand Intangible & {
    ItemOffered Thing
    Seeks Thing
    PriceSpecification
    Availability ItemAvailability
    ValidFrom DateTime
    ValidThrough DateTime
}

// =============================================================================
// Orders and invoices
// =============================================================================

OrderItem Intangible & { OrderedItem Thing, OrderQuantity Count, OrderItemStatus OrderStatus, OrderDelivery ParcelDelivery }

Order Intangible & {
    OrderNumber String
    OrderDate DateTime
    OrderStatus
    Customer Agent
    Seller Agent
    AcceptedOffer List(Offer)
    OrderedItem List(OrderItem)
    BillingAddress PostalAddress
    PaymentMethod
    Discount Real
    DiscountCode String
    OrderDelivery ParcelDelivery
    PartOfInvoice Invoice
}

Invoice Intangible & {
    AccountId String
    BillingPeriod Duration_
    Broker Agent
    Customer Agent
    Provider Agent
    PaymentDueDate DateTime
    PaymentMethod
    PaymentStatus PaymentStatusType
    TotalPaymentDue MonetaryAmount
    MinimumPaymentDue MonetaryAmount
    ReferencesOrder List(Order)
    ScheduledPaymentDate Date
}

// =============================================================================
// Reservations and tickets
// =============================================================================

Ticket Intangible & {
    TicketNumber String
    TicketToken String
    TicketedSeat Seat
    TotalPrice PriceSpecification
    IssuedBy Agent
    UnderName Agent
    DateIssued DateTime
}

Reservation Intangible & {
    ReservationId String
    ReservationStatus ReservationStatusType
    ReservationFor Thing
    UnderName Agent
    Broker Agent
    Provider Agent
    BookingTime DateTime
    ModifiedTime DateTime
    ReservedTicket Ticket
    TotalPrice PriceSpecification
    ProgramMembershipUsed ProgramMembership
}

BusReservation        Reservation
EventReservation      Reservation
FlightReservation     Reservation & { BoardingGroup String, PassengerPriorityStatus String, PassengerSequenceNumber String, SecurityScreening String }
FoodEstablishmentReservation Reservation & { PartySize Count, StartTime DateTime, EndTime DateTime }
LodgingReservation    Reservation & { CheckinTime DateTime, CheckoutTime DateTime, LodgingUnitType String, NumAdults Count, NumChildren Count }
RentalCarReservation  Reservation & { PickupLocation String, DropoffLocation String, PickupTime DateTime, DropoffTime DateTime }
ReservationPackage    Reservation & { SubReservation List(Reservation) }
TaxiReservation       Reservation & { PartySize Count, PickupLocation String, PickupTime DateTime }
TrainReservation      Reservation
BoatReservation       Reservation

// =============================================================================
// Transitions
// =============================================================================

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
