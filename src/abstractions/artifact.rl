_ primitive
_ structure
_ quantity
_ time
_ space
_ energy
_ matter
_ agent
_ information
_ economy

#
Artifacts
#

Condition "new" | "like-new" | "good" | "worn" | "damaged" | "broken" | "destroyed"
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

Working  {}
Broken_  { Fault String }
InUse    { User Agent }
Stored   { Location Position }
Discarded { At Instant }

#
Tools and devices
#

ToolKind "hammer" | "screwdriver" | "wrench" | "saw" | "drill" | "knife" | "axe" | "shovel"
    | "needle" | "brush" | "pen" | "pencil" | "ruler" | "scissors" | "pliers" | "spoon" | "pot"
Tool Artifact & { ToolKind }

DeviceKind "phone" | "computer" | "laptop" | "tablet" | "watch" | "camera" | "television" | "radio"
    | "speaker" | "headphones" | "printer" | "router" | "sensor" | "lamp" | "refrigerator"
    | "oven" | "microwave" | "washing-machine" | "air-conditioner" | "heater" | "game-console"
Device Artifact & {
    DeviceKind
    Manufacturer
    ModelName
    SerialNumber
    Power
}

MachineKind "engine" | "motor" | "pump" | "generator" | "turbine" | "press" | "lathe" | "loom"
    | "crane" | "excavator" | "tractor" | "robot-arm" | "3d-printer" | "reactor"
Machine Artifact & { MachineKind, Power, Efficiency }

Component { Name, PartOf Artifact }
Battery   Component & EnergyStore
Processor Component & { Cores Count, ClockSpeed Frequency }
Display   Component & { Resolution, Diagonal Length }
Memory_   Component & { Capacity DataSize }

#
Vehicles
#

VehicleKind "car" | "truck" | "bus" | "motorcycle" | "bicycle" | "scooter" | "train" | "tram"
    | "subway" | "ship" | "boat" | "submarine" | "airplane" | "helicopter" | "drone" | "rocket"
    | "spacecraft" | "cart" | "wagon" | "sled"
Medium "land" | "rail" | "water" | "underwater" | "air" | "space"
FuelKind "gasoline" | "diesel" | "electric" | "hybrid" | "hydrogen" | "kerosene" | "human" | "animal" | "wind"

Vehicle Artifact & Moving & {
    VehicleKind
    Medium
    FuelKind
    Capacity_ Count
    MaxSpeed Velocity
    Vin
}
Parked  {}
Driving { Driver Agent, Destination GeoCoordinate }

#
Buildings and infrastructure
#

BuildingKind "house" | "apartment" | "office" | "factory" | "warehouse" | "shop" | "school"
    | "hospital" | "church" | "mosque" | "temple" | "synagogue" | "stadium" | "theater"
    | "museum" | "library" | "station" | "airport" | "bridge" | "tower" | "castle" | "barn"
RoomKind "kitchen" | "bedroom" | "bathroom" | "living-room" | "dining-room" | "office" | "hall"
    | "garage" | "basement" | "attic" | "classroom" | "ward" | "storage"

Room { RoomKind, Area }
Floor_ { Level Int, Rooms List(Room) }
Building Artifact & {
    BuildingKind
    Address
    GeoCoordinate
    Floors List(Floor_)
    FloorArea Area
    BuiltIn Year
}

InfrastructureKind "road" | "railway" | "pipeline" | "power-line" | "water-main" | "sewer"
    | "canal" | "dam" | "port" | "cable" | "cell-tower" | "data-center"
Infrastructure Artifact & { InfrastructureKind, Route GeoPath }

UnderConstruction { Progress Fraction }
Completed_ { CompletedAt Instant }
Demolished { At Instant }

#
Software
#

Version String
License "mit" | "apache-2.0" | "gpl-3.0" | "bsd-3" | "mpl-2.0" | "proprietary" | "public-domain"
ProgrammingLanguage "c" | "cpp" | "rust" | "go" | "java" | "kotlin" | "python" | "javascript"
    | "typescript" | "csharp" | "swift" | "ruby" | "php" | "haskell" | "rl"
Platform "linux" | "macos" | "windows" | "android" | "ios" | "web" | "embedded"

Software {
    Name
    Version
    License
    ProgrammingLanguage
    Platform
    SourceUrl Url
}
Installed   { On Device }
Uninstalled {}
Running     { Since Instant }
Stopped     {}

#
Clothing and food
#

GarmentKind "shirt" | "trousers" | "dress" | "skirt" | "coat" | "jacket" | "hat" | "shoes"
    | "socks" | "gloves" | "scarf" | "underwear" | "uniform"
Garment Artifact & { GarmentKind, Size_ String, Color }
Worn_   { Wearer Agent }

FoodKind "fruit" | "vegetable" | "grain" | "meat" | "fish" | "dairy" | "egg" | "bread" | "sweet"
    | "beverage" | "spice" | "legume" | "nut"
Calories Measure(Real & NonNegative, Joule)
Food { Name, FoodKind, Calories, Ingredients List(Substance) }
Raw    {}
Cooked { Method "boiled" | "fried" | "baked" | "grilled" | "steamed" | "roasted" }
Spoiled {}

#
Transitions
#

Make(A Agent, M Material, Purpose String) [ Artifact { Material M, Maker A, MadeAt Now, Condition "new", Purpose } & Working {} ]
Assemble(Parts List(Component), A Agent) [ Artifact { Maker A, MadeAt Now, Condition "new" } & Working {} ]
Use(X Artifact & Working, U Agent) [ X & InUse { User U } ]
Release_(X Artifact & InUse) [ X / InUse ]
Wear(X Artifact) [
    Condition . {
        "new"      [ X & { Condition "like-new" } ]
        "like-new" [ X & { Condition "good" } ]
        "good"     [ X & { Condition "worn" } ]
        "worn"     [ X & { Condition "damaged" } ]
        _          [ X ]
    }
]
Break(X Artifact & Working, Fault String) [ X / Working & Broken_ { Fault } & { Condition "broken" } ]
Repair(X Artifact & Broken_) [ X / Broken_ & Working {} & { Condition "good" } ]
Discard(X Artifact) [ X & Discarded { At Now } ]
Recycle(X Artifact & Discarded) [ X.Material ]
Store(X Artifact, P Position) [ X & Stored { Location P } ]
Build(B Building & UnderConstruction) [ B / UnderConstruction & Completed_ { CompletedAt Now } ]
Demolish(B Building) [ B & Demolished { At Now } ]
Park(V Vehicle & Driving) [ V / Driving & Parked {} ]
Drive(V Vehicle & Parked, D Agent, To GeoCoordinate) [ V / Parked & Driving { Driver D, Destination To } ]
Install(S Software & Uninstalled, D Device) [ S / Uninstalled & Installed { On D } ]
Uninstall(S Software & Installed) [ S / Installed & Uninstalled {} ]
Launch(S Software & Installed & Stopped) [ S / Stopped & Running { Since Now } ]
Terminate(S Software & Running) [ S / Running & Stopped {} ]
Upgrade(S Software, V Version) [ S & { Version V } ]
Cook(F Food & Raw, Method String) [ F / Raw & Cooked { Method } ]
Spoil(F Food) [ F & Spoiled {} ]
Dress(G Garment, W Agent) [ G & Worn_ { Wearer W } ]
