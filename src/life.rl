_ primitive
_ primitive
_ structure
_ quantity
_ time
_ space
_ energy
_ matter
_ cosmos

// =============================================================================
// Taxonomy
// =============================================================================

TaxonRank "domain" | "kingdom" | "phylum" | "class" | "order" | "family" | "genus" | "species" | "subspecies"
ScientificName String
CommonName     String

Taxon {
    TaxonRank
    ScientificName
    CommonName
    Parent Taxon | None
}

Domain   Taxon & { TaxonRank "domain" }
Kingdom  Taxon & { TaxonRank "kingdom" }
Phylum   Taxon & { TaxonRank "phylum" }
Class    Taxon & { TaxonRank "class" }
Order    Taxon & { TaxonRank "order" }
Family   Taxon & { TaxonRank "family" }
Genus    Taxon & { TaxonRank "genus" }
Species  Taxon & { TaxonRank "species" }

Bacteria  Domain & { ScientificName "Bacteria" }
Archaea   Domain & { ScientificName "Archaea" }
Eukaryota Domain & { ScientificName "Eukaryota" }

Animalia Kingdom & { ScientificName "Animalia", Parent Eukaryota }
Plantae  Kingdom & { ScientificName "Plantae",  Parent Eukaryota }
Fungi    Kingdom & { ScientificName "Fungi",    Parent Eukaryota }
Protista Kingdom & { ScientificName "Protista", Parent Eukaryota }
Chromista Kingdom & { ScientificName "Chromista", Parent Eukaryota }

Chordata     Phylum & { ScientificName "Chordata",     Parent Animalia }
Arthropoda   Phylum & { ScientificName "Arthropoda",   Parent Animalia }
Mollusca     Phylum & { ScientificName "Mollusca",     Parent Animalia }
Annelida     Phylum & { ScientificName "Annelida",     Parent Animalia }
Cnidaria     Phylum & { ScientificName "Cnidaria",     Parent Animalia }
Echinodermata Phylum & { ScientificName "Echinodermata", Parent Animalia }
Porifera     Phylum & { ScientificName "Porifera",     Parent Animalia }
Nematoda     Phylum & { ScientificName "Nematoda",     Parent Animalia }
Tracheophyta Phylum & { ScientificName "Tracheophyta", Parent Plantae }
Bryophyta    Phylum & { ScientificName "Bryophyta",    Parent Plantae }
Basidiomycota Phylum & { ScientificName "Basidiomycota", Parent Fungi }
Ascomycota   Phylum & { ScientificName "Ascomycota",   Parent Fungi }

Mammalia       Class & { ScientificName "Mammalia",       CommonName "mammals",    Parent Chordata }
Aves           Class & { ScientificName "Aves",           CommonName "birds",      Parent Chordata }
Reptilia       Class & { ScientificName "Reptilia",       CommonName "reptiles",   Parent Chordata }
Amphibia       Class & { ScientificName "Amphibia",       CommonName "amphibians", Parent Chordata }
Actinopterygii Class & { ScientificName "Actinopterygii", CommonName "ray-finned fish", Parent Chordata }
Chondrichthyes Class & { ScientificName "Chondrichthyes", CommonName "cartilaginous fish", Parent Chordata }
Insecta        Class & { ScientificName "Insecta",        CommonName "insects",    Parent Arthropoda }
Arachnida      Class & { ScientificName "Arachnida",      CommonName "arachnids",  Parent Arthropoda }
Crustacea      Class & { ScientificName "Crustacea",      CommonName "crustaceans", Parent Arthropoda }
Gastropoda     Class & { ScientificName "Gastropoda",     CommonName "snails",     Parent Mollusca }
Cephalopoda    Class & { ScientificName "Cephalopoda",    CommonName "cephalopods", Parent Mollusca }
Magnoliopsida  Class & { ScientificName "Magnoliopsida",  CommonName "dicots",     Parent Tracheophyta }
Liliopsida     Class & { ScientificName "Liliopsida",     CommonName "monocots",   Parent Tracheophyta }
Pinopsida      Class & { ScientificName "Pinopsida",      CommonName "conifers",   Parent Tracheophyta }

