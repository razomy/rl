_ thing
_ enumeration
_ intangible
_ place
_ organization
_ person
_ product
_ creative_work

// =============================================================================
// MedicalEntity & Coding Systems
// =============================================================================

MedicalCode Intangible & {
  CodeValue    String
  CodingSystem "ICD-10" | "ICD-11" | "SNOMED-CT" | "LOINC" | "ATC" | "MeSH" | "RxNorm" | "CPT"
}

MedicalEntity Thing & {
  Code_                MedicalCode
  Guideline            List(MedicalGuideline)
  LegalStatus          String
  MedicineSystem       "WesternConventional" | "Ayurvedic" | "Chiropractic" | "Homeopathic" | "Osteopathic" | "TraditionalChinese"
  RecognizingAuthority Organization
  RelevantSpecialty    MedicalSpecialty
  Study                List(MedicalStudy)
}

// =============================================================================
// Anatomy
// =============================================================================

AnatomicalStructure MedicalEntity & {
  AssociatedPathophysiology Text
  BodyLocation              String
  ConnectedTo               List(AnatomicalStructure)
  Diagram                   Option(Image)
  PartOfSystem              AnatomicalSystem
  RelatedCondition          List(MedicalCondition)
  RelatedTherapy            List(MedicalTherapy)
  SubStructure              List(AnatomicalStructure)
  Function                  String
}

Bone                AnatomicalStructure
BrainStructure      AnatomicalStructure
Joint               AnatomicalStructure & { BiomechnicalClass String, FunctionalClass String, StructuralClass String }
Ligament            AnatomicalStructure
Muscle              AnatomicalStructure & { MuscleAction String, Antagonist Muscle, BloodSupply Vessel, Insertion AnatomicalStructure, Nerve Nerve }
Nerve               AnatomicalStructure & { Branch AnatomicalStructure, SensoryUnit AnatomicalStructure }
Vessel              AnatomicalStructure
Artery              Vessel & { ArterialBranch AnatomicalStructure, Supply_ AnatomicalStructure }
LymphaticVessel     Vessel
Vein                Vessel & { DrainsTo Vessel, Tributary AnatomicalStructure }
AnatomicalSystem    MedicalEntity & { ComprisedOf List(AnatomicalStructure), RelatedCondition List(MedicalCondition), RelatedStructure List(AnatomicalStructure), RelatedTherapy List(MedicalTherapy) }
SuperficialAnatomy  MedicalEntity

// =============================================================================
// Conditions, Symptoms, Stages & Diagnostics
// =============================================================================

MedicalConditionStage MedicalEntity & {
  StageAsNumber  Real
  SubStageSuffix Option(String)
}

DDxElement MedicalEntity & {
  Diagnosis          MedicalCondition
  DistinguishingSign List(MedicalSignOrSymptom)
}

MedicalCondition MedicalEntity & {
  AssociatedAnatomy     AnatomicalStructure
  DifferentialDiagnosis List(DDxElement)
  Drug                  List(Drug)
  Epidemiology          Text
  ExpectedPrognosis     Text
  NaturalProgression    Text
  Pathophysiology       Text
  PossibleComplication  Text
  PossibleTreatment     List(MedicalTherapy)
  PrimaryPrevention     List(MedicalTherapy)
  RiskFactor            List(MedicalRiskFactor)
  SecondaryPrevention   List(MedicalTherapy)
  SignOrSymptom         List(MedicalSignOrSymptom)
  Stage                 Option(MedicalConditionStage)
  Status_               "Active" | "Resolved" | "Chronic" | "Remission"
  TypicalTest           List(MedicalTest)
}

InfectiousDisease    MedicalCondition & { InfectiousAgent String, InfectiousAgentClass, TransmissionMethod String }
MedicalSignOrSymptom MedicalCondition & { PossibleTreatment List(MedicalTherapy) }
MedicalSign          MedicalSignOrSymptom & { IdentifyingExam Option(PhysicalExam_), IdentifyingTest Option(MedicalTest) }
VitalSign            MedicalSign
MedicalSymptom       MedicalSignOrSymptom
MedicalRiskFactor    MedicalEntity & { IncreasesRiskOf MedicalEntity }

