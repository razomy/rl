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
Processor Component & { Cores Count, ClockSpeed Frequency }
Display   Component & { Resolution, Diagonal Length }
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

Make(A Agent, M Material, Purpose String) [ Artifact { Material M, Maker A, MadeAt Now, Condition "new", Purpose } & Working Object ]
Assemble(Parts List(Component), A Agent) [ Artifact { Maker A, MadeAt Now, Condition "new" } & Working Object ]
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
Repair(X Artifact & Broken_) [ X / Broken_ & Working Object & { Condition "good" } ]
Discard(X Artifact) [ X & Discarded { At Now } ]
Recycle(X Artifact & Discarded) [ X.Material ]
Store(X Artifact, P Position) [ X & Stored { Location P } ]
Build(B Building & UnderConstruction) [ B / UnderConstruction & Completed_ { CompletedAt Now } ]
Demolish(B Building) [ B & Demolished { At Now } ]
Park(V Vehicle & Driving) [ V / Driving & Parked Object ]
Drive(V Vehicle & Parked, D Agent, To GeoCoordinate) [ V / Parked & Driving { Driver D, Destination To } ]
Install(S Software & Uninstalled, D Device) [ S / Uninstalled & Installed { On D } ]
Uninstall(S Software & Installed) [ S / Installed & Uninstalled Object ]
Launch(S Software & Installed & Stopped) [ S / Stopped & Running { Since Now } ]
Terminate(S Software & Running) [ S / Running & Stopped Object ]
Upgrade(S Software, V Version) [ S & { Version V } ]
Cook(F Food & Raw, Method String) [ F / Raw & Cooked { Method } ]
Spoil(F Food) [ F & Spoiled Object ]
Dress(G Garment, W Agent) [ G & Worn_ { Wearer W } ]
