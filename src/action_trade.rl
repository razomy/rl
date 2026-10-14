_ thing
_ intangible
_ intangible_commerce
_ action

// =============================================================================
// TradeAction and subtypes
// =============================================================================

TradeAction Action & { Price, PriceCurrency Currency, PriceSpecification }
BuyAction       TradeAction & { Seller Agent }
SellAction      TradeAction & { Buyer Agent }
OrderAction     TradeAction & { DeliveryMethod }
PayAction       TradeAction & { Recipient Agent }
PreOrderAction  TradeAction
QuoteAction     TradeAction
RentAction      TradeAction & { Landlord Agent, RealEstateAgent Agent }
TipAction       TradeAction & { Recipient Agent }
DonateAction    TradeAction & { Recipient Agent }

TransferAction Action & { FromLocation Place, ToLocation Place }
BorrowAction  TransferAction & { Lender Agent }
LendAction    TransferAction & { Borrower Agent }
GiveAction    TransferAction & { Recipient Agent }
ReceiveAction TransferAction & { DeliveryMethod, Sender Agent }
ReturnAction  TransferAction & { Recipient Agent }
SendAction    TransferAction & { DeliveryMethod, Recipient Agent }
TakeAction    TransferAction
DownloadAction TransferAction

// =============================================================================
// Transitions
// =============================================================================

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
