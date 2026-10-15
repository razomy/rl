_ meta
_ primitive
_ structure
_ math
_ quantity
_ time
_ space
_ energy
_ matter
_ artifact

// =============================================================================
// 1. Mechanical & Structural Engineering (Statics, Dynamics, FEM, CAD/CAM)
// =============================================================================

StressTensor3D {
  SigmaXX Float, SigmaYY Float, SigmaZZ Float
  TauXY   Float, TauYZ   Float, TauZX   Float
}

StrainTensor3D {
  EpsilonXX Float, EpsilonYY Float, EpsilonZZ Float
  GammaXY   Float, GammaYZ   Float, GammaZX   Float
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

BeamSupportType "Cantilever" | "SimplySupported" | "FixedBothEnds" | "Overhanging" | "Continuous"
CrossSectionShape "IBeam" | "HBeam" | "ChannelC" | "AngleL" | "HollowRectangular" | "HollowCircular" | "SolidCircular" | "SolidRectangular" | "TBeam"

StructuralBeam {
  BeamId            Str
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

FemElementType "Tetrahedron4" | "Tetrahedron10" | "Hexahedron8" | "Hexahedron20" | "TriangleShell3" | "QuadShell4" | "Beam2" | "Truss2"

FemMeshAnalysis {
  ElementType       FemElementType
  NodeCount         Count
  ElementCount      Count
  DegreesOfFreedom  Count
  MaxVonMisesMpa    Float
  MaxDisplacementMm Float
  Converged         Bool
}

// =============================================================================
// 2. Thermodynamics, Fluid Mechanics & HVACCycles
// =============================================================================

ThermodynamicProcess "Isothermal" | "Adiabatic" | "Isobaric" | "Isochoric" | "Isentropic" | "Polytropic" | "Throttling"
ThermodynamicCycle   "Carnot" | "Rankine" | "Otto" | "Diesel" | "Brayton" | "Stirling" | "Ericsson" | "VaporCompressionRefrigeration"

FluidFlowRegime "Laminar" | "Transitional" | "Turbulent" | "CreepingStokes" | "CompressibleSubsonic" | "Supersonic" | "Hypersonic"

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

HeatExchangerType "ShellAndTube" | "PlateAndFrame" | "CounterFlow" | "ParallelFlow" | "CrossFlow" | "FinTube" | "Regenerative"

HeatExchanger {
  Type                   HeatExchangerType
  HeatTransferAreaM2     Float
  OverallCoeffU          Float
  HotInletTempK          Float
  HotOutletTempK         Float
  ColdInletTempK         Float
  ColdOutletTempK        Float
  Effectiveness          Fraction
  FoulingFactor          Float
}

// =============================================================================
// 3. Electrical Engineering, Power Grids & PCB / Semiconductor VLSI Design
// =============================================================================

CurrentType "DC" | "AC-SinglePhase" | "AC-ThreePhase" | "PulsedDC" | "RF-HighFrequency"

PassiveComponentKind "Resistor" | "Capacitor" | "Inductor" | "FerriteBead" | "Transformer" | "Memristor" | "CrystalOscillator"
ActiveComponentKind  "Diode" | "ZenerDiode" | "LED" | "Photodiode" | "BJT-NPN" | "BJT-PNP" | "MOSFET-N" | "MOSFET-P" | "IGBT" | "JFET" | "ThyristorSCR" | "Triac" | "OpAmp"

PcbLayerType "TopSignal" | "BottomSignal" | "InnerSignal" | "PowerPlane" | "GroundPlane" | "SolderMask" | "Silkscreen" | "PasteMask"
SurfaceMountPackage "0201" | "0402" | "0603" | "0805" | "1206" | "SOT-23" | "SOIC-8" | "QFP" | "QFN" | "BGA" | "LGA" | "DIP"

PcbBoardSpec {
  DesignName        Str
  LayerCount        Count
  WidthMm           Float
  HeightMm          Float
  ThicknessMm       Float
  CopperWeightOz    Float
  MinTraceWidthMm   Float
  MinClearanceMm    Float
  MinViaDrillMm     Float
  DielectricMaterial "FR4" | "Rogers4350B" | "PolyimideFlex" | "AluminumBacked" | "CeramicAlN"
  ImpedanceControlled Bool
}

SemiconductorNodeProcess "180nm" | "65nm" | "28nm" | "14nm-FinFET" | "7nm-EUV" | "5nm-EUV" | "3nm-GAA" | "2nm-RibbonFET" | "14A"

IntegratedCircuitChip {
  ModelName         Str
  ProcessNode       SemiconductorNodeProcess
  TransistorCount   Bigint
  DieAreaMm2        Float
  ClockBaseGhz      Float
  ClockBoostGhz     Float
  TdpWatts          Float
  PackageSocket     Str
  SupplyVoltageV    Float
}

PowerGridSubstation {
  SubstationId      Str
  InputVoltageKv    Float
  OutputVoltageKv   Float
  FrequencyHz       "50Hz" | "60Hz"
  CapacityMva       Float
  ActivePowerMw     Float
  ReactivePowerMvar Float
  PowerFactor       Fraction
  BreakerClosed     Bool
}

// =============================================================================
// 4. Aerospace, Avionics, Orbital Mechanics & Propulsion
// =============================================================================

PropulsionSystemKind
  "Turbofan" | "Turbojet" | "Turboprop" | "Ramjet" | "Scramjet"
  | "LiquidBipropellantRocket" | "SolidRocketBooster" | "HybridRocket"
  | "HallEffectIonThruster" | "NuclearThermalRocket" | "SolarSail"

RocketEngineSpec {
  EngineName          Str
  PropulsionKind      PropulsionSystemKind
  Fuel                Str
  Oxidizer            Str
  ThrustSeaLevelKn    Float
  ThrustVacuumKn      Float
  SpecificImpulseIspS Float
  ChamberPressureBar  Float
  MassKg              Float
  ThrustToWeightRatio Float
  ThrottleMinPct      Percent
  GimbalRangeDeg      Float
}

OrbitalRegime "LEO" | "MEO" | "GEO" | "SSO" | "GTO" | "HEO" | "LagrangeL1" | "LagrangeL2" | "LunarNRHO" | "Heliocentric"

KeplerianOrbitalElements {
  SemiMajorAxisKm          Float
  Eccentricity             Range(0.0, 1.0) & Float
  InclinationDeg           Range(0.0, 180.0) & Float
  RightAscensionNodeDeg    Range(0.0, 360.0) & Float
  ArgumentOfPeriapsisDeg   Range(0.0, 360.0) & Float
  TrueAnomalyDeg           Range(0.0, 360.0) & Float
}

SpacecraftTelemetry {
  Callsign          Str
  Regime            OrbitalRegime
  Elements          KeplerianOrbitalElements
  DryMassKg         Float
  PropellantMassKg  Float
  DeltaVRemainingMs Float
  SolarArrayWatts   Float
  AttitudeQuat      Quaternion
}

// =============================================================================
// 5. Industrial Manufacturing, CNC, Additive 3D Printing & Supply Chain QC
// =============================================================================

ManufacturingProcess
  "CNC-Milling-3Axis" | "CNC-Milling-5Axis" | "CNC-Turning-Lathe" | "EDM-Wire"
  | "InjectionMolding" | "DieCasting" | "SandCasting" | "InvestmentCasting"
  | "SheetMetalStamping" | "LaserCutting" | "WaterjetCutting" | "Forging"
  | "FDM-3DPrint" | "SLA-ResinPrint" | "SLS-PowderSintering" | "DMLS-MetalPrint"

GeometricToleranceType "Flatness" | "Straightness" | "Circularity" | "Cylindricity" | "Perpendicularity" | "Parallelism" | "Concentricity" | "TruePosition" | "SurfaceProfile"

GdtCallout {
  ToleranceType     GeometricToleranceType
  ToleranceZoneMm   Float
  DatumPrimary      Option(Char)
  DatumSecondary    Option(Char)
  DatumTertiary     Option(Char)
  MaterialCondition "MMC" | "LMC" | "RFS"
}

// =============================================================================
// 6. Engineering Calculations & Transitions
// =============================================================================

ComputeReynoldsNumber(Density Float, Velocity Float, CharacteristicLength Float, DynamicViscosity Float) [
  (Density * Velocity * CharacteristicLength) / DynamicViscosity
]

ComputeRocketDeltaV(IspSeconds Float, InitialMassKg Float, FinalDryMassKg Float) [
  G0 9.80665
  (IspSeconds * G0) * Math.Ln(InitialMassKg / FinalDryMassKg)
]

TripSubstationBreaker(Sub PowerGridSubstation & { BreakerClosed true }) [
  Sub & { BreakerClosed false, ActivePowerMw 0.0 }
]
