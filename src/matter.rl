_ meta
_ primitive
_ structure
_ quantity
_ time
_ space
_ energy

// =============================================================================
// Particles
// =============================================================================

Spin Real

ParticleFamily "quark" | "lepton" | "gauge-boson" | "scalar-boson" | "hadron"
ParticleKind "up" | "down" | "charm" | "strange" | "top" | "bottom"
    | "electron" | "muon" | "tau" | "electron-neutrino" | "muon-neutrino" | "tau-neutrino"
    | "photon" | "gluon" | "w-boson" | "z-boson" | "higgs-boson"
    | "proton" | "neutron"

Particle {
    ParticleKind
    ParticleFamily
    Mass
    Charge
    Spin
}

Electron Particle & { ParticleKind "electron", ParticleFamily "lepton" }
Proton   Particle & { ParticleKind "proton",   ParticleFamily "hadron" }
Neutron  Particle & { ParticleKind "neutron",  ParticleFamily "hadron" }
Photon   Particle & { ParticleKind "photon",   ParticleFamily "gauge-boson" }
AntiParticle(P Particle) Particle & { ParticleKind P.ParticleKind, Charge (0 - P.Charge.Value) }

// =============================================================================
// Elements
// =============================================================================

ElementSymbol String
AtomicNumber  Range(1, 118) & Int
ElementCategory "alkali-metal" | "alkaline-earth-metal" | "transition-metal" | "post-transition-metal"
    | "metalloid" | "nonmetal" | "halogen" | "noble-gas" | "lanthanide" | "actinide" | "unknown"
PeriodIndex Range(1, 7) & Int
GroupIndex  Range(1, 18) & Int

Element {
    Name
    ElementSymbol
    AtomicNumber
    ElementCategory
}

