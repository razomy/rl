#
Concrete Substances, Materials & Phase Transitions
#

BondKind "covalent" | "ionic" | "metallic" | "hydrogen" | "van-der-waals"

Water          Substance & { Name "water",          Formula "H2O" }
CarbonDioxide  Substance & { Name "carbon dioxide", Formula "CO2" }
Methane        Substance & { Name "methane",        Formula "CH4" }
Ammonia        Substance & { Name "ammonia",        Formula "NH3" }
SodiumChloride Substance & { Name "salt",           Formula "NaCl" }
Glucose        Substance & { Name "glucose",        Formula "C6H12O6" }
Ethanol        Substance & { Name "ethanol",        Formula "C2H5OH" }
Ozone          Substance & { Name "ozone",          Formula "O3" }
Silica         Substance & { Name "silica",         Formula "SiO2" }

MaterialKind "metal" | "wood" | "stone" | "glass" | "plastic" | "ceramic" | "fabric" | "paper"
    | "rubber" | "composite" | "concrete" | "leather" | "bone" | "clay" | "sand" | "soil"

Steel    Material & { Name "steel",    MaterialKind "metal" }
Wood     Material & { Name "wood",     MaterialKind "wood" }
Glass    Material & { Name "glass",    MaterialKind "glass", Transparency "transparent" }
Plastic  Material & { Name "plastic",  MaterialKind "plastic" }
Concrete Material & { Name "concrete", MaterialKind "concrete" }
Cotton   Material & { Name "cotton",   MaterialKind "fabric" }

Melt(s Solid) [
    Temperature.Value . {
        [ _ >= Substance.MeltingPoint.Value ] [ Liquid { Substance, Temperature } ]
        _                                     [ S ]
    }
]

Freeze(l Liquid) [
    Temperature.Value . {
        [ _ < Substance.MeltingPoint.Value ] [ Solid { Substance, Temperature } ]
        _                                    [ L ]
    }
]

Boil(l Liquid) [
    Temperature.Value . {
        [ _ >= Substance.BoilingPoint.Value ] [ Gas { Substance, Temperature } ]
        _                                     [ L ]
    }
]

Condense(g Gas) [
    Temperature.Value . {
        [ _ < Substance.BoilingPoint.Value ] [ Liquid { Substance, Temperature } ]
        _                                    [ G ]
    }
]

Sublimate(s Solid)  [ Gas { Substance, Temperature } ]
Deposit(g Gas)      [ Solid { Substance, Temperature } ]
Ionize(g Gas)       [ Plasma { Substance, Temperature } ]
Recombine(p Plasma) [ Gas { Substance, Temperature } ]

React(reactants List(Substance), released Energy) [
    Reactants . {
        Nil [ NoReaction Object ]
        _   [ Reaction { Reactants, products List(Substance), Released } ]
    }
]

Dissolve(s Substance, l Liquid) [
    Solution { Components List2(L.Substance, S), solvent L, solute S }
]

Decay(i Radioactive) [
    I & Atom { ProtonCount (ProtonCount - 2), NeutronCount (NeutronCount - 2) }
]

Shatter(o PhysicalObject & Intact) [
    O / Intact & Fragmented { Pieces List(PhysicalObject) }
]
