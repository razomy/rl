#
RPG Inventory, Crafting, Achievements, Ranks, Skills & Level Progression
#

ItemRarity    "Common" | "Uncommon" | "Rare" | "Epic" | "Legendary" | "Mythic" | "Artifact"
EquipmentSlot "Head" | "Chest" | "Legs" | "Feet" | "Hands" | "MainHand" | "OffHand" | "Ring" | "Amulet" | "Cloak" | "Belt"
DamageType    "Physical" | "Slashing" | "Piercing" | "Bludgeoning" | "Fire" | "Cold" | "Lightning" | "Poison" | "Acid" | "Psychic" | "Radiant" | "Necrotic" | "True"

StatusEffect {
  EffectId     String
  Name         String
  IsBuff       Bool
  DurationSec  Float
  Stacks       Int
  MaxStacks    Int
  TickInterval Float
}

ProductEntity IEntity & HasPrimary(ProductEntity) & HasName & HasTitle & {
  EnergyPrice Int
  Rarity      ItemRarity
  Image       ImageModel
}

ProductContainerItemModel { ProductId ForeignId(ProductEntity), count Int }

ProductContainerEntity IEntity & HasPrimary(ProductContainerEntity) & {
  Items List(ProductContainerItemModel)
}

CraftEntity {
  Produces  List(ProductEntity)
  Resources List(ProductEntity)
}

RewardEntity IEntity & HasPrimary(RewardEntity) & HasTitle & {
  ProductContainerId ForeignId(ProductContainerEntity)
}

AchievementEntity IEntity & HasPrimary(AchievementEntity) & HasName & HasTitle & {
  RewardId ForeignId(RewardEntity)
  Image    ImageModel
}

UserAchievementEntity ExtendsEntity(AchievementEntity, UserAchievementEntity) & CardTraits & HasAchieved & HasViewed & HasReceived & HasTouched & {
  UserId String
}

RankEntity IEntity & HasPrimary(RankEntity) & HasName & HasTitle & {
  RequiredScore Int
  RewardId      ForeignId(RewardEntity)
  Image         ImageModel
}

UserRankEntity ExtendsEntity(RankEntity, UserRankEntity) & CardTraits & HasAchieved & HasCompleted & HasViewed & HasReceived & HasTouched & {
  UserId String
}

SkillEdgeModel {
  SourceId ForeignId(SkillEntity)
  TargetId ForeignId(SkillEntity)
}

SkillEntity IEntity & HasPrimary(SkillEntity) & HasName & HasTitle & HasDescription & {
  Image         ImageModel
  ChildrenEdges List(SkillEdgeModel)
}

UserSkillEntity ExtendsEntity(SkillEntity, UserSkillEntity) & HasOpened & HasDirty & HasCompleted & HasViewed & HasReceived & HasTouched & {
  UserId String
}

TrophyEntity IEntity & HasPrimary(TrophyEntity) & HasTitle & {
  Image ImageModel
}

GridStepsTaskEntity     { Steps Int }
RequiredSkillTaskEntity { RequiredSkill ForeignId(SkillEntity) }
RewardedCountTaskEntity { Count Int, rewardId ForeignId(RewardEntity) }

ObjectiveEntity IEntity & HasPrimary(ObjectiveEntity) & HasName & HasTitle & {
  RequiredSkill RequiredSkillTaskEntity
  MaxSteps      GridStepsTaskEntity
  GoalSum       RewardedCountTaskEntity
  FirstScore    RewardedCountTaskEntity
  SecondScore   RewardedCountTaskEntity
  ThirdScore    RewardedCountTaskEntity
  Image         ImageModel
}

UserLevelStateType "Locked" | "Opened" | "InProgress" | "Completed"

UserNumberBoardObjectiveEntity ExtendsEntity(ObjectiveEntity, UserNumberBoardObjectiveEntity) & CardTraits & HasCompleted & HasTouched & {
  UserId         String
  Score          Int
  Steps          Int
  State          UserLevelStateType
  IsFirstReward  Bool
  IsSecondReward Bool
  IsThirdReward  Bool
}

ChapterEntity IEntity & HasPrimary(ChapterEntity) & HasName & HasTitle & {
  Image         ImageModel
  ObjectivesIds List(ForeignId(ObjectiveEntity))
}

OpenObjective(level UserNumberBoardObjectiveEntity) [
  Level & { IsOpened true, State "Opened" }
]

MakeBoardStep(level UserNumberBoardObjectiveEntity & { IsOpened true }) [
  Level & {
    Steps     (Steps + 1)
    IsTouched true
    IsDirty   true
    State     "InProgress"
  }
]

UndoBoardStep(level UserNumberBoardObjectiveEntity & { State "InProgress" }) [
  Steps . {
    [ _ > 0 ] [ Level & { Steps (Steps - 1) } ]
    _         [ Level ]
  }
]

CompleteObjective(level UserNumberBoardObjectiveEntity, finalScore Int, objective ObjectiveEntity) [
  Level & {
    Score          FinalScore
    IsCompleted    true
    State          "Completed"
    IsFirstReward  (FinalScore >= Objective.FirstScore.Count)
    IsSecondReward (FinalScore >= Objective.SecondScore.Count)
    IsThirdReward  (FinalScore >= Objective.ThirdScore.Count)
  }
]

UnlockAchievement(ua UserAchievementEntity) [
  ua & { IsAchieved true, IsOpened true, IsDirty true }
]

ClaimAchievementReward(ua UserAchievementEntity & { IsAchieved true, IsReceived false }) [
  ua & { IsReceived true, IsViewed true, IsDirty false }
]

CompleteSkill(us UserSkillEntity & { IsOpened true }) [
  us & { IsCompleted true, IsReceived true, IsDirty true }
]

EvaluateUserRank(ur UserRankEntity, currentScore Int, rankSpec RankEntity) [
  CurrentScore . {
    [ _ >= RankSpec.RequiredScore ] [ Ur & { IsAchieved true, IsCompleted true, IsOpened true } ]
    _                               [ Ur ]
  }
]
