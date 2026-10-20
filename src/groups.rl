#
Concrete Social Groups, Kinship, Laws, Rights, Governance & Transitions
#

GroupKind "family" | "household" | "tribe" | "clan" | "community" | "team" | "club" | "party"
    | "nation" | "ethnicity" | "religion" | "class" | "guild" | "union" | "movement" | "audience"

Family    Group & { GroupKind "family" }
Household Group & { GroupKind "household", Address }
Community Group & { GroupKind "community" }
Team      Group & { GroupKind "team" }
Nation    Group & { GroupKind "nation", Language }
Ethnicity Group & { GroupKind "ethnicity" }
Religion  Group & { GroupKind "religion", Beliefs List(Belief) }

RoleKind "leader" | "member" | "founder" | "parent" | "child" | "sibling" | "spouse" | "partner"
    | "friend" | "neighbor" | "employer" | "employee" | "teacher" | "student" | "citizen"
    | "customer" | "supplier" | "guest" | "host" | "mentor" | "official" | "volunteer"

RelationshipKind "kinship" | "marriage" | "partnership" | "friendship" | "rivalry" | "employment"
    | "mentorship" | "neighborhood" | "acquaintance" | "alliance" | "enmity"
Kinship "parent" | "child" | "sibling" | "grandparent" | "grandchild" | "aunt" | "uncle"
    | "cousin" | "niece" | "nephew" | "in-law" | "step-parent" | "step-child"

LegalSystem "civil" | "common" | "religious" | "customary" | "mixed"

Regulation   Law
Constitution Law
Treaty       { Title, Parties List(Agent), SignedAt Date }

RightKind "life" | "liberty" | "property" | "speech" | "religion" | "assembly" | "privacy"
    | "vote" | "education" | "health" | "work" | "fair-trial" | "movement" | "asylum"

Verdict "guilty" | "not-guilty" | "dismissed"

GovernmentForm "democracy" | "republic" | "monarchy" | "constitutional-monarchy" | "theocracy"
    | "dictatorship" | "oligarchy" | "federation" | "confederation" | "anarchy"

Join(A Agent & NonMember, G Group, R Role) [ A / NonMember & Member { Membership { Member A, Group G, Role R, Since Now } } ]
Leave(A Agent & Member) [ A / Member & NonMember Object ]
Befriend(A Agent, B Agent) [ Relationship { RelationshipKind "friendship", From A, To B, Since Now } ]
Marry(A Agent & Single, B Agent & Single) [ List2(A / Single & Married { Spouse B, Since Now }, B / Single & Married { Spouse A, Since Now }) ]
Divorce(A Agent & Married) [ A / Married & Divorced { Since Now } ]
Widow(A Agent & Married) [ A / Married & Widowed { Since Now } ]
Adopt(Parent Agent, Child Agent) [ Relationship { RelationshipKind "kinship", From Parent, To Child, Since Now } ]
Enact(L Law) [ L & { EnactedAt Today } ]
Repeal(L Law) [ L & { Repealed Today } ]
Grant(A Agent, K RightKind, L Law) [ Right { RightKind K, Holder A, GrantedBy L } ]
Acquire(X Any & Unowned, A Agent) [ X / Unowned & Owned { Ownership { Owner A, Property X, Since Now, Share 1 } } ]
Abandon_(X Any & Owned) [ X / Owned & Unowned Object ]
Naturalize(A Agent & Stateless, S State_) [ A / Stateless & Citizen { State_ S } ]
CastVote(V Agent, C Agent, E Election) [ Vote { Voter V, Choice C, Election E } ]
Convict(C Crime) [ C.Offender & Imprisoned { Since Now } ]
Release(P Agent & Imprisoned) [ P / Imprisoned & Free Object ]
