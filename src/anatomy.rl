#
Concrete Anatomy, Diseases, Drugs, Procedures, Biochemistry & Transitions
#

Bone               AnatomicalStructure
BrainStructure     AnatomicalStructure
Joint              AnatomicalStructure & { BiomechnicalClass String, functionalClass String, structuralClass String }
Ligament           AnatomicalStructure
Muscle             AnatomicalStructure & { MuscleAction String, antagonist Muscle, bloodSupply Vessel, insertion AnatomicalStructure, nerve Nerve }
Nerve              AnatomicalStructure & { Branch AnatomicalStructure, sensoryUnit AnatomicalStructure }
Vessel             AnatomicalStructure
Artery             Vessel & { ArterialBranch AnatomicalStructure, supply_ AnatomicalStructure }
LymphaticVessel    Vessel
Vein               Vessel & { DrainsTo Vessel, tributary AnatomicalStructure }
SuperficialAnatomy MedicalEntity

InfectiousDisease    MedicalCondition & { InfectiousAgent String, InfectiousAgentClass, transmissionMethod String }
MedicalSignOrSymptom MedicalCondition & { PossibleTreatment List(MedicalTherapy) }
MedicalSign          MedicalSignOrSymptom & { IdentifyingExam Option(PhysicalExam_), identifyingTest Option(MedicalTest) }
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

DrugStrength MedicalEntity & {
  ActiveIngredient String
  AvailableIn      Option(AdministrativeArea)
  MaximumIntake    Option(MaximumDoseSchedule)
  StrengthUnit     String
  StrengthValue    Real
}

MaximumDoseSchedule     DoseSchedule
RecommendedDoseSchedule DoseSchedule
ReportedDoseSchedule    DoseSchedule

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

DiagnosticProcedure    MedicalProcedure
PhysicalExam_          MedicalProcedure & { PhysicalExam }
SurgicalProcedure      MedicalProcedure
TherapeuticProcedure   MedicalProcedure & { AdverseOutcome MedicalEntity, DoseSchedule, drug List(Drug) }
MedicalTherapy         TherapeuticProcedure & { ContraindicationE Text, duplicateTherapy MedicalTherapy, seriousAdverseOutcome MedicalEntity }
OccupationalTherapy    MedicalTherapy
PalliativeProcedure    MedicalTherapy
PhysicalTherapy        MedicalTherapy
RadiationTherapy       MedicalTherapy
RespiratoryTherapy_    MedicalTherapy
PsychologicalTreatment TherapeuticProcedure

BloodTest        MedicalTest
ImagingTest      MedicalTest & { ImagingTechnique "CT" | "MRI" | "PET" | "Ultrasound" | "XRay" }
PathologyTest    MedicalTest & { TissueSample String }
MedicalTestPanel MedicalTest & { SubTest List(MedicalTest) }
MedicalDevice    MedicalEntity & Product & { AdverseOutcome MedicalEntity, contraindication Text, postOp Text, preOp Text, procedure Text }

MedicalObservationalStudy MedicalStudy & { StudyDesign String }
MedicalTrial              MedicalStudy & { TrialDesign String, Phase_ "Phase1" | "Phase2" | "Phase3" | "Phase4" }

MedicalGuidelineContraindication MedicalGuideline
MedicalGuidelineRecommendation   MedicalGuideline & { RecommendationStrength String }
MedicalCause                     MedicalEntity & { CauseOf MedicalEntity }
MedicalContraindication          MedicalEntity
MedicalIndication                MedicalEntity
ApprovedIndication               MedicalIndication
PreventionIndication             MedicalIndication
TreatmentIndication              MedicalIndication
LifestyleModification            MedicalEntity
Diet_                            CreativeWork & MedicalEntity & LifestyleModification & { DietFeatures Text, endorsers List(Agent), expertConsiderations Text, physiologicalBenefits Option(String), risks Option(String) }
PhysicalActivity                 LifestyleModification & { AssociatedAnatomy Option(AnatomicalStructure), category_ PhysicalActivityCategory, epidemiology Text }
ExercisePlan_                    CreativeWork & PhysicalActivity & { ActivityDuration Duration_, activityFrequency String, exerciseType String, intensity_ String, repetitions Count, restPeriods String, workload Energy_ }

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

Diagnose(p Patient, c MedicalCondition) [ p & { Diagnosis (Cons { Head C & { Status_ "Active" }, tail Diagnosis }) } ]
Prescribe(p Patient, d Drug) [ p & { Drug (Cons { Head D, tail Drug }) } ]
Treat(c MedicalCondition & { Status_ "Active" }, t MedicalTherapy) [ c & { Status_ "Remission" } ]
Cure(c MedicalCondition) [ c & { Status_ "Resolved" } ]
Relapse(c MedicalCondition & { Status_ "Remission" }) [ c & { Status_ "Active" } ]
Chronify(c MedicalCondition & { Status_ "Active" }) [ c & { Status_ "Chronic" } ]
RunTest(t MedicalTest, p Patient) [ t & { UsedToDiagnose P.HealthCondition } ]
Operate(s SurgicalProcedure, p Patient) [ s & { Status_ "Completed" } ]
Vaccinate(p Patient, d Drug) [ p & { Drug (Cons { Head D, tail Drug }) } ]
StartTrial(t MedicalTrial) [ t & { Status_ "Recruiting" } ]
CompleteTrial(t MedicalTrial) [ t & { Status_ "Completed" } ]