Primates     Order & { ScientificName "Primates",     Parent Mammalia }
Carnivora    Order & { ScientificName "Carnivora",    Parent Mammalia }
Rodentia     Order & { ScientificName "Rodentia",     Parent Mammalia }
Artiodactyla Order & { ScientificName "Artiodactyla", Parent Mammalia }
Perissodactyla Order & { ScientificName "Perissodactyla", Parent Mammalia }
Chiroptera   Order & { ScientificName "Chiroptera",   Parent Mammalia }
Cetacea      Order & { ScientificName "Cetacea",      Parent Mammalia }
Lagomorpha   Order & { ScientificName "Lagomorpha",   Parent Mammalia }
Proboscidea  Order & { ScientificName "Proboscidea",  Parent Mammalia }
Passeriformes Order & { ScientificName "Passeriformes", Parent Aves }
Galliformes  Order & { ScientificName "Galliformes",  Parent Aves }
Accipitriformes Order & { ScientificName "Accipitriformes", Parent Aves }
Squamata     Order & { ScientificName "Squamata",     Parent Reptilia }
Testudines   Order & { ScientificName "Testudines",   Parent Reptilia }
Crocodilia   Order & { ScientificName "Crocodilia",   Parent Reptilia }
Anura        Order & { ScientificName "Anura",        Parent Amphibia }
Coleoptera   Order & { ScientificName "Coleoptera",   Parent Insecta }
Lepidoptera  Order & { ScientificName "Lepidoptera",  Parent Insecta }
Hymenoptera  Order & { ScientificName "Hymenoptera",  Parent Insecta }
Diptera      Order & { ScientificName "Diptera",      Parent Insecta }
Araneae      Order & { ScientificName "Araneae",      Parent Arachnida }
Rosales      Order & { ScientificName "Rosales",      Parent Magnoliopsida }
Poales       Order & { ScientificName "Poales",       Parent Liliopsida }
Fagales      Order & { ScientificName "Fagales",      Parent Magnoliopsida }

Hominidae Family & { ScientificName "Hominidae", Parent Primates }
Canidae   Family & { ScientificName "Canidae",   Parent Carnivora }
Felidae   Family & { ScientificName "Felidae",   Parent Carnivora }
Ursidae   Family & { ScientificName "Ursidae",   Parent Carnivora }
Bovidae   Family & { ScientificName "Bovidae",   Parent Artiodactyla }
Suidae    Family & { ScientificName "Suidae",    Parent Artiodactyla }
Cervidae  Family & { ScientificName "Cervidae",  Parent Artiodactyla }
Equidae   Family & { ScientificName "Equidae",   Parent Perissodactyla }
Muridae   Family & { ScientificName "Muridae",   Parent Rodentia }
Leporidae Family & { ScientificName "Leporidae", Parent Lagomorpha }
Elephantidae Family & { ScientificName "Elephantidae", Parent Proboscidea }
Phasianidae Family & { ScientificName "Phasianidae", Parent Galliformes }
Apidae    Family & { ScientificName "Apidae",    Parent Hymenoptera }
Rosaceae  Family & { ScientificName "Rosaceae",  Parent Rosales }
Poaceae   Family & { ScientificName "Poaceae",   Parent Poales }
Fagaceae  Family & { ScientificName "Fagaceae",  Parent Fagales }

