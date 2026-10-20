#
Abstract Offer, Order, Invoice, Ticket, Reservation & Ontological Fulfillment Typestates
#

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

// Ontological Typestates
Reserved   { ReservedAt Int }
Paid       { TransactionId String }
OutOfStock { Reason String }
NoMoney    { Reason String }
