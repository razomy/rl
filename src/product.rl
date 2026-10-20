
#
Abstract Product & SchemaVehicle (schema.org)
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
