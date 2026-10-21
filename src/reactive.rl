#
Transactional Memory, Signals, Pipelines & Reactive Stores
#

Atom(T) {
  Read()                            [ Self . native_atom_read ]
  Swap(Transition)                  [ (Self, Transition) . native_atom_swap ]
  Reset(newVal T)                   [ (Self, NewVal) . native_atom_reset ]
  CompareAndSet(expected T, next T) [ (Self, Expected, Next) . native_atom_cas ]
}

SignalState(T) {
  Get()         [ Self . native_signal_get ]
  Set(val T)    [ (Self, Val) . native_signal_set ]
  Subscribe(Fn) [ (Self, Fn) . native_signal_subscribe ]
}

Computed(T) {
  Evaluate() [ Self . native_computed_eval ]
}

ContextRegistry {
  Registry Map(String, IContext)
  Events   Channel(ContextEvent)
}

Pipeline(T)      { Pipes List(IPipe(T)) }
PipelineAsync(T) { Pipes List(IPipeAsync(T)) }

ParallelPipe(T) {
  Pipes List(IPipeAsync(T))
  Merge Any
}

ContextPipeline IContextable & IContextPipe & {
  Pipes Map(String, IContextPipe)
}

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

MemoryStore(T) IStore(T) & {
  Value        T
  DefaultValue T
}

CollectionStore(T)      IReset & { Store List(T) }
IdCollectionStore(K, V) IReset & { Store Map(K, V) }
