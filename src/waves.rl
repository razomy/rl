#
Concrete Energy Forms, Forces, Colors, Sound & Transitions
#

EnergyForm "kinetic" | "potential" | "thermal" | "chemical" | "electrical" | "nuclear"
    | "radiant" | "sound" | "elastic" | "magnetic" | "gravitational"

EnergySource "solar" | "wind" | "hydro" | "geothermal" | "biomass" | "nuclear"
    | "coal" | "oil" | "natural-gas" | "tidal" | "muscle"
Renewable "solar" | "wind" | "hydro" | "geothermal" | "biomass" | "tidal"

FundamentalForce "gravity" | "electromagnetism" | "strong-nuclear" | "weak-nuclear"
Gravity          Force & { FundamentalForce "gravity" }
Friction         Force & { FundamentalForce "electromagnetism" }

Celsius    Unit & { UnitSymbol "C", Dimension "temperature", Factor 1 }
Fahrenheit Unit & { UnitSymbol "F", Dimension "temperature", Factor 0.5556 }

HeatTransfer "conduction" | "convection" | "radiation"

ElectromagneticBand "radio" | "microwave" | "infrared" | "visible" | "ultraviolet" | "xray" | "gamma"

Channel Range(0, 255) & Int
Rgb     { Red Channel, Green Channel, Blue Channel }
Hex     String
Color   "red" | "orange" | "yellow" | "green" | "cyan" | "blue" | "violet" | "purple" | "pink"
    | "brown" | "black" | "white" | "gray" | "gold" | "silver" | Rgb | Hex

Decibel  Unit & { UnitSymbol "dB", Dimension "dimensionless", Factor 1 }
Loudness Measure(Real, Decibel)
Pitch    Frequency
Timbre   String

Silence Sound & { Loudness { Value 0, Unit Decibel } }
Audible Sound & [ _.Pitch.Value >= 20 ] & [ _.Pitch.Value <= 20000 ]

FieldKind "gravitational" | "electric" | "magnetic" | "electromagnetic" | "higgs"

Heat(B Thermal, E Energy) [
    B & Thermal { Temperature { Value (Temperature.Value + E.Value / HeatCapacity), Unit Kelvin } }
]

Cool(B Thermal, E Energy) [
    B & Thermal { Temperature { Value (Temperature.Value - E.Value / HeatCapacity), Unit Kelvin } }
]

Emit(Source Any & Hot, L Light) [
    Source & Radiating { Emission L }
]

Absorb(B Thermal, L Light) [
    B . Heat(Energy { Value L.Amplitude, Unit Joule })
]

Resonate(Source Any, S Sound) [
    Source & Sounding { Emission S }
]

SwitchOn(X Unpowered, P Power) [
    X / Unpowered & Powered { Power P }
]

SwitchOff(X Powered) [
    X / Powered & Unpowered Object
]

Recharge(S EnergyStore, E Energy) [
    S & EnergyStore { Stored { Value (Stored.Value + E.Value), Unit Joule } }
    . {
        [ _.Stored.Value > _.Capacity.Value ] [ S & EnergyStore { Stored Capacity } ]
        _                                     [ _ ]
    }
]

Discharge(S EnergyStore, E Energy) [
    S & EnergyStore { Stored { Value (Stored.Value - E.Value), Unit Joule } }
]
