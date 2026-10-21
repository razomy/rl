#
Concrete Molecular Biology, Organs, Organisms & Biological Transitions
#

Nucleotide "A" | "C" | "G" | "T" | "U"
AminoAcid "Ala" | "Arg" | "Asn" | "Asp" | "Cys" | "Gln" | "Glu" | "Gly" | "His" | "Ile"
    | "Leu" | "Lys" | "Met" | "Phe" | "Pro" | "Ser" | "Thr" | "Trp" | "Tyr" | "Val"

CellKind  "prokaryotic" | "eukaryotic"
Organelle "nucleus" | "mitochondrion" | "ribosome" | "chloroplast" | "golgi" | "endoplasmic-reticulum"
    | "lysosome" | "vacuole" | "membrane" | "cell-wall" | "cytoplasm"
CellType  "neuron" | "muscle" | "epithelial" | "blood-red" | "blood-white" | "stem" | "bone"
    | "fat" | "skin" | "sperm" | "egg" | "plant" | "bacterial"

TissueKind "epithelial" | "connective" | "muscle" | "nervous" | "xylem" | "phloem"

OrganKind "brain" | "heart" | "lung" | "liver" | "kidney" | "stomach" | "intestine" | "skin"
    | "eye" | "ear" | "nose" | "tongue" | "bone" | "muscle" | "pancreas" | "spleen" | "bladder"
    | "root" | "stem" | "leaf" | "flower" | "fruit" | "seed"

OrganSystem "nervous" | "circulatory" | "respiratory" | "digestive" | "excretory" | "endocrine"
    | "immune" | "musculoskeletal" | "reproductive" | "integumentary" | "lymphatic"

Microorganism Organism & { Body { Organs Nil } }
Virus         { Name, Genome, host Species }
Bacterium     Organism & { Species & { Parent Bacteria } }
Plant         Organism & { Diet "autotroph" }
Fungus        Organism
Animal        Organism
Mammal        Animal
Bird          Animal
Reptile       Animal
Amphibian     Animal
Fish          Animal
Insect        Animal
Human         Mammal & { Species HomoSapiens }

Born(o Organism) [ o & Alive { Since Now } & { LifeStage "infant", birthDate Today } ]
Germinate(s Plant & { LifeStage "seed" }) [ s & Alive { Since Now } & { LifeStage "juvenile" } ]

Grow(o Organism & Alive) [
    LifeStage . {
        "embryo"     [ o & { LifeStage "infant" } ]
        "infant"     [ o & { LifeStage "juvenile" } ]
        "juvenile"   [ o & { LifeStage "adolescent" } ]
        "adolescent" [ o & { LifeStage "adult" } ]
        "adult"      [ o & { LifeStage "elder" } ]
        _            [ O ]
    }
]

Metamorphose(l Insect & { LifeStage "larva" }) [ l & { LifeStage "pupa" } ]
Emerge(p Insect & { LifeStage "pupa" }) [ p & { LifeStage "adult" } ]

Conceive(mother Organism & Alive & { Sex "female" }, father Organism & Alive & { Sex "male" }) [
    Mother & Pregnant { Since Now, offspring List1(Organism { Species Mother.Species, LifeStage "embryo" }) }
]
GiveBirth(p Pregnant) [ P / Pregnant ]
Reproduce(a Organism & Alive, b Organism & Alive) [
    A.Species . {
        B.Species [ Organism { Species A.Species, LifeStage "embryo" } ]
        _         [ None ]
    }
]
Divide(c Cell) [ List2(C, C) ]
Mutate(g Gene) [ g & { Dna Dna } ]

Eat(h Organism & Hungry, food Organism) [ H / Hungry & Fed Object ]
Starve(f Organism & Fed) [ F / Fed & Hungry Object ]
Sleep(a Organism & Awake) [ A / Awake & Asleep Object ]
Wake(a Organism & Asleep) [ A / Asleep & Awake Object ]
FallIll(h Organism & Healthy, disease String) [ H / Healthy & Sick { Disease } ]
Recover(s Organism & Sick) [ S / Sick & Healthy Object ]
Die(o Organism & Alive, cause String) [ O / Alive & Dead { DeathDate Today, Cause } ]
Evolve(s Species) [ Species { Parent S } ]
Extinct(p Population) [ p & { Size 0 } ]
