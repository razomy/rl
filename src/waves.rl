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
Rgb     { Red Channel, green Channel, blue Channel }
Hex     String
Color   "red" | "orange" | "yellow" | "green" | "cyan" | "blue" | "violet" | "purple" | "pink"
    | "brown" | "black" | "white" | "gray" | "gold" | "silver" | Rgb | Hex

Decibel  Unit & { UnitSymbol "dB", Dimension "dimensionless", Factor 1 }
Loudness Measure(Real, Decibel)
Pitch    Frequency
Timbre   String

Silence Sound & { Loudness { Value 0, unit Decibel } }
Audible Sound & [ _.Pitch.Value >= 20 ] & [ _.Pitch.Value <= 20000 ]

FieldKind "gravitational" | "electric" | "magnetic" | "electromagnetic" | "higgs"

Heat(b Thermal, e Energy) [
    B & Thermal { Temperature { Value (Temperature.Value + E.Value / HeatCapacity), unit Kelvin } }
]

Cool(b Thermal, e Energy) [
    B & Thermal { Temperature { Value (Temperature.Value - E.Value / HeatCapacity), unit Kelvin } }
]

Emit(source Any & Hot, l Light) [
    Source & Radiating { Emission L }
]

Absorb(b Thermal, l Light) [
    B . Heat(Energy { Value L.Amplitude, unit Joule })
]

Resonate(source Any, s Sound) [
    Source & Sounding { Emission S }
]

SwitchOn(x Unpowered, p Power) [
    X / Unpowered & Powered { Power P }
]

SwitchOff(x Powered) [
    X / Powered & Unpowered Object
]

Recharge(s EnergyStore, e Energy) [
    S & EnergyStore { Stored { Value (Stored.Value + E.Value), unit Joule } }
    . {
        [ _.Stored.Value > _.Capacity.Value ] [ s & EnergyStore { Stored Capacity } ]
        _                                     [ _ ]
    }
]

Discharge(s EnergyStore, e Energy) [
    S & EnergyStore { Stored { Value (Stored.Value - E.Value), unit Joule } }
]
