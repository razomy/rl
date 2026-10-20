#
Abstract Scalars, Labels, Dimensions, Units & Measures
#

Real     Double
Natural  Int & NonNegative
Count    Natural
Index    Natural
Percent  Range(0, 100) & Double
Fraction Range(0, 1) & Double
Ratio    { Numerator Real, Denominator Real & Positive }
Sign     "negative" | "zero" | "positive"

Name  String
Code  String
Label String

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

Measure(T, U) {
    Value T
    Unit  U
}

Tolerance { Lower Real, Upper Real }
