_ thing
_ intangible
_ person
_ organization
_ creative_work
_ action

// =============================================================================
// InteractAction and subtypes
// =============================================================================

InteractAction Action
BefriendAction   InteractAction
CommunicateAction InteractAction & { About Thing, InLanguage Language, Recipient Agent }
AskAction        CommunicateAction & { Question }
CheckInAction    CommunicateAction
CheckOutAction   CommunicateAction
CommentAction    CommunicateAction & { ResultComment Comment }
InformAction     CommunicateAction & { Event_ Thing }
ConfirmAction    InformAction
RsvpAction       InformAction & { RsvpResponse RsvpResponseType, AdditionalNumberOfGuests Count }
InviteAction     CommunicateAction & { Event_ Thing }
ReplyAction      CommunicateAction & { ResultComment Comment }
ShareAction      CommunicateAction
FollowAction     InteractAction & { Followee Agent }
JoinAction       InteractAction & { Event_ Thing }
LeaveAction      InteractAction & { Event_ Thing }
MarryAction      InteractAction
RegisterAction   InteractAction
SubscribeAction  InteractAction
UnRegisterAction InteractAction

AssessAction Action
ChooseAction  AssessAction & { ActionOption Thing }
VoteAction    ChooseAction & { Candidate Person }
IgnoreAction  AssessAction
ReactAction   AssessAction
AgreeAction   ReactAction
DisagreeAction ReactAction
DislikeAction ReactAction
EndorseAction ReactAction & { Endorsee Agent }
LikeAction    ReactAction
WantAction    ReactAction
ReviewAction  AssessAction & { ResultReview Review }

// =============================================================================
// Transitions
// =============================================================================

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
