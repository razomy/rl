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

Sublimate(S Solid)  [ Gas { Substance, Temperature } ]
Deposit(G Gas)      [ Solid { Substance, Temperature } ]
Ionize(G Gas)       [ Plasma { Substance, Temperature } ]
Recombine(P Plasma) [ Gas { Substance, Temperature } ]

React(Reactants List(Substance), Released Energy) [
    Reactants . {
        Nil [ NoReaction Object ]
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
