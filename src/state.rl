_ primitives

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

Atom(T) {
  Read()          [ Self . native_atom_read ]
  Swap(Transition)[ (Self, Transition) . native_atom_swap ]
}

GlobalCounter Atom(CounterState { Count 0 })

ModifyGlobalCounter() [
  GlobalCounter.Swap(State [ UpdateCounter(State, Increment { By 5 }) ])
]
