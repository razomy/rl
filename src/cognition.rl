#
Concrete Agent Subtypes, maslow Needs, Big-Five Personality, Emotions & Transitions
#

HumanAgent    Agent & Human & { AgentKind "human" }
AnimalAgent   Agent & Animal & { AgentKind "animal" }
SoftwareAgent Agent & { AgentKind "software", model String }
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

Perceive(a Agent & Mind, p Perception) [ a & { Memories (Cons { Head Memory { Content P, recorded Now }, tail Memories }) } ]
Learn(a Agent & Mind, s Skill) [ a & { Skills (Cons { Head S, tail Skills }) } ]
Practice(s Skill, d Duration) [
    Proficiency . {
        "novice"       [ s & { Proficiency "beginner" } ]
        "beginner"     [ s & { Proficiency "intermediate" } ]
        "intermediate" [ s & { Proficiency "advanced" } ]
        "advanced"     [ s & { Proficiency "expert" } ]
        "expert"       [ s & { Proficiency "master" } ]
        _              [ S ]
    }
]
Believe(a Agent & Mind, b Belief) [ a & { Beliefs (Cons { Head B, tail Beliefs }) } ]
Forget(m Memory) [ m & { Strength 0 } ]
Feel(a Agent & Mind, e Emotion) [ a & { Emotions (Cons { Head E, tail Emotions }) } ]
SetGoal(a Agent & Mind, g Goal) [ a & { Goals (Cons { Head G & { GoalStatus "active" }, tail Goals }) } ]
Achieve(g Goal & { GoalStatus "active" }) [ g & { GoalStatus "achieved", Progress 1 } ]
Abandon(g Goal & { GoalStatus "active" }) [ g & { GoalStatus "abandoned" } ]
Decide(a Agent, options List(Any)) [
    Options . {
        Nil [ a & Idle Object ]
        _   [ Choice { Options, chosen Options.Head } ]
    }
]
Satisfy(u Unsatisfied) [ U / Unsatisfied & Satisfied { Need } ]
StartActivity(a Agent & Idle, activity String) [ A / Idle & Busy { Activity } ]
StopActivity(a Agent & Busy) [ A / Busy & Idle Object ]
Rest(a Agent & Tired) [ A / Tired & Rested Object ]

Agent [
LifeCycle {
  }
]