Hydrogen      Element & { Name "hydrogen",      ElementSymbol "H",  AtomicNumber 1,   ElementCategory "nonmetal" }
Helium        Element & { Name "helium",        ElementSymbol "He", AtomicNumber 2,   ElementCategory "noble-gas" }
Lithium       Element & { Name "lithium",       ElementSymbol "Li", AtomicNumber 3,   ElementCategory "alkali-metal" }
Beryllium     Element & { Name "beryllium",     ElementSymbol "Be", AtomicNumber 4,   ElementCategory "alkaline-earth-metal" }
Boron         Element & { Name "boron",         ElementSymbol "B",  AtomicNumber 5,   ElementCategory "metalloid" }
Carbon        Element & { Name "carbon",        ElementSymbol "C",  AtomicNumber 6,   ElementCategory "nonmetal" }
Nitrogen      Element & { Name "nitrogen",      ElementSymbol "N",  AtomicNumber 7,   ElementCategory "nonmetal" }
Oxygen        Element & { Name "oxygen",        ElementSymbol "O",  AtomicNumber 8,   ElementCategory "nonmetal" }
Fluorine      Element & { Name "fluorine",      ElementSymbol "F",  AtomicNumber 9,   ElementCategory "halogen" }
Neon          Element & { Name "neon",          ElementSymbol "Ne", AtomicNumber 10,  ElementCategory "noble-gas" }
Sodium        Element & { Name "sodium",        ElementSymbol "Na", AtomicNumber 11,  ElementCategory "alkali-metal" }
Magnesium     Element & { Name "magnesium",     ElementSymbol "Mg", AtomicNumber 12,  ElementCategory "alkaline-earth-metal" }
Aluminium     Element & { Name "aluminium",     ElementSymbol "Al", AtomicNumber 13,  ElementCategory "post-transition-metal" }
Silicon       Element & { Name "silicon",       ElementSymbol "Si", AtomicNumber 14,  ElementCategory "metalloid" }
Phosphorus    Element & { Name "phosphorus",    ElementSymbol "P",  AtomicNumber 15,  ElementCategory "nonmetal" }
Sulfur        Element & { Name "sulfur",        ElementSymbol "S",  AtomicNumber 16,  ElementCategory "nonmetal" }
Chlorine      Element & { Name "chlorine",      ElementSymbol "Cl", AtomicNumber 17,  ElementCategory "halogen" }
Argon         Element & { Name "argon",         ElementSymbol "Ar", AtomicNumber 18,  ElementCategory "noble-gas" }
Potassium     Element & { Name "potassium",     ElementSymbol "K",  AtomicNumber 19,  ElementCategory "alkali-metal" }
Calcium       Element & { Name "calcium",       ElementSymbol "Ca", AtomicNumber 20,  ElementCategory "alkaline-earth-metal" }
Scandium      Element & { Name "scandium",      ElementSymbol "Sc", AtomicNumber 21,  ElementCategory "transition-metal" }
Titanium      Element & { Name "titanium",      ElementSymbol "Ti", AtomicNumber 22,  ElementCategory "transition-metal" }
Vanadium      Element & { Name "vanadium",      ElementSymbol "V",  AtomicNumber 23,  ElementCategory "transition-metal" }
Chromium      Element & { Name "chromium",      ElementSymbol "Cr", AtomicNumber 24,  ElementCategory "transition-metal" }
Manganese     Element & { Name "manganese",     ElementSymbol "Mn", AtomicNumber 25,  ElementCategory "transition-metal" }
Iron          Element & { Name "iron",          ElementSymbol "Fe", AtomicNumber 26,  ElementCategory "transition-metal" }
Cobalt        Element & { Name "cobalt",        ElementSymbol "Co", AtomicNumber 27,  ElementCategory "transition-metal" }
Nickel        Element & { Name "nickel",        ElementSymbol "Ni", AtomicNumber 28,  ElementCategory "transition-metal" }
Copper        Element & { Name "copper",        ElementSymbol "Cu", AtomicNumber 29,  ElementCategory "transition-metal" }
Zinc          Element & { Name "zinc",          ElementSymbol "Zn", AtomicNumber 30,  ElementCategory "transition-metal" }
Gallium       Element & { Name "gallium",       ElementSymbol "Ga", AtomicNumber 31,  ElementCategory "post-transition-metal" }
Germanium     Element & { Name "germanium",     ElementSymbol "Ge", AtomicNumber 32,  ElementCategory "metalloid" }
Arsenic       Element & { Name "arsenic",       ElementSymbol "As", AtomicNumber 33,  ElementCategory "metalloid" }
Selenium      Element & { Name "selenium",      ElementSymbol "Se", AtomicNumber 34,  ElementCategory "nonmetal" }
Bromine       Element & { Name "bromine",       ElementSymbol "Br", AtomicNumber 35,  ElementCategory "halogen" }
Krypton       Element & { Name "krypton",       ElementSymbol "Kr", AtomicNumber 36,  ElementCategory "noble-gas" }
Rubidium      Element & { Name "rubidium",      ElementSymbol "Rb", AtomicNumber 37,  ElementCategory "alkali-metal" }
Strontium     Element & { Name "strontium",     ElementSymbol "Sr", AtomicNumber 38,  ElementCategory "alkaline-earth-metal" }
Yttrium       Element & { Name "yttrium",       ElementSymbol "Y",  AtomicNumber 39,  ElementCategory "transition-metal" }
Zirconium     Element & { Name "zirconium",     ElementSymbol "Zr", AtomicNumber 40,  ElementCategory "transition-metal" }
Niobium       Element & { Name "niobium",       ElementSymbol "Nb", AtomicNumber 41,  ElementCategory "transition-metal" }
Molybdenum    Element & { Name "molybdenum",    ElementSymbol "Mo", AtomicNumber 42,  ElementCategory "transition-metal" }
Technetium    Element & { Name "technetium",    ElementSymbol "Tc", AtomicNumber 43,  ElementCategory "transition-metal" }
Ruthenium     Element & { Name "ruthenium",     ElementSymbol "Ru", AtomicNumber 44,  ElementCategory "transition-metal" }
Rhodium       Element & { Name "rhodium",       ElementSymbol "Rh", AtomicNumber 45,  ElementCategory "transition-metal" }
Palladium     Element & { Name "palladium",     ElementSymbol "Pd", AtomicNumber 46,  ElementCategory "transition-metal" }
Silver        Element & { Name "silver",        ElementSymbol "Ag", AtomicNumber 47,  ElementCategory "transition-metal" }
Cadmium       Element & { Name "cadmium",       ElementSymbol "Cd", AtomicNumber 48,  ElementCategory "transition-metal" }
Indium        Element & { Name "indium",        ElementSymbol "In", AtomicNumber 49,  ElementCategory "post-transition-metal" }
Tin           Element & { Name "tin",           ElementSymbol "Sn", AtomicNumber 50,  ElementCategory "post-transition-metal" }
Antimony      Element & { Name "antimony",      ElementSymbol "Sb", AtomicNumber 51,  ElementCategory "metalloid" }
Tellurium     Element & { Name "tellurium",     ElementSymbol "Te", AtomicNumber 52,  ElementCategory "metalloid" }
Iodine        Element & { Name "iodine",        ElementSymbol "I",  AtomicNumber 53,  ElementCategory "halogen" }
Xenon         Element & { Name "xenon",         ElementSymbol "Xe", AtomicNumber 54,  ElementCategory "noble-gas" }
Caesium       Element & { Name "caesium",       ElementSymbol "Cs", AtomicNumber 55,  ElementCategory "alkali-metal" }
Barium        Element & { Name "barium",        ElementSymbol "Ba", AtomicNumber 56,  ElementCategory "alkaline-earth-metal" }
Lanthanum     Element & { Name "lanthanum",     ElementSymbol "La", AtomicNumber 57,  ElementCategory "lanthanide" }
Cerium        Element & { Name "cerium",        ElementSymbol "Ce", AtomicNumber 58,  ElementCategory "lanthanide" }
Praseodymium  Element & { Name "praseodymium",  ElementSymbol "Pr", AtomicNumber 59,  ElementCategory "lanthanide" }
Neodymium     Element & { Name "neodymium",     ElementSymbol "Nd", AtomicNumber 60,  ElementCategory "lanthanide" }
Promethium    Element & { Name "promethium",    ElementSymbol "Pm", AtomicNumber 61,  ElementCategory "lanthanide" }
Samarium      Element & { Name "samarium",      ElementSymbol "Sm", AtomicNumber 62,  ElementCategory "lanthanide" }
Europium      Element & { Name "europium",      ElementSymbol "Eu", AtomicNumber 63,  ElementCategory "lanthanide" }
Gadolinium    Element & { Name "gadolinium",    ElementSymbol "Gd", AtomicNumber 64,  ElementCategory "lanthanide" }
Terbium       Element & { Name "terbium",       ElementSymbol "Tb", AtomicNumber 65,  ElementCategory "lanthanide" }
Dysprosium    Element & { Name "dysprosium",    ElementSymbol "Dy", AtomicNumber 66,  ElementCategory "lanthanide" }
Holmium       Element & { Name "holmium",       ElementSymbol "Ho", AtomicNumber 67,  ElementCategory "lanthanide" }
Erbium        Element & { Name "erbium",        ElementSymbol "Er", AtomicNumber 68,  ElementCategory "lanthanide" }
Thulium       Element & { Name "thulium",       ElementSymbol "Tm", AtomicNumber 69,  ElementCategory "lanthanide" }
Ytterbium     Element & { Name "ytterbium",     ElementSymbol "Yb", AtomicNumber 70,  ElementCategory "lanthanide" }
Lutetium      Element & { Name "lutetium",      ElementSymbol "Lu", AtomicNumber 71,  ElementCategory "lanthanide" }
Hafnium       Element & { Name "hafnium",       ElementSymbol "Hf", AtomicNumber 72,  ElementCategory "transition-metal" }
Tantalum      Element & { Name "tantalum",      ElementSymbol "Ta", AtomicNumber 73,  ElementCategory "transition-metal" }
Tungsten      Element & { Name "tungsten",      ElementSymbol "W",  AtomicNumber 74,  ElementCategory "transition-metal" }
Rhenium       Element & { Name "rhenium",       ElementSymbol "Re", AtomicNumber 75,  ElementCategory "transition-metal" }
Osmium        Element & { Name "osmium",        ElementSymbol "Os", AtomicNumber 76,  ElementCategory "transition-metal" }
Iridium       Element & { Name "iridium",       ElementSymbol "Ir", AtomicNumber 77,  ElementCategory "transition-metal" }
Platinum      Element & { Name "platinum",      ElementSymbol "Pt", AtomicNumber 78,  ElementCategory "transition-metal" }
Gold          Element & { Name "gold",          ElementSymbol "Au", AtomicNumber 79,  ElementCategory "transition-metal" }
Mercury       Element & { Name "mercury",       ElementSymbol "Hg", AtomicNumber 80,  ElementCategory "transition-metal" }
Thallium      Element & { Name "thallium",      ElementSymbol "Tl", AtomicNumber 81,  ElementCategory "post-transition-metal" }
Lead          Element & { Name "lead",          ElementSymbol "Pb", AtomicNumber 82,  ElementCategory "post-transition-metal" }
Bismuth       Element & { Name "bismuth",       ElementSymbol "Bi", AtomicNumber 83,  ElementCategory "post-transition-metal" }
Polonium      Element & { Name "polonium",      ElementSymbol "Po", AtomicNumber 84,  ElementCategory "post-transition-metal" }
Astatine      Element & { Name "astatine",      ElementSymbol "At", AtomicNumber 85,  ElementCategory "halogen" }
Radon         Element & { Name "radon",         ElementSymbol "Rn", AtomicNumber 86,  ElementCategory "noble-gas" }
Francium      Element & { Name "francium",      ElementSymbol "Fr", AtomicNumber 87,  ElementCategory "alkali-metal" }
Radium        Element & { Name "radium",        ElementSymbol "Ra", AtomicNumber 88,  ElementCategory "alkaline-earth-metal" }
Actinium      Element & { Name "actinium",      ElementSymbol "Ac", AtomicNumber 89,  ElementCategory "actinide" }
Thorium       Element & { Name "thorium",       ElementSymbol "Th", AtomicNumber 90,  ElementCategory "actinide" }
Protactinium  Element & { Name "protactinium",  ElementSymbol "Pa", AtomicNumber 91,  ElementCategory "actinide" }
Uranium       Element & { Name "uranium",       ElementSymbol "U",  AtomicNumber 92,  ElementCategory "actinide" }
Neptunium     Element & { Name "neptunium",     ElementSymbol "Np", AtomicNumber 93,  ElementCategory "actinide" }
Plutonium     Element & { Name "plutonium",     ElementSymbol "Pu", AtomicNumber 94,  ElementCategory "actinide" }
Americium     Element & { Name "americium",     ElementSymbol "Am", AtomicNumber 95,  ElementCategory "actinide" }
Curium        Element & { Name "curium",        ElementSymbol "Cm", AtomicNumber 96,  ElementCategory "actinide" }
Berkelium     Element & { Name "berkelium",     ElementSymbol "Bk", AtomicNumber 97,  ElementCategory "actinide" }
Californium   Element & { Name "californium",   ElementSymbol "Cf", AtomicNumber 98,  ElementCategory "actinide" }
Einsteinium   Element & { Name "einsteinium",   ElementSymbol "Es", AtomicNumber 99,  ElementCategory "actinide" }
Fermium       Element & { Name "fermium",       ElementSymbol "Fm", AtomicNumber 100, ElementCategory "actinide" }
Mendelevium   Element & { Name "mendelevium",   ElementSymbol "Md", AtomicNumber 101, ElementCategory "actinide" }
Nobelium      Element & { Name "nobelium",      ElementSymbol "No", AtomicNumber 102, ElementCategory "actinide" }
Lawrencium    Element & { Name "lawrencium",    ElementSymbol "Lr", AtomicNumber 103, ElementCategory "actinide" }
Rutherfordium Element & { Name "rutherfordium", ElementSymbol "Rf", AtomicNumber 104, ElementCategory "transition-metal" }
Dubnium       Element & { Name "dubnium",       ElementSymbol "Db", AtomicNumber 105, ElementCategory "transition-metal" }
Seaborgium    Element & { Name "seaborgium",    ElementSymbol "Sg", AtomicNumber 106, ElementCategory "transition-metal" }
Bohrium       Element & { Name "bohrium",       ElementSymbol "Bh", AtomicNumber 107, ElementCategory "transition-metal" }
Hassium       Element & { Name "hassium",       ElementSymbol "Hs", AtomicNumber 108, ElementCategory "transition-metal" }
Meitnerium    Element & { Name "meitnerium",    ElementSymbol "Mt", AtomicNumber 109, ElementCategory "unknown" }
Darmstadtium  Element & { Name "darmstadtium",  ElementSymbol "Ds", AtomicNumber 110, ElementCategory "unknown" }
Roentgenium   Element & { Name "roentgenium",   ElementSymbol "Rg", AtomicNumber 111, ElementCategory "unknown" }
Copernicium   Element & { Name "copernicium",   ElementSymbol "Cn", AtomicNumber 112, ElementCategory "transition-metal" }
Nihonium      Element & { Name "nihonium",      ElementSymbol "Nh", AtomicNumber 113, ElementCategory "unknown" }
Flerovium     Element & { Name "flerovium",     ElementSymbol "Fl", AtomicNumber 114, ElementCategory "unknown" }
Moscovium     Element & { Name "moscovium",     ElementSymbol "Mc", AtomicNumber 115, ElementCategory "unknown" }
Livermorium   Element & { Name "livermorium",   ElementSymbol "Lv", AtomicNumber 116, ElementCategory "unknown" }
Tennessine    Element & { Name "tennessine",    ElementSymbol "Ts", AtomicNumber 117, ElementCategory "unknown" }
Oganesson     Element & { Name "oganesson",     ElementSymbol "Og", AtomicNumber 118, ElementCategory "unknown" }

