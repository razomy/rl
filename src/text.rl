#
Concrete Text Works, Reviews, Comments, web Pages & Authoring Transitions
#

NewsArticle            Article & { Dateline String, printColumn String, printEdition String, printPage String, printSection String }
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
LiveBlogPosting        BlogPosting & { CoverageStartTime DateTime, coverageEndTime DateTime, liveBlogUpdate List(BlogPosting) }
DiscussionForumPosting SocialMediaPosting
TechArticle            Article & { Dependencies String, proficiencyLevel String }
APIReference           TechArticle & { ProgrammingModel String, targetPlatform String }

Audiobook         Book & AudioObject_ & { ReadBy List(Person) }
Chapter           CreativeWork & { PageStart Count, pageEnd Count }
Poem              CreativeWork
Thesis            CreativeWork & { InSupportOf String }
Manuscript        CreativeWork
Letter_           CreativeWork
Quotation         CreativeWork & { SpokenByCharacter Agent }
Claim             CreativeWork & { Appearance CreativeWork, firstAppearance CreativeWork }
Legislation       CreativeWork & { LegislationIdentifier String, legislationJurisdiction AdministrativeArea, legislationLegalForce LegalForceStatus, legislationDate Date }
Statement         CreativeWork
HowTo             CreativeWork & { Step List(HowToStep), supply List(HowToSupply), tool List(HowToTool), totalTime Duration_, prepTime Duration_, performTime Duration_, estimatedCost MonetaryAmount, yield String }
Recipe            HowTo & { RecipeIngredient List(String), recipeInstructions List(HowToStep), recipeYield String, recipeCategory String, recipeCuisine String, cookTime Duration_, cookingMethod String, NutritionInformation, suitableForDiet RestrictedDiet }
Guide             CreativeWork & { ReviewAspect String }
Menu              CreativeWork & { HasMenuItem List(MenuItem), hasMenuSection List(MenuSection) }
MenuSection       CreativeWork & { HasMenuItem List(MenuItem) }

Periodical        CreativeWorkSeries & { Issn }
BookSeries        CreativeWorkSeries
PublicationIssue  CreativeWork & { IssueNumber String, pageStart Count, pageEnd Count }
PublicationVolume CreativeWork & { VolumeNumber String }

ClaimReview    Review & { ClaimReviewed String }
CriticReview   Review
EmployerReview Review
MediaReview    Review & { MediaAuthenticityCategory String }
Recommendation Review
UserReview     Review

Answer            Comment & { AnswerExplanation Comment }
CorrectionComment Comment
Question          Comment & { AcceptedAnswer Answer, suggestedAnswer List(Answer), answerCount Count }

EmailMessage  SchemaMessage
Conversation  CreativeWork
Collection_   CreativeWork & { CollectionSize Count }
Map_          CreativeWork & { MapType MapCategoryType }
Drawing       CreativeWork
Painting      CreativeWork
Photograph    CreativeWork
Sculpture     CreativeWork
VisualArtwork CreativeWork & { ArtMedium String, artform String, artist Person, height QuantitativeValue, width QuantitativeValue }
Season_       CreativeWork
Episode_      CreativeWork
Game          CreativeWork & { NumberOfPlayers QuantitativeValue, characterAttribute Thing, gameItem Thing, gameLocation Place, quest Thing }
Certification CreativeWork & { CertificationIdentification String, certificationStatus String, issuedBy Organization, validFrom Date, expires Date }
EducationalOccupationalCredential CreativeWork & { CredentialCategory String, recognizedBy Organization, validFor Duration_ }

NoteDigitalDocument         DigitalDocument
PresentationDigitalDocument DigitalDocument
SpreadsheetDigitalDocument  DigitalDocument
TextDigitalDocument         DigitalDocument
ArchiveComponent            CreativeWork & { HoldingArchive Organization, itemLocation Place }
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

Author(a Agent, t Text) [ CreativeWork { Author List1(A), text T, dateCreated Now, CreativeWorkStatus "Draft" } ]
Edit(w CreativeWork, t Text) [ w & { Text T, dateModified Now } ]
PublishWork(w CreativeWork & { CreativeWorkStatus "Draft" }, p Agent) [ w & { CreativeWorkStatus "Published", datePublished Now, publisher P } ]
Obsolete(w CreativeWork & { CreativeWorkStatus "Published" }) [ w & { CreativeWorkStatus "Obsolete" } ]
Cite(w CreativeWork, source CreativeWork) [ w & { Citation (Cons { Head Source, tail Citation }) } ]
Adapt(source CreativeWork, a Agent) [ CreativeWork { IsBasedOn Source, author List1(A), dateCreated Now } ]
WriteReview(a Agent, i Thing, r Rating, b Text) [ Review { Author List1(A), itemReviewed I, reviewRating R, reviewBody B, datePublished Now } ]
AddComment(w CreativeWork, c Comment) [ w & { Comment (Cons { Head C, tail Comment }), CommentCount (CommentCount + 1) } ]
AskQuestion(a Agent, t Text) [ Question { Author List1(A), text T, AnswerCount 0 } ]
AnswerQuestion(q Question, a Answer) [ q & { SuggestedAnswer (Cons { Head A, tail SuggestedAnswer }), AnswerCount (AnswerCount + 1) } ]
AcceptAnswer(q Question, a Answer) [ q & { AcceptedAnswer A } ]
Upvote(c Comment) [ c & { UpvoteCount (UpvoteCount + 1) } ]
Downvote(c Comment) [ c & { DownvoteCount (DownvoteCount + 1) } ]
