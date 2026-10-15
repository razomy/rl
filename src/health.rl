// =============================================================================
// Health, Medicine, Fitness, Diet & Biology
// =============================================================================

MedicalEntity Thing & {
  Code             Option(MedicalCode)
  Guideline        List(MedicalGuideline)
  LegalStatus      Option(Str)
  MedicineSystem   Option(Str)
  RecognizingAuthority Option(Organization)
  RelevantSpecialty Option(Str)
  Study            List(MedicalStudy)
}

MedicalCode Intangible & {
  CodeValue    Str
  CodingSystem Str
}
MedicalGuideline MedicalEntity & {
  EvidenceLevel  Option(Str)
  EvidenceOrigin Option(Str)
  GuidelineDate  Option(Date)
  GuidelineSubject Option(MedicalEntity)
}
MedicalStudy MedicalEntity & {
  HealthCondition Option(MedicalCondition)
  Phase           Option(Str)
  Sponsor         Option(Agent)
  Status          Option(Str)
  StudyLocation   Option(Place)
  StudySubject    Option(MedicalEntity)
}

// Anatomy
AnatomicalStructure MedicalEntity & {
  AssociatedPathophysiology Option(Str)
  BodyLocation              Option(Str)
  ConnectedTo               List(AnatomicalStructure)
  Diagram                   Option(ImageObject)
  PartOfSystem              Option(AnatomicalSystem)
  RelatedCondition          List(MedicalCondition)
  RelatedTherapy            List(MedicalTherapy)
  SubStructure              List(AnatomicalStructure)
}
Bone              AnatomicalStructure
BrainStructure    AnatomicalStructure
Joint             AnatomicalStructure & { BiomechnicalClass Option(Str), FunctionalClass Option(Str), StructuralClass Option(Str) }
Ligament          AnatomicalStructure
Muscle            AnatomicalStructure & { Antagonist Option(Muscle), BloodSupply Option(Vessel), Insertion Option(AnatomicalStructure), MuscleAction Option(Str), Nerve Option(Nerve) }
Nerve             AnatomicalStructure
Vessel            AnatomicalStructure
Artery            Vessel
LymphaticVessel   Vessel
Vein              Vessel
AnatomicalSystem  MedicalEntity & {
  ComprisedOf       List(AnatomicalStructure | AnatomicalSystem)
  RelatedCondition  List(MedicalCondition)
  RelatedStructure  List(AnatomicalStructure)
  RelatedTherapy    List(MedicalTherapy)
}

// Conditions, Symptoms & Diagnostics
MedicalCondition MedicalEntity & {
  AssociatedAnatomy       Option(AnatomicalStructure | AnatomicalSystem)
  DifferentialDiagnosis   List(DDxElement)
  Drug                    List(Drug)
  Epidemiology            Option(Str)
  ExpectedPrognosis       Option(Str)
  NaturalProgression      Option(Str)
  Pathophysiology         Option(Str)
  PossibleComplication    List(Str)
  PossibleTreatment       List(MedicalTherapy)
  PrimaryPrevention       List(MedicalTherapy)
  RiskFactor              List(MedicalRiskFactor)
  SecondaryPrevention     List(MedicalTherapy)
  SignOrSymptom           List(MedicalSignOrSymptom)
  Stage                   Option(MedicalConditionStage)
  Status                  Option(Str)
  TypicalTest             List(MedicalTest)
}
InfectiousDisease MedicalCondition & {
  InfectiousAgent      Str
  InfectiousAgentClass Option(Str)
  TransmissionMethod   Option(Str)
}
MedicalSignOrSymptom MedicalCondition & {
  PossibleTreatment List(MedicalTherapy)
}
MedicalSign    MedicalSignOrSymptom & {
  IdentifyingExam Option(PhysicalExam)
  IdentifyingTest Option(MedicalTest)
}
MedicalSymptom MedicalSignOrSymptom

MedicalConditionStage MedicalEntity & {
  StageAsNumber Float
  SubStageSuffix Option(Str)
}
MedicalRiskFactor MedicalEntity & {
  IncreasesRiskOf MedicalEntity
}
DDxElement MedicalEntity & {
  Diagnosis        MedicalCondition
  DistinguishingSign List(MedicalSignOrSymptom)
}

// Tests & Procedures
MedicalTest MedicalEntity & {
  AffectedBy       List(Drug)
  NormalRange      Option(Str)
  SignDetected     List(MedicalSign)
  UsedToDiagnose   List(MedicalCondition)
  UsesDevice       Option(MedicalDevice)
}
BloodTest        MedicalTest
ImagingTest      MedicalTest & { ImagingTechnique Str }
PathologyTest    MedicalTest & { TissueSample Str }
DiagnosticProcedure MedicalProcedure & MedicalTest

MedicalProcedure MedicalEntity & {
  BodyLocation  Option(Str)
  Followup      Option(Str)
  HowPerformed  Option(Str)
  Preparation   Option(Str)
  ProcedureType Option(Str)
  Status        Option(Str)
}
SurgicalProcedure    MedicalProcedure
TherapeuticProcedure MedicalProcedure & {
  AdverseOutcome List(MedicalEntity)
  DoseSchedule   List(DoseSchedule)
  Drug           List(Drug)
}
PhysicalExam         MedicalProcedure

