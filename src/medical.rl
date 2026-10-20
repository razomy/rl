#
Abstract Medical Entity, Anatomy, Condition, Drug, Procedure, Test, Study & BioChemEntity
#

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

AnatomicalSystem MedicalEntity & {
  ComprisedOf       List(AnatomicalStructure)
  RelatedCondition  List(MedicalCondition)
  RelatedStructure  List(AnatomicalStructure)
  RelatedTherapy    List(MedicalTherapy)
}

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

DoseSchedule MedicalEntity & {
  DoseUnit         String
  DoseValue        Real
  Frequency        String
  TargetPopulation String
}

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

MedicalProcedure MedicalEntity & {
  BodyLocation  String
  Followup      Text
  HowPerformed  Text
  PreparationE  Text
  ProcedureType MedicalProcedureType
  Status_       String
}

MedicalTest MedicalEntity & {
  AffectedBy     List(Drug)
  NormalRange    String
  SignDetected   MedicalSign
  UsedToDiagnose MedicalCondition
  UsesDevice     MedicalDevice
}

MedicalStudy MedicalEntity & {
  HealthCondition MedicalCondition
  Sponsor         Organization
  Status_         MedicalStudyStatus
  StudyLocation   Place
  StudySubject    MedicalEntity
}

MedicalGuideline MedicalEntity & {
  EvidenceLevel    MedicalEvidenceLevel
  EvidenceOrigin   Text
  GuidelineDate    Date
  GuidelineSubject MedicalEntity
}

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
