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

Article            CreativeWork & { ArticleBody Text, articleSection String, pageStart Count, pageEnd Count, pagination String, speakable SpeakableSpecification }
Book               CreativeWork & { Isbn, bookEdition String, bookFormat BookFormatType, illustrator Person, numberOfPages Count, abridged Bool }
CreativeWorkSeries CreativeWork & Series_ & { StartDate Date, endDate Date }
Review             CreativeWork & { ItemReviewed Thing, reviewBody Text, reviewRating Rating, reviewAspect String, positiveNotes ItemList, negativeNotes ItemList }
Comment            CreativeWork & { DownvoteCount Count, upvoteCount Count, parentItem CreativeWork }
SchemaMessage      CreativeWork & { Sender Agent, recipient List(Agent), dateSent DateTime, dateReceived DateTime, dateRead DateTime, messageAttachment List(CreativeWork) }
DigitalDocument    CreativeWork & { HasDigitalDocumentPermission List(DigitalDocumentPermission) }
WebSite            CreativeWork & { Issn }
WebPage            CreativeWork & { Breadcrumb BreadcrumbList, lastReviewed Date, mainContentOfPage WebPageElement, primaryImageOfPage Image, relatedLink List(Url), reviewer Agent, significantLink List(Url), speakable SpeakableSpecification }
WebPageElement     CreativeWork & { CssSelector CssSelectorType, xpath XPathType }
