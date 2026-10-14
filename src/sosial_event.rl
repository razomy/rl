_ schema.thing
_ schema.enumerations
_ schema.intangible
_ schema.intangible_commerce
_ schema.place
_ schema.organization
_ schema.person
_ schema.creative_work

// =============================================================================
// Event (schema.org)
// =============================================================================

SchemaEvent Thing & Event & {
    About Thing
    Actor List(Person)
    Attendee List(Agent)
    Audience
    Composer Agent
    Contributor List(Agent)
    Director Person
    DoorTime DateTime
    Duration_
    StartDate DateTime
    EndDate DateTime
    EventAttendanceMode EventAttendanceModeEnumeration
    EventSchedule Schedule_
    EventStatus EventStatusType
    Funder List(Agent)
    InLanguage Language
    IsAccessibleForFree Bool
    KeywordsE List(Keyword)
    Location Place
    MaximumAttendeeCapacity Count
    MaximumPhysicalAttendeeCapacity Count
    MaximumVirtualAttendeeCapacity Count
    Offers List(Offer)
    Organizer Agent
    Performer List(Agent)
    PreviousStartDate DateTime
    RecordedIn CreativeWork
    RemainingAttendeeCapacity Count
    Review List(Review)
    Sponsor List(Agent)
    SubEvent List(SchemaEvent)
    SuperEvent SchemaEvent
    Translator List(Agent)
    TypicalAgeRange String
    WorkFeatured CreativeWork
    WorkPerformed CreativeWork
}

BusinessEvent      SchemaEvent
ChildrensEvent     SchemaEvent
ComedyEvent        SchemaEvent
CourseInstanceEvent SchemaEvent
DanceEvent         SchemaEvent
DeliveryEvent      SchemaEvent & { AccessCode String, AvailableFrom DateTime, AvailableThrough DateTime, HasDeliveryMethod DeliveryMethod }
EducationEvent     SchemaEvent & { AssessesE String, EducationalLevel String, Teaches String }
EventSeries_       SchemaEvent
ExhibitionEvent    SchemaEvent
Festival           SchemaEvent
FoodEvent          SchemaEvent
Hackathon          SchemaEvent
LiteraryEvent      SchemaEvent
MusicEvent         SchemaEvent
PublicationEvent   SchemaEvent & { PublishedBy Agent, PublishedOn BroadcastService }
BroadcastEvent     PublicationEvent & { BroadcastOfEvent SchemaEvent, IsLiveBroadcast Bool, VideoFormat String }
OnDemandEvent      PublicationEvent
SaleEvent          SchemaEvent
ScreeningEvent     SchemaEvent & { SubtitleLanguage Language, VideoFormat String, WorkPresented Thing }
SocialEvent        SchemaEvent
SportsEvent        SchemaEvent & { AwayTeam Agent, HomeTeam Agent, Competitor List(Agent), Sport String }
TheaterEvent       SchemaEvent
UserInteraction    SchemaEvent
UserBlocks         UserInteraction
UserCheckins       UserInteraction
UserComments       UserInteraction
UserDownloads      UserInteraction
UserLikes          UserInteraction
UserPageVisits     UserInteraction
UserPlays          UserInteraction
UserPlusOnes       UserInteraction
UserTweets         UserInteraction
VisualArtsEvent    SchemaEvent
Wedding            SocialEvent & { Couple List(Person) }
Birthday           SocialEvent & { Celebrant Person }
Funeral            SocialEvent & { Deceased_ Person }
Conference         BusinessEvent & { Track List(String) }
Meetup             SocialEvent
Concert            MusicEvent
Match              SportsEvent & { Score String }
Election_          SchemaEvent & { Candidates List(Person) }
Protest            SchemaEvent & { Cause String }
War                SchemaEvent & { Belligerents List(Agent) }
Disaster           SchemaEvent & { NaturalDisaster }

// =============================================================================
// Transitions
// =============================================================================

ScheduleEvent(E SchemaEvent, S DateTime) [ E & { StartDate S, EventStatus "EventScheduled" } ]
CancelEvent(E SchemaEvent) [ E & { EventStatus "EventCancelled" } ]
PostponeEvent(E SchemaEvent) [ E & { EventStatus "EventPostponed", PreviousStartDate StartDate } ]
RescheduleEvent(E SchemaEvent & { EventStatus "EventPostponed" }, S DateTime) [ E & { StartDate S, EventStatus "EventRescheduled" } ]
MoveOnline(E SchemaEvent) [ E & { EventStatus "EventMovedOnline", EventAttendanceMode "OnlineEventAttendanceMode" } ]
Attend(E SchemaEvent, A Agent) [ E & { Attendee (Cons { Head A, Tail Attendee }), RemainingAttendeeCapacity (RemainingAttendeeCapacity - 1) } ]
Perform(E SchemaEvent, P Agent) [ E & { Performer (Cons { Head P, Tail Performer }) } ]
SellTicket(E SchemaEvent, O Offer) [ E & { Offers (Cons { Head O, Tail Offers }) } ]
