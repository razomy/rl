#
Concrete Biological Taxonomy (Domains to Species)
#

Bacteria  Domain & { ScientificName "Bacteria" }
Archaea   Domain & { ScientificName "Archaea" }
Eukaryota Domain & { ScientificName "Eukaryota" }

Animalia  Kingdom & { ScientificName "Animalia",  Parent Eukaryota }
Plantae   Kingdom & { ScientificName "Plantae",   Parent Eukaryota }
Fungi     Kingdom & { ScientificName "Fungi",     Parent Eukaryota }
Protista  Kingdom & { ScientificName "Protista",  Parent Eukaryota }
Chromista Kingdom & { ScientificName "Chromista", Parent Eukaryota }

Chordata      Phylum & { ScientificName "Chordata",      Parent Animalia }
Arthropoda    Phylum & { ScientificName "Arthropoda",    Parent Animalia }
Mollusca      Phylum & { ScientificName "Mollusca",      Parent Animalia }
Annelida      Phylum & { ScientificName "Annelida",      Parent Animalia }
Cnidaria      Phylum & { ScientificName "Cnidaria",      Parent Animalia }
Echinodermata Phylum & { ScientificName "Echinodermata", Parent Animalia }
Porifera      Phylum & { ScientificName "Porifera",      Parent Animalia }
Nematoda      Phylum & { ScientificName "Nematoda",      Parent Animalia }
Tracheophyta  Phylum & { ScientificName "Tracheophyta",  Parent Plantae }
Bryophyta     Phylum & { ScientificName "Bryophyta",     Parent Plantae }
Basidiomycota Phylum & { ScientificName "Basidiomycota", Parent Fungi }
Ascomycota    Phylum & { ScientificName "Ascomycota",    Parent Fungi }

Mammalia       Class & { ScientificName "Mammalia",       CommonName "mammals",            Parent Chordata }
Aves           Class & { ScientificName "Aves",           CommonName "birds",              Parent Chordata }
Reptilia       Class & { ScientificName "Reptilia",       CommonName "reptiles",           Parent Chordata }
Amphibia       Class & { ScientificName "Amphibia",       CommonName "amphibians",         Parent Chordata }
Actinopterygii Class & { ScientificName "Actinopterygii", CommonName "ray-finned fish",    Parent Chordata }
Chondrichthyes Class & { ScientificName "Chondrichthyes", CommonName "cartilaginous fish", Parent Chordata }
Insecta        Class & { ScientificName "Insecta",        CommonName "insects",            Parent Arthropoda }
Arachnida      Class & { ScientificName "Arachnida",      CommonName "arachnids",          Parent Arthropoda }
Crustacea      Class & { ScientificName "Crustacea",      CommonName "crustaceans",        Parent Arthropoda }
Gastropoda     Class & { ScientificName "Gastropoda",     CommonName "snails",             Parent Mollusca }
Cephalopoda    Class & { ScientificName "Cephalopoda",    CommonName "cephalopods",        Parent Mollusca }
Magnoliopsida  Class & { ScientificName "Magnoliopsida",  CommonName "dicots",             Parent Tracheophyta }
Liliopsida     Class & { ScientificName "Liliopsida",     CommonName "monocots",           Parent Tracheophyta }
Pinopsida      Class & { ScientificName "Pinopsida",      CommonName "conifers",           Parent Tracheophyta }

Primates        Order & { ScientificName "Primates",        Parent Mammalia }
Carnivora       Order & { ScientificName "Carnivora",       Parent Mammalia }
Rodentia        Order & { ScientificName "Rodentia",        Parent Mammalia }
Artiodactyla    Order & { ScientificName "Artiodactyla",    Parent Mammalia }
Perissodactyla  Order & { ScientificName "Perissodactyla",  Parent Mammalia }
Chiroptera      Order & { ScientificName "Chiroptera",      Parent Mammalia }
Cetacea         Order & { ScientificName "Cetacea",         Parent Mammalia }
Lagomorpha      Order & { ScientificName "Lagomorpha",      Parent Mammalia }
Proboscidea     Order & { ScientificName "Proboscidea",     Parent Mammalia }
Passeriformes   Order & { ScientificName "Passeriformes",   Parent Aves }
Galliformes     Order & { ScientificName "Galliformes",     Parent Aves }
Accipitriformes Order & { ScientificName "Accipitriformes", Parent Aves }
Squamata        Order & { ScientificName "Squamata",        Parent Reptilia }
Testudines      Order & { ScientificName "Testudines",      Parent Reptilia }
Crocodilia      Order & { ScientificName "Crocodilia",      Parent Reptilia }
Anura           Order & { ScientificName "Anura",           Parent Amphibia }
Coleoptera      Order & { ScientificName "Coleoptera",      Parent Insecta }
Lepidoptera     Order & { ScientificName "Lepidoptera",     Parent Insecta }
Hymenoptera     Order & { ScientificName "Hymenoptera",     Parent Insecta }
Diptera         Order & { ScientificName "Diptera",         Parent Insecta }
Araneae         Order & { ScientificName "Araneae",         Parent Arachnida }
Rosales         Order & { ScientificName "Rosales",         Parent Magnoliopsida }
Poales          Order & { ScientificName "Poales",          Parent Liliopsida }
Fagales         Order & { ScientificName "Fagales",         Parent Magnoliopsida }

