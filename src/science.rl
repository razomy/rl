#
Abstract Quantum Computing, Neuroscience, Mineralogy, Seismology & Agronomy
#

QubitStateVector {
  Alpha Complex
  Beta  Complex
}

QuantumGateOp {
  Gate          QuantumGateType
  TargetQubits  List(Int)
  ControlQubits List(Int)
  AngleParam    Option(Float)
}

QuantumCircuit {
  Name             String
  NumQubits        Int
  NumClassicalBits Int
  Operations       List(QuantumGateOp)
  Depth            Int
}

QuantumProcessor {
  Name            String
  Backend         QuantumHardwareBackend
  QubitCount      Int
  T1CoherenceUs   Float
  T2DephasingUs   Float
  TwoQubitGateErr Float
  QuantumVolume   Int
}

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

Mineral {
  Name            String
  ChemicalFormula Formula
  CrystalSystem   CrystalSystem
  MohsHardness    Range(1.0, 10.0) & Float
  SpecificGravity Float
  Luster          "Metallic" | "Vitreous" | "Pearly" | "Silky" | "Resinous" | "Adamantine" | "Dull"
}

SeismicEvent {
  EventId           String
  Epicenter         GeoCoordinate
  FocalDepthKm      Float
  MomentMagnitude   Range(0.0, 10.0) & Float
  MercalliIntensity Range(1, 12) & Int
  Timestamp         Instant
}

SoilProfile {
  Texture          SoilTexture
  PhAcidity        Acidity
  OrganicMatterPct Percent
  MoisturePct      Percent
  NitrogenPpm      Float
  PhosphorusPpm    Float
  PotassiumPpm     Float
}

AgriculturalField {
  FieldId          String
  Boundary         GeoPolygon
  AreaHectares     Float
  Soil             SoilProfile
  CropSpecies      Species
  Stage            CropCycleStage
  IrrigationMethod "Rainfed" | "Drip" | "CenterPivotSprinkler" | "Flood" | "Hydroponic" | "Aeroponic"
}
