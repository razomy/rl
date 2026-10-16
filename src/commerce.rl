_ thing
_ enumeration
_ intangible
_ place
_ organization
_ product

// =============================================================================
// Offers, Pricing, Catalogs & Demand
// =============================================================================

Offer Intangible & {
  AcceptedPaymentMethod     List(PaymentMethod)
  AddOn                     List(Offer)
  AdvanceBookingRequirement Option(QuantitativeValue)
  AggregateRating           Option(AggregateRating)
  AreaServed                List(Place)
  Availability              ItemAvailability
  AvailabilityEnds          Option(DateTime)
  AvailabilityStarts        Option(DateTime)
  AvailableAtOrFrom         Option(Place)
  AvailableDeliveryMethod   List(DeliveryMethod)
  BusinessFunction          Option(BusinessFunction)
  Category                  Option(String)
  DeliveryLeadTime          Option(QuantitativeValue)
  EligibleCustomerType      Option(String)
  EligibleDuration          Option(QuantitativeValue)
  EligibleQuantity          Option(QuantitativeValue)
  EligibleRegion            List(Place)
  EligibleTransactionVolume Option(PriceSpecification)
  Gtin                      Option(Gtin)
  HasMerchantReturnPolicy   Option(MerchantReturnPolicy)
  IncludesObject            List(TypeAndQuantityNode)
  InventoryLevel            Option(QuantitativeValue)
  ItemCondition             OfferItemCondition
  ItemOffered               Thing
  LeaseLength               Option(QuantitativeValue)
  Mpn                       Option(String)
  OfferedBy                 Option(Agent)
  Price                     Price
  PriceCurrency             Currency
  PriceSpecification        Option(PriceSpecification)
  PriceValidUntil           Option(Date)
  Review                    List(Any)
  Seller                    Agent
  SerialNumber              Option(String)
  ShippingDetails           Option(OfferShippingDetails)
  Sku                       Option(String)
  ValidFrom                 Option(DateTime)
  ValidThrough              Option(DateTime)
  Warranty                  Option(WarrantyPromise)
}

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

// =============================================================================
// Orders, Invoices, Reservations & Tickets
// =============================================================================

OrderItem Intangible & {
  OrderDelivery   Option(ParcelDelivery)
  OrderItemNumber String
  OrderItemStatus OrderStatus
  OrderQuantity   Count
  OrderedItem     Thing
}

Order Intangible & {
  Id                 String
  OrderNumber        String
  OrderDate          DateTime
  OrderStatus        OrderStatus
  Amount             Int
  Customer           Agent
  Seller             Agent
  Broker             Option(Agent)
  AcceptedOffer      List(Offer)
  OrderedItem        List(OrderItem)
  BillingAddress     Option(PostalAddress)
  ConfirmationNumber Option(String)
  Discount           Option(Real)
  DiscountCode       Option(String)
  DiscountCurrency   Option(String)
  IsGift             Option(Bool)
  OrderDelivery      Option(ParcelDelivery)
  PartOfInvoice      Option(Invoice)
  PaymentDueDate     Option(DateTime)
  PaymentMethod      Option(PaymentMethod)
  PaymentMethodId    Option(String)
  PaymentUrl         Option(URL)
}

Invoice Intangible & {
  AccountId            Option(String)
  BillingPeriod        Option(Duration_)
  Broker               Option(Agent)
  Category             Option(String)
  ConfirmationNumber   Option(String)
  Customer             Agent
  Provider             Agent
  PaymentDueDate       Option(DateTime)
  PaymentMethod        Option(PaymentMethod)
  PaymentMethodId      Option(String)
  PaymentStatus        PaymentStatusType
  TotalPaymentDue      MonetaryAmount
  MinimumPaymentDue    Option(MonetaryAmount)
  ReferencesOrder      List(Order)
  ScheduledPaymentDate Option(Date)
}

Ticket Intangible & {
  TicketNumber  String
  TicketToken   Option(String)
  TicketedSeat  Option(Seat)
  TotalPrice    Option(PriceSpecification)
  PriceCurrency Option(String)
  IssuedBy      Option(Agent)
  UnderName     Option(Agent)
  DateIssued    Option(DateTime)
}

Reservation Intangible & {
  ReservationId         String
  ReservationStatus     ReservationStatusType
  ReservationFor        Thing
  UnderName             Option(Agent)
  Broker                Option(Agent)
  Provider              Option(Agent)
  BookingTime           Option(DateTime)
  ModifiedTime          Option(DateTime)
  ReservedTicket        Option(Ticket)
  TotalPrice            Option(PriceSpecification)
  PriceCurrency         Option(String)
  ProgramMembershipUsed Option(ProgramMembership)
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

// =============================================================================
// Ontological Typestate & Railway-Free Fulfillment (README Section 8, 9, 11)
// =============================================================================

Reserved   { ReservedAt Int }
Paid       { TransactionId String }
OutOfStock { Reason String }
NoMoney    { Reason String }

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

// =============================================================================
// Commerce Transitions
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
