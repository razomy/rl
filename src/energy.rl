_ meta
_ primitives
_ structures
_ quantity
_ time
_ space

// =============================================================================
// Energy and power
// =============================================================================

Energy     Measure(Real, Joule)
Power      Measure(Real, Watt)
Work       Energy
ThermalEnergy Energy
Efficiency Fraction

EnergyForm "kinetic" | "potential" | "thermal" | "chemical" | "electrical" | "nuclear"
    | "radiant" | "sound" | "elastic" | "magnetic" | "gravitational"

EnergySource "solar" | "wind" | "hydro" | "geothermal" | "biomass" | "nuclear"
    | "coal" | "oil" | "natural-gas" | "tidal" | "muscle"
Renewable "solar" | "wind" | "hydro" | "geothermal" | "biomass" | "tidal"

EnergyStore {
    EnergyForm
    Stored   Energy
    Capacity Energy
}

// =============================================================================
// Forces
// =============================================================================

FundamentalForce "gravity" | "electromagnetism" | "strong-nuclear" | "weak-nuclear"
ForceMagnitude Measure(Real, Newton)

Force {
    FundamentalForce
    Magnitude ForceMagnitude
    Direction
}

Momentum { Mass, Velocity }
Gravity  Force & { FundamentalForce "gravity" }
Friction Force & { FundamentalForce "electromagnetism" }

// =============================================================================
// Temperature
// =============================================================================

Celsius    Unit & { UnitSymbol "C", Dimension "temperature", Factor 1 }
Fahrenheit Unit & { UnitSymbol "F", Dimension "temperature", Factor 0.5556 }

Temperature  Measure(Real, Kelvin) & [ _.Value >= 0 ]
AbsoluteZero Temperature & { Value 0 }
HeatCapacity Real & Positive

Thermal { Temperature, HeatCapacity }
Hot     Thermal & [ _.Temperature.Value > 323 ]
Cold    Thermal & [ _.Temperature.Value < 273 ]
Warm    Thermal & [ _.Temperature.Value >= 273 ] & [ _.Temperature.Value <= 323 ]

HeatTransfer "conduction" | "convection" | "radiation"

// =============================================================================
// Waves, light and sound
// =============================================================================

Wavelength Length
Amplitude  Real

Wave {
    Frequency
    Wavelength
    Amplitude
    Velocity
}

ElectromagneticBand "radio" | "microwave" | "infrared" | "visible" | "ultraviolet" | "xray" | "gamma"

Channel Range(0, 255) & Int
Rgb     { Red Channel, Green Channel, Blue Channel }
Hex     String
Color   "red" | "orange" | "yellow" | "green" | "cyan" | "blue" | "violet" | "purple" | "pink"
    | "brown" | "black" | "white" | "gray" | "gold" | "silver" | Rgb | Hex

Luminosity Measure(Real & NonNegative, Candela)

Light Wave & {
    ElectromagneticBand
    Color
    Luminosity
}

Decibel  Unit & { UnitSymbol "dB", Dimension "dimensionless", Factor 1 }
Loudness Measure(Real, Decibel)
Pitch    Frequency
Timbre   String

Sound Wave & {
    Loudness
    Pitch
    Timbre
}

Silence Sound & { Loudness { Value 0, Unit Decibel } }
Audible Sound & [ _.Pitch.Value >= 20 ] & [ _.Pitch.Value <= 20000 ]

// =============================================================================
// Fields and electricity
// =============================================================================

FieldKind "gravitational" | "electric" | "magnetic" | "electromagnetic" | "higgs"
Strength  Real

Field {
    FieldKind
    Strength
    Region Shape
}

Current Measure(Real, Ampere)

Circuit {
    Voltage
    Current
    Resistance
}

Powered   { Power }
Unpowered {}
Radiating { Emission Light }
Sounding  { Emission Sound }

// =============================================================================
// Transitions
// =============================================================================

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
    X / Powered & Unpowered {}
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
