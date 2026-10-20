#
Concrete Agent Subtypes, Maslow Needs, Big-Five Personality, Emotions & Transitions
#

HumanAgent    Agent & Human & { AgentKind "human" }
AnimalAgent   Agent & Animal & { AgentKind "animal" }
SoftwareAgent Agent & { AgentKind "software", Model String }
Robot         Agent & { AgentKind "robot" }

NeedLevel "physiological" | "safety" | "belonging" | "esteem" | "self-actualization"
NeedKind "food" | "water" | "sleep" | "air" | "warmth" | "shelter" | "health" | "security"
    | "income" | "friendship" | "love" | "family" | "respect" | "status" | "recognition"
    | "creativity" | "knowledge" | "purpose" | "freedom"

Proficiency "novice" | "beginner" | "intermediate" | "advanced" | "expert" | "master"
SkillDomain "physical" | "cognitive" | "social" | "technical" | "artistic" | "linguistic" | "craft"

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

SenseKind "sight" | "hearing" | "touch" | "taste" | "smell" | "balance" | "pain" | "proprioception"

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
        Nil [ A & Idle Object ]
        _   [ Choice { Options, Chosen Options.Head } ]
    }
]
Satisfy(U Unsatisfied) [ U / Unsatisfied & Satisfied { Need } ]
StartActivity(A Agent & Idle, Activity String) [ A / Idle & Busy { Activity } ]
StopActivity(A Agent & Busy) [ A / Busy & Idle Object ]
Rest(A Agent & Tired) [ A / Tired & Rested Object ]

Agent [
LifeCycle {
  }
]
