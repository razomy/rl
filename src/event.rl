#
Abstract Event, lifecycle Typestates, Causation, Process & SchemaEvent
#

EventKind "natural" | "social" | "biological" | "physical" | "economic" | "political"
    | "cultural" | "sport" | "personal" | "technical" | "historical"
Scale_ "personal" | "local" | "regional" | "national" | "global" | "cosmic"

Event {
  Name         Name
  EventKind    EventKind
  Interval     Interval
  Location     GeoCoordinate
  Participants List(Agent)
  Scale_       Scale_
}

Planned   { PlannedFor Interval }
Active    { StartedAt Instant }
Paused    { PausedAt Instant }
Done      { FinishedAt Instant }
Cancelled { CancelledAt Instant, reason String }
Postponed { NewTime Interval }
Failed    { FailedAt Instant, reason String }
Lifecycle Planned | Active | Paused | Done | Cancelled | Postponed | Failed

Probability Fraction
Certainty   "impossible" | "unlikely" | "possible" | "likely" | "certain"

Cause      { Event Event, probability Probability }
Effect     { Event Event, delay Duration, magnitude Real }
Causation  { Cause Cause, effect Effect }
Condition_ { Predicate String, holds Bool }
Trigger    { Condition_ Condition_, fires Event }

Process {
  Name      Name
  Steps     List(Event)
  Lifecycle Lifecycle
}

History   { Events List(Event) }
Era_      { Name Name, interval Interval }
Epoch     Era_
Milestone Event & { Significance String }

SchemaEvent Thing & Event & {
  About                           Thing
  Actor                           List(Person)
  Attendee                        List(Agent)
  Audience                        Audience
  Composer                        Agent
  Contributor                     List(Agent)
  Director                        Person
  DoorTime                        DateTime
  Duration_                       Duration_
  StartDate                       DateTime
  EndDate                         DateTime
  EventAttendanceMode             EventAttendanceModeEnumeration
  EventSchedule                   Schedule_
  EventStatus                     EventStatusType
  Funder                          List(Agent)
  InLanguage                      Language
  IsAccessibleForFree             Bool
  KeywordsE                       List(Keyword)
  Location                        Place
  MaximumAttendeeCapacity         Count
  MaximumPhysicalAttendeeCapacity Count
  MaximumVirtualAttendeeCapacity  Count
  Offers                          List(Offer)
  Organizer                       Agent
  Performer                       List(Agent)
  PreviousStartDate               DateTime
  RecordedIn                      CreativeWork
  RemainingAttendeeCapacity       Count
  Review                          List(Review)
  Sponsor                         List(Agent)
  SubEvent                        List(SchemaEvent)
  SuperEvent                      SchemaEvent
  Translator                      List(Agent)
  TypicalAgeRange                 String
  WorkFeatured                    CreativeWork
  WorkPerformed                   CreativeWork
}
