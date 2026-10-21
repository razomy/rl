#
Concrete Software Applications, data Feeds, Courses & Transitions
#

MobileApplication SoftwareApplication & { CarrierRequirements String }
WebApplication    SoftwareApplication & { BrowserRequirements String }
VideoGame         SoftwareApplication & Game & { GamePlatform String, GameServer, playMode GamePlayMode, cheatCode List(CreativeWork), gameTip List(CreativeWork) }
OperatingSystem_  SoftwareApplication

DataFeed         Dataset & { DataFeedElement List(DataFeedItem) }
CompleteDataFeed DataFeed

CourseInstance { CourseMode "online" | "onsite" | "blended", courseWorkload String, instructor List(Person), startDate Date, endDate Date }
Quiz           LearningResource
SyllabusDoc    LearningResource

Develop(t Agent, name Name, l ProgrammingLanguage) [ SoftwareSourceCode { Name name, author List1(T), programmingLanguage L, dateCreated Now } ]
Commit(s SoftwareSourceCode, t Text) [ s & { Text t, dateModified Now } ]
Ship(s SoftwareApplication, v Version) [ s & { SoftwareVersion v, datePublished Now } ]
Patch(s SoftwareApplication, notes Text) [ s & { ReleaseNotes notes, dateModified Now } ]
Deprecate(s SoftwareApplication) [ s & { CreativeWorkStatus "Obsolete" } ]
CollectData(d Dataset, x DataDownload) [ d & { Distribution (Cons { Head X, tail Distribution }) } ]
Catalogue(c DataCatalog, d Dataset) [ c & { Dataset (Cons { Head d, tail Dataset }) } ]
Enroll(c Course, p Person) [ c & { TotalHistoricalEnrollment (TotalHistoricalEnrollment + 1) } ]
Teach(c Course, i Person, start Date) [ CourseInstance { Instructor List1(i), startDate start } ]
Certify(p Person, c Course) [ c.EducationalCredentialAwarded & { RecognizedBy c.Provider } ]
