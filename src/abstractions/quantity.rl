_ primitive
_ primitive

#
Refinements
#

Positive    [ _ > 0 ]
NonNegative [ _ >= 0 ]
Negative    [ _ < 0 ]
Range(Min, Max) [ _ >= Min ] & [ _ <= Max ]

#
Scalars
#

Real     Double
Natural  Int & NonNegative
Count    Natural
Index    Natural
Percent  Range(0, 100) & Double
Fraction Range(0, 1) & Double
Ratio    { Numerator Real, Denominator Real & Positive }
Sign     "negative" | "zero" | "positive"

#
Labels
#

Name  String
Code  String
Label String

#
Units
#

Dimension "length" | "mass" | "time" | "current" | "temperature" | "amount" | "luminosity"
    | "area" | "volume" | "velocity" | "acceleration" | "force" | "energy" | "power"
    | "pressure" | "frequency" | "charge" | "voltage" | "resistance" | "angle"
    | "density" | "information" | "dimensionless"

UnitSymbol String
Prefix "yocto" | "zepto" | "atto" | "femto" | "pico" | "nano" | "micro" | "milli" | "centi" | "deci"
    | "none" | "deca" | "hecto" | "kilo" | "mega" | "giga" | "tera" | "peta" | "exa" | "zetta" | "yotta"

Unit {
    UnitSymbol
    Dimension
    Factor Real
}

// SI base units
Metre    Unit & { UnitSymbol "m",   Dimension "length",      Factor 1 }
Kilogram Unit & { UnitSymbol "kg",  Dimension "mass",        Factor 1 }
Second   Unit & { UnitSymbol "s",   Dimension "time",        Factor 1 }
Ampere   Unit & { UnitSymbol "A",   Dimension "current",     Factor 1 }
Kelvin   Unit & { UnitSymbol "K",   Dimension "temperature", Factor 1 }
Mole     Unit & { UnitSymbol "mol", Dimension "amount",      Factor 1 }
Candela  Unit & { UnitSymbol "cd",  Dimension "luminosity",  Factor 1 }
SiBaseUnit Metre | Kilogram | Second | Ampere | Kelvin | Mole | Candela

// SI derived units
SquareMetre     Unit & { UnitSymbol "m2",    Dimension "area",         Factor 1 }
CubicMetre      Unit & { UnitSymbol "m3",    Dimension "volume",       Factor 1 }
Litre           Unit & { UnitSymbol "L",     Dimension "volume",       Factor 0.001 }
MetrePerSecond  Unit & { UnitSymbol "m/s",   Dimension "velocity",     Factor 1 }
MetrePerSecond2 Unit & { UnitSymbol "m/s2",  Dimension "acceleration", Factor 1 }
Newton          Unit & { UnitSymbol "N",     Dimension "force",        Factor 1 }
Joule           Unit & { UnitSymbol "J",     Dimension "energy",       Factor 1 }
Watt            Unit & { UnitSymbol "W",     Dimension "power",        Factor 1 }
Pascal          Unit & { UnitSymbol "Pa",    Dimension "pressure",     Factor 1 }
Hertz           Unit & { UnitSymbol "Hz",    Dimension "frequency",    Factor 1 }
Coulomb         Unit & { UnitSymbol "C",     Dimension "charge",       Factor 1 }
Volt            Unit & { UnitSymbol "V",     Dimension "voltage",      Factor 1 }
Ohm             Unit & { UnitSymbol "Ohm",   Dimension "resistance",   Factor 1 }
Radian          Unit & { UnitSymbol "rad",   Dimension "angle",        Factor 1 }
Degree          Unit & { UnitSymbol "deg",   Dimension "angle",        Factor 0.0174533 }
KilogramPerM3   Unit & { UnitSymbol "kg/m3", Dimension "density",      Factor 1 }
Bit             Unit & { UnitSymbol "bit",   Dimension "information",  Factor 1 }
Byte            Unit & { UnitSymbol "B",     Dimension "information",  Factor 8 }
One             Unit & { UnitSymbol "1",     Dimension "dimensionless", Factor 1 }
SiDerivedUnit SquareMetre | CubicMetre | Litre | MetrePerSecond | MetrePerSecond2 | Newton | Joule
    | Watt | Pascal | Hertz | Coulomb | Volt | Ohm | Radian | Degree | KilogramPerM3 | Bit | Byte | One

#
Measures
#

Measure(T, U) {
    Value T
    Unit  U
}

Length       Measure(Real, Metre)
Mass         Measure(Real & NonNegative, Kilogram)
Velocity     Measure(Real, MetrePerSecond)
Acceleration Measure(Real, MetrePerSecond2)
Pressure     Measure(Real & NonNegative, Pascal)
Frequency    Measure(Real & NonNegative, Hertz)
Charge       Measure(Real, Coulomb)
Voltage      Measure(Real, Volt)
Resistance   Measure(Real & NonNegative, Ohm)
Angle        Measure(Real, Radian)
Density      Measure(Real & Positive, KilogramPerM3)
DataSize     Measure(Natural, Byte)
AmountOfSubstance Measure(Real & NonNegative, Mole)

Tolerance { Lower Real, Upper Real }

#
Transitions
#

Convert(M Measure(Real, Unit), Target Unit) [
    Measure(Real, Unit) {
        Value (Value * Unit.Factor / Target.Factor)
        Unit  Target
    }
]

Scale(M Measure(Real, Unit), K Real) [
    M & { Value (Value * K) }
]

Increment(C Count) [ C + 1 ]
Decrement(C Count) [
    C . {
        0 [ 0 ]
        _ [ C - 1 ]
    }
]