Homo     Genus & { ScientificName "Homo",     Parent Hominidae }
Canis    Genus & { ScientificName "Canis",    Parent Canidae }
Felis    Genus & { ScientificName "Felis",    Parent Felidae }
Panthera Genus & { ScientificName "Panthera", Parent Felidae }
Ursus    Genus & { ScientificName "Ursus",    Parent Ursidae }
Bos      Genus & { ScientificName "Bos",      Parent Bovidae }
Ovis     Genus & { ScientificName "Ovis",     Parent Bovidae }
Capra    Genus & { ScientificName "Capra",    Parent Bovidae }
Sus      Genus & { ScientificName "Sus",      Parent Suidae }
Equus    Genus & { ScientificName "Equus",    Parent Equidae }
Mus      Genus & { ScientificName "Mus",      Parent Muridae }
Gallus   Genus & { ScientificName "Gallus",   Parent Phasianidae }
Apis     Genus & { ScientificName "Apis",     Parent Apidae }
Malus    Genus & { ScientificName "Malus",    Parent Rosaceae }
Triticum Genus & { ScientificName "Triticum", Parent Poaceae }
Oryza    Genus & { ScientificName "Oryza",    Parent Poaceae }
Zea      Genus & { ScientificName "Zea",      Parent Poaceae }
Quercus  Genus & { ScientificName "Quercus",  Parent Fagaceae }

HomoSapiens   Species & { ScientificName "Homo sapiens",       CommonName "human",   Parent Homo }
CanisLupus    Species & { ScientificName "Canis lupus",        CommonName "wolf",    Parent Canis }
CanisFamiliaris Species & { ScientificName "Canis familiaris", CommonName "dog",     Parent Canis }
FelisCatus    Species & { ScientificName "Felis catus",        CommonName "cat",     Parent Felis }
PantheraLeo   Species & { ScientificName "Panthera leo",       CommonName "lion",    Parent Panthera }
PantheraTigris Species & { ScientificName "Panthera tigris",   CommonName "tiger",   Parent Panthera }
UrsusArctos   Species & { ScientificName "Ursus arctos",       CommonName "brown bear", Parent Ursus }
BosTaurus     Species & { ScientificName "Bos taurus",         CommonName "cattle",  Parent Bos }
OvisAries     Species & { ScientificName "Ovis aries",         CommonName "sheep",   Parent Ovis }
CapraHircus   Species & { ScientificName "Capra hircus",       CommonName "goat",    Parent Capra }
SusScrofa     Species & { ScientificName "Sus scrofa",         CommonName "pig",     Parent Sus }
EquusCaballus Species & { ScientificName "Equus caballus",     CommonName "horse",   Parent Equus }
MusMusculus   Species & { ScientificName "Mus musculus",       CommonName "mouse",   Parent Mus }
GallusGallus  Species & { ScientificName "Gallus gallus",      CommonName "chicken", Parent Gallus }
ApisMellifera Species & { ScientificName "Apis mellifera",     CommonName "honey bee", Parent Apis }
MalusDomestica Species & { ScientificName "Malus domestica",   CommonName "apple",   Parent Malus }
TriticumAestivum Species & { ScientificName "Triticum aestivum", CommonName "wheat", Parent Triticum }
OryzaSativa   Species & { ScientificName "Oryza sativa",       CommonName "rice",    Parent Oryza }
ZeaMays       Species & { ScientificName "Zea mays",           CommonName "maize",   Parent Zea }
QuercusRobur  Species & { ScientificName "Quercus robur",      CommonName "oak",     Parent Quercus }

ConservationStatus "least-concern" | "near-threatened" | "vulnerable" | "endangered"
    | "critically-endangered" | "extinct-in-the-wild" | "extinct"

// =============================================================================
// Biology building blocks
// =============================================================================

Nucleotide "A" | "C" | "G" | "T" | "U"
AminoAcid "Ala" | "Arg" | "Asn" | "Asp" | "Cys" | "Gln" | "Glu" | "Gly" | "His" | "Ile"
    | "Leu" | "Lys" | "Met" | "Phe" | "Pro" | "Ser" | "Thr" | "Trp" | "Tyr" | "Val"

