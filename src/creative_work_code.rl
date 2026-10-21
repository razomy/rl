#
Abstract SoftwareApplication, SoftwareSourceCode, Dataset, Course & LearningResource
#

SoftwareApplication CreativeWork & {
    ApplicationCategory String
    ApplicationSubCategory String
    ApplicationSuite String
    AvailableOnDevice String
    CountriesSupported List(String)
    DownloadUrl Url
    FeatureList List(String)
    FileSize String
    InstallUrl Url
    MemoryRequirements String
    OperatingSystem Platform
    Permissions List(String)
    ProcessorRequirements String
    ReleaseNotes Text
    Screenshot ImageObject
    SoftwareAddOn List(SoftwareApplication)
    SoftwareHelp CreativeWork
    SoftwareRequirements List(String)
    SoftwareVersion Version
    StorageRequirements String
    SupportingData DataFeed
}

SoftwareSourceCode CreativeWork & {
    CodeRepository Url
    CodeSampleType "full" | "snippet" | "inline" | "script"
    ProgrammingLanguage
    RuntimePlatform String
    TargetProduct SoftwareApplication
}

Dataset CreativeWork & {
    Distribution List(DataDownload)
    IncludedInDataCatalog DataCatalog
    IssnD String
    MeasurementTechnique String
    VariableMeasured List(PropertyValue)
    SpatialCoverage Place
    TemporalCoverage Interval
}

DataCatalog CreativeWork & { Dataset List(Dataset), measurementTechnique String }

Course CreativeWork & {
    CourseCode String
    CoursePrerequisites List(Course)
    EducationalCredentialAwarded EducationalOccupationalCredential
    HasCourseInstance List(CourseInstance)
    NumberOfCredits Count
    OccupationalCredentialAwarded EducationalOccupationalCredential
    Syllabus List(CreativeWork)
    TotalHistoricalEnrollment Count
}

LearningResource CreativeWork & {
    AssessesSkill List(String)
    CompetencyRequired List(String)
    EducationalAlignment AlignmentObject
    TeachesSkill List(String)
}
