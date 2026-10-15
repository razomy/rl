_ meta
_ primitive
_ structure
_ quantity
_ time
_ space
_ energy
_ matter

// =============================================================================
// Astronomical units
// =============================================================================

AstronomicalUnit Unit & { UnitSymbol "au", Dimension "length", Factor 149597870700 }
LightYear        Unit & { UnitSymbol "ly", Dimension "length", Factor 9460730472580800 }
Parsec           Unit & { UnitSymbol "pc", Dimension "length", Factor 30856775814913673 }

Redshift  Real
Magnitude Real

// =============================================================================
// Celestial bodies
// =============================================================================

CelestialBody {
    Name
    Mass
    Radius
    Position
    Velocity Vector3D
    Composition List(Substance)
}

Orbit {
    Primary        CelestialBody
    SemiMajorAxis  Length
    Eccentricity   Range(0, 1) & Real
    Inclination    Angle
    Period         Duration
}
Orbiting { Orbit }

GalaxyType "spiral" | "barred-spiral" | "elliptical" | "lenticular" | "irregular" | "dwarf"

Universe { Age Duration, Galaxies List(Galaxy) }
GalaxyCluster { Name, Galaxies List(Galaxy) }
Galaxy CelestialBody & {
    GalaxyType
    Stars List(Star)
    Redshift
}
MilkyWay  Galaxy & { Name "milky way", GalaxyType "barred-spiral" }
Andromeda Galaxy & { Name "andromeda", GalaxyType "spiral" }

SpectralClass "O" | "B" | "A" | "F" | "G" | "K" | "M"
StarStage "protostar" | "main-sequence" | "red-giant" | "supergiant" | "white-dwarf"
    | "neutron-star" | "black-hole" | "supernova"

Star CelestialBody & {
    SpectralClass
    StarStage
    Luminosity
    Temperature
    Magnitude
}
Sun Star & { Name "sun", SpectralClass "G", StarStage "main-sequence" }
BlackHole CelestialBody & { EventHorizon Radius }
Nebula CelestialBody & { NebulaKind "emission" | "reflection" | "dark" | "planetary" }

PlanetKind "terrestrial" | "gas-giant" | "ice-giant" | "dwarf" | "exoplanet"
Atmosphere { Composition List(Substance), Pressure }

Planet CelestialBody & Orbiting & {
    PlanetKind
    Atmosphere
    Moons List(Moon)
    RotationPeriod Duration
    AxialTilt Angle
}
Mercury_ Planet & { Name "mercury", PlanetKind "terrestrial" }
Venus    Planet & { Name "venus",   PlanetKind "terrestrial" }
Earth    Planet & { Name "earth",   PlanetKind "terrestrial" }
Mars     Planet & { Name "mars",    PlanetKind "terrestrial" }
Jupiter  Planet & { Name "jupiter", PlanetKind "gas-giant" }
Saturn   Planet & { Name "saturn",  PlanetKind "gas-giant" }
Uranus   Planet & { Name "uranus",  PlanetKind "ice-giant" }
Neptune  Planet & { Name "neptune", PlanetKind "ice-giant" }
Pluto    Planet & { Name "pluto",   PlanetKind "dwarf" }

Moon CelestialBody & Orbiting
Luna     Moon & { Name "moon" }
Phobos   Moon & { Name "phobos" }
Deimos   Moon & { Name "deimos" }
Io       Moon & { Name "io" }
Europa   Moon & { Name "europa" }
Ganymede Moon & { Name "ganymede" }
Callisto Moon & { Name "callisto" }
Titan    Moon & { Name "titan" }
Enceladus Moon & { Name "enceladus" }
Triton   Moon & { Name "triton" }

Asteroid CelestialBody & Orbiting
Comet    CelestialBody & Orbiting & { Tail Length }
Meteor   CelestialBody & { Entering Planet }
Meteorite CelestialBody & { LandedOn Planet }

PlanetarySystem { Star, Planets List(Planet) }
SolarSystem PlanetarySystem & { Star Sun }

MoonPhase "new" | "waxing-crescent" | "first-quarter" | "waxing-gibbous"
    | "full" | "waning-gibbous" | "last-quarter" | "waning-crescent"
Eclipse { EclipseKind "solar" | "lunar", At Instant, Totality Fraction }

// =============================================================================
// Earth systems
// =============================================================================

Hemisphere "northern" | "southern" | "eastern" | "western"
Season "spring" | "summer" | "autumn" | "winter" | "wet" | "dry"

ClimateZone "tropical" | "arid" | "temperate" | "continental" | "polar" | "alpine" | "mediterranean"
Biome "tundra" | "taiga" | "temperate-forest" | "rainforest" | "savanna" | "grassland"
    | "desert" | "wetland" | "mangrove" | "coral-reef" | "ocean" | "freshwater" | "alpine"

Precipitation Measure(Real & NonNegative, Metre)
Humidity      Percent
WindSpeed     Velocity
CloudCover    Percent

Climate {
    ClimateZone
    Biome
    AverageTemperature Temperature
    AnnualPrecipitation Precipitation
}

WeatherCondition "clear" | "cloudy" | "overcast" | "fog" | "rain" | "drizzle" | "snow" | "sleet"
    | "hail" | "thunderstorm" | "wind" | "tornado" | "hurricane" | "blizzard" | "heatwave" | "sandstorm"

Weather {
    WeatherCondition
    Temperature
    Humidity
    Pressure
    WindSpeed
    WindDirection CompassDirection
    Precipitation
    CloudCover
    At Instant
    GeoCoordinate
}

NaturalDisaster "earthquake" | "tsunami" | "volcanic-eruption" | "flood" | "drought" | "wildfire"
    | "landslide" | "avalanche" | "hurricane" | "tornado"

Landform "mountain" | "hill" | "valley" | "plain" | "plateau" | "canyon" | "cave" | "island"
    | "peninsula" | "desert" | "glacier" | "volcano" | "beach" | "cliff"
WaterBody "ocean" | "sea" | "lake" | "river" | "stream" | "pond" | "bay" | "gulf" | "strait" | "lagoon"

Continent "africa" | "antarctica" | "asia" | "australia" | "europe" | "north-america" | "south-america"
Ocean "pacific" | "atlantic" | "indian" | "southern" | "arctic"

// =============================================================================
// Transitions
// =============================================================================

Revolve(B Orbiting, D Duration) [ B & { Position (Position . Translate(Velocity)) } ]
Ignite(C CelestialBody) [ Star & C & { StarStage "main-sequence" } ]
Expand(S Star & { StarStage "main-sequence" }) [ S & { StarStage "red-giant" } ]
Collapse(S Star) [
    Mass.Value . {
        [ _ > 6e31 ] [ BlackHole & S ]
        [ _ > 3e30 ] [ S & { StarStage "neutron-star" } ]
        _            [ S & { StarStage "white-dwarf" } ]
    }
]
Explode(S Star & { StarStage "supergiant" }) [ S & { StarStage "supernova" } ]
Impact(A Asteroid, P Planet) [ Meteorite { LandedOn P } & A ]
ChangeSeason(S Season) [
    S . {
        "spring" [ "summer" ]
        "summer" [ "autumn" ]
        "autumn" [ "winter" ]
        "winter" [ "spring" ]
    }
]
Forecast(W Weather, D Duration) [ Weather & W & { At (W.At . Elapse(D)) } ]
