_ primitive
_ primitive
_ structure
_ math
_ quantity
_ time
_ space
_ energy
_ matter
_ cosmos
_ life

// =============================================================================
// 1. Quantum Mechanics & Quantum Computing
// =============================================================================

QubitStateVector {
  Alpha Complex
  Beta  Complex
}

QuantumGateType
  "Identity" | "PauliX" | "PauliY" | "PauliZ" | "Hadamard" | "PhaseS" | "PhaseT"
  | "Rx" | "Ry" | "Rz" | "CNOT" | "CZ" | "SWAP" | "iSWAP" | "ToffoliCCNOT" | "FredkinCSWAP"

QuantumGateOp {
  Gate          QuantumGateType
  TargetQubits  List(Int)
  ControlQubits List(Int)
  AngleParam    Option(Float)
}

QuantumCircuit {
  Name          String
  NumQubits     Int
  NumClassicalBits Int
  Operations    List(QuantumGateOp)
  Depth         Int
}

QuantumHardwareBackend "SuperconductingTransmon" | "TrappedIon" | "NeutralAtom" | "Photonic" | "TopologicalMajorana" | "SpinSilicon" | "StatevectorSimulator"

QuantumProcessor {
  Name            String
  Backend         QuantumHardwareBackend
  QubitCount      Int
  T1CoherenceUs   Float
  T2DephasingUs   Float
  TwoQubitGateErr Float
  QuantumVolume   Int
}

// =============================================================================
// 2. Neuroscience & Cognitive Architecture
// =============================================================================

Neurotransmitter "Dopamine" | "Serotonin" | "Norepinephrine" | "Acetylcholine" | "Glutamate" | "GABA" | "Endorphin" | "Oxytocin"
BrainWaveBand "Delta" | "Theta" | "Alpha" | "Beta" | "Gamma"
CorticalLobe "Frontal" | "Parietal" | "Temporal" | "Occipital" | "Insular" | "Limbic" | "Cerebellum" | "Brainstem"

Synapse {
  PreSynapticNeuronId  String
  PostSynapticNeuronId String
  Transmitter          Neurotransmitter
  SynapticWeight       Float
  IsExcitatory         Bool
}

SpikingNeuron {
  NeuronId             String
  MembranePotentialMv  Float
  RestingPotentialMv   Float
  ThresholdPotentialMv Float
  RefractoryPeriodMs   Float
}

FireActionPotential(N SpikingNeuron) [
  (N.MembranePotentialMv >= N.ThresholdPotentialMv) . {
    true  [ N & { MembranePotentialMv N.RestingPotentialMv } ]
    false [ N ]
  }
]

// =============================================================================
// 3. Geology, Mineralogy, Seismology & Plate Tectonics
// =============================================================================

GeologicalEon "Hadean" | "Archean" | "Proterozoic" | "Phanerozoic"
GeologicalEra "Paleozoic" | "Mesozoic" | "Cenozoic"
GeologicalPeriod "Cambrian" | "Ordovician" | "Silurian" | "Devonian" | "Carboniferous" | "Permian" | "Triassic" | "Jurassic" | "Cretaceous" | "Paleogene" | "Neogene" | "Quaternary"

RockCategory "IgneousIntrusive" | "IgneousExtrusive" | "SedimentaryClastic" | "SedimentaryChemical" | "MetamorphicFoliated" | "MetamorphicNonFoliated"
CrystalSystem "Cubic" | "Tetragonal" | "Orthorhombic" | "Hexagonal" | "Trigonal" | "Monoclinic" | "Triclinic" | "Amorphous"

Mineral {
  Name            String
  ChemicalFormula Formula
  CrystalSystem   CrystalSystem
  MohsHardness    Range(1.0, 10.0) & Float
  SpecificGravity Float
  Luster          "Metallic" | "Vitreous" | "Pearly" | "Silky" | "Resinous" | "Adamantine" | "Dull"
}

PlateBoundaryType "Divergent" | "ConvergentSubduction" | "ConvergentCollision" | "TransformFault"

SeismicEvent {
  EventId          String
  Epicenter        GeoCoordinate
  FocalDepthKm     Float
  MomentMagnitude  Range(0.0, 10.0) & Float
  MercalliIntensity Range(1, 12) & Int
  Timestamp        Instant
}

// =============================================================================
// 4. Ecology, Climate Carbon Cycles & Agriculture (Agronomy)
// =============================================================================

TrophicLevel "PrimaryProducer" | "PrimaryConsumerHerbivore" | "SecondaryConsumerCarnivore" | "TertiaryApexPredator" | "DecomposerDetritivore"

SoilTexture "Sand" | "LoamySand" | "SandyLoam" | "Loam" | "SiltLoam" | "Silt" | "ClayLoam" | "Clay" | "Peat" | "Chalk"

SoilProfile {
  Texture            SoilTexture
  PhAcidity          Acidity
  OrganicMatterPct   Percent
  MoisturePct        Percent
  NitrogenPpm        Float
  PhosphorusPpm      Float
  PotassiumPpm       Float
}

CropCycleStage "Fallow" | "SeedbedPrepared" | "Sown" | "Germinating" | "VegetativeGrowth" | "Flowering" | "Ripening" | "Harvested"

AgriculturalField {
  FieldId          String
  Boundary         GeoPolygon
  AreaHectares     Float
  Soil             SoilProfile
  CropSpecies      Species
  Stage            CropCycleStage
  IrrigationMethod "Rainfed" | "Drip" | "CenterPivotSprinkler" | "Flood" | "Hydroponic" | "Aeroponic"
}

HarvestField(F AgriculturalField & { Stage "Ripening" }) [
  F & { Stage "Harvested" }
]
