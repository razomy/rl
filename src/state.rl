_ primitive
_ primitive
_ structure
_ concurrency

// =============================================================================
// Transactional Memory & Reactive Primitives
// =============================================================================

Atom(T) {
  Read()                            [ Self . native_atom_read ]
  Swap(Transition)                  [ (Self, Transition) . native_atom_swap ]
  Reset(NewVal T)                   [ (Self, NewVal) . native_atom_reset ]
  CompareAndSet(Expected T, Next T) [ (Self, Expected, Next) . native_atom_cas ]
}

SignalState(T) {
  Get()         [ Self . native_signal_get ]
  Set(Val T)    [ (Self, Val) . native_signal_set ]
  Subscribe(Fn) [ (Self, Fn) . native_signal_subscribe ]
}

Computed(T) {
  Evaluate() [ Self . native_computed_eval ]
}

// =============================================================================
// Contexts, Pipes, CQRS Commands & Queries
// =============================================================================

ContextEventType "Add" | "Remove" | "Set"
ContextEvent     { EventType ContextEventType, Key String, Value Any }

IReadOnlyContext IResource & {
  Store Map(String, Any)
}

IContext IReadOnlyContext & {
  Parent   Option(IContext)
  Children List(IContext)
  Events   Channel(ContextEvent)
}

IContextable { Ctx IContext }

ContextRegistry {
  Registry Map(String, IContext)
  Events   Channel(ContextEvent)
}

IPipe(T)      { Execute Any }
IPipeAsync(T) { Process Any }
IContextPipe  IResource & { Modify Any, Cancel Any }

Pipeline(T)      { Pipes List(IPipe(T)) }
PipelineAsync(T) { Pipes List(IPipeAsync(T)) }

ParallelPipe(T) {
  Pipes List(IPipeAsync(T))
  Merge Any
}

ContextPipeline IContextable & IContextPipe & {
  Pipes Map(String, IContextPipe)
}

// CQRS & Jobs
IAExecutable IResource
IACommand    IAExecutable
IAQuery      IAExecutable

ICommand                IACommand & { Execute Any }
ICommandIn(TReq)        IACommand & { Execute Any }
ICommandOut(TReq, TRes) IACommand & { Execute Any }
IQuery(TRes)            IAQuery   & { Execute Any }

IJob IResource & { Execute Any, Dispose Any }
AJob IJob & IContextable

// =============================================================================
// Events, Change Tracking & Reactive Collections
// =============================================================================

IEvent         {}
ExceptionEvent IEvent & { Error String, Message String }

Change(T) { Before T, After T }

DifferenceType       "CREATED" | "UPDATED" | "DELETED" | "NESTED_UPDATE"
Difference(T)        { Type DifferenceType, Value T }
ReplaceDifference(T) { Type DifferenceType, PrevValue T, Value T }
ChangeDifference(T)  Difference(T) | ReplaceDifference(T)

EnumerableBroker(T) {
  CreateEvent  Channel(T)
  DestroyEvent Channel(T)
  UpdateEvent  Channel(Change(T))
}

ReactiveCollection(T) {
  Items    List(T)
  OnCreate List(Any)
  OnRead   List(Any)
  OnUpdate List(Any)
  OnDelete List(Any)
}

IReset         { Reset Any }
IReadStore(T)  { Read Any }
IWriteStore(T) { Write Any }
IStore(T)      IReset & IReadStore(T) & IWriteStore(T)
Gate(T)        { Get Any, Set Any }

MemoryStore(T) IStore(T) & {
  Value        T
  DefaultValue T
}

CollectionStore(T)      IReset & { Store List(T) }
IdCollectionStore(K, V) IReset & { Store Map(K, V) }

// =============================================================================
// Undo / Redo Time-Travel History State
// =============================================================================

HistoryState(T) {
  Past    List(T)
  Present T
  Future  List(T)
}

PushHistory(H HistoryState, NextVal) [
  HistoryState {
    Past    (Cons { Head H.Present, Tail H.Past })
    Present NextVal
    Future  Nil
  }
]

UndoHistory(H HistoryState) [
  H.Past . {
    Nil  [ H ]
    Cons [
      HistoryState {
        Past    Tail
        Present Head
        Future  (Cons { Head H.Present, Tail H.Future })
      }
    ]
  }
]

RedoHistory(H HistoryState) [
  H.Future . {
    Nil  [ H ]
    Cons [
      HistoryState {
        Past    (Cons { Head H.Present, Tail H.Past })
        Present Head
        Future  Tail
      }
    ]
  }
]

// =============================================================================
// Finite State Machine (FSM) & Store Pattern
// =============================================================================

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

ContextTransitionMachine {
  FirstState   ITransitable
  CurrentState ITransitable
}

Store(StateType, ActionType) {
  State     Atom(StateType)
  Reducer   Any
  Dispatch(Act ActionType) [
    State.Swap(Current [ Reducer(Current, Act) ])
  ]
}

// =============================================================================
// Counter Reducer Example
// =============================================================================

CounterState { Count Int }
Increment    { By Int }
Decrement    { By Int }
Reset        {}
CounterMsg   Increment | Decrement | Reset

UpdateCounter(State CounterState, Msg CounterMsg) [
  Msg . {
    Increment [ CounterState { Count (State.Count + By) } ]
    Decrement [ CounterState { Count (State.Count - By) } ]
    Reset     [ CounterState { Count 0 } ]
  }
]

GlobalCounter Atom(CounterState { Count 0 })

ModifyGlobalCounter() [
  GlobalCounter.Swap(State [ UpdateCounter(State, Increment { By 5 }) ])
]