Influenza    InfectiousDisease & { Name "influenza",    InfectiousAgentClass "Virus" }
Covid19      InfectiousDisease & { Name "COVID-19",     InfectiousAgentClass "Virus" }
Tuberculosis InfectiousDisease & { Name "tuberculosis", InfectiousAgentClass "Bacteria" }
Malaria      InfectiousDisease & { Name "malaria",      InfectiousAgentClass "Protozoa" }
Diabetes     MedicalCondition & { Name "diabetes" }
Hypertension MedicalCondition & { Name "hypertension" }
Asthma       MedicalCondition & { Name "asthma" }
Cancer       MedicalCondition & { Name "cancer" }
Depression   MedicalCondition & { Name "depression" }
Fever        MedicalSymptom & { Name "fever" }
Cough        MedicalSymptom & { Name "cough" }
Pain         MedicalSymptom & { Name "pain" }

// =============================================================================
// Pharmacology, Drugs & Supplements
// =============================================================================

DrugStrength MedicalEntity & {
  ActiveIngredient String
  AvailableIn      Option(AdministrativeArea)
  MaximumIntake    Option(MaximumDoseSchedule)
  StrengthUnit     String
  StrengthValue    Real
}

DoseSchedule MedicalEntity & {
  DoseUnit         String
  DoseValue        Real
  Frequency        String
  TargetPopulation String
}
MaximumDoseSchedule     DoseSchedule
RecommendedDoseSchedule DoseSchedule
ReportedDoseSchedule    DoseSchedule

DrugClass MedicalEntity & { Drug List(Drug) }

Drug Product & MedicalEntity & {
  ActiveIngredient       String
  AdministrationRoute    String
  AlcoholWarning         Text
  AvailableStrength      List(DrugStrength)
  BreastfeedingWarning   Option(String)
  ClinicalPharmacology   Option(String)
  DosageForm             Option(String)
  DoseSchedule           List(DoseSchedule)
  DrugClass              DrugClass
  DrugUnit               String
  FoodWarning            Option(String)
  InteractingDrug        List(Drug)
  IsAvailableGenerically Bool
  IsProprietary          Bool
  LabelDetails           Option(Url)
  MaximumIntake          Option(MaximumDoseSchedule)
  MechanismOfAction      Text
  NonProprietaryName     String
  Overdosage             Text
  PregnancyCategory      DrugPregnancyCategory
  PregnancyWarning       Option(String)
  PrescribingInfo        Option(Url)
  PrescriptionStatus     DrugPrescriptionStatus
  ProprietaryName        String
  Warning                Text
}

Substance_         MedicalEntity & { ActiveIngredient String }
DietarySupplement_ Substance_ & Product & {
  Background          Option(String)
  IsProprietary       Option(Bool)
  MaximumIntake       Option(MaximumDoseSchedule)
  MechanismOfAction   Option(String)
  NonProprietaryName  Option(String)
  RecommendedIntake   Option(RecommendedDoseSchedule)
  SafetyConsideration Option(String)
  TargetPopulation    Option(String)
}

Paracetamol Drug & { NonProprietaryName "paracetamol", PrescriptionStatus "OTC" }
Ibuprofen   Drug & { NonProprietaryName "ibuprofen",   PrescriptionStatus "OTC" }
Amoxicillin Drug & { NonProprietaryName "amoxicillin", PrescriptionStatus "PrescriptionOnly" }
Insulin     Drug & { NonProprietaryName "insulin",     PrescriptionStatus "PrescriptionOnly" }

// =============================================================================
// Procedures, Tests, Therapies, Lifestyle & Studies
// =============================================================================

MedicalProcedure MedicalEntity & {
  BodyLocation  String
  Followup      Text
  HowPerformed  Text
  PreparationE  Text
  ProcedureType MedicalProcedureType
  Status_       String
}

DiagnosticProcedure    MedicalProcedure
PhysicalExam_          MedicalProcedure & { PhysicalExam }
SurgicalProcedure      MedicalProcedure
TherapeuticProcedure   MedicalProcedure & { AdverseOutcome MedicalEntity, DoseSchedule, Drug List(Drug) }
MedicalTherapy         TherapeuticProcedure & { ContraindicationE Text, DuplicateTherapy MedicalTherapy, SeriousAdverseOutcome MedicalEntity }
OccupationalTherapy    MedicalTherapy
PalliativeProcedure    MedicalTherapy
PhysicalTherapy        MedicalTherapy
RadiationTherapy       MedicalTherapy
RespiratoryTherapy_    MedicalTherapy
PsychologicalTreatment TherapeuticProcedure