Hominidae    Family & { ScientificName "Hominidae",    Parent Primates }
Canidae      Family & { ScientificName "Canidae",      Parent Carnivora }
Felidae      Family & { ScientificName "Felidae",      Parent Carnivora }
Ursidae      Family & { ScientificName "Ursidae",      Parent Carnivora }
Bovidae      Family & { ScientificName "Bovidae",      Parent Artiodactyla }
Suidae       Family & { ScientificName "Suidae",       Parent Artiodactyla }
Cervidae     Family & { ScientificName "Cervidae",     Parent Artiodactyla }
Equidae      Family & { ScientificName "Equidae",      Parent Perissodactyla }
Muridae      Family & { ScientificName "Muridae",      Parent Rodentia }
Leporidae    Family & { ScientificName "Leporidae",    Parent Lagomorpha }
Elephantidae Family & { ScientificName "Elephantidae", Parent Proboscidea }
Phasianidae  Family & { ScientificName "Phasianidae",  Parent Galliformes }
Apidae       Family & { ScientificName "Apidae",       Parent Hymenoptera }
Rosaceae     Family & { ScientificName "Rosaceae",     Parent Rosales }
Poaceae      Family & { ScientificName "Poaceae",      Parent Poales }
Fagaceae     Family & { ScientificName "Fagaceae",     Parent Fagales }

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
Quercus  Genus & { ScientificName "Quercus",  Parent Fagales }

HomoSapiens      Species & { ScientificName "Homo sapiens",      CommonName "human",      Parent Homo }
CanisLupus       Species & { ScientificName "Canis lupus",       CommonName "wolf",       Parent Canis }
CanisFamiliaris  Species & { ScientificName "Canis familiaris",  CommonName "dog",        Parent Canis }
FelisCatus       Species & { ScientificName "Felis catus",       CommonName "cat",        Parent Felis }
PantheraLeo      Species & { ScientificName "Panthera leo",      CommonName "lion",       Parent Panthera }
PantheraTigris   Species & { ScientificName "Panthera tigris",   CommonName "tiger",      Parent Panthera }
UrsusArctos      Species & { ScientificName "Ursus arctos",      CommonName "brown bear", Parent Ursus }
BosTaurus        Species & { ScientificName "Bos taurus",        CommonName "cattle",     Parent Bos }
OvisAries        Species & { ScientificName "Ovis aries",        CommonName "sheep",      Parent Ovis }
CapraHircus      Species & { ScientificName "Capra hircus",      CommonName "goat",       Parent Capra }
SusScrofa        Species & { ScientificName "Sus scrofa",        CommonName "pig",        Parent Sus }
EquusCaballus    Species & { ScientificName "Equus caballus",    CommonName "horse",      Parent Equus }
MusMusculus      Species & { ScientificName "Mus musculus",      CommonName "mouse",      Parent Mus }
GallusGallus     Species & { ScientificName "Gallus gallus",     CommonName "chicken",    Parent Gallus }
ApisMellifera    Species & { ScientificName "Apis mellifera",    CommonName "honey bee",  Parent Apis }
MalusDomestica   Species & { ScientificName "Malus domestica",   CommonName "apple",      Parent Malus }
TriticumAestivum Species & { ScientificName "Triticum aestivum", CommonName "wheat",      Parent Triticum }
OryzaSativa      Species & { ScientificName "Oryza sativa",      CommonName "rice",       Parent Oryza }
ZeaMays          Species & { ScientificName "Zea mays",          CommonName "maize",      Parent Zea }
QuercusRobur     Species & { ScientificName "Quercus robur",     CommonName "oak",        Parent Quercus }

ConservationStatus "least-concern" | "near-threatened" | "vulnerable" | "endangered"
    | "critically-endangered" | "extinct-in-the-wild" | "extinct"
