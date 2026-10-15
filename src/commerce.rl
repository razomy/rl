// =============================================================================
// Commerce: Products, Vehicles, Services, Offers, Orders & Finance
// =============================================================================

Product Thing & {
  AggregateRating     Option(AggregateRating)
  Audience            Option(Audience)
  Award               List(Str)
  Brand               Option(Brand | Organization)
  Category            Option(Str)
  Color               Option(Str)
  CountryOfAssembly   Option(Str)
  CountryOfLastProcessing Option(Str)
  CountryOfOrigin     Option(Country)
  Depth               Option(Distance)
  Gtin                Option(Str)
  Gtin12              Option(Str)
  Gtin13              Option(Str)
  Gtin14              Option(Str)
  Gtin8               Option(Str)
  HasMerchantReturnPolicy Option(MerchantReturnPolicy)
  Height              Option(Distance)
  InProductGroupWithID Option(Str)
  IsAccessoryOrSparePartFor List(Product)
  IsConsumableFor     List(Product)
  IsFamilyFriendly    Option(Bool)
  IsRelatedTo         List(Product | Service)
  IsSimilarTo         List(Product | Service)
  ItemCondition       "DamagedCondition" | "NewCondition" | "RefurbishedCondition" | "UsedCondition"
  Keywords            List(Str)
  Logo                Option(URL)
  Manufacturer        Option(Organization)
  Material            Option(Product | Str)
  Model               Option(Str)
  Mpn                 Option(Str)
  Nsn                 Option(Str)
  Offers              List(Offer)
  Pattern             Option(Str)
  ProductID           Option(Str)
  ProductionDate      Option(Date)
  PurchaseDate        Option(Date)
  ReleaseDate         Option(Date)
  Review              List(Review)
  Size                Option(Str)
  Sku                 Option(Str)
  Slogan              Option(Str)
  Weight              Option(Mass)
  Width               Option(Distance)
}

IndividualProduct Product & {
  SerialNumber Str
}
ProductGroup Product & {
  HasVariant      List(Product)
  ProductGroupID  Str
  VariesBy        List(Str)
}
ProductModel Product & {
  IsVariantOf Option(ProductGroup | ProductModel)
  PredecessorOf Option(ProductModel)
  SuccessorOf Option(ProductModel)
}
SomeProducts Product & {
  InventoryLevel QuantitativeValue
}

// Vehicles
Vehicle Product & {
  AccelerationTime          Option(QuantitativeValue)
  BodyType                  Option(Str)
  CargoVolume               Option(QuantitativeValue)
  DateVehicleFirstRegistered Option(Date)
  DriveWheelConfiguration   Option(Str)
  EmissionsCO2              Option(Float)
  FuelCapacity              Option(QuantitativeValue)
  FuelConsumption           Option(QuantitativeValue)
  FuelEfficiency            Option(QuantitativeValue)
  FuelType                  Option(Str)
  KnownVehicleDamages       Option(Str)
  MeetsEmissionStandard     Option(Str)
  MileageFromOdometer       Option(QuantitativeValue)
  ModelDate                 Option(Date)
  NumberOfAirbags           Option(Count)
  NumberOfAxles             Option(Count)
  NumberOfDoors             Option(Count)
  NumberOfForwardGears      Option(Count)
  NumberOfPreviousOwners    Option(Count)
  Payload                   Option(Mass)
  ProductionDate            Option(Date)
  PurchaseDate              Option(Date)
  SeatingCapacity           Option(Count)
  Speed                     Option(QuantitativeValue)
  SteeringPosition          "LeftHandDriving" | "RightHandDriving"
  TongueWeight              Option(Mass)
  TrailerWeight             Option(Mass)
  VehicleConfiguration      Option(Str)
  VehicleEngine             Option(EngineSpecification)
  VehicleIdentificationNumber Option(Str)
  VehicleInteriorColor      Option(Str)
  VehicleInteriorType       Option(Str)
  VehicleModelDate          Option(Date)
  VehicleSeatingCapacity    Option(Count)
  VehicleTransmission       Option(Str)
  WeightTotal               Option(Mass)
  Wheelbase                 Option(Distance)
}

