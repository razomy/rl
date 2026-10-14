_ thing
_ enumerations
_ intangible
_ intangible_commerce
_ organization
_ person
_ creative_work
_ creative_work_media

// =============================================================================
// Software
// =============================================================================

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
MobileApplication SoftwareApplication & { CarrierRequirements String }
WebApplication    SoftwareApplication & { BrowserRequirements String }
VideoGame         SoftwareApplication & Game & { GamePlatform String, GameServer, PlayMode GamePlayMode, CheatCode List(CreativeWork), GameTip List(CreativeWork) }
OperatingSystem_  SoftwareApplication

SoftwareSourceCode CreativeWork & {
    CodeRepository Url
    CodeSampleType "full" | "snippet" | "inline" | "script"
    ProgrammingLanguage
    RuntimePlatform String
    TargetProduct SoftwareApplication
}

// =============================================================================
// Data
// =============================================================================

Dataset CreativeWork & {
    Distribution List(DataDownload)
    IncludedInDataCatalog DataCatalog
    IssnD String
    MeasurementTechnique String
    VariableMeasured List(PropertyValue)
    SpatialCoverage Place
    TemporalCoverage Interval
}
DataFeed    Dataset & { DataFeedElement List(DataFeedItem) }
CompleteDataFeed DataFeed
DataCatalog CreativeWork & { Dataset List(Dataset), MeasurementTechnique String }

// =============================================================================
// Learning
// =============================================================================

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
CourseInstance { CourseMode "online" | "onsite" | "blended", CourseWorkload String, Instructor List(Person), StartDate Date, EndDate Date }
LearningResource CreativeWork & { AssessesSkill List(String), CompetencyRequired List(String), EducationalAlignment AlignmentObject, TeachesSkill List(String) }
Quiz LearningResource
SyllabusDoc LearningResource

// =============================================================================
// Transitions
// =============================================================================

Develop(T Agent, Name_ Name, L ProgrammingLanguage) [ SoftwareSourceCode { Name Name_, Author List1(T), ProgrammingLanguage L, DateCreated Now } ]
Commit(S SoftwareSourceCode, T Text) [ S & { Text T, DateModified Now } ]
Ship(S SoftwareApplication, V Version) [ S & { SoftwareVersion V, DatePublished Now } ]
Patch(S SoftwareApplication, Notes Text) [ S & { ReleaseNotes Notes, DateModified Now } ]
Deprecate(S SoftwareApplication) [ S & { CreativeWorkStatus "Obsolete" } ]
CollectData(D Dataset, X DataDownload) [ D & { Distribution (Cons { Head X, Tail Distribution }) } ]
Catalogue(C DataCatalog, D Dataset) [ C & { Dataset (Cons { Head D, Tail Dataset }) } ]
Enroll(C Course, P Person) [ C & { TotalHistoricalEnrollment (TotalHistoricalEnrollment + 1) } ]
Teach(C Course, I Person, Start Date) [ CourseInstance { Instructor List1(I), StartDate Start } ]
Certify(P Person, C Course) [ C.EducationalCredentialAwarded & { RecognizedBy C.Provider } ]
