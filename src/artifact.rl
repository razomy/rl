#
Abstract Artifact, Tool, Device, Machine, Vehicle, Building, Software, Garment, Food & Typestates
#

Condition    "new" | "like-new" | "good" | "worn" | "damaged" | "broken" | "destroyed"
Manufacturer Agent
SerialNumber String
ModelName    String

Artifact PhysicalObject & {
    Name
    Maker Agent
    MadeAt Instant
    Condition
    Purpose String
}

Working   Object
Broken_   { Fault String }
InUse     { User Agent }
Stored    { Location Position }
Discarded { At Instant }

Tool Artifact & { ToolKind }

Device Artifact & {
    DeviceKind
    Manufacturer
    ModelName
    SerialNumber
    Power
}

Machine   Artifact & { MachineKind, Power, Efficiency }
Component { Name, partOf Artifact }

Vehicle Artifact & Moving & {
    VehicleKind
    Medium
    FuelKind
    Capacity_ Count
    MaxSpeed Velocity
    Vin
}
Parked  Object
Driving { Driver Agent, destination GeoCoordinate }

Room   { RoomKind, Area }
Floor_ { Level Int, rooms List(Room) }
Building Artifact & {
    BuildingKind
    Address
    GeoCoordinate
    Floors List(Floor_)
    FloorArea Area
    BuiltIn Year
}

Infrastructure Artifact & { InfrastructureKind, route GeoPath }

UnderConstruction { Progress Fraction }
Completed_        { CompletedAt Instant }
Demolished        { At Instant }

Version String

Software {
    Name
    Version
    License
    ProgrammingLanguage
    Platform
    SourceUrl Url
}
Installed   { On Device }
Uninstalled Object
Running     { Since Instant }
Stopped     Object

Garment Artifact & { GarmentKind, size_ String, Color }
Worn_   { Wearer Agent }

Calories Measure(Real & NonNegative, Joule)
Food     { Name, FoodKind, Calories, ingredients List(Substance) }
Raw      Object
Cooked   { Method "boiled" | "fried" | "baked" | "grilled" | "steamed" | "roasted" }
Spoiled  Object
