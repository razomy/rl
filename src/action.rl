#
Abstract Action, status Typestates & Top-Level Action Categories (schema.org)
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
MoveAction     Action & { FromLocation Place, toLocation Place }
ConsumeAction  Action & { ActionAccessibilityRequirement Thing, expectsAcceptanceOf Thing }
OrganizeAction Action
PlayAction     Action & { Audience Audience, event_ Thing }
SearchAction   Action & { Query String }
FindAction     Action
AchieveAction  Action
ControlAction  Action
TradeAction    Action & { Price Price, priceCurrency Currency, priceSpecification PriceSpecification }
TransferAction Action & { FromLocation Place, toLocation Place }
