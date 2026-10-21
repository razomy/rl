#
UI Animations, Timelines & Declarative Routing
#

CurvedAnimationHandler { Handler IAnimationHandler, curve ICurve }
ColorHandler           IAnimationHandler & { From RgbaColorFloat, delta RgbaColorFloat }
VectorHandler          IAnimationHandler & { From VectorFloat3, delta VectorFloat3 }

DefaultAnimationTrack IAnimationTrack & { Handler IAnimationHandler }
RepeatAnimationTrack  DefaultAnimationTrack & { TrackLength Float, repeatCount Float }

AnimationTimeLine {
  CurrentTime Float
  TotalTime   Float
  IsPlaying   Bool
  Tracks      List(IAnimationTrack)
}

UpdateTimeline(tl AnimationTimeLine, delta Float) [
  IsPlaying . {
    false [ Tl ]
    true  [
      NextTime (CurrentTime + Delta)
      NextTime . {
        [ _ >= TotalTime ] [ Tl & { CurrentTime TotalTime, IsPlaying false } ]
        _                  [ Tl & { CurrentTime NextTime } ]
      }
    ]
  }
]

RouteHistory       { ActiveHistory List(RoutePath(RouteValue)), count Int }
RouteInitEvent     IRouteEvent
RouteEnterEvent    IRouteEvent
RouteLeaveEvent    IRouteEvent
RoutingStartEvent  IRouteEvent
RoutingFinishEvent IRouteEvent

RouteNavigateState {
  IsRouting Bool
  Event     Option(IRouteEvent)
  Path      RoutePath(RouteValue)
}

NavigateToRoute(state RouteNavigateState, nextPath RoutePath(RouteValue)) [
  State & {
    IsRouting false
    Path      NextPath
    Event     Some(RouteEnterEvent { Path NextPath })
  }
]
