#
Concrete Currency Codes, Asset Kinds, Commodities, Economic Sectors & Transitions
#

CurrencyCode "USD" | "EUR" | "GBP" | "JPY" | "CNY" | "CHF" | "CAD" | "AUD" | "NZD" | "SEK"
    | "NOK" | "DKK" | "PLN" | "CZK" | "HUF" | "UAH" | "RUB" | "TRY" | "INR" | "KRW" | "SGD"
    | "HKD" | "BRL" | "MXN" | "ARS" | "ZAR" | "NGN" | "EGP" | "AED" | "SAR" | "ILS" | "THB"
    | "IDR" | "MYR" | "PHP" | "VND" | "KZT" | "GEL" | "BTC" | "ETH"

AssetKind "cash" | "deposit" | "stock" | "bond" | "real-estate" | "commodity" | "vehicle"
    | "equipment" | "intellectual-property" | "crypto" | "receivable" | "inventory"

Share_ Asset & { AssetKind "stock", Ticker String }
Bond_  Asset & { AssetKind "bond", Maturity Date, InterestRate }

AccountKind "checking" | "savings" | "credit" | "loan" | "brokerage" | "wallet" | "ledger"

TransactionKind "payment" | "transfer" | "deposit" | "withdrawal" | "refund" | "fee" | "salary"
    | "purchase" | "sale" | "loan" | "repayment" | "donation" | "tax"

Commodity "oil" | "gas" | "gold" | "silver" | "copper" | "wheat" | "corn" | "coffee" | "sugar" | "cotton"

EconomicSector "agriculture" | "mining" | "manufacturing" | "construction" | "energy" | "retail"
    | "transport" | "finance" | "healthcare" | "education" | "technology" | "media" | "hospitality"
    | "government" | "real-estate" | "telecom"

Pay(From Account, To Account, M Money) [
    From.Balance.Amount . {
        [ _ >= M.Amount ] [ Transaction { TransactionKind "payment", TransactionStatus "settled", From, To, Money M, At Now } ]
        _                 [ Insufficient { Needed M, Available From.Balance } ]
    }
]
Transfer(T Transaction & { TransactionStatus "authorized" }) [ T & { TransactionStatus "settled" } ]
Authorize(T Transaction & { TransactionStatus "pending" }) [ T & { TransactionStatus "authorized" } ]
Reverse(T Transaction & { TransactionStatus "settled" }) [ T & { TransactionStatus "reversed" } ]
Deposit(A Account, M Money) [ A & { Balance { Amount (Balance.Amount + M.Amount), Currency } } ]
Withdraw(A Account, M Money) [ A & { Balance { Amount (Balance.Amount - M.Amount), Currency } } ]
Exchange(M Money, R ExchangeRate) [ Money { Amount (M.Amount * R.Rate), Currency R.To } ]
OpenAccount(H Agent, K AccountKind, C Currency) [ Account { Holder H, AccountKind K, Currency C } & Open_ { OpenedAt Now } ]
Freeze_(A Account & Open_, Reason String) [ A / Open_ & Frozen { Reason } ]
CloseAccount(A Account & Open_) [ A / Open_ & Closed { ClosedAt Now } ]
Offer_(C Contract & { ContractStatus "draft" }) [ C & { ContractStatus "offered" } ]
Sign(C Contract & { ContractStatus "offered" }) [ C & { ContractStatus "signed" } ]
Fulfill(C Contract & { ContractStatus "active" }) [ C & { ContractStatus "fulfilled" } ]
Breach(C Contract & { ContractStatus "active" }) [ C & { ContractStatus "breached" } ]
Employ(A Agent & Unemployed, E Employment) [ A / Unemployed & Employed { Employment E } ]
Dismiss(A Agent & Employed) [ A / Employed & Unemployed Object ]
Retire(A Agent & Employed) [ A / Employed & Retired { Since Now } ]
Borrow(L Loan, A Account) [ A . Deposit(L.Principal) ]
Invest(A Account, X Asset) [ X & { Ownership { Owner A.Holder, Since Now, Share 1 } } ]
