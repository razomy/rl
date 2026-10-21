#
Concrete Biological Taxonomy (Domains to Species)
#

Bacteria  Domain & { ScientificName "Bacteria" }
Archaea   Domain & { ScientificName "Archaea" }
Eukaryota Domain & { ScientificName "Eukaryota" }

Animalia  Kingdom & { ScientificName "Animalia",  parent Eukaryota }
Plantae   Kingdom & { ScientificName "Plantae",   parent Eukaryota }
Fungi     Kingdom & { ScientificName "Fungi",     parent Eukaryota }
Protista  Kingdom & { ScientificName "Protista",  parent Eukaryota }
Chromista Kingdom & { ScientificName "Chromista", parent Eukaryota }

Chordata      Phylum & { ScientificName "Chordata",      parent Animalia }
Arthropoda    Phylum & { ScientificName "Arthropoda",    parent Animalia }
Mollusca      Phylum & { ScientificName "Mollusca",      parent Animalia }
Annelida      Phylum & { ScientificName "Annelida",      parent Animalia }
Cnidaria      Phylum & { ScientificName "Cnidaria",      parent Animalia }
Echinodermata Phylum & { ScientificName "Echinodermata", parent Animalia }
Porifera      Phylum & { ScientificName "Porifera",      parent Animalia }
Nematoda      Phylum & { ScientificName "Nematoda",      parent Animalia }
Tracheophyta  Phylum & { ScientificName "Tracheophyta",  parent Plantae }
Bryophyta     Phylum & { ScientificName "Bryophyta",     parent Plantae }
Basidiomycota Phylum & { ScientificName "Basidiomycota", parent Fungi }
Ascomycota    Phylum & { ScientificName "Ascomycota",    parent Fungi }

Mammalia       Class & { ScientificName "Mammalia",       CommonName "mammals",            parent Chordata }
Aves           Class & { ScientificName "Aves",           CommonName "birds",              parent Chordata }
Reptilia       Class & { ScientificName "Reptilia",       CommonName "reptiles",           parent Chordata }
Amphibia       Class & { ScientificName "Amphibia",       CommonName "amphibians",         parent Chordata }
Actinopterygii Class & { ScientificName "Actinopterygii", CommonName "ray-finned fish",    parent Chordata }
Chondrichthyes Class & { ScientificName "Chondrichthyes", CommonName "cartilaginous fish", parent Chordata }
Insecta        Class & { ScientificName "Insecta",        CommonName "insects",            parent Arthropoda }
Arachnida      Class & { ScientificName "Arachnida",      CommonName "arachnids",          parent Arthropoda }
Crustacea      Class & { ScientificName "Crustacea",      CommonName "crustaceans",        parent Arthropoda }
Gastropoda     Class & { ScientificName "Gastropoda",     CommonName "snails",             parent Mollusca }
Cephalopoda    Class & { ScientificName "Cephalopoda",    CommonName "cephalopods",        parent Mollusca }
Magnoliopsida  Class & { ScientificName "Magnoliopsida",  CommonName "dicots",             parent Tracheophyta }
Liliopsida     Class & { ScientificName "Liliopsida",     CommonName "monocots",           parent Tracheophyta }
Pinopsida      Class & { ScientificName "Pinopsida",      CommonName "conifers",           parent Tracheophyta }

Primates        Order & { ScientificName "Primates",        parent Mammalia }
Carnivora       Order & { ScientificName "Carnivora",       parent Mammalia }
Rodentia        Order & { ScientificName "Rodentia",        parent Mammalia }
Artiodactyla    Order & { ScientificName "Artiodactyla",    parent Mammalia }
Perissodactyla  Order & { ScientificName "Perissodactyla",  parent Mammalia }
Chiroptera      Order & { ScientificName "Chiroptera",      parent Mammalia }
Cetacea         Order & { ScientificName "Cetacea",         parent Mammalia }
Lagomorpha      Order & { ScientificName "Lagomorpha",      parent Mammalia }
Proboscidea     Order & { ScientificName "Proboscidea",     parent Mammalia }
Passeriformes   Order & { ScientificName "Passeriformes",   parent Aves }
Galliformes     Order & { ScientificName "Galliformes",     parent Aves }
Accipitriformes Order & { ScientificName "Accipitriformes", parent Aves }
Squamata        Order & { ScientificName "Squamata",        parent Reptilia }
Testudines      Order & { ScientificName "Testudines",      parent Reptilia }
Crocodilia      Order & { ScientificName "Crocodilia",      parent Reptilia }
Anura           Order & { ScientificName "Anura",           parent Amphibia }
Coleoptera      Order & { ScientificName "Coleoptera",      parent Insecta }
Lepidoptera     Order & { ScientificName "Lepidoptera",     parent Insecta }
Hymenoptera     Order & { ScientificName "Hymenoptera",     parent Insecta }
Diptera         Order & { ScientificName "Diptera",         parent Insecta }
Araneae         Order & { ScientificName "Araneae",         parent Arachnida }
Rosales         Order & { ScientificName "Rosales",         parent Magnoliopsida }
Poales          Order & { ScientificName "Poales",          parent Liliopsida }
Fagales         Order & { ScientificName "Fagales",         parent Magnoliopsida }

