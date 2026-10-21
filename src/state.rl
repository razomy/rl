#
Abstract State, Contexts, Pipes, CQRS & Store Interfaces
#

ContextEventType "Add" | "Remove" | "Set"
ContextEvent     { EventType ContextEventType, key String, value Any }

IReadOnlyContext IResource & {
  Store Map(String, Any)
}

IContext IReadOnlyContext & {
  Parent   Option(IContext)
  Children List(IContext)
  Events   Channel(ContextEvent)
}

IContextable { Ctx IContext }

IPipe(T)      { Execute Any }
IPipeAsync(T) { Process Any }
IContextPipe  IResource & { Modify Any, cancel Any }

// CQRS & Jobs
IAExecutable IResource
IACommand    IAExecutable
IAQuery      IAExecutable

ICommand                IACommand & { Execute Any }
ICommandIn(TReq)        IACommand & { Execute Any }
ICommandOut(TReq, TRes) IACommand & { Execute Any }
IQuery(TRes)            IAQuery   & { Execute Any }

IJob IResource & { Execute Any, dispose Any }
AJob IJob & IContextable

// Events & Change Tracking
IEvent         Object
ExceptionEvent IEvent & { Error String, message String }

Change(T) { Before T, after T }

DifferenceType       "CREATED" | "UPDATED" | "DELETED" | "NESTED_UPDATE"
Difference(T)        { Type DifferenceType, value T }
ReplaceDifference(T) { Type DifferenceType, prevValue T, value T }
ChangeDifference(T)  Difference(T) | ReplaceDifference(T)

// Stores
IReset         { Reset Any }
IReadStore(T)  { Read Any }
IWriteStore(T) { Write Any }
IStore(T)      IReset & IReadStore(T) & IWriteStore(T)
Gate(T)        { Get Any, set Any }

// FSM
TransitionRule(S, E) {
  FromState S
  OnEvent   E
  ToState   S
}

StateMachine(S, E) {
  CurrentState S
  Rules        List(TransitionRule(S, E))
}

ITransitable IContextable & {
  Next  Option(ITransitable)
  Enter Any
  Leave Any
}
