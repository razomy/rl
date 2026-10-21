#
Futures, async Runtime, actor Model & Parallel Worker Loops
#

Future(T, E) {
  State    TaskState(T, E)
  Await()  [ Self . native_future_await ]
  Cancel() [ Self . native_future_cancel ]
}

Async {
  Spawn(Fn)               [ Fn . native_async_spawn ]
  Sleep(ms Int)           [ ms . native_async_sleep ]
  Timeout(Fut, ms Int)    [ (Fut, Ms) . native_async_timeout ]
  All(futures List(Any))  [ Futures . native_async_all ]
  Race(futures List(Any)) [ Futures . native_async_race ]
}

ActorRef(Msg) {
  Address     String
  Tell(m Msg) [ (Self, m) . native_actor_tell ]
  Ask(m Msg)  [ (Self, m) . native_actor_ask ]
  Stop()      [ Self . native_actor_stop ]
}

WorkerLoop(jobs Channel(String), results Channel(Int)) [
  jobs.Recv() . {
    None [ "Channel closed, terminating worker." . Shell.Log ]
    Some [
      Value
      . Length
      .> (Len [ Results.Send(Len) ])
      . [ WorkerLoop(Jobs, Results) ]
    ]
  }
]

FetchProfile(id String)         [ Http.Get("https://api.ex/users/{Id}") ]
FetchRecommendations(id String) [ Http.Get("https://api.ex/recs/{Id}") ]
FetchAds()                      [ Http.Get("https://api.ex/ads") ]

LoadDashboardData(userId String) [
  userId .| {
    Profile [ _ . FetchProfile ]
    Recs    [ _ . FetchRecommendations ]
    Ads     [ FetchAds() ]
  }
]
