_ primitives
_ shell

Channel(T) {
  Send(Val T) [ (Self, Val) . native_chan_send ]
  Recv()      [ Self . native_chan_recv ]
}

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
