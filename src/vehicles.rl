#
Concrete Product Variants, Vehicles & Product Transitions
#

ProductModel      Product & { IsVariantOf ProductModel, predecessorOf ProductModel, successorOf ProductModel }
ProductGroup      Product & { HasVariant List(Product), productGroupID String, variesBy List(String) }
IndividualProduct Product & { SerialNumber }
SomeProducts      Product & { InventoryLevel QuantitativeValue }
ProductCollection Product & { IncludesObject List(TypeAndQuantityNode) }
DietarySupplement Product & { ActiveIngredient String, safetyConsideration String }
Drug_             Product

Car              SchemaVehicle & { AcrissCode String, roofLoad QuantitativeValue }
BusOrCoach       SchemaVehicle & { AcrissCode String, roofLoad QuantitativeValue }
Motorcycle       SchemaVehicle
MotorizedBicycle SchemaVehicle
RVParkVehicle    SchemaVehicle

Manufacture(m Organization, model ProductModel) [ IndividualProduct & Model & { Manufacturer M, productionDate Today, ItemCondition "NewCondition" } ]
ReleaseProduct(p Product) [ p & { ReleaseDate Today } ]
Purchase(p Product) [ p & { PurchaseDate Today } ]
UseUp(p Product & { ItemCondition "NewCondition" }) [ p & { ItemCondition "UsedCondition" } ]
Refurbish(p Product) [ p & { ItemCondition "RefurbishedCondition" } ]
Damage(p Product) [ p & { ItemCondition "DamagedCondition" } ]
Drive_(v SchemaVehicle, d QuantitativeValue) [ v & { MileageFromOdometer { Value (MileageFromOdometer.Value + D.Value) } } ]
Register(v SchemaVehicle) [ v & { DateVehicleFirstRegistered Today } ]
Resell(v SchemaVehicle) [ v & { NumberOfPreviousOwners (NumberOfPreviousOwners + 1) } ]
