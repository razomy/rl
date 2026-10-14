_ meta
_ primitives
_ structures
_ core.quantity
_ core.time
_ core.space
_ core.agent

// =============================================================================
// Occurrences
// =============================================================================

EventKind "natural" | "social" | "biological" | "physical" | "economic" | "political"
    | "cultural" | "sport" | "personal" | "technical" | "historical"
Scale_ "personal" | "local" | "regional" | "national" | "global" | "cosmic"

Event {
    Name
    EventKind
    Interval
    Location GeoCoordinate
    Participants List(Agent)
    Scale_
}

// =============================================================================
// Lifecycle
// =============================================================================

Planned   { PlannedFor Interval }
Active    { StartedAt Instant }
Paused    { PausedAt Instant }
Done      { FinishedAt Instant }
Cancelled { CancelledAt Instant, Reason String }
Postponed { NewTime Interval }
Failed    { FailedAt Instant, Reason String }
Lifecycle Planned | Active | Paused | Done | Cancelled | Postponed | Failed

// =============================================================================
// Causality
// =============================================================================

Probability Fraction
Certainty "impossible" | "unlikely" | "possible" | "likely" | "certain"

Cause  { Event, Probability }
Effect { Event, Delay Duration, Magnitude Real }
Causation { Cause, Effect }
Condition_ { Predicate String, Holds Bool }
Trigger { Condition_, Fires Event }

Process {
    Name
    Steps List(Event)
    Lifecycle
}

History  { Events List(Event) }
Era_     { Name, Interval }
Epoch    Era_
Milestone Event & { Significance String }

// =============================================================================
// Transitions
// =============================================================================

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
