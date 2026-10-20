#
UI Animations, Timelines & Declarative Routing
#

CurvedAnimationHandler { Handler IAnimationHandler, Curve ICurve }
ColorHandler           IAnimationHandler & { From RgbaColorFloat, Delta RgbaColorFloat }
VectorHandler          IAnimationHandler & { From VectorFloat3, Delta VectorFloat3 }

DefaultAnimationTrack IAnimationTrack & { Handler IAnimationHandler }
RepeatAnimationTrack  DefaultAnimationTrack & { TrackLength Float, RepeatCount Float }

AnimationTimeLine {
  CurrentTime Float
  TotalTime   Float
  IsPlaying   Bool
  Tracks      List(IAnimationTrack)
}

UpdateTimeline(Tl AnimationTimeLine, Delta Float) [
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

RouteHistory       { ActiveHistory List(RoutePath(RouteValue)), Count Int }
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

NavigateToRoute(State RouteNavigateState, NextPath RoutePath(RouteValue)) [
  State & {
    IsRouting false
    Path      NextPath
    Event     Some(RouteEnterEvent { Path NextPath })
  }
]