MedicalTest MedicalEntity & {
  AffectedBy     List(Drug)
  NormalRange    String
  SignDetected   MedicalSign
  UsedToDiagnose MedicalCondition
  UsesDevice     MedicalDevice
}
BloodTest        MedicalTest
ImagingTest      MedicalTest & { ImagingTechnique "CT" | "MRI" | "PET" | "Ultrasound" | "XRay" }
PathologyTest    MedicalTest & { TissueSample String }
MedicalTestPanel MedicalTest & { SubTest List(MedicalTest) }
MedicalDevice    MedicalEntity & Product & { AdverseOutcome MedicalEntity, Contraindication Text, PostOp Text, PreOp Text, Procedure Text }

MedicalStudy MedicalEntity & {
  HealthCondition MedicalCondition
  Sponsor         Organization
  Status_         MedicalStudyStatus
  StudyLocation   Place
  StudySubject    MedicalEntity
}
MedicalObservationalStudy MedicalStudy & { StudyDesign String }
MedicalTrial              MedicalStudy & { TrialDesign String, Phase_ "Phase1" | "Phase2" | "Phase3" | "Phase4" }

MedicalGuideline               MedicalEntity & { EvidenceLevel MedicalEvidenceLevel, EvidenceOrigin Text, GuidelineDate Date, GuidelineSubject MedicalEntity }
MedicalGuidelineContraindication MedicalGuideline
MedicalGuidelineRecommendation MedicalGuideline & { RecommendationStrength String }
MedicalCause                   MedicalEntity & { CauseOf MedicalEntity }
MedicalContraindication        MedicalEntity
MedicalIndication              MedicalEntity
ApprovedIndication             MedicalIndication
PreventionIndication           MedicalIndication
TreatmentIndication            MedicalIndication
LifestyleModification          MedicalEntity
Diet_                          CreativeWork & MedicalEntity & LifestyleModification & { DietFeatures Text, Endorsers List(Agent), ExpertConsiderations Text, PhysiologicalBenefits Option(String), Risks Option(String) }
PhysicalActivity               LifestyleModification & { AssociatedAnatomy Option(AnatomicalStructure), Category_ PhysicalActivityCategory, Epidemiology Text }
ExercisePlan_                  CreativeWork & PhysicalActivity & { ActivityDuration Duration_, ActivityFrequency String, ExerciseType String, Intensity_ String, Repetitions Count, RestPeriods String, Workload Energy_ }

// =============================================================================
// Biochemistry & Molecular Biology
// =============================================================================

BioChemEntity Thing & {
  AssociatedDisease              List(MedicalCondition)
  BioChemInteraction             List(BioChemEntity)
  BioChemSimilarity              List(BioChemEntity)
  BiologicalRole                 Option(String)
  HasMolecularFunction           Option(String)
  IsInvolvedInBiologicalProcess  Option(String)
  IsLocatedInSubcellularLocation Option(String)
  IsPartOfBioChemEntity          Option(BioChemEntity)
}

MolecularEntity BioChemEntity & {
  InChI            Option(String)
  InChIKey         Option(String)
  IupacName        Option(String)
  MolecularFormula Option(String)
  MolecularWeight  Option(QuantitativeValue)
  Smiles           Option(String)
}

ChemicalSubstance BioChemEntity & {
  ChemicalComposition Option(String)
  ChemicalRole        Option(String)
}

// =============================================================================
// Medical Transitions
// =============================================================================

Diagnose(P Patient, C MedicalCondition) [ P & { Diagnosis (Cons { Head C & { Status_ "Active" }, Tail Diagnosis }) } ]
Prescribe(P Patient, D Drug) [ P & { Drug (Cons { Head D, Tail Drug }) } ]
Treat(C MedicalCondition & { Status_ "Active" }, T MedicalTherapy) [ C & { Status_ "Remission" } ]
Cure(C MedicalCondition) [ C & { Status_ "Resolved" } ]
Relapse(C MedicalCondition & { Status_ "Remission" }) [ C & { Status_ "Active" } ]
Chronify(C MedicalCondition & { Status_ "Active" }) [ C & { Status_ "Chronic" } ]
RunTest(T MedicalTest, P Patient) [ T & { UsedToDiagnose P.HealthCondition } ]
Operate(S SurgicalProcedure, P Patient) [ S & { Status_ "Completed" } ]
Vaccinate(P Patient, D Drug) [ P & { Drug (Cons { Head D, Tail Drug }) } ]
StartTrial(T MedicalTrial) [ T & { Status_ "Recruiting" } ]
CompleteTrial(T MedicalTrial) [ T & { Status_ "Completed" } ]
