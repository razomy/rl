_ primitive
_ structure
_ quantity
_ time
_ space
_ life

#
Agents
#

AgentKind "human" | "animal" | "organization" | "software" | "robot" | "collective"
Autonomy  Fraction

Agent {
    Name
    AgentKind
    Autonomy
    Position
}

HumanAgent    Agent & Human & { AgentKind "human" }
AnimalAgent   Agent & Animal & { AgentKind "animal" }
SoftwareAgent Agent & { AgentKind "software", Model String }
Robot         Agent & { AgentKind "robot" }

#
Needs (Maslow) and motivation
#

NeedLevel "physiological" | "safety" | "belonging" | "esteem" | "self-actualization"
NeedKind "food" | "water" | "sleep" | "air" | "warmth" | "shelter" | "health" | "security"
    | "income" | "friendship" | "love" | "family" | "respect" | "status" | "recognition"
    | "creativity" | "knowledge" | "purpose" | "freedom"
Urgency Fraction

Need {
    NeedKind
    NeedLevel
    Urgency
}
Satisfied   { Need }
Unsatisfied { Need }

Priority "low" | "medium" | "high" | "critical"
GoalStatus "proposed" | "active" | "achieved" | "abandoned" | "failed"

Goal {
    Title String
    Priority
    GoalStatus
    Deadline
    Serves List(Need)
    Progress Fraction
}
Plan_ { Goal, Steps List(String) }
Intention { Goal, Committed Bool }

#
Mind
#

Proficiency "novice" | "beginner" | "intermediate" | "advanced" | "expert" | "master"
SkillDomain "physical" | "cognitive" | "social" | "technical" | "artistic" | "linguistic" | "craft"

Skill {
    Name
    SkillDomain
    Proficiency
    Experience Duration
}

Knowledge { Topic String, Confidence Fraction }
Confidence Fraction

Belief {
    Proposition String
    Confidence
    Source String
}
Fact  Belief & { Confidence 1 }
Doubt Belief & [ _.Confidence < 0.5 ]

Value_ "honesty" | "kindness" | "justice" | "freedom" | "loyalty" | "courage" | "wisdom"
    | "tradition" | "achievement" | "power" | "security" | "pleasure" | "benevolence"

PersonalityTrait "openness" | "conscientiousness" | "extraversion" | "agreeableness" | "neuroticism"
Personality {
    Openness          Fraction
    Conscientiousness Fraction
    Extraversion      Fraction
    Agreeableness     Fraction
    Neuroticism       Fraction
}

EmotionKind "joy" | "sadness" | "anger" | "fear" | "surprise" | "disgust" | "trust" | "anticipation"
    | "love" | "shame" | "guilt" | "pride" | "envy" | "gratitude" | "boredom" | "curiosity"
Intensity Fraction
Valence   Range(-1, 1) & Real

Emotion {
    EmotionKind
    Intensity
    Valence
    Since Instant
}
Mood { Valence, Arousal Fraction }

Attention { Focus Any, Span Duration }
Memory    { Content Any, Recorded Instant, Strength Fraction }
Perception { Sense SenseKind, Stimulus Any }
SenseKind "sight" | "hearing" | "touch" | "taste" | "smell" | "balance" | "pain" | "proprioception"

Mind {
    Beliefs   List(Belief)
    Goals     List(Goal)
    Skills    List(Skill)
    Emotions  List(Emotion)
    Memories  List(Memory)
    Personality
    Mood
}

Choice   { Options List(Any), Chosen Any, Reason String }
Idle     {}
Busy     { Activity String }
Tired    { Fatigue Fraction }
Rested   {}

#
Transitions
#

Perceive(A Agent & Mind, P Perception) [ A & { Memories (Cons { Head Memory { Content P, Recorded Now }, Tail Memories }) } ]
Learn(A Agent & Mind, S Skill) [ A & { Skills (Cons { Head S, Tail Skills }) } ]
Practice(S Skill, D Duration) [
    Proficiency . {
        "novice"       [ S & { Proficiency "beginner" } ]
        "beginner"     [ S & { Proficiency "intermediate" } ]
        "intermediate" [ S & { Proficiency "advanced" } ]
        "advanced"     [ S & { Proficiency "expert" } ]
        "expert"       [ S & { Proficiency "master" } ]
        _              [ S ]
    }
]
Believe(A Agent & Mind, B Belief) [ A & { Beliefs (Cons { Head B, Tail Beliefs }) } ]
Forget(M Memory) [ M & { Strength 0 } ]
Feel(A Agent & Mind, E Emotion) [ A & { Emotions (Cons { Head E, Tail Emotions }) } ]
SetGoal(A Agent & Mind, G Goal) [ A & { Goals (Cons { Head G & { GoalStatus "active" }, Tail Goals }) } ]
Achieve(G Goal & { GoalStatus "active" }) [ G & { GoalStatus "achieved", Progress 1 } ]
Abandon(G Goal & { GoalStatus "active" }) [ G & { GoalStatus "abandoned" } ]
Decide(A Agent, Options List(Any)) [
    Options . {
        Nil [ A & Idle {} ]
        _   [ Choice { Options, Chosen Options.Head } ]
    }
]
Satisfy(U Unsatisfied) [ U / Unsatisfied & Satisfied { Need } ]
StartActivity(A Agent & Idle, Activity String) [ A / Idle & Busy { Activity } ]
StopActivity(A Agent & Busy) [ A / Busy & Idle {} ]
Rest(A Agent & Tired) [ A / Tired & Rested {} ]

Agent [
LifeCycle {
  }
]
