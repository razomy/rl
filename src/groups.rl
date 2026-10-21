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
Religion  Group & { GroupKind "religion", beliefs List(Belief) }

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
Treaty       { Title, parties List(Agent), signedAt Date }

RightKind "life" | "liberty" | "property" | "speech" | "religion" | "assembly" | "privacy"
    | "vote" | "education" | "health" | "work" | "fair-trial" | "movement" | "asylum"

Verdict "guilty" | "not-guilty" | "dismissed"

GovernmentForm "democracy" | "republic" | "monarchy" | "constitutional-monarchy" | "theocracy"
    | "dictatorship" | "oligarchy" | "federation" | "confederation" | "anarchy"

Join(a Agent & NonMember, g Group, r Role) [ A / NonMember & Member { Membership { Member A, group G, role R, since Now } } ]
Leave(a Agent & Member) [ A / Member & NonMember Object ]
Befriend(a Agent, b Agent) [ Relationship { RelationshipKind "friendship", from A, to B, since Now } ]
Marry(a Agent & Single, b Agent & Single) [ List2(A / Single & Married { Spouse B, since Now }, B / Single & Married { Spouse A, since Now }) ]
Divorce(a Agent & Married) [ A / Married & Divorced { Since Now } ]
Widow(a Agent & Married) [ A / Married & Widowed { Since Now } ]
Adopt(parent Agent, child Agent) [ Relationship { RelationshipKind "kinship", from Parent, to Child, since Now } ]
Enact(l Law) [ l & { EnactedAt Today } ]
Repeal(l Law) [ l & { Repealed Today } ]
Grant(a Agent, k RightKind, l Law) [ Right { RightKind K, holder A, grantedBy L } ]
Acquire(x Any & Unowned, a Agent) [ X / Unowned & Owned { Ownership { Owner A, property X, since Now, Share 1 } } ]
Abandon_(x Any & Owned) [ X / Owned & Unowned Object ]
Naturalize(a Agent & Stateless, s State_) [ A / Stateless & Citizen { State_ S } ]
CastVote(v Agent, c Agent, e Election) [ Vote { Voter V, choice C, election E } ]
Convict(c Crime) [ C.Offender & Imprisoned { Since Now } ]
Release(p Agent & Imprisoned) [ P / Imprisoned & Free Object ]
