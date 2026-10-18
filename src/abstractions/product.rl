_ thing
_ enumeration
_ intangible
_ organization

#
Product
#

Sku       String
Mpn       String
ProductID String
Color_    String

Product Thing & {
    Brand
    Manufacturer Organization
    Model ProductModel
    Sku
    Mpn
    Gtin
    ProductID
    Category String
    Color_
    Material String
    Pattern String
    Size_ String
    Width QuantitativeValue
    Height QuantitativeValue
    Depth QuantitativeValue
    Weight QuantitativeValue
    Offers List(Any)
    AggregateRating
    Review List(Any)
    Audience
    Award List(String)
    ItemCondition OfferItemCondition
    IsAccessoryOrSparePartFor List(Product)
    IsConsumableFor List(Product)
    IsRelatedTo List(Product)
    IsSimilarTo List(Product)
    IsVariantOf ProductGroup
    ProductionDate Date
    PurchaseDate Date
    ReleaseDate Date
    CountryOfOrigin Country
    CountryOfAssembly String
    AdditionalProperty List(PropertyValue)
    HasMerchantReturnPolicy MerchantReturnPolicy
    NSN String
} . DeriveJson

ProductModel      Product & { IsVariantOf ProductModel, PredecessorOf ProductModel, SuccessorOf ProductModel }
ProductGroup      Product & { HasVariant List(Product), ProductGroupID String, VariesBy List(String) }
IndividualProduct Product & { SerialNumber }
SomeProducts      Product & { InventoryLevel QuantitativeValue }
ProductCollection Product & { IncludesObject List(TypeAndQuantityNode) }
DietarySupplement Product & { ActiveIngredient String, SafetyConsideration String }
Drug_             Product

#
Vehicles
#

SchemaVehicle Product & {
    VehicleIdentificationNumber String
    VehicleConfiguration String
    VehicleEngine EngineSpecification
    VehicleModelDate Date
    VehicleSeatingCapacity Count
    VehicleTransmission String
    BodyType String
    DriveWheelConfiguration "AllWheelDriveConfiguration" | "FourWheelDriveConfiguration" | "FrontWheelDriveConfiguration" | "RearWheelDriveConfiguration"
    FuelType String
    FuelConsumption QuantitativeValue
    FuelEfficiency QuantitativeValue
    MileageFromOdometer QuantitativeValue
    NumberOfAxles Count
    NumberOfDoors Count
    NumberOfForwardGears Count
    NumberOfPreviousOwners Count
    SteeringPosition SteeringPositionValue
    Speed QuantitativeValue
    CargoVolume QuantitativeValue
    Payload QuantitativeValue
    EmissionsCO2 Real
    DateVehicleFirstRegistered Date
    KnownVehicleDamages Text
    CallSign String
}
Car               SchemaVehicle & { AcrissCode String, RoofLoad QuantitativeValue }
BusOrCoach        SchemaVehicle & { AcrissCode String, RoofLoad QuantitativeValue }
Motorcycle        SchemaVehicle
MotorizedBicycle  SchemaVehicle
RVParkVehicle     SchemaVehicle

#
Transitions
#

Manufacture(M Organization, Model ProductModel) [ IndividualProduct & Model & { Manufacturer M, ProductionDate Today, ItemCondition "NewCondition" } ]
ReleaseProduct(P Product) [ P & { ReleaseDate Today } ]
Purchase(P Product) [ P & { PurchaseDate Today } ]
UseUp(P Product & { ItemCondition "NewCondition" }) [ P & { ItemCondition "UsedCondition" } ]
Refurbish(P Product) [ P & { ItemCondition "RefurbishedCondition" } ]
Damage(P Product) [ P & { ItemCondition "DamagedCondition" } ]
Drive_(V SchemaVehicle, D QuantitativeValue) [ V & { MileageFromOdometer { Value (MileageFromOdometer.Value + D.Value) } } ]
Register(V SchemaVehicle) [ V & { DateVehicleFirstRegistered Today } ]
Resell(V SchemaVehicle) [ V & { NumberOfPreviousOwners (NumberOfPreviousOwners + 1) } ]
