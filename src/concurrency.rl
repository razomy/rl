_ meta
_ primitives
_ structures
_ shell

// =============================================================================
// CSP Channels & Synchronization Primitives
// =============================================================================

ChannelClosed {}

Channel(T) {
  Capacity    Int
  Send(Val T) [ (Self, Val) . native_chan_send ]
  Recv()      [ Self . native_chan_recv ]
  TryRecv()   [ Self . native_chan_try_recv ]
  Close()     [ Self . native_chan_close ]
}

Mutex(T) {
  Lock()               [ Self . native_mutex_lock ]
  Unlock()             [ Self . native_mutex_unlock ]
  WithLock(Action)     [
    Self . Mutex.Lock
    . Action
    .> [ Self . Mutex.Unlock ]
  ]
}

RwLock(T) {
  ReadLock()           [ Self . native_rwlock_read ]
  WriteLock()          [ Self . native_rwlock_write ]
  Unlock()             [ Self . native_rwlock_unlock ]
}

Semaphore {
  Permits   Int
  Acquire() [ Self . native_sem_acquire ]
  Release() [ Self . native_sem_release ]
}

WaitGroup {
  Count  Int
  Add(N Int) [ (Self, N) . native_wg_add ]
  Done()     [ Self . native_wg_done ]
  Wait()     [ Self . native_wg_wait ]
}

// =============================================================================
// Futures, Promises & Tasks
// =============================================================================

TaskPending   {}
TaskRunning   {}
TaskCompleted(T) { Value T }
TaskFailed(E)    { Error E }
TaskCancelled {}
TaskState(T, E) TaskPending | TaskRunning | TaskCompleted(T) | TaskFailed(E) | TaskCancelled

Future(T, E) {
  State   TaskState(T, E)
  Await() [ Self . native_future_await ]
  Cancel()[ Self . native_future_cancel ]
}

Async {
  Spawn(Fn)              [ Fn . native_async_spawn ]
  Sleep(Ms Int)          [ Ms . native_async_sleep ]
  Timeout(Fut, Ms Int)   [ (Fut, Ms) . native_async_timeout ]
  All(Futures List(Any)) [ Futures . native_async_all ]
  Race(Futures List(Any))[ Futures . native_async_race ]
}

// =============================================================================
// Actor Model & Supervision Trees
// =============================================================================

ActorRef(Msg) {
  Address       Str
  Tell(M Msg)   [ (Self, M) . native_actor_tell ]
  Ask(M Msg)    [ (Self, M) . native_actor_ask ]
  Stop()        [ Self . native_actor_stop ]
}

RestartPolicy "always" | "on-failure" | "never" | "exponential-backoff"

SupervisorSpec {
  MaxRestarts   Int
  WithinSeconds Int
  Policy        RestartPolicy
}

// =============================================================================
// Worker Loops & Parallel Fan-Out ('.|')
// =============================================================================

WorkerLoop(Jobs Channel(Str), Results Channel(Int)) [
  Jobs.Recv() . {
    None [ "Channel closed, terminating worker." . Shell.Log ]
    Some [
      Value
      . Str.Length
      .> (Len [ Results.Send(Len) ])
      . [ WorkerLoop(Jobs, Results) ]
    ]
  }
]

FetchProfile(Id Str)         [ Http.Get("https://api.ex/users/{Id}") ]
FetchRecommendations(Id Str) [ Http.Get("https://api.ex/recs/{Id}") ]
FetchAds()                   [ Http.Get("https://api.ex/ads") ]

LoadDashboardData(UserId Str) [
  UserId .| {
    Profile [ _ . FetchProfile ]
    Recs    [ _ . FetchRecommendations ]
    Ads     [ FetchAds() ]
  }
]