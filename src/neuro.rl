#
Concrete Quantum Gates, Neurotransmitters, geological Eras, crystal Systems & Transitions
#

QuantumGateType
  "Identity" | "PauliX" | "PauliY" | "PauliZ" | "Hadamard" | "PhaseS" | "PhaseT"
  | "Rx" | "Ry" | "Rz" | "CNOT" | "CZ" | "SWAP" | "iSWAP" | "ToffoliCCNOT" | "FredkinCSWAP"

QuantumHardwareBackend "SuperconductingTransmon" | "TrappedIon" | "NeutralAtom" | "Photonic" | "TopologicalMajorana" | "SpinSilicon" | "StatevectorSimulator"

Neurotransmitter "Dopamine" | "Serotonin" | "Norepinephrine" | "Acetylcholine" | "Glutamate" | "GABA" | "Endorphin" | "Oxytocin"
BrainWaveBand    "Delta" | "Theta" | "Alpha" | "Beta" | "Gamma"
CorticalLobe     "Frontal" | "Parietal" | "Temporal" | "Occipital" | "Insular" | "Limbic" | "Cerebellum" | "Brainstem"

FireActionPotential(n SpikingNeuron) [
  (N.MembranePotentialMv >= N.ThresholdPotentialMv) . {
    true  [ n & { MembranePotentialMv N.RestingPotentialMv } ]
    false [ N ]
  }
]

GeologicalEon    "Hadean" | "Archean" | "Proterozoic" | "Phanerozoic"
GeologicalEra    "Paleozoic" | "Mesozoic" | "Cenozoic"
GeologicalPeriod "Cambrian" | "Ordovician" | "Silurian" | "Devonian" | "Carboniferous" | "Permian" | "Triassic" | "Jurassic" | "Cretaceous" | "Paleogene" | "Neogene" | "Quaternary"

RockCategory      "IgneousIntrusive" | "IgneousExtrusive" | "SedimentaryClastic" | "SedimentaryChemical" | "MetamorphicFoliated" | "MetamorphicNonFoliated"
CrystalSystem     "Cubic" | "Tetragonal" | "Orthorhombic" | "Hexagonal" | "Trigonal" | "Monoclinic" | "Triclinic" | "Amorphous"
PlateBoundaryType "Divergent" | "ConvergentSubduction" | "ConvergentCollision" | "TransformFault"

TrophicLevel   "PrimaryProducer" | "PrimaryConsumerHerbivore" | "SecondaryConsumerCarnivore" | "TertiaryApexPredator" | "DecomposerDetritivore"
SoilTexture    "Sand" | "LoamySand" | "SandyLoam" | "Loam" | "SiltLoam" | "Silt" | "ClayLoam" | "Clay" | "Peat" | "Chalk"
CropCycleStage "Fallow" | "SeedbedPrepared" | "Sown" | "Germinating" | "VegetativeGrowth" | "Flowering" | "Ripening" | "Harvested"

HarvestField(f AgriculturalField & { Stage "Ripening" }) [
  F & { Stage "Harvested" }
]