Dna     { Sequence List(Nucleotide) }
Rna     { Sequence List(Nucleotide) }
Gene    { Name, Locus String, Dna }
Protein { Name, Chain List(AminoAcid) }
Genome  { Genes List(Gene), Chromosomes Count }

CellKind "prokaryotic" | "eukaryotic"
Organelle "nucleus" | "mitochondrion" | "ribosome" | "chloroplast" | "golgi" | "endoplasmic-reticulum"
    | "lysosome" | "vacuole" | "membrane" | "cell-wall" | "cytoplasm"
CellType "neuron" | "muscle" | "epithelial" | "blood-red" | "blood-white" | "stem" | "bone"
    | "fat" | "skin" | "sperm" | "egg" | "plant" | "bacterial"

Cell {
    CellKind
    CellType
    Organelles List(Organelle)
    Genome
}

TissueKind "epithelial" | "connective" | "muscle" | "nervous" | "xylem" | "phloem"
Tissue { TissueKind, Cells List(Cell) }

OrganKind "brain" | "heart" | "lung" | "liver" | "kidney" | "stomach" | "intestine" | "skin"
    | "eye" | "ear" | "nose" | "tongue" | "bone" | "muscle" | "pancreas" | "spleen" | "bladder"
    | "root" | "stem" | "leaf" | "flower" | "fruit" | "seed"
Organ { OrganKind, Tissues List(Tissue) }

OrganSystem "nervous" | "circulatory" | "respiratory" | "digestive" | "excretory" | "endocrine"
    | "immune" | "musculoskeletal" | "reproductive" | "integumentary" | "lymphatic"

Body {
    Organs List(Organ)
    Systems List(OrganSystem)
    Mass
    Height
}

// =============================================================================
// Organisms
// =============================================================================

Sex "female" | "male" | "hermaphrodite" | "none"
Diet "herbivore" | "carnivore" | "omnivore" | "detritivore" | "autotroph" | "parasite"
Habitat Biome
Lifespan Duration
Age Range(0, 150) & Duration

LifeStage "embryo" | "seed" | "larva" | "pupa" | "infant" | "juvenile" | "adolescent" | "adult" | "elder"

Organism {
    Species
    Body
    Genome
    Sex
    Diet
    Habitat
    LifeStage
    BirthDate Date
}

Microorganism Organism & { Body { Organs Nil } }
Virus     { Name, Genome, Host Species }
Bacterium Organism & { Species & { Parent Bacteria } }
Plant     Organism & { Diet "autotroph" }
Fungus    Organism
Animal    Organism
Mammal    Animal
Bird      Animal
Reptile   Animal
Amphibian Animal
Fish      Animal
Insect    Animal
Human     Mammal & { Species HomoSapiens }

Alive    { Since Instant }
Dead     { DeathDate Date, Cause String }
Healthy  {}
Sick     { Disease String }
Pregnant { Since Instant, Offspring List(Organism) }
Asleep   {}
Awake    {}
Hungry   {}
Fed      {}

Population { Species, Size Count, Habitat }
Ecosystem  { Biome, Populations List(Population), Climate }
FoodChain  List(Species)

// =============================================================================
// Transitions
// =============================================================================

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

Eat(H Organism & Hungry, Food Organism) [ H / Hungry & Fed {} ]
Starve(F Organism & Fed) [ F / Fed & Hungry {} ]
Sleep(A Organism & Awake) [ A / Awake & Asleep {} ]
Wake(A Organism & Asleep) [ A / Asleep & Awake {} ]
FallIll(H Organism & Healthy, Disease String) [ H / Healthy & Sick { Disease } ]
Recover(S Organism & Sick) [ S / Sick & Healthy {} ]
Die(O Organism & Alive, Cause String) [ O / Alive & Dead { DeathDate Today, Cause } ]
Evolve(S Species) [ Species { Parent S } ]
Extinct(P Population) [ P & { Size 0 } ]
