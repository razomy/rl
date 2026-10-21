#
Abstract Biological Taxon, Genetics, Cell, Organ, Organism, Ecosystem & Life Typestates
#

TaxonRank "domain" | "kingdom" | "phylum" | "class" | "order" | "family" | "genus" | "species" | "subspecies"
ScientificName String
CommonName     String

Taxon {
    TaxonRank
    ScientificName
    CommonName
    Parent Taxon | None
}

Domain  Taxon & { TaxonRank "domain" }
Kingdom Taxon & { TaxonRank "kingdom" }
Phylum  Taxon & { TaxonRank "phylum" }
Class   Taxon & { TaxonRank "class" }
Order   Taxon & { TaxonRank "order" }
Family  Taxon & { TaxonRank "family" }
Genus   Taxon & { TaxonRank "genus" }
Species Taxon & { TaxonRank "species" }

Dna     { Sequence List(Nucleotide) }
Rna     { Sequence List(Nucleotide) }
Gene    { Name, locus String, Dna }
Protein { Name, chain List(AminoAcid) }
Genome  { Genes List(Gene), chromosomes Count }

Cell {
    CellKind
    CellType
    Organelles List(Organelle)
    Genome
}

Tissue { TissueKind, cells List(Cell) }
Organ  { OrganKind, tissues List(Tissue) }

Body {
    Organs  List(Organ)
    Systems List(OrganSystem)
    Mass
    Height
}

Sex       "female" | "male" | "hermaphrodite" | "none"
Diet      "herbivore" | "carnivore" | "omnivore" | "detritivore" | "autotroph" | "parasite"
Habitat   Biome
Lifespan  Duration
Age       Range(0, 150) & Duration
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

Alive    { Since Instant }
Dead     { DeathDate Date, cause String }
Healthy  Object
Sick     { Disease String }
Pregnant { Since Instant, offspring List(Organism) }
Asleep   Object
Awake    Object
Hungry   Object
Fed      Object

Population { Species, size Count, Habitat }
Ecosystem  { Biome, populations List(Population), Climate }
FoodChain  List(Species)
