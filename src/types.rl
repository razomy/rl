#
Concrete SchemaEvent Subtypes & Event Lifecycle Transitions
#

BusinessEvent       SchemaEvent
ChildrensEvent      SchemaEvent
ComedyEvent         SchemaEvent
CourseInstanceEvent SchemaEvent
DanceEvent          SchemaEvent
DeliveryEvent       SchemaEvent & { AccessCode String, availableFrom DateTime, availableThrough DateTime, hasDeliveryMethod DeliveryMethod }
EducationEvent      SchemaEvent & { AssessesE String, educationalLevel String, teaches String }
EventSeries_        SchemaEvent
ExhibitionEvent     SchemaEvent
Festival            SchemaEvent
FoodEvent           SchemaEvent
Hackathon           SchemaEvent
LiteraryEvent       SchemaEvent
MusicEvent          SchemaEvent
PublicationEvent    SchemaEvent & { PublishedBy Agent, publishedOn BroadcastService }
BroadcastEvent      PublicationEvent & { BroadcastOfEvent SchemaEvent, isLiveBroadcast Bool, videoFormat String }
OnDemandEvent       PublicationEvent
SaleEvent           SchemaEvent
ScreeningEvent      SchemaEvent & { SubtitleLanguage Language, videoFormat String, workPresented Thing }
SocialEvent         SchemaEvent
SportsEvent         SchemaEvent & { AwayTeam Agent, homeTeam Agent, competitor List(Agent), sport String }
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

PlanEvent(e Event, i Interval) [ e & Planned { PlannedFor I } ]
Start(e Event & Planned) [ E / Planned & Active { StartedAt Now } ]
Pause(e Event & Active) [ E / Active & Paused { PausedAt Now } ]
Resume(e Event & Paused) [ E / Paused & Active { StartedAt Now } ]
Finish(e Event & Active) [ E / Active & Done { FinishedAt Now } ]
Cancel(e Event & Planned, reason String) [ E / Planned & Cancelled { CancelledAt Now, Reason } ]
Postpone(e Event & Planned, i Interval) [ E / Planned & Postponed { NewTime I } ]
Fail(e Event & Active, reason String) [ E / Active & Failed { FailedAt Now, Reason } ]
Cause_(c Event, e Event) [ Causation { Cause { Event C, Probability 1 }, Effect { Event E } } ]
Fire(t Trigger) [
  T.Condition_.Holds . {
    true [ T.Fires . Start ]
    _    [ None ]
  }
]
Record_(h History, e Event & Done) [ h & { Events (Cons { Head E, tail Events }) } ]

ScheduleEvent(e SchemaEvent, s DateTime) [ e & { StartDate S, EventStatus "EventScheduled" } ]
CancelEvent(e SchemaEvent) [ e & { EventStatus "EventCancelled" } ]
PostponeEvent(e SchemaEvent) [ e & { EventStatus "EventPostponed", previousStartDate StartDate } ]
RescheduleEvent(e SchemaEvent & { EventStatus "EventPostponed" }, s DateTime) [ e & { StartDate S, EventStatus "EventRescheduled" } ]
MoveOnline(e SchemaEvent) [ e & { EventStatus "EventMovedOnline", EventAttendanceMode "OnlineEventAttendanceMode" } ]
Attend(e SchemaEvent, a Agent) [ e & { Attendee (Cons { Head A, tail Attendee }), RemainingAttendeeCapacity (RemainingAttendeeCapacity - 1) } ]
Perform(e SchemaEvent, p Agent) [ e & { Performer (Cons { Head P, tail Performer }) } ]
SellTicket(e SchemaEvent, o Offer) [ e & { Offers (Cons { Head O, tail Offers }) } ]