EngineSpecification StructuredValue & {
  EngineDisplacement Option(QuantitativeValue)
  EnginePower        Option(QuantitativeValue)
  EngineType         Option(Str)
  FuelType           Option(Str)
  Torque             Option(QuantitativeValue)
}

Car                   Vehicle
BusOrCoach            Vehicle
Motorcycle            Vehicle
MotorizedBicycle      Vehicle
RVParkVehicle         Vehicle

// Services
Service Intangible & {
  AggregateRating    Option(AggregateRating)
  AreaServed         List(Place)
  Audience           Option(Audience)
  AvailableChannel   Option(ServiceChannel)
  Award              List(Str)
  Brand              Option(Brand | Organization)
  Broker             Option(Agent)
  Category           Option(Str)
  HasOfferCatalog    Option(OfferCatalog)
  HoursAvailable     Option(OpeningHoursSpecification)
  IsRelatedTo        List(Product | Service)
  IsSimilarTo        List(Product | Service)
  Logo               Option(URL)
  Offers             List(Offer)
  Provider           Option(Agent)
  ProviderMobility   Option(Str)
  Review             List(Review)
  ServiceOutput      Option(Thing)
  ServiceType        Option(Str)
  Slogan             Option(Str)
  TermsOfService     Option(Str | URL)
}

ServiceChannel Intangible & {
  AvailableLanguage List(Language)
  ProcessingTime    Option(Duration)
  ProvidesService   Option(Service)
  ServiceLocation   Option(Place)
  ServicePhone      Option(ContactPoint)
  ServicePostalAddress Option(PostalAddress)
  ServiceSmsNumber  Option(ContactPoint)
  ServiceUrl        Option(URL)
}

BroadcastService Service & {
  BroadcastAffiliateOf Option(Organization)
  BroadcastDisplayName Option(Str)
  BroadcastFrequency   Option(Str)
  BroadcastTimezone    Option(Str)
  Broadcaster          Option(Organization)
  InLanguage           Option(Language)
  ParentService        Option(BroadcastService)
  VideoFormat          Option(Str)
}
CableOrSatelliteService Service
FinancialProduct        Service & {
  AnnualPercentageRate Option(Float)
  FeesAndCommissionsSpecification Option(Str)
  InterestRate         Option(Float)
}
BankAccount             FinancialProduct & {
  AccountMinimumInflow Option(MonetaryAmount)
  AccountOverdraftLimit Option(MonetaryAmount)
  BankAccountType      Option(Str)
}
CurrencyConversionService FinancialProduct
InvestmentOrDeposit     FinancialProduct & { Amount MonetaryAmount }
LoanOrCredit            FinancialProduct & {
  Amount             MonetaryAmount
  Currency           Str
  GracePeriod        Option(Duration)
  LoanRepaymentForm  Option(Thing)
  LoanTerm           Option(QuantitativeValue)
  LoanType           Option(Str)
  RecourseLoan       Option(Bool)
  RenegotiableLoan   Option(Bool)
  RequiredCollateral Option(Thing | Str)
}
CreditCard              LoanOrCredit
MortgageLoan            LoanOrCredit
PaymentCard             FinancialProduct & {
  CashBack          Option(Float | Bool)
  ContactlessPayment Option(Bool)
  FloorLimit        Option(MonetaryAmount)
  MonthlyMinimumRepaymentAmount Option(MonetaryAmount)
}
PaymentService          FinancialProduct
FoodService             Service
GovernmentService       Service & {
  Jurisdiction       Option(AdministrativeArea)
  ServiceOperator    Option(Organization)
}
TaxiService             Service
WebAPI                  Service & {
  Documentation Option(CreativeWork | URL)
}

