#
Abstract Energy, Power, Force, thermal State, Wave, Light, Sound, Field & Circuit
#

Energy        Measure(Real, Joule)
Power         Measure(Real, Watt)
Work          Energy
ThermalEnergy Energy
Efficiency    Fraction

EnergyStore {
    EnergyForm
    Stored   Energy
    Capacity Energy
}

ForceMagnitude Measure(Real, Newton)

Force {
    FundamentalForce
    Magnitude ForceMagnitude
    Direction
}

Momentum { Mass, Velocity }

Temperature  Measure(Real, Kelvin) & [ _.Value >= 0 ]
AbsoluteZero Temperature & { Value 0 }
HeatCapacity Real & Positive

Thermal { Temperature, HeatCapacity }
Hot     Thermal & [ _.Temperature.Value > 323 ]
Cold    Thermal & [ _.Temperature.Value < 273 ]
Warm    Thermal & [ _.Temperature.Value >= 273 ] & [ _.Temperature.Value <= 323 ]

Wavelength Length
Amplitude  Real

Wave {
    Frequency
    Wavelength
    Amplitude
    Velocity
}

Luminosity Measure(Real & NonNegative, Candela)

Light Wave & {
    ElectromagneticBand
    Color
    Luminosity
}

Sound Wave & {
    Loudness
    Pitch
    Timbre
}

Strength Real

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
Unpowered Object
Radiating { Emission Light }
Sounding  { Emission Sound }
