_ thing
_ enumeration
_ intangible
_ commerce
_ place
_ organization
_ person

#
CreativeWork
#

Headline String
Genre    String
InLanguage Language
Version_ String

CreativeWork Thing & {
    About Thing
    Abstract Text
    Author List(Agent)
    Creator List(Agent)
    Contributor List(Agent)
    Editor List(Person)
    Publisher Agent
    Producer Agent
    Provider Agent
    Funder List(Agent)
    Sponsor List(Agent)
    CopyrightHolder Agent
    CopyrightYear Year
    CopyrightNotice String
    License Url
    DateCreated DateTime
    DateModified DateTime
    DatePublished DateTime
    Expires DateTime
    Headline
    AlternativeHeadline String
    Text
    Keywords List(Keyword)
    Genre
    InLanguage
    Version_
    Audience
    ContentRating String
    ContentLocation Place
    LocationCreated Place
    SpatialCoverage Place
    TemporalCoverage Interval
    EncodingFormat MimeType
    Encoding List(Any)
    AssociatedMedia List(Any)
    Thumbnail Image
    Comment List(Comment)
    CommentCount Count
    Review List(Review)
    AggregateRating
    Offers List(Offer)
    Award List(String)
    Citation List(CreativeWork)
    IsBasedOn CreativeWork
    IsPartOf CreativeWork
    HasPart List(CreativeWork)
    WorkExample List(CreativeWork)
    ExampleOfWork CreativeWork
    Position Count
    InteractionStatistic InteractionCounter
    IsAccessibleForFree Bool
    IsFamilyFriendly Bool
    AccessMode String
    AccessibilityFeature List(String)
    CreativeWorkStatus "Draft" | "Published" | "Obsolete" | "Incomplete"
    EducationalLevel String
    LearningResourceType String
    TypicalAgeRange String
    TimeRequired Duration_
    WordCount Count
}

#
Text works
#

Article CreativeWork & { ArticleBody Text, ArticleSection String, PageStart Count, PageEnd Count, Pagination String, Speakable SpeakableSpecification }
NewsArticle     Article & { Dateline String, PrintColumn String, PrintEdition String, PrintPage String, PrintSection String }
AnalysisNewsArticle NewsArticle
AskPublicNewsArticle NewsArticle
BackgroundNewsArticle NewsArticle
OpinionNewsArticle NewsArticle
ReportageNewsArticle NewsArticle
ReviewNewsArticle NewsArticle
Report          Article & { ReportNumber String }
SatiricalArticle Article
ScholarlyArticle Article
MedicalScholarlyArticle ScholarlyArticle & { PublicationType String }
SocialMediaPosting Article & { SharedContent CreativeWork }
BlogPosting     SocialMediaPosting
LiveBlogPosting BlogPosting & { CoverageStartTime DateTime, CoverageEndTime DateTime, LiveBlogUpdate List(BlogPosting) }
DiscussionForumPosting SocialMediaPosting
TechArticle     Article & { Dependencies String, ProficiencyLevel String }
APIReference    TechArticle & { ProgrammingModel String, TargetPlatform String }

Book CreativeWork & { Isbn, BookEdition String, BookFormat BookFormatType, Illustrator Person, NumberOfPages Count, Abridged Bool }
Audiobook Book & AudioObject_ & { ReadBy List(Person) }
Chapter   CreativeWork & { PageStart Count, PageEnd Count }
Poem      CreativeWork
Thesis    CreativeWork & { InSupportOf String }
Manuscript CreativeWork
Letter_   CreativeWork
Quotation CreativeWork & { SpokenByCharacter Agent }
Claim     CreativeWork & { Appearance CreativeWork, FirstAppearance CreativeWork }
Legislation CreativeWork & { LegislationIdentifier String, LegislationJurisdiction AdministrativeArea, LegislationLegalForce LegalForceStatus, LegislationDate Date }
Statement CreativeWork
Recipe    HowTo & { RecipeIngredient List(String), RecipeInstructions List(HowToStep), RecipeYield String, RecipeCategory String, RecipeCuisine String, CookTime Duration_, CookingMethod String, NutritionInformation, SuitableForDiet RestrictedDiet }
HowTo     CreativeWork & { Step List(HowToStep), Supply List(HowToSupply), Tool List(HowToTool), TotalTime Duration_, PrepTime Duration_, PerformTime Duration_, EstimatedCost MonetaryAmount, Yield String }
Guide     CreativeWork & { ReviewAspect String }
Menu      CreativeWork & { HasMenuItem List(MenuItem), HasMenuSection List(MenuSection) }
MenuSection CreativeWork & { HasMenuItem List(MenuItem) }

