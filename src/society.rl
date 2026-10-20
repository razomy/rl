#
Abstract Social Group, Role, Relationship, Law, Right, Ownership & Governance
#

Group {
    Name
    GroupKind
    Members List(Agent)
    Founded Date
}

Role {
    RoleKind
    Holder Agent
    In     Group
    Interval
}

Strength_ Fraction

Relationship {
    RelationshipKind
    From Agent
    To   Agent
    Since Instant
    Strength_
}

Single   Object
Married  { Spouse Agent, Since Instant }
Divorced { Since Instant }
Widowed  { Since Instant }
MaritalStatus Single | Married | Divorced | Widowed

Membership {
    Member Agent
    Group
    Role
    Since Instant
}
Member    { Membership }
NonMember Object

Jurisdiction { Name, Area GeoShape }

Norm { Description Text, Enforced Bool }
Law {
    Title
    Text
    Jurisdiction
    EnactedAt Date
    LegalSystem
}

Right       { RightKind, Holder Agent, GrantedBy Law }
Duty        { Description Text, Bearer Agent, ImposedBy Law }
Permission  { Grantee Agent, Action_ String, Scope Any }
Prohibition { Subject Agent, Action_ String }

Ownership {
    Owner Agent
    Property Any
    Since Instant
    Share Fraction
}
Owned   { Ownership }
Unowned Object

Crime     { Law, Offender Agent, At Instant }
Sentence_ { Verdict, Penalty String, Duration }

State_ {
    Name
    GovernmentForm
    Jurisdiction
    Population Count
    Constitution
    Capital String
}

Election { Office String, Candidates List(Agent), Voters List(Agent), At Date }
Vote     { Voter Agent, Choice Agent, Election }
Office   { Title, Holder Agent, Term Interval }

Citizen    { State_ }
Stateless  Object
Free       Object
Imprisoned { Since Instant, Until Instant }
