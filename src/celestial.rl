#
Concrete Astronomical Units, Galaxies, Solar System Planets & Moons
#

AstronomicalUnit Unit & { UnitSymbol "au", Dimension "length", Factor 149597870700 }
LightYear        Unit & { UnitSymbol "ly", Dimension "length", Factor 9460730472580800 }
Parsec           Unit & { UnitSymbol "pc", Dimension "length", Factor 30856775814913673 }

GalaxyType "spiral" | "barred-spiral" | "elliptical" | "lenticular" | "irregular" | "dwarf"

MilkyWay  Galaxy & { Name "milky way", GalaxyType "barred-spiral" }
Andromeda Galaxy & { Name "andromeda", GalaxyType "spiral" }

SpectralClass "O" | "B" | "A" | "F" | "G" | "K" | "M"
StarStage "protostar" | "main-sequence" | "red-giant" | "supergiant" | "white-dwarf"
    | "neutron-star" | "black-hole" | "supernova"

Sun Star & { Name "sun", SpectralClass "G", StarStage "main-sequence" }

PlanetKind "terrestrial" | "gas-giant" | "ice-giant" | "dwarf" | "exoplanet"

Mercury_ Planet & { Name "mercury", PlanetKind "terrestrial" }
Venus    Planet & { Name "venus",   PlanetKind "terrestrial" }
Earth    Planet & { Name "earth",   PlanetKind "terrestrial" }
Mars     Planet & { Name "mars",    PlanetKind "terrestrial" }
Jupiter  Planet & { Name "jupiter", PlanetKind "gas-giant" }
Saturn   Planet & { Name "saturn",  PlanetKind "gas-giant" }
Uranus   Planet & { Name "uranus",  PlanetKind "ice-giant" }
Neptune  Planet & { Name "neptune", PlanetKind "ice-giant" }
Pluto    Planet & { Name "pluto",   PlanetKind "dwarf" }

Luna      Moon & { Name "moon" }
Phobos    Moon & { Name "phobos" }
Deimos    Moon & { Name "deimos" }
Io        Moon & { Name "io" }
Europa    Moon & { Name "europa" }
Ganymede  Moon & { Name "ganymede" }
Callisto  Moon & { Name "callisto" }
Titan     Moon & { Name "titan" }
Enceladus Moon & { Name "enceladus" }
Triton    Moon & { Name "triton" }

SolarSystem PlanetarySystem & { Star Sun }

MoonPhase "new" | "waxing-crescent" | "first-quarter" | "waxing-gibbous"
    | "full" | "waning-gibbous" | "last-quarter" | "waning-crescent"
