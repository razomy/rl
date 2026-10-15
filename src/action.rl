_ thing
_ enumeration
_ intangible
_ place
_ person
_ organization
_ commerce
_ creative_work
_ creative_work_media
_ creative_work_code
_ computing

// =============================================================================
// 1. Base Action & Status Typestates (schema.org)
// =============================================================================

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

// =============================================================================
// 2. InteractAction, CommunicateAction & AssessAction Subtypes
// =============================================================================

InteractAction    Action
BefriendAction    InteractAction
CommunicateAction InteractAction & { About Thing, InLanguage Language, Recipient Agent }
AskAction         CommunicateAction & { Question Question }
CheckInAction     CommunicateAction
CheckOutAction    CommunicateAction
CommentAction     CommunicateAction & { ResultComment Comment }
InformAction      CommunicateAction & { Event_ Thing }
ConfirmAction     InformAction
RsvpAction        InformAction & { RsvpResponse RsvpResponseType, AdditionalNumberOfGuests Count }
InviteAction      CommunicateAction & { Event_ Thing }
ReplyAction       CommunicateAction & { ResultComment Comment }
ShareAction       CommunicateAction
FollowAction      InteractAction & { Followee Agent }
JoinAction        InteractAction & { Event_ Thing }
LeaveAction       InteractAction & { Event_ Thing }
MarryAction       InteractAction
RegisterAction    InteractAction
SubscribeAction   InteractAction
UnRegisterAction  InteractAction

AssessAction   Action
ChooseAction   AssessAction & { ActionOption Thing }
VoteAction     ChooseAction & { Candidate Person }
IgnoreAction   AssessAction
ReactAction    AssessAction
AgreeAction    ReactAction
DisagreeAction ReactAction
DislikeAction  ReactAction
EndorseAction  ReactAction & { Endorsee Agent }
LikeAction     ReactAction
WantAction     ReactAction
ReviewAction   AssessAction & { ResultReview Review }

// =============================================================================
// 3. Create, Update, Move, Consume, Organize, Play, Search & Control Actions
// =============================================================================

CreateAction     Action
CookAction       CreateAction & { FoodEstablishment_ Thing, Recipe Recipe }
DrawAction       CreateAction
FilmAction       CreateAction
PaintAction      CreateAction
PhotographAction CreateAction
WriteAction      CreateAction & { InLanguage Language }

UpdateAction  Action & { TargetCollection Thing }
AddAction     UpdateAction
InsertAction  AddAction & { ToLocation Place }
AppendAction  InsertAction
PrependAction InsertAction
DeleteAction  UpdateAction
ReplaceAction UpdateAction & { Replacee Thing, Replacer Thing }

MoveAction   Action & { FromLocation Place, ToLocation Place }
ArriveAction MoveAction
DepartAction MoveAction
TravelAction MoveAction & { Distance_ Distance_ }

ConsumeAction  Action & { ActionAccessibilityRequirement Thing, ExpectsAcceptanceOf Thing }
DrinkAction    ConsumeAction
EatAction      ConsumeAction
InstallAction  ConsumeAction
ListenAction   ConsumeAction
PlayGameAction ConsumeAction
ReadAction     ConsumeAction
UseAction      ConsumeAction
WearAction     UseAction
ViewAction     ConsumeAction
WatchAction    ConsumeAction

OrganizeAction  Action
AllocateAction  OrganizeAction
AcceptAction    AllocateAction
AssignAction    AllocateAction
AuthorizeAction AllocateAction & { Recipient Agent }
RejectAction    AllocateAction
ApplyAction     OrganizeAction
BookmarkAction  OrganizeAction
PlanAction      OrganizeAction & { ScheduledTime DateTime }
CancelAction    PlanAction
ReserveAction   PlanAction
ScheduleAction  PlanAction

PlayAction     Action & { Audience Audience, Event_ Thing }
ExerciseAction PlayAction & { Course_ Place, Diet_ Diet_, Distance_ Distance_, ExercisePlan ExercisePlan, ExerciseType String, Opponent Agent, SportsActivityLocation_ Place }
PerformAction  PlayAction

SearchAction   Action & { Query String }
FindAction     Action
CheckAction    FindAction
DiscoverAction FindAction
TrackAction    FindAction & { DeliveryMethod DeliveryMethod }