Periodical CreativeWorkSeries & { Issn }
CreativeWorkSeries CreativeWork & Series_ & { StartDate Date, EndDate Date }
BookSeries CreativeWorkSeries
PublicationIssue CreativeWork & { IssueNumber String, PageStart Count, PageEnd Count }
PublicationVolume CreativeWork & { VolumeNumber String }

#
Reviews, comments, messages
#

Review CreativeWork & { ItemReviewed Thing, ReviewBody Text, ReviewRating Rating, ReviewAspect String, PositiveNotes ItemList, NegativeNotes ItemList }
ClaimReview    Review & { ClaimReviewed String }
CriticReview   Review
EmployerReview Review
MediaReview    Review & { MediaAuthenticityCategory String }
Recommendation Review
UserReview     Review

Comment CreativeWork & { DownvoteCount Count, UpvoteCount Count, ParentItem CreativeWork }
Answer   Comment & { AnswerExplanation Comment }
CorrectionComment Comment
Question Comment & { AcceptedAnswer Answer, SuggestedAnswer List(Answer), AnswerCount Count }

SchemaMessage CreativeWork & { Sender Agent, Recipient List(Agent), DateSent DateTime, DateReceived DateTime, DateRead DateTime, MessageAttachment List(CreativeWork) }
EmailMessage SchemaMessage

Conversation CreativeWork
Collection_  CreativeWork & { CollectionSize Count }
Map_         CreativeWork & { MapType MapCategoryType }
Drawing      CreativeWork
Painting     CreativeWork
Photograph   CreativeWork
Sculpture    CreativeWork
VisualArtwork CreativeWork & { ArtMedium String, Artform String, Artist Person, Height QuantitativeValue, Width QuantitativeValue }
Season_      CreativeWork
Episode_     CreativeWork
Game         CreativeWork & { NumberOfPlayers QuantitativeValue, CharacterAttribute Thing, GameItem Thing, GameLocation Place, Quest Thing }
Certification CreativeWork & { CertificationIdentification String, CertificationStatus String, IssuedBy Organization, ValidFrom Date, Expires Date }
EducationalOccupationalCredential CreativeWork & { CredentialCategory String, RecognizedBy Organization, ValidFor Duration_ }
DigitalDocument CreativeWork & { HasDigitalDocumentPermission List(DigitalDocumentPermission) }
NoteDigitalDocument         DigitalDocument
PresentationDigitalDocument DigitalDocument
SpreadsheetDigitalDocument  DigitalDocument
TextDigitalDocument         DigitalDocument
ArchiveComponent CreativeWork & { HoldingArchive Organization, ItemLocation Place }
Atlas        CreativeWork
Blog         CreativeWork & { BlogPost List(BlogPosting) }
Chapter_     Chapter
Clip_        CreativeWork
Diet_        CreativeWork
ExercisePlan CreativeWork
HyperToc     CreativeWork
MathSolver   CreativeWork
Play         CreativeWork
Thesis_      Thesis
WebContent   CreativeWork
HealthTopicContent WebContent

#
Web
#

WebSite  CreativeWork & { Issn }
WebPage  CreativeWork & { Breadcrumb BreadcrumbList, LastReviewed Date, MainContentOfPage WebPageElement, PrimaryImageOfPage Image, RelatedLink List(Url), Reviewer Agent, SignificantLink List(Url), Speakable SpeakableSpecification }
AboutPage        WebPage
CheckoutPage     WebPage
CollectionPage   WebPage
ImageGallery     CollectionPage
MediaGallery     CollectionPage
VideoGallery     MediaGallery
ContactPage      WebPage
FAQPage          WebPage
ItemPage         WebPage
MedicalWebPage   WebPage
ProfilePage      WebPage
QAPage           WebPage
RealEstateListing WebPage
SearchResultsPage WebPage
WebPageElement   CreativeWork & { CssSelector CssSelectorType, Xpath XPathType }
SiteNavigationElement WebPageElement
Table            WebPageElement
WPAdBlock        WebPageElement
WPFooter         WebPageElement
WPHeader         WebPageElement
WPSideBar        WebPageElement

#
Transitions
#

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
