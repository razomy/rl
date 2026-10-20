#
Abstract Action, Status Typestates & Top-Level Action Categories (schema.org)
#

Action Thing & {
  ActionStatus  ActionStatusType
  Agent         Agent
  Object        Thing
  Result        Thing
  Instrument    Thing
  Location      Place
  Participant   List(Agent)
  Provider      Agent
  StartTime     DateTime
  EndTime       DateTime
  Target        EntryPoint
  Error         Thing
  ActionProcess Thing
}

Potential { ActionStatus "PotentialActionStatus" }
Running_  { ActionStatus "ActiveActionStatus" }
Completed { ActionStatus "CompletedActionStatus" }
Errored   { ActionStatus "FailedActionStatus" }

InteractAction Action
AssessAction   Action
CreateAction   Action
UpdateAction   Action & { TargetCollection Thing }
MoveAction     Action & { FromLocation Place, ToLocation Place }
ConsumeAction  Action & { ActionAccessibilityRequirement Thing, ExpectsAcceptanceOf Thing }
OrganizeAction Action
PlayAction     Action & { Audience Audience, Event_ Thing }
SearchAction   Action & { Query String }
FindAction     Action
AchieveAction  Action
ControlAction  Action
TradeAction    Action & { Price Price, PriceCurrency Currency, PriceSpecification PriceSpecification }
TransferAction Action & { FromLocation Place, ToLocation Place }