// =============================================================================
// Atoms and molecules
// =============================================================================

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
BondKind  "covalent" | "ionic" | "metallic" | "hydrogen" | "van-der-waals"

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

// =============================================================================
// Substances and phases
// =============================================================================

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

Water         Substance & { Name "water",          Formula "H2O" }
CarbonDioxide Substance & { Name "carbon dioxide", Formula "CO2" }
Methane       Substance & { Name "methane",        Formula "CH4" }
Ammonia       Substance & { Name "ammonia",        Formula "NH3" }
SodiumChloride Substance & { Name "salt",          Formula "NaCl" }
Glucose       Substance & { Name "glucose",        Formula "C6H12O6" }
Ethanol       Substance & { Name "ethanol",        Formula "C2H5OH" }
Ozone         Substance & { Name "ozone",          Formula "O3" }
Silica        Substance & { Name "silica",         Formula "SiO2" }

Phase "solid" | "liquid" | "gas" | "plasma"

Solid  { Substance, Temperature, Phase "solid" }
Liquid { Substance, Temperature, Phase "liquid" }
Gas    { Substance, Temperature, Phase "gas" }
Plasma { Substance, Temperature, Phase "plasma" }
Matter Solid | Liquid | Gas | Plasma

Mixture  { Components List(Substance), Proportions List(Fraction) }
Solution Mixture & { Solvent Liquid, Solute Substance }
Alloy    Mixture & { Phase "solid" }
Suspension Mixture
Emulsion   Mixture

