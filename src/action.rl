_ schema.thing
_ schema.enumerations
_ schema.intangible
_ schema.place

// =============================================================================
// Action (schema.org)
// =============================================================================

Action Thing & {
    ActionStatus ActionStatusType
    Agent
    Object Thing
    Result Thing
    Instrument Thing
    Location Place
    Participant List(Agent)
    Provider Agent
    StartTime DateTime
    EndTime DateTime
    Target EntryPoint
    Error Thing
    ActionProcess Thing
}

Potential { ActionStatus "PotentialActionStatus" }
Running_  { ActionStatus "ActiveActionStatus" }
Completed { ActionStatus "CompletedActionStatus" }
Errored   { ActionStatus "FailedActionStatus" }

// =============================================================================
// Transitions
// =============================================================================

Propose(A Agent, O Thing) [ Action { Agent A, Object O, ActionStatus "PotentialActionStatus" } ]
Begin(X Action & Potential) [ X & { ActionStatus "ActiveActionStatus", StartTime Now } ]
Complete(X Action & Running_, R Thing) [ X & { ActionStatus "CompletedActionStatus", EndTime Now, Result R } ]
FailAction(X Action & Running_, E Thing) [ X & { ActionStatus "FailedActionStatus", EndTime Now, Error E } ]
Retry(X Action & Errored) [ X & { ActionStatus "PotentialActionStatus", Error None } ]
