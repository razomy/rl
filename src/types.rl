#
Concrete SchemaEvent Subtypes & Event Lifecycle Transitions
#

BusinessEvent       SchemaEvent
ChildrensEvent      SchemaEvent
ComedyEvent         SchemaEvent
CourseInstanceEvent SchemaEvent
DanceEvent          SchemaEvent
DeliveryEvent       SchemaEvent & { AccessCode String, AvailableFrom DateTime, AvailableThrough DateTime, HasDeliveryMethod DeliveryMethod }
EducationEvent      SchemaEvent & { AssessesE String, EducationalLevel String, Teaches String }
EventSeries_        SchemaEvent
ExhibitionEvent     SchemaEvent
Festival            SchemaEvent
FoodEvent           SchemaEvent
Hackathon           SchemaEvent
LiteraryEvent       SchemaEvent
MusicEvent          SchemaEvent
PublicationEvent    SchemaEvent & { PublishedBy Agent, PublishedOn BroadcastService }
BroadcastEvent      PublicationEvent & { BroadcastOfEvent SchemaEvent, IsLiveBroadcast Bool, VideoFormat String }
OnDemandEvent       PublicationEvent
SaleEvent           SchemaEvent
ScreeningEvent      SchemaEvent & { SubtitleLanguage Language, VideoFormat String, WorkPresented Thing }
SocialEvent         SchemaEvent
SportsEvent         SchemaEvent & { AwayTeam Agent, HomeTeam Agent, Competitor List(Agent), Sport String }
TheaterEvent        SchemaEvent
UserInteraction     SchemaEvent
UserBlocks          UserInteraction
UserCheckins        UserInteraction
UserComments        UserInteraction
UserDownloads       UserInteraction
UserLikes           UserInteraction
UserPageVisits      UserInteraction
UserPlays           UserInteraction
UserPlusOnes        UserInteraction
UserTweets          UserInteraction
VisualArtsEvent     SchemaEvent
Wedding             SocialEvent & { Couple List(Person) }
Birthday            SocialEvent & { Celebrant Person }
Funeral             SocialEvent & { Deceased_ Person }
Conference          BusinessEvent & { Track List(String) }
Meetup              SocialEvent
Concert             MusicEvent
Match               SportsEvent & { Score String }
Election_           SchemaEvent & { Candidates List(Person) }
Protest             SchemaEvent & { Cause String }
War                 SchemaEvent & { Belligerents List(Agent) }
Disaster            SchemaEvent & { NaturalDisaster NaturalDisaster }

PlanEvent(E Event, I Interval) [ E & Planned { PlannedFor I } ]
Start(E Event & Planned) [ E / Planned & Active { StartedAt Now } ]
Pause(E Event & Active) [ E / Active & Paused { PausedAt Now } ]
Resume(E Event & Paused) [ E / Paused & Active { StartedAt Now } ]
Finish(E Event & Active) [ E / Active & Done { FinishedAt Now } ]
Cancel(E Event & Planned, Reason String) [ E / Planned & Cancelled { CancelledAt Now, Reason } ]
Postpone(E Event & Planned, I Interval) [ E / Planned & Postponed { NewTime I } ]
Fail(E Event & Active, Reason String) [ E / Active & Failed { FailedAt Now, Reason } ]
Cause_(C Event, E Event) [ Causation { Cause { Event C, Probability 1 }, Effect { Event E } } ]
Fire(T Trigger) [
  T.Condition_.Holds . {
    true [ T.Fires . Start ]
    _    [ None ]
  }
]
Record_(H History, E Event & Done) [ H & { Events (Cons { Head E, Tail Events }) } ]

ScheduleEvent(E SchemaEvent, S DateTime) [ E & { StartDate S, EventStatus "EventScheduled" } ]
CancelEvent(E SchemaEvent) [ E & { EventStatus "EventCancelled" } ]
PostponeEvent(E SchemaEvent) [ E & { EventStatus "EventPostponed", PreviousStartDate StartDate } ]
RescheduleEvent(E SchemaEvent & { EventStatus "EventPostponed" }, S DateTime) [ E & { StartDate S, EventStatus "EventRescheduled" } ]
MoveOnline(E SchemaEvent) [ E & { EventStatus "EventMovedOnline", EventAttendanceMode "OnlineEventAttendanceMode" } ]
Attend(E SchemaEvent, A Agent) [ E & { Attendee (Cons { Head A, Tail Attendee }), RemainingAttendeeCapacity (RemainingAttendeeCapacity - 1) } ]
Perform(E SchemaEvent, P Agent) [ E & { Performer (Cons { Head P, Tail Performer }) } ]
SellTicket(E SchemaEvent, O Offer) [ E & { Offers (Cons { Head O, Tail Offers }) } ]
