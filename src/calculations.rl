#
Concrete Engineering Types, semiconductor Nodes, Propulsion & Calculations
#

BeamSupportType   "Cantilever" | "SimplySupported" | "FixedBothEnds" | "Overhanging" | "Continuous"
CrossSectionShape "IBeam" | "HBeam" | "ChannelC" | "AngleL" | "HollowRectangular" | "HollowCircular" | "SolidCircular" | "SolidRectangular" | "TBeam"
FemElementType    "Tetrahedron4" | "Tetrahedron10" | "Hexahedron8" | "Hexahedron20" | "TriangleShell3" | "QuadShell4" | "Beam2" | "Truss2"

ThermodynamicProcess "Isothermal" | "Adiabatic" | "Isobaric" | "Isochoric" | "Isentropic" | "Polytropic" | "Throttling"
ThermodynamicCycle   "Carnot" | "Rankine" | "Otto" | "Diesel" | "Brayton" | "Stirling" | "Ericsson" | "VaporCompressionRefrigeration"
FluidFlowRegime      "Laminar" | "Transitional" | "Turbulent" | "CreepingStokes" | "CompressibleSubsonic" | "Supersonic" | "Hypersonic"
HeatExchangerType    "ShellAndTube" | "PlateAndFrame" | "CounterFlow" | "ParallelFlow" | "CrossFlow" | "FinTube" | "Regenerative"

CurrentType              "DC" | "AC-SinglePhase" | "AC-ThreePhase" | "PulsedDC" | "RF-HighFrequency"
PassiveComponentKind     "Resistor" | "Capacitor" | "Inductor" | "FerriteBead" | "Transformer" | "Memristor" | "CrystalOscillator"
ActiveComponentKind      "Diode" | "ZenerDiode" | "LED" | "Photodiode" | "BJT-NPN" | "BJT-PNP" | "MOSFET-N" | "MOSFET-P" | "IGBT" | "JFET" | "ThyristorSCR" | "Triac" | "OpAmp"
PcbLayerType             "TopSignal" | "BottomSignal" | "InnerSignal" | "PowerPlane" | "GroundPlane" | "SolderMask" | "Silkscreen" | "PasteMask"
SurfaceMountPackage      "0201" | "0402" | "0603" | "0805" | "1206" | "SOT-23" | "SOIC-8" | "QFP" | "QFN" | "BGA" | "LGA" | "DIP"
SemiconductorNodeProcess "180nm" | "65nm" | "28nm" | "14nm-FinFET" | "7nm-EUV" | "5nm-EUV" | "3nm-GAA" | "2nm-RibbonFET" | "14A"

PropulsionSystemKind
  "Turbofan" | "Turbojet" | "Turboprop" | "Ramjet" | "Scramjet"
  | "LiquidBipropellantRocket" | "SolidRocketBooster" | "HybridRocket"
  | "HallEffectIonThruster" | "NuclearThermalRocket" | "SolarSail"

OrbitalRegime "LEO" | "MEO" | "GEO" | "SSO" | "GTO" | "HEO" | "LagrangeL1" | "LagrangeL2" | "LunarNRHO" | "Heliocentric"

ManufacturingProcess
  "CNC-Milling-3Axis" | "CNC-Milling-5Axis" | "CNC-Turning-Lathe" | "EDM-Wire"
  | "InjectionMolding" | "DieCasting" | "SandCasting" | "InvestmentCasting"
  | "SheetMetalStamping" | "LaserCutting" | "WaterjetCutting" | "Forging"
  | "FDM-3DPrint" | "SLA-ResinPrint" | "SLS-PowderSintering" | "DMLS-MetalPrint"

GeometricToleranceType "Flatness" | "Straightness" | "Circularity" | "Cylindricity" | "Perpendicularity" | "Parallelism" | "Concentricity" | "TruePosition" | "SurfaceProfile"

ComputeReynoldsNumber(density Float, velocity Float, characteristicLength Float, dynamicViscosity Float) [
  (Density * Velocity * CharacteristicLength) / DynamicViscosity
]

ComputeRocketDeltaV(ispSeconds Float, initialMassKg Float, finalDryMassKg Float) [
  G0 9.80665
  (IspSeconds * G0) * Math.Ln(InitialMassKg / FinalDryMassKg)
]

TripSubstationBreaker(sub PowerGridSubstation & { BreakerClosed true }) [
  Sub & { BreakerClosed false, ActivePowerMw 0.0 }
]
