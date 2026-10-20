#
Undo / Redo Time-Travel History & Store Reducers
#

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

ContextTransitionMachine {
  FirstState   ITransitable
  CurrentState ITransitable
}

Store(StateType, ActionType) {
  State   Atom(StateType)
  Reducer Any
  Dispatch(Act ActionType) [
    State.Swap(Current [ Reducer(Current, Act) ])
  ]
}

CounterState { Count Int }
Increment    { By Int }
Decrement    { By Int }
Reset        Object
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
