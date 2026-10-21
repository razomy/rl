#
Concrete Action Subtypes
#

// Interact & Communicate
BefriendAction    InteractAction
CommunicateAction InteractAction & { About Thing, inLanguage Language, recipient Agent }
AskAction         CommunicateAction & { Question Question }
CheckInAction     CommunicateAction
CheckOutAction    CommunicateAction
CommentAction     CommunicateAction & { ResultComment Comment }
InformAction      CommunicateAction & { Event_ Thing }
ConfirmAction     InformAction
RsvpAction        InformAction & { RsvpResponse RsvpResponseType, additionalNumberOfGuests Count }
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

// Assess & React
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

// Create, Update, Move, Consume, Organize, Play, Search, Achieve, control
CookAction       CreateAction & { FoodEstablishment_ Thing, recipe Recipe }
DrawAction       CreateAction
FilmAction       CreateAction
PaintAction      CreateAction
PhotographAction CreateAction
WriteAction      CreateAction & { InLanguage Language }

AddAction     UpdateAction
InsertAction  AddAction & { ToLocation Place }
AppendAction  InsertAction
PrependAction InsertAction
DeleteAction  UpdateAction
ReplaceAction UpdateAction & { Replacee Thing, replacer Thing }

ArriveAction MoveAction
DepartAction MoveAction
TravelAction MoveAction & { Distance_ Distance_ }

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

ExerciseAction PlayAction & { Course_ Place, diet_ Diet_, distance_ Distance_, exercisePlan ExercisePlan, exerciseType String, opponent Agent, sportsActivityLocation_ Place }
PerformAction  PlayAction

CheckAction    FindAction
DiscoverAction FindAction
TrackAction    FindAction & { DeliveryMethod DeliveryMethod }

LoseAction AchieveAction & { Winner Agent }
TieAction  AchieveAction
WinAction  AchieveAction & { Loser Agent }

ActivateAction   ControlAction
DeactivateAction ControlAction
ResumeAction     ControlAction
SuspendAction    ControlAction

SolveMathAction Action & { EduQuestionType String }
SeekToAction    Action & { StartOffset Real }

// Trade & Transfer
BuyAction      TradeAction & { Seller Agent }
SellAction     TradeAction & { Buyer Agent }
OrderAction    TradeAction & { DeliveryMethod DeliveryMethod }
PayAction      TradeAction & { Recipient Agent }
PreOrderAction TradeAction
QuoteAction    TradeAction
RentAction     TradeAction & { Landlord Agent, realEstateAgent Agent }
TipAction      TradeAction & { Recipient Agent }
DonateAction   TradeAction & { Recipient Agent }

BorrowAction   TransferAction & { Lender Agent }
LendAction     TransferAction & { Borrower Agent }
GiveAction     TransferAction & { Recipient Agent }
ReceiveAction  TransferAction & { DeliveryMethod DeliveryMethod, sender Agent }
ReturnAction   TransferAction & { Recipient Agent }
SendAction     TransferAction & { DeliveryMethod DeliveryMethod, recipient Agent }
TakeAction     TransferAction
DownloadAction TransferAction