// Offers, Pricing & Catalogs
Offer Intangible & {
  AcceptedPaymentMethod  List(Str)
  AddOn                  List(Offer)
  AdvanceBookingRequirement Option(QuantitativeValue)
  AggregateRating        Option(AggregateRating)
  AreaServed             List(Place)
  Availability           ItemAvailability
  AvailabilityEnds       Option(DateTime)
  AvailabilityStarts     Option(DateTime)
  AvailableAtOrFrom      Option(Place)
  AvailableDeliveryMethod List(DeliveryMethod)
  BusinessFunction       Option(Str)
  Category               Option(Str)
  DeliveryLeadTime       Option(QuantitativeValue)
  EligibleCustomerType   Option(Str)
  EligibleDuration       Option(QuantitativeValue)
  EligibleQuantity       Option(QuantitativeValue)
  EligibleRegion         List(Place)
  EligibleTransactionVolume Option(PriceSpecification)
  Gtin                   Option(Str)
  HasMerchantReturnPolicy Option(MerchantReturnPolicy)
  IncludesObject         List(TypeAndQuantityNode)
  InventoryLevel         Option(QuantitativeValue)
  ItemCondition          Option(Str)
  ItemOffered            Product | Service | Event | CreativeWork
  LeaseLength            Option(QuantitativeValue)
  Mpn                    Option(Str)
  OfferedBy              Option(Agent)
  Price                  Float
  PriceCurrency          Str
  PriceSpecification     Option(PriceSpecification)
  PriceValidUntil        Option(Date)
  Review                 List(Review)
  Seller                 Option(Agent)
  SerialNumber           Option(Str)
  ShippingDetails        Option(OfferShippingDetails)
  Sku                    Option(Str)
  ValidFrom              Option(DateTime)
  ValidThrough           Option(DateTime)
  Warranty               Option(WarrantyPromise)
}

AggregateOffer Offer & {
  HighPrice  Float
  LowPrice   Float
  OfferCount Count
  Offers     List(Offer)
}

OfferCatalog ItemList

PriceSpecification StructuredValue & {
  EligibleQuantity          Option(QuantitativeValue)
  EligibleTransactionVolume Option(PriceSpecification)
  MaxPrice                  Option(Float)
  MinPrice                  Option(Float)
  Price                     Float
  PriceCurrency             Str
  ValidFrom                 Option(DateTime)
  ValidThrough              Option(DateTime)
  ValueAddedTaxIncluded     Option(Bool)
}
UnitPriceSpecification     PriceSpecification & {
  BillingDuration  Option(QuantitativeValue)
  BillingIncrement Option(Float)
  BillingStart     Option(Float)
  PriceType        Option(Str)
  ReferenceQuantity Option(QuantitativeValue)
  UnitCode         Option(Str)
  UnitText         Option(Str)
}
DeliveryChargeSpecification PriceSpecification & {
  AppliesToDeliveryMethod Option(DeliveryMethod)
  AreaServed              List(Place)
}
PaymentChargeSpecification  PriceSpecification & {
  AppliesToPaymentMethod Str
}

MerchantReturnPolicy Intangible & {
  ApplicableCountry        Option(Country)
  InStoreReturnsOffered    Option(Bool)
  MerchantReturnDays       Option(Count)
  MerchantReturnLink       Option(URL)
  RefundType               "ExchangeRefund" | "FullRefund" | "StoreCreditRefund"
  ReturnFees               "FreeReturn" | "OriginalShippingFees" | "RestockingFees" | "ReturnFeesCustomerResponsibility" | "ReturnShippingFees"
  ReturnMethod             "KeepProduct" | "ReturnAtKiosk" | "ReturnByMail" | "ReturnInStore"
}

OfferShippingDetails StructuredValue & {
  DeliveryTime        Option(ShippingDeliveryTime)
  DoesNotShip         Option(Bool)
  ShippingDestination Option(DefinedRegion)
  ShippingLabel       Option(Str)
  ShippingRate        Option(MonetaryAmount)
}
ShippingDeliveryTime StructuredValue & {
  BusinessDays Option(OpeningHoursSpecification)
  CutoffTime   Option(Time)
  HandlingTime Option(QuantitativeValue)
  TransitTime  Option(QuantitativeValue)
}
DefinedRegion StructuredValue & {
  AddressCountry Option(Str)
  AddressRegion  Option(Str)
  PostalCode     Option(Str)
}

WarrantyPromise StructuredValue & {
  DurationOfWarranty QuantitativeValue
  WarrantyScope      Str
}
TypeAndQuantityNode StructuredValue & {
  AmountOfThisGood Float
  BusinessFunction Option(Str)
  TypeOfGood       Product | Service
  UnitCode         Option(Str)
  UnitText         Option(Str)
}