// =============================================================================
// Materials and bodies
// =============================================================================

MaterialKind "metal" | "wood" | "stone" | "glass" | "plastic" | "ceramic" | "fabric" | "paper"
    | "rubber" | "composite" | "concrete" | "leather" | "bone" | "clay" | "sand" | "soil"
Hardness   Range(1, 10) & Real
Elasticity Real & NonNegative
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

Steel    Material & { Name "steel",    MaterialKind "metal" }
Wood     Material & { Name "wood",     MaterialKind "wood" }
Glass    Material & { Name "glass",    MaterialKind "glass",    Transparency "transparent" }
Plastic  Material & { Name "plastic",  MaterialKind "plastic" }
Concrete Material & { Name "concrete", MaterialKind "concrete" }
Cotton   Material & { Name "cotton",   MaterialKind "fabric" }

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
Exothermic Reaction & [ _.Released.Value > 0 ]
Endothermic Reaction & [ _.Released.Value < 0 ]
NoReaction {}

// =============================================================================
// Transitions
// =============================================================================

Melt(S Solid) [
    Temperature.Value . {
        [ _ >= Substance.MeltingPoint.Value ] [ Liquid { Substance, Temperature } ]
        _                                     [ S ]
    }
]

Freeze(L Liquid) [
    Temperature.Value . {
        [ _ < Substance.MeltingPoint.Value ] [ Solid { Substance, Temperature } ]
        _                                    [ L ]
    }
]