AchieveAction Action
LoseAction    AchieveAction & { Winner Agent }
TieAction     AchieveAction
WinAction     AchieveAction & { Loser Agent }

ControlAction    Action
ActivateAction   ControlAction
DeactivateAction ControlAction
ResumeAction     ControlAction
SuspendAction    ControlAction

SolveMathAction Action & { EduQuestionType String }
SeekToAction    Action & { StartOffset Real }

// =============================================================================
// 4. TradeAction & TransferAction Subtypes
// =============================================================================

TradeAction    Action & { Price Price, PriceCurrency Currency, PriceSpecification PriceSpecification }
BuyAction      TradeAction & { Seller Agent }
SellAction     TradeAction & { Buyer Agent }
OrderAction    TradeAction & { DeliveryMethod DeliveryMethod }
PayAction      TradeAction & { Recipient Agent }
PreOrderAction TradeAction
QuoteAction    TradeAction
RentAction     TradeAction & { Landlord Agent, RealEstateAgent Agent }
TipAction      TradeAction & { Recipient Agent }
DonateAction   TradeAction & { Recipient Agent }

TransferAction Action & { FromLocation Place, ToLocation Place }
BorrowAction   TransferAction & { Lender Agent }
LendAction     TransferAction & { Borrower Agent }
GiveAction     TransferAction & { Recipient Agent }
ReceiveAction  TransferAction & { DeliveryMethod DeliveryMethod, Sender Agent }
ReturnAction   TransferAction & { Recipient Agent }
SendAction     TransferAction & { DeliveryMethod DeliveryMethod, Recipient Agent }
TakeAction     TransferAction
DownloadAction TransferAction

// =============================================================================
// 5. Base, Social, Lifecycle & Trade Transitions
// =============================================================================

Propose(A Agent, O Thing) [ Action { Agent A, Object O, ActionStatus "PotentialActionStatus" } ]
Begin(X Action & Potential) [ X & { ActionStatus "ActiveActionStatus", StartTime Now } ]
Complete(X Action & Running_, R Thing) [ X & { ActionStatus "CompletedActionStatus", EndTime Now, Result R } ]
FailAction(X Action & Running_, E Thing) [ X & { ActionStatus "FailedActionStatus", EndTime Now, Error E } ]
Retry(X Action & Errored) [ X & { ActionStatus "PotentialActionStatus", Error None } ]

// Interact & Assess Transitions
Follow(A Agent, B Agent) [ FollowAction { Agent A, Followee B, ActionStatus "CompletedActionStatus" } ]
JoinGroup(A Agent, O Organization) [ JoinAction { Agent A, Object O } ]
LeaveGroup(A Agent, O Organization) [ LeaveAction { Agent A, Object O } ]
Like(A Agent, T Thing) [ LikeAction { Agent A, Object T } ]
Dislike(A Agent, T Thing) [ DislikeAction { Agent A, Object T } ]
Reply(A Agent, To Comment, C Comment) [ ReplyAction { Agent A, Object To, ResultComment C } ]
Share(A Agent, W CreativeWork, R Agent) [ ShareAction { Agent A, Object W, Recipient R } ]
Invite(A Agent, R Agent, E Thing) [ InviteAction { Agent A, Recipient R, Event_ E } ]
Rsvp(A Agent, E Thing, R RsvpResponseType) [ RsvpAction { Agent A, Event_ E, RsvpResponse R } ]
Ask(A Agent, R Agent, Q Question) [ AskAction { Agent A, Recipient R, Question Q } ]
Vote_(A Agent, C Person) [ VoteAction { Agent A, Candidate C } ]
Endorse(A Agent, B Agent) [ EndorseAction { Agent A, Endorsee B } ]
Subscribe(A Agent, T Thing) [ SubscribeAction { Agent A, Object T } ]
Befriend_(A Agent, B Agent) [ BefriendAction { Agent A, Object B } ]

// Lifecycle Transitions
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