// Therapies, Drugs, Devices, Diet & Exercise
MedicalTherapy TherapeuticProcedure & {
  Contraindication List(MedicalContraindication | Str)
  DuplicateTherapy List(MedicalTherapy)
  SeriousAdverseOutcome List(MedicalEntity)
}
OccupationalTherapy MedicalTherapy
PalliativeProcedure MedicalTherapy
PhysicalTherapy     MedicalTherapy
RadiationTherapy    MedicalTherapy
RespiratoryTherapy  MedicalTherapy

MedicalContraindication MedicalEntity

Drug MedicalEntity & Product & {
  ActiveIngredient    Str
  AdministrationRoute Option(Str)
  AlcoholWarning      Option(Str)
  AvailableStrength   List(DrugStrength)
  BreastfeedingWarning Option(Str)
  ClinicalPharmacology Option(Str)
  DosageForm          Option(Str)
  DoseSchedule        List(DoseSchedule)
  DrugClass           Option(Str)
  DrugUnit            Option(Str)
  FoodWarning         Option(Str)
  InteractingDrug     List(Drug)
  IsAvailableGenerically Option(Bool)
  IsProprietary       Option(Bool)
  LabelDetails        Option(URL)
  MaximumIntake       Option(MaximumDoseSchedule)
  MechanismOfAction   Option(Str)
  NonProprietaryName  Option(Str)
  Overdosage          Option(Str)
  PregnancyCategory   Option(Str)
  PregnancyWarning    Option(Str)
  PrescribingInfo     Option(URL)
  PrescriptionStatus  "OTC" | "PrescriptionOnly"
  ProprietaryName     Option(Str)
  Warning             Option(Str | URL)
}
DrugStrength MedicalEntity & {
  ActiveIngredient Str
  AvailableIn      Option(AdministrativeArea)
  MaximumIntake    Option(MaximumDoseSchedule)
  StrengthUnit     Str
  StrengthValue    Float
}
DoseSchedule MedicalEntity & {
  DoseUnit         Str
  DoseValue        Float
  Frequency        Str
  TargetPopulation Option(Str)
}
MaximumDoseSchedule  DoseSchedule
RecommendedDoseSchedule DoseSchedule
ReportedDoseSchedule DoseSchedule

DietarySupplement MedicalEntity & Product & {
  ActiveIngredient  Str
  Background        Option(Str)
  IsProprietary     Option(Bool)
  MaximumIntake     Option(MaximumDoseSchedule)
  MechanismOfAction Option(Str)
  NonProprietaryName Option(Str)
  RecommendedIntake Option(RecommendedDoseSchedule)
  SafetyConsideration Option(Str)
  TargetPopulation  Option(Str)
}

MedicalDevice MedicalEntity & Product & {
  AdverseOutcome     List(MedicalEntity)
  Contraindication   List(MedicalContraindication | Str)
  PostOp             Option(Str)
  PreOp              Option(Str)
  Procedure          Option(Str)
  SeriousAdverseOutcome List(MedicalEntity)
}

Diet CreativeWork & MedicalTherapy & {
  DietFeatures          Option(Str)
  Endorsers             List(Agent)
  ExpertConsiderations  Option(Str)
  Overview              Option(Str)
  PhysiologicalBenefits Option(Str)
  Risks                 Option(Str)
}
Diet_ Diet

ExercisePlan CreativeWork & PhysicalActivity & {
  ActivityDuration  Option(Duration)
  ActivityFrequency Option(Str)
  AdditionalVariable Option(Str)
  ExerciseType      Str
  Intensity         Option(Str)
  Repetitions       Option(Count)
  RestPeriods       Option(Str)
  Workload          Option(Energy)
}

PhysicalActivity MedicalEntity & {
  AssociatedAnatomy Option(AnatomicalStructure | AnatomicalSystem)
  Category          Option(Str)
  Epidemiology      Option(Str)
  Pathophysiology   Option(Str)
}

// Biology & Taxonomy
Taxon Thing & {
  ChildTaxon      List(Taxon)
  ParentTaxon     Option(Taxon)
  TaxonRank       "Domain" | "Kingdom" | "Phylum" | "Class" | "Order" | "Family" | "Genus" | "Species"
  ScientificName  Str
}

BioChemEntity Thing & {
  AssociatedDisease List(MedicalCondition)
  BioChemInteraction List(BioChemEntity)
  BioChemSimilarity List(BioChemEntity)
  BiologicalRole    Option(Str)
  HasMolecularFunction Option(Str)
  IsInvolvedInBiologicalProcess Option(Str)
  IsLocatedInSubcellularLocation Option(Str)
  IsPartOfBioChemEntity Option(BioChemEntity)
  TaxonomicRange    Option(Taxon)
}
Gene              BioChemEntity & { EncodesBioChemEntity Option(BioChemEntity), ExpressedIn Option(AnatomicalStructure) }
Protein           BioChemEntity & { HasBioPolymerSequence Option(Str) }
MolecularEntity   BioChemEntity & {
  InChI            Option(Str)
  InChIKey         Option(Str)
  IupacName        Option(Str)
  MolecularFormula Option(Str)
  MolecularWeight  Option(QuantitativeValue)
  Smiles           Option(Str)
}
ChemicalSubstance BioChemEntity & {
  ChemicalComposition Option(Str)
  ChemicalRole        Option(Str)
}
