#
Abstract Particle, Element, Atom, Molecule, Substance, Matter Phase, Material & Reaction
#

Spin Real

Particle {
    ParticleKind
    ParticleFamily
    Mass
    Charge
    Spin
}

ElementSymbol   String
AtomicNumber    Range(1, 118) & Int
PeriodIndex     Range(1, 7) & Int
GroupIndex      Range(1, 18) & Int

Element {
    Name
    ElementSymbol
    AtomicNumber
    ElementCategory
}

ProtonCount   Count
NeutronCount  Count
ElectronCount Count

Atom {
    Element
    ProtonCount
    NeutronCount
    ElectronCount
}
NeutralAtom Atom & [ _.ProtonCount == _.ElectronCount ]
Ion         Atom & [ _.ProtonCount != _.ElectronCount ]
Isotope     Atom & { HalfLife Duration }
Stable      Isotope & [ _.HalfLife == None ]
Radioactive Isotope & [ _.HalfLife != None ]

Formula   String
MolarMass Measure(Real & Positive, Kilogram)

Bond {
    BondKind
    From Atom
    To   Atom
}

Molecule {
    Formula
    Atoms List(Atom)
    Bonds List(Bond)
}

MeltingPoint Temperature
BoilingPoint Temperature
Acidity      Range(0, 14) & Real
Toxicity     "none" | "low" | "moderate" | "high" | "lethal"

Substance {
    Name
    Formula
    MolarMass
    Density
    MeltingPoint
    BoilingPoint
}

Phase "solid" | "liquid" | "gas" | "plasma"

Solid  { Substance, Temperature, Phase "solid" }
Liquid { Substance, Temperature, Phase "liquid" }
Gas    { Substance, Temperature, Phase "gas" }
Plasma { Substance, Temperature, Phase "plasma" }
Matter Solid | Liquid | Gas | Plasma

Mixture    { Components List(Substance), Proportions List(Fraction) }
Solution   Mixture & { Solvent Liquid, Solute Substance }
Alloy      Mixture & { Phase "solid" }
Suspension Mixture
Emulsion   Mixture

Hardness     Range(1, 10) & Real
Elasticity   Real & NonNegative
Conductivity "insulator" | "semiconductor" | "conductor" | "superconductor"
Transparency "opaque" | "translucent" | "transparent"

Material {
    Name
    MaterialKind
    Substance
    Hardness
    Elasticity
    Conductivity
    Transparency
}

PhysicalObject {
    Material
    Mass
    Volume
    Shape
    Position
    Temperature
}

Intact     { Integrity Fraction }
Fragmented { Pieces List(PhysicalObject) }

Reaction {
    Reactants List(Substance)
    Products  List(Substance)
    Released  Energy
}
Exothermic  Reaction & [ _.Released.Value > 0 ]
Endothermic Reaction & [ _.Released.Value < 0 ]
NoReaction  Object