Boil(L Liquid) [
    Temperature.Value . {
        [ _ >= Substance.BoilingPoint.Value ] [ Gas { Substance, Temperature } ]
        _                                     [ L ]
    }
]

Condense(G Gas) [
    Temperature.Value . {
        [ _ < Substance.BoilingPoint.Value ] [ Liquid { Substance, Temperature } ]
        _                                    [ G ]
    }
]

Sublimate(S Solid) [ Gas { Substance, Temperature } ]
Deposit(G Gas)     [ Solid { Substance, Temperature } ]
Ionize(G Gas)      [ Plasma { Substance, Temperature } ]
Recombine(P Plasma) [ Gas { Substance, Temperature } ]

React(Reactants List(Substance), Released Energy) [
    Reactants . {
        Nil [ NoReaction {} ]
        _   [ Reaction { Reactants, Products List(Substance), Released } ]
    }
]

Dissolve(S Substance, L Liquid) [
    Solution { Components List2(L.Substance, S), Solvent L, Solute S }
]

Decay(I Radioactive) [
    I & Atom { ProtonCount (ProtonCount - 2), NeutronCount (NeutronCount - 2) }
]

Shatter(O PhysicalObject & Intact) [
    O / Intact & Fragmented { Pieces List(PhysicalObject) }
]
