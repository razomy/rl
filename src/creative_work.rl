#
Abstract CreativeWork, Article, Book, Review, Comment, DigitalDocument & WebPage (schema.org)
#

Headline   String
Genre      String
InLanguage Language
Version_   String

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

Article            CreativeWork & { ArticleBody Text, ArticleSection String, PageStart Count, PageEnd Count, Pagination String, Speakable SpeakableSpecification }
Book               CreativeWork & { Isbn, BookEdition String, BookFormat BookFormatType, Illustrator Person, NumberOfPages Count, Abridged Bool }
CreativeWorkSeries CreativeWork & Series_ & { StartDate Date, EndDate Date }
Review             CreativeWork & { ItemReviewed Thing, ReviewBody Text, ReviewRating Rating, ReviewAspect String, PositiveNotes ItemList, NegativeNotes ItemList }
Comment            CreativeWork & { DownvoteCount Count, UpvoteCount Count, ParentItem CreativeWork }
SchemaMessage      CreativeWork & { Sender Agent, Recipient List(Agent), DateSent DateTime, DateReceived DateTime, DateRead DateTime, MessageAttachment List(CreativeWork) }
DigitalDocument    CreativeWork & { HasDigitalDocumentPermission List(DigitalDocumentPermission) }
WebSite            CreativeWork & { Issn }
WebPage            CreativeWork & { Breadcrumb BreadcrumbList, LastReviewed Date, MainContentOfPage WebPageElement, PrimaryImageOfPage Image, RelatedLink List(Url), Reviewer Agent, SignificantLink List(Url), Speakable SpeakableSpecification }
WebPageElement     CreativeWork & { CssSelector CssSelectorType, Xpath XPathType }
