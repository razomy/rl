#
Abstract Celestial Body, Orbit, Galaxy, Star, Planet, Climate & Weather
#

Redshift  Real
Magnitude Real

CelestialBody {
    Name
    Mass
    Radius
    Position
    Velocity Vector3D
    Composition List(Substance)
}

Orbit {
    Primary       CelestialBody
    SemiMajorAxis Length
    Eccentricity  Range(0, 1) & Real
    Inclination   Angle
    Period        Duration
}
Orbiting { Orbit }

Universe      { Age Duration, galaxies List(Galaxy) }
GalaxyCluster { Name, galaxies List(Galaxy) }

Galaxy CelestialBody & {
    GalaxyType
    Stars List(Star)
    Redshift
}

Star CelestialBody & {
    SpectralClass
    StarStage
    Luminosity
    Temperature
    Magnitude
}

BlackHole CelestialBody & { EventHorizon Radius }
Nebula    CelestialBody & { NebulaKind "emission" | "reflection" | "dark" | "planetary" }

Atmosphere { Composition List(Substance), Pressure }

Planet CelestialBody & Orbiting & {
    PlanetKind
    Atmosphere
    Moons List(Moon)
    RotationPeriod Duration
    AxialTilt Angle
}

Moon      CelestialBody & Orbiting
Asteroid  CelestialBody & Orbiting
Comet     CelestialBody & Orbiting & { Tail Length }
Meteor    CelestialBody & { Entering Planet }
Meteorite CelestialBody & { LandedOn Planet }

PlanetarySystem { Star, planets List(Planet) }
Eclipse         { EclipseKind "solar" | "lunar", at Instant, totality Fraction }

Precipitation Measure(Real & NonNegative, Metre)
Humidity      Percent
WindSpeed     Velocity
CloudCover    Percent

Climate {
    ClimateZone
    Biome
    AverageTemperature  Temperature
    AnnualPrecipitation Precipitation
}

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
