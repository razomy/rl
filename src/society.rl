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
Married  { Spouse Agent, since Instant }
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

Jurisdiction { Name, area GeoShape }

Norm { Description Text, enforced Bool }
Law {
    Title
    Text
    Jurisdiction
    EnactedAt Date
    LegalSystem
}

Right       { RightKind, holder Agent, grantedBy Law }
Duty        { Description Text, bearer Agent, imposedBy Law }
Permission  { Grantee Agent, action_ String, scope Any }
Prohibition { Subject Agent, action_ String }

Ownership {
    Owner Agent
    Property Any
    Since Instant
    Share Fraction
}
Owned   { Ownership }
Unowned Object

Crime     { Law, offender Agent, at Instant }
Sentence_ { Verdict, penalty String, Duration }

State_ {
    Name
    GovernmentForm
    Jurisdiction
    Population Count
    Constitution
    Capital String
}

Election { Office String, candidates List(Agent), voters List(Agent), at Date }
Vote     { Voter Agent, choice Agent, Election }
Office   { Title, holder Agent, term Interval }

Citizen    { State_ }
Stateless  Object
Free       Object
Imprisoned { Since Instant, until Instant }
