_ thing
_ intangible
_ place
_ creative_work
_ action

// =============================================================================
// Create / Update / Move / Consume / Organize / Play / Search ...
// =============================================================================

CreateAction Action
CookAction    CreateAction & { FoodEstablishment_ Thing, Recipe }
DrawAction    CreateAction
FilmAction    CreateAction
PaintAction   CreateAction
PhotographAction CreateAction
WriteAction   CreateAction & { InLanguage Language }

UpdateAction Action & { TargetCollection Thing }
AddAction     UpdateAction
InsertAction  AddAction & { ToLocation Place }
AppendAction  InsertAction
PrependAction InsertAction
DeleteAction  UpdateAction
ReplaceAction UpdateAction & { Replacee Thing, Replacer Thing }

MoveAction Action & { FromLocation Place, ToLocation Place }
ArriveAction MoveAction
DepartAction MoveAction
TravelAction MoveAction & { Distance_ }

ConsumeAction Action & { ActionAccessibilityRequirement Thing, ExpectsAcceptanceOf Thing }
DrinkAction   ConsumeAction
EatAction     ConsumeAction
InstallAction ConsumeAction
ListenAction  ConsumeAction
PlayGameAction ConsumeAction
ReadAction    ConsumeAction
UseAction     ConsumeAction
WearAction    UseAction
ViewAction    ConsumeAction
WatchAction   ConsumeAction

OrganizeAction Action
AllocateAction OrganizeAction
AcceptAction  AllocateAction
AssignAction  AllocateAction
AuthorizeAction AllocateAction & { Recipient Agent }
RejectAction  AllocateAction
ApplyAction   OrganizeAction
BookmarkAction OrganizeAction
PlanAction    OrganizeAction & { ScheduledTime DateTime }
CancelAction  PlanAction
ReserveAction PlanAction
ScheduleAction PlanAction

PlayAction Action & { Audience, Event_ Thing }
ExerciseAction PlayAction & { Course_ Place, Diet_, Distance_, ExercisePlan, ExerciseType String, Opponent Agent, SportsActivityLocation_ Place }
PerformAction  PlayAction

SearchAction Action & { Query String }
FindAction Action
CheckAction    FindAction
DiscoverAction FindAction
TrackAction    FindAction & { DeliveryMethod }

AchieveAction Action
LoseAction    AchieveAction & { Winner Agent }
TieAction     AchieveAction
WinAction     AchieveAction & { Loser Agent }

ControlAction Action
ActivateAction   ControlAction
DeactivateAction ControlAction
ResumeAction     ControlAction
SuspendAction    ControlAction

SolveMathAction Action & { EduQuestionType String }
SeekToAction Action & { StartOffset Real }

// =============================================================================
// Transitions
// =============================================================================

Create(A Agent, R Thing) [ CreateAction { Agent A, Result R, ActionStatus "CompletedActionStatus" } ]
Update(A Agent, T Thing, C Thing) [ UpdateAction { Agent A, Object T, TargetCollection C } ]
Delete(A Agent, T Thing, C Thing) [ DeleteAction { Agent A, Object T, TargetCollection C } ]
Replace(A Agent, Old Thing, New Thing) [ ReplaceAction { Agent A, Replacee Old, Replacer New } ]
MoveTo(A Agent, From Place, To Place) [ MoveAction { Agent A, FromLocation From, ToLocation To } ]
Arrive(A Agent, To Place) [ ArriveAction { Agent A, ToLocation To } ]
Depart(A Agent, From Place) [ DepartAction { Agent A, FromLocation From } ]
Consume(A Agent, T Thing) [ ConsumeAction { Agent A, Object T } ]
ReadWork(A Agent, W CreativeWork) [ ReadAction { Agent A, Object W } ]
Watch(A Agent, W CreativeWork) [ WatchAction { Agent A, Object W } ]
Listen(A Agent, W CreativeWork) [ ListenAction { Agent A, Object W } ]
Accept(A Agent, T Thing) [ AcceptAction { Agent A, Object T } ]
Reject(A Agent, T Thing) [ RejectAction { Agent A, Object T } ]
Bookmark(A Agent, T Thing) [ BookmarkAction { Agent A, Object T } ]
PlanAt(A Agent, T Thing, W DateTime) [ ScheduleAction { Agent A, Object T, ScheduledTime W } ]
Play_(A Agent, G Thing) [ PlayAction { Agent A, Object G } ]
Search(A Agent, Q String) [ SearchAction { Agent A, Query Q } ]
Discover(A Agent, T Thing) [ DiscoverAction { Agent A, Result T } ]
Win(A Agent, L Agent) [ WinAction { Agent A, Loser L } ]
Lose(A Agent, W Agent) [ LoseAction { Agent A, Winner W } ]
Activate(A Agent, T Thing) [ ActivateAction { Agent A, Object T } ]
Deactivate(A Agent, T Thing) [ DeactivateAction { Agent A, Object T } ]
Suspend(A Agent, T Thing) [ SuspendAction { Agent A, Object T } ]
