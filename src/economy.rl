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
ExchangeRate { From Currency, To Currency, Rate Real & Positive, At Instant }
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

Loan { Principal Money, InterestRate, Term Duration, Borrower Agent, Lender Agent }

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

Good     { Name, Price, Quantity_ Count }
Service_ { Name, Price, Provider Agent }

Market {
    Name
    Goods List(Good)
    Participants List(Agent)
    Currency
}
Supply { Good, Quantity_ Count }
Demand { Good, Quantity_ Count }

ContractStatus "draft" | "offered" | "signed" | "active" | "fulfilled" | "breached" | "terminated"
Contract {
    Title
    Parties List(Agent)
    Terms Text
    ContractStatus
    Interval
    Value Money
}

Invoice_ { Identifier, Issuer Agent, Payer Agent, Money, DueDate Date }
Receipt  { Transaction, IssuedAt Instant }

Employment { Employer Agent, Employee Agent, Wage, Interval, Title }
Employed   { Employment }
Unemployed Object
Retired    { Since Instant }

Insufficient { Needed Money, Available Balance }
Rejected     { Reason String }