// Orders, Invoices, Reservations & Receipts
Order Intangible & {
  AcceptedOffer            List(Offer)
  BillingAddress           Option(PostalAddress)
  Broker                   Option(Agent)
  ConfirmationNumber       Option(Str)
  Customer                 Agent
  Discount                 Option(Float | Str)
  DiscountCode             Option(Str)
  DiscountCurrency         Option(Str)
  IsGift                   Option(Bool)
  OrderDate                DateTime
  OrderDelivery            Option(ParcelDelivery)
  OrderNumber              Str
  OrderStatus              OrderStatus
  OrderedItem              List(OrderItem | Product | Service)
  PartOfInvoice            Option(Invoice)
  PaymentDueDate           Option(DateTime)
  PaymentMethod            Option(Str)
  PaymentMethodId          Option(Str)
  PaymentUrl               Option(URL)
  Seller                   Agent
}

OrderItem Intangible & {
  OrderDelivery   Option(ParcelDelivery)
  OrderItemNumber Str
  OrderItemStatus OrderStatus
  OrderQuantity   Count
  OrderedItem     Product | Service | OrderItem
}

ParcelDelivery Intangible & {
  DeliveryAddress       PostalAddress
  DeliveryStatus        Option(DeliveryEvent)
  ExpectedArrivalFrom   Option(DateTime)
  ExpectedArrivalUntil  Option(DateTime)
  HasDeliveryMethod     Option(DeliveryMethod)
  ItemShipped           List(Product)
  OriginAddress         Option(PostalAddress)
  PartOfOrder           Option(Order)
  Provider              Option(Agent)
  TrackingNumber        Option(Str)
  TrackingUrl           Option(URL)
}

Invoice Intangible & {
  AccountId            Option(Str)
  BillingPeriod        Option(Duration)
  Broker               Option(Agent)
  Category             Option(Str)
  ConfirmationNumber   Option(Str)
  Customer             Agent
  MinimumPaymentDue    Option(MonetaryAmount | PriceSpecification)
  PaymentDueDate       Option(DateTime)
  PaymentMethod        Option(Str)
  PaymentMethodId      Option(Str)
  PaymentStatus        PaymentStatusType
  Provider             Agent
  ReferencesOrder      List(Order)
  ScheduledPaymentDate Option(Date)
  TotalPaymentDue      MonetaryAmount | PriceSpecification
}

Reservation Intangible & {
  BookingTime       Option(DateTime)
  Broker            Option(Agent)
  ModifiedTime      Option(DateTime)
  PriceCurrency     Option(Str)
  ProgramMembershipUsed Option(Thing)
  Provider          Option(Agent)
  ReservationFor    Thing
  ReservationId     Str
  ReservationStatus "ReservationCancelled" | "ReservationConfirmed" | "ReservationHold" | "ReservationPending"
  ReservedTicket    Option(Ticket)
  TotalPrice        Option(Float | MonetaryAmount)
  UnderName         Option(Agent)
}
BusReservation          Reservation
EventReservation        Reservation
FlightReservation       Reservation & {
  BoardingGroup  Option(Str)
  PassengerPriorityStatus Option(Str)
  PassengerSequenceNumber Option(Str)
  SecurityScreening Option(Str)
}
FoodEstablishmentReservation Reservation & {
  EndTime   DateTime
  PartySize Count
  StartTime DateTime
}
LodgingReservation      Reservation & {
  CheckinTime  DateTime
  CheckoutTime DateTime
  LodgingUnitType Option(Str)
  NumAdults    Count
  NumChildren  Count
}
RentalCarReservation    Reservation & {
  DropoffLocation Place
  DropoffTime     DateTime
  PickupLocation  Place
  PickupTime      DateTime
}
TaxiReservation         Reservation
TrainReservation        Reservation

Ticket Intangible & {
  DateIssued    Option(DateTime)
  IssuedBy      Option(Organization)
  PriceCurrency Option(Str)
  TicketNumber  Str
  TicketToken   Option(Str)
  TicketedSeat  Option(Seat)
  TotalPrice    Option(Float | MonetaryAmount)
  UnderName     Option(Agent)
}

Seat Intangible & {
  SeatNumber  Str
  SeatRow     Option(Str)
  SeatSection Option(Str)
  SeatingType Option(Str)
}
