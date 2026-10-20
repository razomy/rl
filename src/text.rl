#
Concrete Text Works, Reviews, Comments, Web Pages & Authoring Transitions
#

NewsArticle            Article & { Dateline String, PrintColumn String, PrintEdition String, PrintPage String, PrintSection String }
AnalysisNewsArticle    NewsArticle
AskPublicNewsArticle   NewsArticle
BackgroundNewsArticle  NewsArticle
OpinionNewsArticle     NewsArticle
ReportageNewsArticle   NewsArticle
ReviewNewsArticle      NewsArticle
Report                 Article & { ReportNumber String }
SatiricalArticle       Article
ScholarlyArticle       Article
MedicalScholarlyArticle ScholarlyArticle & { PublicationType String }
SocialMediaPosting     Article & { SharedContent CreativeWork }
BlogPosting            SocialMediaPosting
LiveBlogPosting        BlogPosting & { CoverageStartTime DateTime, CoverageEndTime DateTime, LiveBlogUpdate List(BlogPosting) }
DiscussionForumPosting SocialMediaPosting
TechArticle            Article & { Dependencies String, ProficiencyLevel String }
APIReference           TechArticle & { ProgrammingModel String, TargetPlatform String }

Audiobook         Book & AudioObject_ & { ReadBy List(Person) }
Chapter           CreativeWork & { PageStart Count, PageEnd Count }
Poem              CreativeWork
Thesis            CreativeWork & { InSupportOf String }
Manuscript        CreativeWork
Letter_           CreativeWork
Quotation         CreativeWork & { SpokenByCharacter Agent }
Claim             CreativeWork & { Appearance CreativeWork, FirstAppearance CreativeWork }
Legislation       CreativeWork & { LegislationIdentifier String, LegislationJurisdiction AdministrativeArea, LegislationLegalForce LegalForceStatus, LegislationDate Date }
Statement         CreativeWork
HowTo             CreativeWork & { Step List(HowToStep), Supply List(HowToSupply), Tool List(HowToTool), TotalTime Duration_, PrepTime Duration_, PerformTime Duration_, EstimatedCost MonetaryAmount, Yield String }
Recipe            HowTo & { RecipeIngredient List(String), RecipeInstructions List(HowToStep), RecipeYield String, RecipeCategory String, RecipeCuisine String, CookTime Duration_, CookingMethod String, NutritionInformation, SuitableForDiet RestrictedDiet }
Guide             CreativeWork & { ReviewAspect String }
Menu              CreativeWork & { HasMenuItem List(MenuItem), HasMenuSection List(MenuSection) }
MenuSection       CreativeWork & { HasMenuItem List(MenuItem) }

Periodical        CreativeWorkSeries & { Issn }
BookSeries        CreativeWorkSeries
PublicationIssue  CreativeWork & { IssueNumber String, PageStart Count, PageEnd Count }
PublicationVolume CreativeWork & { VolumeNumber String }

ClaimReview    Review & { ClaimReviewed String }
CriticReview   Review
EmployerReview Review
MediaReview    Review & { MediaAuthenticityCategory String }
Recommendation Review
UserReview     Review

Answer            Comment & { AnswerExplanation Comment }
CorrectionComment Comment
Question          Comment & { AcceptedAnswer Answer, SuggestedAnswer List(Answer), AnswerCount Count }

EmailMessage  SchemaMessage
Conversation  CreativeWork
Collection_   CreativeWork & { CollectionSize Count }
Map_          CreativeWork & { MapType MapCategoryType }
Drawing       CreativeWork
Painting      CreativeWork
Photograph    CreativeWork
Sculpture     CreativeWork
VisualArtwork CreativeWork & { ArtMedium String, Artform String, Artist Person, Height QuantitativeValue, Width QuantitativeValue }
Season_       CreativeWork
Episode_      CreativeWork
Game          CreativeWork & { NumberOfPlayers QuantitativeValue, CharacterAttribute Thing, GameItem Thing, GameLocation Place, Quest Thing }
Certification CreativeWork & { CertificationIdentification String, CertificationStatus String, IssuedBy Organization, ValidFrom Date, Expires Date }
EducationalOccupationalCredential CreativeWork & { CredentialCategory String, RecognizedBy Organization, ValidFor Duration_ }

NoteDigitalDocument         DigitalDocument
PresentationDigitalDocument DigitalDocument
SpreadsheetDigitalDocument  DigitalDocument
TextDigitalDocument         DigitalDocument
ArchiveComponent            CreativeWork & { HoldingArchive Organization, ItemLocation Place }
Atlas                       CreativeWork
Blog                        CreativeWork & { BlogPost List(BlogPosting) }
Chapter_                    Chapter
Clip_                       CreativeWork
Diet_                       CreativeWork
ExercisePlan                CreativeWork
HyperToc                    CreativeWork
MathSolver                  CreativeWork
Play                        CreativeWork
Thesis_                     Thesis
WebContent                  CreativeWork
HealthTopicContent          WebContent

AboutPage             WebPage
CheckoutPage          WebPage
CollectionPage        WebPage
ImageGallery          CollectionPage
MediaGallery          CollectionPage
VideoGallery          MediaGallery
ContactPage           WebPage
FAQPage               WebPage
ItemPage              WebPage
MedicalWebPage        WebPage
ProfilePage           WebPage
QAPage                WebPage
RealEstateListing     WebPage
SearchResultsPage     WebPage
SiteNavigationElement WebPageElement
Table                 WebPageElement
WPAdBlock             WebPageElement
WPFooter              WebPageElement
WPHeader              WebPageElement
WPSideBar             WebPageElement

Author(A Agent, T Text) [ CreativeWork { Author List1(A), Text T, DateCreated Now, CreativeWorkStatus "Draft" } ]
Edit(W CreativeWork, T Text) [ W & { Text T, DateModified Now } ]
PublishWork(W CreativeWork & { CreativeWorkStatus "Draft" }, P Agent) [ W & { CreativeWorkStatus "Published", DatePublished Now, Publisher P } ]
Obsolete(W CreativeWork & { CreativeWorkStatus "Published" }) [ W & { CreativeWorkStatus "Obsolete" } ]
Cite(W CreativeWork, Source CreativeWork) [ W & { Citation (Cons { Head Source, Tail Citation }) } ]
Adapt(Source CreativeWork, A Agent) [ CreativeWork { IsBasedOn Source, Author List1(A), DateCreated Now } ]
WriteReview(A Agent, I Thing, R Rating, B Text) [ Review { Author List1(A), ItemReviewed I, ReviewRating R, ReviewBody B, DatePublished Now } ]
AddComment(W CreativeWork, C Comment) [ W & { Comment (Cons { Head C, Tail Comment }), CommentCount (CommentCount + 1) } ]
AskQuestion(A Agent, T Text) [ Question { Author List1(A), Text T, AnswerCount 0 } ]
AnswerQuestion(Q Question, A Answer) [ Q & { SuggestedAnswer (Cons { Head A, Tail SuggestedAnswer }), AnswerCount (AnswerCount + 1) } ]
AcceptAnswer(Q Question, A Answer) [ Q & { AcceptedAnswer A } ]
Upvote(C Comment) [ C & { UpvoteCount (UpvoteCount + 1) } ]
Downvote(C Comment) [ C & { DownvoteCount (DownvoteCount + 1) } ]
