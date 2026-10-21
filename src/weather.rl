#
Earth Systems, Biomes, Continents, weather Conditions & Cosmic Transitions
#

Hemisphere  "northern" | "southern" | "eastern" | "western"
Season      "spring" | "summer" | "autumn" | "winter" | "wet" | "dry"
ClimateZone "tropical" | "arid" | "temperate" | "continental" | "polar" | "alpine" | "mediterranean"
Biome       "tundra" | "taiga" | "temperate-forest" | "rainforest" | "savanna" | "grassland"
    | "desert" | "wetland" | "mangrove" | "coral-reef" | "ocean" | "freshwater" | "alpine"

WeatherCondition "clear" | "cloudy" | "overcast" | "fog" | "rain" | "drizzle" | "snow" | "sleet"
    | "hail" | "thunderstorm" | "wind" | "tornado" | "hurricane" | "blizzard" | "heatwave" | "sandstorm"

NaturalDisaster "earthquake" | "tsunami" | "volcanic-eruption" | "flood" | "drought" | "wildfire"
    | "landslide" | "avalanche" | "hurricane" | "tornado"

Landform "mountain" | "hill" | "valley" | "plain" | "plateau" | "canyon" | "cave" | "island"
    | "peninsula" | "desert" | "glacier" | "volcano" | "beach" | "cliff"
WaterBody "ocean" | "sea" | "lake" | "river" | "stream" | "pond" | "bay" | "gulf" | "strait" | "lagoon"

Continent "africa" | "antarctica" | "asia" | "australia" | "europe" | "north-america" | "south-america"
Ocean     "pacific" | "atlantic" | "indian" | "southern" | "arctic"

Revolve(b Orbiting, d Duration) [ b & { Position (Position . Translate(Velocity)) } ]
Ignite(c CelestialBody) [ Star & C & { StarStage "main-sequence" } ]
Expand(s Star & { StarStage "main-sequence" }) [ s & { StarStage "red-giant" } ]
Collapse(s Star) [
    Mass.Value . {
        [ _ > 6e31 ] [ BlackHole & S ]
        [ _ > 3e30 ] [ s & { StarStage "neutron-star" } ]
        _            [ s & { StarStage "white-dwarf" } ]
    }
]
Explode(s Star & { StarStage "supergiant" }) [ s & { StarStage "supernova" } ]
Impact(a Asteroid, p Planet) [ Meteorite { LandedOn P } & A ]
ChangeSeason(s Season) [
    S . {
        "spring" [ "summer" ]
        "summer" [ "autumn" ]
        "autumn" [ "winter" ]
        "winter" [ "spring" ]
    }
]
Forecast(w Weather, d Duration) [ Weather & W & { At (W.At . Elapse(D)) } ]
