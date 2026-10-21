#
Abstract Mechanical, Thermal, Electrical, Semiconductor & Aerospace Engineering Structures
#

StressTensor3D {
  SigmaXX Float, sigmaYY Float, sigmaZZ Float
  TauXY   Float, tauYZ   Float, tauZX   Float
}

StrainTensor3D {
  EpsilonXX Float, epsilonYY Float, epsilonZZ Float
  GammaXY   Float, gammaYZ   Float, gammaZX   Float
}

MechanicalMaterialProperties {
  YoungsModulusGpa       Float
  ShearModulusGpa        Float
  BulkModulusGpa         Float
  PoissonsRatio          Range(-1.0, 0.5) & Float
  YieldStrengthMpa       Float
  UltimateTensileMpa     Float
  CompressiveStrengthMpa Float
  FractureToughness      Float
  FatigueLimitMpa        Float
  ThermalExpansionCoeff  Float
  ThermalConductivityWmK Float
}

StructuralBeam {
  BeamId            String
  Support           BeamSupportType
  SectionShape      CrossSectionShape
  LengthMeters      Float
  CrossSectionArea  Float
  MomentOfInertiaIx Float
  MomentOfInertiaIy Float
  MaterialProps     MechanicalMaterialProperties
  MaxBendingMoment  Float
  MaxShearForce     Float
  SafetyFactor      Float
}

FemMeshAnalysis {
  ElementType       FemElementType
  NodeCount         Count
  ElementCount      Count
  DegreesOfFreedom  Count
  MaxVonMisesMpa    Float
  MaxDisplacementMm Float
  Converged         Bool
}

FluidFlowState {
  VelocityMs          Float
  PressurePa          Float
  DensityKgM3         Float
  DynamicViscosityPas Float
  ReynoldsNumber      Float
  MachNumber          Float
  PrandtlNumber       Float
  Regime              FluidFlowRegime
}

HeatExchanger {
  Type               HeatExchangerType
  HeatTransferAreaM2 Float
  OverallCoeffU      Float
  HotInletTempK      Float
  HotOutletTempK     Float
  ColdInletTempK     Float
  ColdOutletTempK    Float
  Effectiveness      Fraction
  FoulingFactor      Float
}

PcbBoardSpec {
  DesignName          String
  LayerCount          Count
  WidthMm             Float
  HeightMm            Float
  ThicknessMm         Float
  CopperWeightOz      Float
  MinTraceWidthMm     Float
  MinClearanceMm      Float
  MinViaDrillMm       Float
  DielectricMaterial  "FR4" | "Rogers4350B" | "PolyimideFlex" | "AluminumBacked" | "CeramicAlN"
  ImpedanceControlled Bool
}

IntegratedCircuitChip {
  ModelName       String
  ProcessNode     SemiconductorNodeProcess
  TransistorCount Bigint
  DieAreaMm2      Float
  ClockBaseGhz    Float
  ClockBoostGhz   Float
  TdpWatts        Float
  PackageSocket   String
  SupplyVoltageV  Float
}

PowerGridSubstation {
  SubstationId      String
  InputVoltageKv    Float
  OutputVoltageKv   Float
  FrequencyHz       "50Hz" | "60Hz"
  CapacityMva       Float
  ActivePowerMw     Float
  ReactivePowerMvar Float
  PowerFactor       Fraction
  BreakerClosed     Bool
}

RocketEngineSpec {
  EngineName          String
  PropulsionKind      PropulsionSystemKind
  Fuel                String
  Oxidizer            String
  ThrustSeaLevelKn    Float
  ThrustVacuumKn      Float
  SpecificImpulseIspS Float
  ChamberPressureBar  Float
  MassKg              Float
  ThrustToWeightRatio Float
  ThrottleMinPct      Percent
  GimbalRangeDeg      Float
}

KeplerianOrbitalElements {
  SemiMajorAxisKm        Float
  Eccentricity           Range(0.0, 1.0) & Float
  InclinationDeg         Range(0.0, 180.0) & Float
  RightAscensionNodeDeg  Range(0.0, 360.0) & Float
  ArgumentOfPeriapsisDeg Range(0.0, 360.0) & Float
  TrueAnomalyDeg         Range(0.0, 360.0) & Float
}

SpacecraftTelemetry {
  Callsign          String
  Regime            OrbitalRegime
  Elements          KeplerianOrbitalElements
  DryMassKg         Float
  PropellantMassKg  Float
  DeltaVRemainingMs Float
  SolarArrayWatts   Float
  AttitudeQuat      Quaternion
}

GdtCallout {
  ToleranceType     GeometricToleranceType
  ToleranceZoneMm   Float
  DatumPrimary      Option(Char)
  DatumSecondary    Option(Char)
  DatumTertiary     Option(Char)
  MaterialCondition "MMC" | "LMC" | "RFS"
}
