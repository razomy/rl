#
Earth Systems, Biomes, Continents, Weather Conditions & Cosmic Transitions
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
