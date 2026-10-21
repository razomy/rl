#
Concrete Currency Codes, asset Kinds, Commodities, economic Sectors & Transitions
#

CurrencyCode "USD" | "EUR" | "GBP" | "JPY" | "CNY" | "CHF" | "CAD" | "AUD" | "NZD" | "SEK"
    | "NOK" | "DKK" | "PLN" | "CZK" | "HUF" | "UAH" | "RUB" | "TRY" | "INR" | "KRW" | "SGD"
    | "HKD" | "BRL" | "MXN" | "ARS" | "ZAR" | "NGN" | "EGP" | "AED" | "SAR" | "ILS" | "THB"
    | "IDR" | "MYR" | "PHP" | "VND" | "KZT" | "GEL" | "BTC" | "ETH"

AssetKind "cash" | "deposit" | "stock" | "bond" | "real-estate" | "commodity" | "vehicle"
    | "equipment" | "intellectual-property" | "crypto" | "receivable" | "inventory"

Share_ Asset & { AssetKind "stock", ticker String }
Bond_  Asset & { AssetKind "bond", maturity Date, InterestRate }

AccountKind "checking" | "savings" | "credit" | "loan" | "brokerage" | "wallet" | "ledger"

TransactionKind "payment" | "transfer" | "deposit" | "withdrawal" | "refund" | "fee" | "salary"
    | "purchase" | "sale" | "loan" | "repayment" | "donation" | "tax"

Commodity "oil" | "gas" | "gold" | "silver" | "copper" | "wheat" | "corn" | "coffee" | "sugar" | "cotton"

EconomicSector "agriculture" | "mining" | "manufacturing" | "construction" | "energy" | "retail"
    | "transport" | "finance" | "healthcare" | "education" | "technology" | "media" | "hospitality"
    | "government" | "real-estate" | "telecom"

Pay(from Account, to Account, m Money) [
    From.Balance.Amount . {
        [ _ >= M.Amount ] [ Transaction { TransactionKind "payment", TransactionStatus "settled", From, To, money M, at Now } ]
        _                 [ Insufficient { Needed M, available From.Balance } ]
    }
]
Transfer(t Transaction & { TransactionStatus "authorized" }) [ t & { TransactionStatus "settled" } ]
Authorize(t Transaction & { TransactionStatus "pending" }) [ t & { TransactionStatus "authorized" } ]
Reverse(t Transaction & { TransactionStatus "settled" }) [ t & { TransactionStatus "reversed" } ]
Deposit(a Account, m Money) [ a & { Balance { Amount (Balance.Amount + M.Amount), Currency } } ]
Withdraw(a Account, m Money) [ a & { Balance { Amount (Balance.Amount - M.Amount), Currency } } ]
Exchange(m Money, r ExchangeRate) [ Money { Amount (M.Amount * R.Rate), currency R.To } ]
OpenAccount(h Agent, k AccountKind, c Currency) [ Account { Holder H, accountKind K, currency C } & Open_ { OpenedAt Now } ]
Freeze_(a Account & Open_, reason String) [ A / Open_ & Frozen { Reason } ]
CloseAccount(a Account & Open_) [ A / Open_ & Closed { ClosedAt Now } ]
Offer_(c Contract & { ContractStatus "draft" }) [ c & { ContractStatus "offered" } ]
Sign(c Contract & { ContractStatus "offered" }) [ c & { ContractStatus "signed" } ]
Fulfill(c Contract & { ContractStatus "active" }) [ c & { ContractStatus "fulfilled" } ]
Breach(c Contract & { ContractStatus "active" }) [ c & { ContractStatus "breached" } ]
Employ(a Agent & Unemployed, e Employment) [ A / Unemployed & Employed { Employment E } ]
Dismiss(a Agent & Employed) [ A / Employed & Unemployed Object ]
Retire(a Agent & Employed) [ A / Employed & Retired { Since Now } ]
Borrow(l Loan, a Account) [ A . Deposit(L.Principal) ]
Invest(a Account, x Asset) [ x & { Ownership { Owner A.Holder, since Now, Share 1 } } ]
