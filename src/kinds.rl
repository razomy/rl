#
Concrete Artifact Kinds (Tools, Devices, Vehicles, Buildings, Software, Food) & Transitions
#

ToolKind "hammer" | "screwdriver" | "wrench" | "saw" | "drill" | "knife" | "axe" | "shovel"
    | "needle" | "brush" | "pen" | "pencil" | "ruler" | "scissors" | "pliers" | "spoon" | "pot"

DeviceKind "phone" | "computer" | "laptop" | "tablet" | "watch" | "camera" | "television" | "radio"
    | "speaker" | "headphones" | "printer" | "router" | "sensor" | "lamp" | "refrigerator"
    | "oven" | "microwave" | "washing-machine" | "air-conditioner" | "heater" | "game-console"

MachineKind "engine" | "motor" | "pump" | "generator" | "turbine" | "press" | "lathe" | "loom"
    | "crane" | "excavator" | "tractor" | "robot-arm" | "3d-printer" | "reactor"

Battery   Component & EnergyStore
Processor Component & { Cores Count, clockSpeed Frequency }
Display   Component & { Resolution, diagonal Length }
Memory_   Component & { Capacity DataSize }

VehicleKind "car" | "truck" | "bus" | "motorcycle" | "bicycle" | "scooter" | "train" | "tram"
    | "subway" | "ship" | "boat" | "submarine" | "airplane" | "helicopter" | "drone" | "rocket"
    | "spacecraft" | "cart" | "wagon" | "sled"
Medium "land" | "rail" | "water" | "underwater" | "air" | "space"
FuelKind "gasoline" | "diesel" | "electric" | "hybrid" | "hydrogen" | "kerosene" | "human" | "animal" | "wind"

BuildingKind "house" | "apartment" | "office" | "factory" | "warehouse" | "shop" | "school"
    | "hospital" | "church" | "mosque" | "temple" | "synagogue" | "stadium" | "theater"
    | "museum" | "library" | "station" | "airport" | "bridge" | "tower" | "castle" | "barn"
RoomKind "kitchen" | "bedroom" | "bathroom" | "living-room" | "dining-room" | "office" | "hall"
    | "garage" | "basement" | "attic" | "classroom" | "ward" | "storage"

InfrastructureKind "road" | "railway" | "pipeline" | "power-line" | "water-main" | "sewer"
    | "canal" | "dam" | "port" | "cable" | "cell-tower" | "data-center"

License "mit" | "apache-2.0" | "gpl-3.0" | "bsd-3" | "mpl-2.0" | "proprietary" | "public-domain"
ProgrammingLanguage "c" | "cpp" | "rust" | "go" | "java" | "kotlin" | "python" | "javascript"
    | "typescript" | "csharp" | "swift" | "ruby" | "php" | "haskell" | "rl"
Platform "linux" | "macos" | "windows" | "android" | "ios" | "web" | "embedded"

GarmentKind "shirt" | "trousers" | "dress" | "skirt" | "coat" | "jacket" | "hat" | "shoes"
    | "socks" | "gloves" | "scarf" | "underwear" | "uniform"

FoodKind "fruit" | "vegetable" | "grain" | "meat" | "fish" | "dairy" | "egg" | "bread" | "sweet"
    | "beverage" | "spice" | "legume" | "nut"

Make(a Agent, m Material, purpose String) [ Artifact { Material M, maker A, madeAt Now, Condition "new", Purpose } & Working Object ]
Assemble(parts List(Component), a Agent) [ Artifact { Maker A, madeAt Now, Condition "new" } & Working Object ]
Use(x Artifact & Working, u Agent) [ x & InUse { User U } ]
Release_(x Artifact & InUse) [ X / InUse ]
Wear(x Artifact) [
    Condition . {
        "new"      [ x & { Condition "like-new" } ]
        "like-new" [ x & { Condition "good" } ]
        "good"     [ x & { Condition "worn" } ]
        "worn"     [ x & { Condition "damaged" } ]
        _          [ X ]
    }
]
Break(x Artifact & Working, fault String) [ X / Working & Broken_ { Fault } & { Condition "broken" } ]
Repair(x Artifact & Broken_) [ X / Broken_ & Working Object & { Condition "good" } ]
Discard(x Artifact) [ x & Discarded { At Now } ]
Recycle(x Artifact & Discarded) [ X.Material ]
Store(x Artifact, p Position) [ x & Stored { Location P } ]
Build(b Building & UnderConstruction) [ B / UnderConstruction & Completed_ { CompletedAt Now } ]
Demolish(b Building) [ b & Demolished { At Now } ]
Park(v Vehicle & Driving) [ V / Driving & Parked Object ]
Drive(v Vehicle & Parked, d Agent, to GeoCoordinate) [ V / Parked & Driving { Driver D, destination To } ]
Install(s Software & Uninstalled, d Device) [ S / Uninstalled & Installed { On D } ]
Uninstall(s Software & Installed) [ S / Installed & Uninstalled Object ]
Launch(s Software & Installed & Stopped) [ S / Stopped & Running { Since Now } ]
Terminate(s Software & Running) [ S / Running & Stopped Object ]
Upgrade(s Software, v Version) [ s & { Version V } ]
Cook(f Food & Raw, method String) [ F / Raw & Cooked { Method } ]
Spoil(f Food) [ f & Spoiled Object ]
Dress(g Garment, w Agent) [ g & Worn_ { Wearer W } ]
