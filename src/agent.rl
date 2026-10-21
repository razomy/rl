#
Abstract Agent, Need, Goal, Mind & Cognitive Typestates
#

AgentKind "human" | "animal" | "organization" | "software" | "robot" | "collective"
Autonomy  Fraction

Agent {
    Name
    AgentKind
    Autonomy
    Position
}

Urgency Fraction

Need {
    NeedKind
    NeedLevel
    Urgency
}
Satisfied   { Need }
Unsatisfied { Need }

Priority   "low" | "medium" | "high" | "critical"
GoalStatus "proposed" | "active" | "achieved" | "abandoned" | "failed"

Goal {
    Title String
    Priority
    GoalStatus
    Deadline
    Serves List(Need)
    Progress Fraction
}
Plan_     { Goal, steps List(String) }
Intention { Goal, committed Bool }

Skill {
    Name
    SkillDomain
    Proficiency
    Experience Duration
}

Knowledge  { Topic String, confidence Fraction }
Confidence Fraction

Belief {
    Proposition String
    Confidence
    Source String
}
Fact  Belief & { Confidence 1 }
Doubt Belief & [ _.Confidence < 0.5 ]

Intensity Fraction
Valence   Range(-1, 1) & Real

Emotion {
    EmotionKind
    Intensity
    Valence
    Since Instant
}
Mood { Valence, arousal Fraction }

Attention  { Focus Any, span Duration }
Memory     { Content Any, recorded Instant, strength Fraction }
Perception { Sense SenseKind, stimulus Any }

Mind {
    Beliefs  List(Belief)
    Goals    List(Goal)
    Skills   List(Skill)
    Emotions List(Emotion)
    Memories List(Memory)
    Personality
    Mood
}

Choice { Options List(Any), chosen Any, reason String }
Idle   Object
Busy   { Activity String }
Tired  { Fatigue Fraction }
Rested Object
