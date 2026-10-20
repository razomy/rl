#
Concrete Product Variants, Vehicles & Product Transitions
#

ProductModel      Product & { IsVariantOf ProductModel, PredecessorOf ProductModel, SuccessorOf ProductModel }
ProductGroup      Product & { HasVariant List(Product), ProductGroupID String, VariesBy List(String) }
IndividualProduct Product & { SerialNumber }
SomeProducts      Product & { InventoryLevel QuantitativeValue }
ProductCollection Product & { IncludesObject List(TypeAndQuantityNode) }
DietarySupplement Product & { ActiveIngredient String, SafetyConsideration String }
Drug_             Product

Car              SchemaVehicle & { AcrissCode String, RoofLoad QuantitativeValue }
BusOrCoach       SchemaVehicle & { AcrissCode String, RoofLoad QuantitativeValue }
Motorcycle       SchemaVehicle
MotorizedBicycle SchemaVehicle
RVParkVehicle    SchemaVehicle

Manufacture(M Organization, Model ProductModel) [ IndividualProduct & Model & { Manufacturer M, ProductionDate Today, ItemCondition "NewCondition" } ]
ReleaseProduct(P Product) [ P & { ReleaseDate Today } ]
Purchase(P Product) [ P & { PurchaseDate Today } ]
UseUp(P Product & { ItemCondition "NewCondition" }) [ P & { ItemCondition "UsedCondition" } ]
Refurbish(P Product) [ P & { ItemCondition "RefurbishedCondition" } ]
Damage(P Product) [ P & { ItemCondition "DamagedCondition" } ]
Drive_(V SchemaVehicle, D QuantitativeValue) [ V & { MileageFromOdometer { Value (MileageFromOdometer.Value + D.Value) } } ]
Register(V SchemaVehicle) [ V & { DateVehicleFirstRegistered Today } ]
Resell(V SchemaVehicle) [ V & { NumberOfPreviousOwners (NumberOfPreviousOwners + 1) } ]