// Trade & Transfer Transitions
Buy(B Agent, O Offer) [ BuyAction { Agent B, Object O.ItemOffered, Seller O.Seller, Price O.Price, ActionStatus "CompletedActionStatus" } | Rejected { Reason "offer unavailable" } ]
Sell(S Agent, I Thing, B Agent, P Price) [ SellAction { Agent S, Object I, Buyer B, Price P, ActionStatus "CompletedActionStatus" } ]
PayFor(A Agent, R Agent, P Price) [ PayAction { Agent A, Recipient R, Price P, ActionStatus "CompletedActionStatus" } ]
Rent(T Agent, I Thing, L Agent, P Price) [ RentAction { Agent T, Object I, Landlord L, Price P } ]
Donate(A Agent, R Agent, P Price) [ DonateAction { Agent A, Recipient R, Price P } ]
Tip(A Agent, R Agent, P Price) [ TipAction { Agent A, Recipient R, Price P } ]
Give(A Agent, I Thing, R Agent) [ GiveAction { Agent A, Object I, Recipient R } ]
Lend(A Agent, I Thing, B Agent) [ LendAction { Agent A, Object I, Borrower B } ]
ReturnItem(A Agent, I Thing, R Agent) [ ReturnAction { Agent A, Object I, Recipient R } ]
Ship_(A Agent, I Thing, R Agent, M DeliveryMethod) [ SendAction { Agent A, Object I, Recipient R, DeliveryMethod M } ]

// =============================================================================
// 6. Digital & Computing Actions (6-Level Hierarchy)
// =============================================================================

// Level 1: Physical Input
Point(A Agent, T Coordinates) [ CursorState ]
Click(A Agent, T UIElement, P ClickType) [ UIEvent ]
DragAndDrop(A Agent, T UIElement, S StartCoords, E EndCoords) [ UIState ]
Scroll(A Agent, T Viewport, Dir Direction, Dist Distance) [ ViewportState ]
Type(A Agent, T InputField, P String) [ TextData ]
ExecuteShortcut(A Agent, P KeyCombination) [ SystemCommand ]

// Level 2: System & Environment Management
ManagePower(A Agent, T System, P PowerState) [ SystemState ]
Authenticate(A Agent, T SecuritySystem, P Credentials) [ AuthToken ]
ManageWindow(A Agent, T Window, P WindowAction) [ UIState ]
ConfigureEnvironment(A Agent, T SystemSettings, Param Parameter, Val Value) [ ConfigState ]
MaintainSystem(A Agent, T OperatingSystem, P MaintenanceTask) [ SystemHealth ]

// Level 3: Data & File System Operations
Read(A Agent, T Thing) [ ContentStream ]
UpdateData(A Agent, T Thing, P NewData) [ Thing ]
DeleteData(A Agent, T Thing) [ Boolean_ ]
Organize(A Agent, T Thing, Src SourceLocation, Dst TargetLocation, Op OperationType) [ FileSystemState ]
SearchLocal(A Agent, T Storage, P Query) [ ThingList ]

// Level 4: Web & Network Operations
NavigateWeb(A Agent, T Browser, P URL) [ WebPage ]
QuerySearchEngine(A Agent, T SearchEngine, P SearchQuery) [ SearchResults ]
TransferData(A Agent, T DataObject, Src SourceNode, Dst DestinationNode) [ TransferStatus ]
AuthenticateWeb(A Agent, T WebService, P Credentials) [ Session ]

// Level 5: Communication & Socialization
ExchangeMessage(A Agent, R Recipient, P MessageContent) [ MessageStatus ]
StreamMediaCall(A Agent, R ParticipantList, P MediaStream) [ CallSession ]
InteractSocial(A Agent, T SocialObject, P InteractionType) [ SocialEvent ]

// Level 6: Applied Tasks
ConsumeMedia(A Agent, T MediaContent) [ Experience ]
AuthorText(A Agent, T Document, P TextOperations) [ Document ]
ProcessSpreadsheets(A Agent, T Dataset, P Formulas) [ AnalyticsResult ]
ProduceMultimedia(A Agent, T RawMedia, P EditingTools) [ MediaArtifact ]
DevelopCode(A Agent, T SourceCode, P Compiler) [ Executable ]
PlayGame(A Agent, T GameEnvironment, P GameActions) [ GameState ]
ExecuteTransaction(A Agent, T ECommercePlatform, C Cart, PayMethod PaymentMethod) [ OrderReceipt ]
