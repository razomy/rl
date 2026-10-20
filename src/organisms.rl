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
Virus         { Name, Genome, Host Species }
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

Born(O Organism) [ O & Alive { Since Now } & { LifeStage "infant", BirthDate Today } ]
Germinate(S Plant & { LifeStage "seed" }) [ S & Alive { Since Now } & { LifeStage "juvenile" } ]

Grow(O Organism & Alive) [
    LifeStage . {
        "embryo"     [ O & { LifeStage "infant" } ]
        "infant"     [ O & { LifeStage "juvenile" } ]
        "juvenile"   [ O & { LifeStage "adolescent" } ]
        "adolescent" [ O & { LifeStage "adult" } ]
        "adult"      [ O & { LifeStage "elder" } ]
        _            [ O ]
    }
]

Metamorphose(L Insect & { LifeStage "larva" }) [ L & { LifeStage "pupa" } ]
Emerge(P Insect & { LifeStage "pupa" }) [ P & { LifeStage "adult" } ]

Conceive(Mother Organism & Alive & { Sex "female" }, Father Organism & Alive & { Sex "male" }) [
    Mother & Pregnant { Since Now, Offspring List1(Organism { Species Mother.Species, LifeStage "embryo" }) }
]
GiveBirth(P Pregnant) [ P / Pregnant ]
Reproduce(A Organism & Alive, B Organism & Alive) [
    A.Species . {
        B.Species [ Organism { Species A.Species, LifeStage "embryo" } ]
        _         [ None ]
    }
]
Divide(C Cell) [ List2(C, C) ]
Mutate(G Gene) [ G & { Dna Dna } ]

Eat(H Organism & Hungry, Food Organism) [ H / Hungry & Fed Object ]
Starve(F Organism & Fed) [ F / Fed & Hungry Object ]
Sleep(A Organism & Awake) [ A / Awake & Asleep Object ]
Wake(A Organism & Asleep) [ A / Asleep & Awake Object ]
FallIll(H Organism & Healthy, Disease String) [ H / Healthy & Sick { Disease } ]
Recover(S Organism & Sick) [ S / Sick & Healthy Object ]
Die(O Organism & Alive, Cause String) [ O / Alive & Dead { DeathDate Today, Cause } ]
Evolve(S Species) [ Species { Parent S } ]
Extinct(P Population) [ P & { Size 0 } ]
