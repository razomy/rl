_ meta
_ primitives
_ structures

// =============================================================================
// Transactional Memory & Reactive Primitives
// =============================================================================

Atom(T) {
  Read()           [ Self . native_atom_read ]
  Swap(Transition) [ (Self, Transition) . native_atom_swap ]
  Reset(NewVal T)  [ (Self, NewVal) . native_atom_reset ]
  CompareAndSet(Expected T, Next T) [ (Self, Expected, Next) . native_atom_cas ]
}

SignalState(T) {
  Get()            [ Self . native_signal_get ]
  Set(Val T)       [ (Self, Val) . native_signal_set ]
  Subscribe(Fn)    [ (Self, Fn) . native_signal_subscribe ]
}

Computed(T) {
  Evaluate()       [ Self . native_computed_eval ]
}

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