Hominidae    Family & { ScientificName "Hominidae",    parent Primates }
Canidae      Family & { ScientificName "Canidae",      parent Carnivora }
Felidae      Family & { ScientificName "Felidae",      parent Carnivora }
Ursidae      Family & { ScientificName "Ursidae",      parent Carnivora }
Bovidae      Family & { ScientificName "Bovidae",      parent Artiodactyla }
Suidae       Family & { ScientificName "Suidae",       parent Artiodactyla }
Cervidae     Family & { ScientificName "Cervidae",     parent Artiodactyla }
Equidae      Family & { ScientificName "Equidae",      parent Perissodactyla }
Muridae      Family & { ScientificName "Muridae",      parent Rodentia }
Leporidae    Family & { ScientificName "Leporidae",    parent Lagomorpha }
Elephantidae Family & { ScientificName "Elephantidae", parent Proboscidea }
Phasianidae  Family & { ScientificName "Phasianidae",  parent Galliformes }
Apidae       Family & { ScientificName "Apidae",       parent Hymenoptera }
Rosaceae     Family & { ScientificName "Rosaceae",     parent Rosales }
Poaceae      Family & { ScientificName "Poaceae",      parent Poales }
Fagaceae     Family & { ScientificName "Fagaceae",     parent Fagales }

Homo     Genus & { ScientificName "Homo",     parent Hominidae }
Canis    Genus & { ScientificName "Canis",    parent Canidae }
Felis    Genus & { ScientificName "Felis",    parent Felidae }
Panthera Genus & { ScientificName "Panthera", parent Felidae }
Ursus    Genus & { ScientificName "Ursus",    parent Ursidae }
Bos      Genus & { ScientificName "Bos",      parent Bovidae }
Ovis     Genus & { ScientificName "Ovis",     parent Bovidae }
Capra    Genus & { ScientificName "Capra",    parent Bovidae }
Sus      Genus & { ScientificName "Sus",      parent Suidae }
Equus    Genus & { ScientificName "Equus",    parent Equidae }
Mus      Genus & { ScientificName "Mus",      parent Muridae }
Gallus   Genus & { ScientificName "Gallus",   parent Phasianidae }
Apis     Genus & { ScientificName "Apis",     parent Apidae }
Malus    Genus & { ScientificName "Malus",    parent Rosaceae }
Triticum Genus & { ScientificName "Triticum", parent Poaceae }
Oryza    Genus & { ScientificName "Oryza",    parent Poaceae }
Zea      Genus & { ScientificName "Zea",      parent Poaceae }
Quercus  Genus & { ScientificName "Quercus",  parent Fagales }

HomoSapiens      Species & { ScientificName "Homo sapiens",      CommonName "human",      parent Homo }
CanisLupus       Species & { ScientificName "Canis lupus",       CommonName "wolf",       parent Canis }
CanisFamiliaris  Species & { ScientificName "Canis familiaris",  CommonName "dog",        parent Canis }
FelisCatus       Species & { ScientificName "Felis catus",       CommonName "cat",        parent Felis }
PantheraLeo      Species & { ScientificName "Panthera leo",      CommonName "lion",       parent Panthera }
PantheraTigris   Species & { ScientificName "Panthera tigris",   CommonName "tiger",      parent Panthera }
UrsusArctos      Species & { ScientificName "Ursus arctos",      CommonName "brown bear", parent Ursus }
BosTaurus        Species & { ScientificName "Bos taurus",        CommonName "cattle",     parent Bos }
OvisAries        Species & { ScientificName "Ovis aries",        CommonName "sheep",      parent Ovis }
CapraHircus      Species & { ScientificName "Capra hircus",      CommonName "goat",       parent Capra }
SusScrofa        Species & { ScientificName "Sus scrofa",        CommonName "pig",        parent Sus }
EquusCaballus    Species & { ScientificName "Equus caballus",    CommonName "horse",      parent Equus }
MusMusculus      Species & { ScientificName "Mus musculus",      CommonName "mouse",      parent Mus }
GallusGallus     Species & { ScientificName "Gallus gallus",     CommonName "chicken",    parent Gallus }
ApisMellifera    Species & { ScientificName "Apis mellifera",    CommonName "honey bee",  parent Apis }
MalusDomestica   Species & { ScientificName "Malus domestica",   CommonName "apple",      parent Malus }
TriticumAestivum Species & { ScientificName "Triticum aestivum", CommonName "wheat",      parent Triticum }
OryzaSativa      Species & { ScientificName "Oryza sativa",      CommonName "rice",       parent Oryza }
ZeaMays          Species & { ScientificName "Zea mays",          CommonName "maize",      parent Zea }
QuercusRobur     Species & { ScientificName "Quercus robur",     CommonName "oak",        parent Quercus }

ConservationStatus "least-concern" | "near-threatened" | "vulnerable" | "endangered"
    | "critically-endangered" | "extinct-in-the-wild" | "extinct"
