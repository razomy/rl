#
Abstract Currency, Money, Asset, Account, Transaction, Market, Contract & Employment
#

CurrencyKind "fiat" | "commodity" | "crypto" | "virtual" | "barter"

Currency {
    CurrencyCode
    CurrencyKind
    Name
    MinorUnits Range(0, 18) & Int
}

Amount       Real
Money        { Amount, Currency }
Price        Money & [ _.Amount >= 0 ]
Cost         Money
Revenue      Money
Profit       Money
Debt         Money
Wage         Money & { Per TimeUnit }
ExchangeRate { From Currency, to Currency, rate Real & Positive, at Instant }
TaxRate      Percent
Tax          { Name, TaxRate, Jurisdiction }
InterestRate Percent

Asset {
    Name
    AssetKind
    Value Money
    Ownership
}

Balance Money

Account {
    Identifier
    AccountKind
    Holder Agent
    Balance
    Currency
}

Open_  { OpenedAt Instant }
Frozen { Reason String }
Closed { ClosedAt Instant }

Loan { Principal Money, InterestRate, term Duration, borrower Agent, lender Agent }

TransactionStatus "pending" | "authorized" | "settled" | "failed" | "reversed"

Transaction {
    Identifier
    TransactionKind
    TransactionStatus
    From Account
    To   Account
    Money
    At   Instant
}

Good     { Name, Price, quantity_ Count }
Service_ { Name, Price, provider Agent }

Market {
    Name
    Goods List(Good)
    Participants List(Agent)
    Currency
}
Supply { Good, quantity_ Count }
Demand { Good, quantity_ Count }

ContractStatus "draft" | "offered" | "signed" | "active" | "fulfilled" | "breached" | "terminated"
Contract {
    Title
    Parties List(Agent)
    Terms Text
    ContractStatus
    Interval
    Value Money
}

Invoice_ { Identifier, issuer Agent, payer Agent, Money, dueDate Date }
Receipt  { Transaction, issuedAt Instant }

Employment { Employer Agent, employee Agent, Wage, Interval, Title }
Employed   { Employment }
Unemployed Object
Retired    { Since Instant }

Insufficient { Needed Money, available Balance }
Rejected     { Reason String }
