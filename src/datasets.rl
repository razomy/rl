#
Concrete Software Applications, Data Feeds, Courses & Transitions
#

MobileApplication SoftwareApplication & { CarrierRequirements String }
WebApplication    SoftwareApplication & { BrowserRequirements String }
VideoGame         SoftwareApplication & Game & { GamePlatform String, GameServer, PlayMode GamePlayMode, CheatCode List(CreativeWork), GameTip List(CreativeWork) }
OperatingSystem_  SoftwareApplication

DataFeed         Dataset & { DataFeedElement List(DataFeedItem) }
CompleteDataFeed DataFeed

CourseInstance { CourseMode "online" | "onsite" | "blended", CourseWorkload String, Instructor List(Person), StartDate Date, EndDate Date }
Quiz           LearningResource
SyllabusDoc    LearningResource

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
