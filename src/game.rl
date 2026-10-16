_ primitive
_ primitive
_ structure
_ math
_ space
_ state
_ ui

#
1. Elemental Affinities, Grid Boards & Puzzle Mechanics
#

EmpedoclesElements "None" | "Water" | "Earth" | "Fire" | "Air" | "Aether" | "Light" | "Dark" | "Lightning" | "Ice"
GridLayoutType     "Rectangle" | "Hexagon" | "Isometric" | "Octagonal"

GridCellModel {
  GridPosition   VectorFloat3
  Size           VectorFloat3
  GridCoordinate VectorInt3
}

GridCellsLayoutOptions {
  Count VectorInt3
  Gap   VectorFloat3
  Size  VectorFloat3
}

GridCellsLayout {
  Cells   List(GridCellModel)
  Options GridCellsLayoutOptions
}

NumberBoardBlockType "None" | "RealNumber" | "NegativeNumber" | "Finish" | "Incrementer" | "Decrement" | "Multiplier" | "Divider"

NumberBoardBlockModel {
  Number      Int
  IsFinish    Bool
  NumberType  NumberBoardBlockType
  ElementType EmpedoclesElements
  IsActive    Bool
}

NumberBlockCellEntity IEntity & {
  Cell  GridCellModel
  Block NumberBoardBlockModel
}

SelectionActionType "None" | "Move" | "Swap" | "Merge" | "Increment" | "Decrement" | "Divider" | "Multiplier"

CellState {
  LastNumber   Int
  LastPosition GridCellModel
}

GridHistoryController {
  Snapshots List(List(CellState))
}

IBoardEvent             IEvent & { Cells List(NumberBlockCellEntity) }
BoardMoveEvent          IBoardEvent
BoardMergeEvent         IBoardEvent
BoardSwapEvent          IBoardEvent
BoardStepEvent          IBoardEvent
BoardStepUndoEvent      IBoardEvent
AfterBoardStepUndoEvent IBoardEvent

IsNeighborCell(Target VectorInt3, Neighbor VectorInt3) [
  ((Target.X - Neighbor.X) . Math.Abs <= 1) &&
  ((Target.Y - Neighbor.Y) . Math.Abs <= 1) &&
  ((Target.Z - Neighbor.Z) . Math.Abs <= 1)
]

#
2. Resource Generators, Clicker & Idle Systems
#

UserGeneratorInteractionType "HoldUpProduce" | "HoldProduce" | "ClickProduce" | "AutoClickGenerator"
AutoClickGeneratorState      "Gathering" | "ProduceIncrements" | "ProduceDecrements" | "StoreIncrements" | "StoreDecrements" | "Dispose" | "DisposeIncrements" | "DisposeDecrement"

GeneratorModel {
  CoolingAbility          Float
  PassiveCoolingAbility   Float
  GatheringAbility        Float
  PassiveGatheringAbility Float
  GatheringHeatProducing  Float
  ProduceAbility          Float
  GeneratingHeatProducing Float
  OverheatMaxHeat         Float
  ConsumingCapacity       Float
  MaxCollect              Float
  DisposeAbility          Float
}

CoolingSystem {
  CoolingAbility        Float
  PassiveCoolingAbility Float
  HeatLevel             Float
  IsActive              Bool
}

GatheringSystem {
  Cooling                 CoolingSystem
  GatheringAbility        Float
  PassiveGatheringAbility Float
  GatheringHeatProducing  Float
  Collect                 Float
  IsActive                Bool
}

ProducingSystem {
  Cooling                 CoolingSystem
  Gathering               GatheringSystem
  ConsumingCapacity       Float
  ProduceAbility          Float
  GeneratingHeatProducing Float
  Produce                 Float
  IsActive                Bool
}

OverheatSystem   { Cooling CoolingSystem, MaxHeat Float, IsActive Bool }
OverGatherSystem { Gathering GatheringSystem, MaxCollect Float, IsActive Bool }
DisposeSystem    { Producing ProducingSystem, DisposeAbility Float, IsActive Bool }

Generator {
  IsActive         Bool
  CoolingSystem    CoolingSystem
  GatheringSystem  GatheringSystem
  ProducingSystem  ProducingSystem
  OverheatSystem   OverheatSystem
  OverGatherSystem OverGatherSystem
  DisposeSystem    DisposeSystem
}

CoolingZeroLevelException          { Reason String }
OverheatException                  { Reason String }
OverGatherException                { Reason String }
GatheringTakeMoreThenAbleException { Reason String }
ProducingTakeMoreThenAbleException { Reason String }

HeatCoolingSystem(Cs CoolingSystem, Amount Float) [
  Cs & { HeatLevel (HeatLevel + Amount) }
]

UpdateCoolingSystem(Cs CoolingSystem) [
  CoolAmount (IsActive . { true [ CoolingAbility ], false [ PassiveCoolingAbility ] })
  NextHeat   (HeatLevel - CoolAmount)
  NextHeat . {
    [ _ <= 0.0 ] [ Cs & { HeatLevel 0.0 } ]
    _            [ Cs & { HeatLevel NextHeat } ]
  }
]

CheckOverheat(Os OverheatSystem) [
  Os.Cooling.HeatLevel . {
    [ _ > Os.MaxHeat ] [ OverheatException { Reason "Max heat exceeded" } ]
    _                  [ Os ]
  }
]

GatherResources(Gs GatheringSystem) [
  Gain (IsActive . { true [ GatheringAbility ], false [ PassiveGatheringAbility ] })
  Gs & {
    Collect (Collect + Gain)
    Cooling (Cooling . HeatCoolingSystem(GatheringHeatProducing))
  }
]

ProduceResources(Ps ProducingSystem) [
  Ps.Gathering.Collect . {
    [ _ < ConsumingCapacity ] [ ProducingTakeMoreThenAbleException { Reason "Not enough gathered resources" } ]
    _ [
      Ps & {
        Produce   (Produce + ProduceAbility)
        Gathering (Gathering & { Collect (Gathering.Collect - ConsumingCapacity) })
        Cooling   (Cooling . HeatCoolingSystem(GeneratingHeatProducing))
      }
    ]
  }
]

#
3. RPG Stats, Inventory, Crafting, Achievements, Ranks, Skills & Trophies
#

ItemRarity "Common" | "Uncommon" | "Rare" | "Epic" | "Legendary" | "Mythic" | "Artifact"
EquipmentSlot "Head" | "Chest" | "Legs" | "Feet" | "Hands" | "MainHand" | "OffHand" | "Ring" | "Amulet" | "Cloak" | "Belt"
DamageType "Physical" | "Slashing" | "Piercing" | "Bludgeoning" | "Fire" | "Cold" | "Lightning" | "Poison" | "Acid" | "Psychic" | "Radiant" | "Necrotic" | "True"

CharacterStats {
  Level            Int
  Experience       Int
  MaxHealth        Float
  CurrentHealth    Float
  MaxMana          Float
  CurrentMana      Float
  Stamina          Float
  Strength         Int
  Dexterity        Int
  Constitution     Int
  Intelligence     Int
  Wisdom           Int
  Charisma         Int
  Luck             Int
  Armor            Float
  MagicResistance  Float
  CritChance       Float
  CritMultiplier   Float
  MovementSpeed    Float
  AttackSpeed      Float
}

StatusEffect {
  EffectId      String
  Name          String
  IsBuff        Bool
  DurationSec   Float
  Stacks        Int
  MaxStacks     Int
  TickInterval  Float
}

ImageModel { ImageData Any }
CardTraits HasTitle & HasDescription & HasOpened & HasDirty & { Image ImageModel }

ProductEntity IEntity & HasPrimary(ProductEntity) & HasName & HasTitle & {
  EnergyPrice Int
  Rarity      ItemRarity
  Image       ImageModel
}

ProductContainerItemModel { ProductId ForeignId(ProductEntity), Count Int }

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

#
4. Locations, Chapters, Objectives, Quests & Progression Transitions
#

GridStepsTaskEntity     { Steps Int }
RequiredSkillTaskEntity { RequiredSkill ForeignId(SkillEntity) }
RewardedCountTaskEntity { Count Int, RewardId ForeignId(RewardEntity) }

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

OpenObjective(Level UserNumberBoardObjectiveEntity) [
  Level & { IsOpened true, State "Opened" }
]

MakeBoardStep(Level UserNumberBoardObjectiveEntity & { IsOpened true }) [
  Level & {
    Steps     (Steps + 1)
    IsTouched true
    IsDirty   true
    State     "InProgress"
  }
]

UndoBoardStep(Level UserNumberBoardObjectiveEntity & { State "InProgress" }) [
  Steps . {
    [ _ > 0 ] [ Level & { Steps (Steps - 1) } ]
    _         [ Level ]
  }
]

CompleteObjective(Level UserNumberBoardObjectiveEntity, FinalScore Int, Objective ObjectiveEntity) [
  Level & {
    Score          FinalScore
    IsCompleted    true
    State          "Completed"
    IsFirstReward  (FinalScore >= Objective.FirstScore.Count)
    IsSecondReward (FinalScore >= Objective.SecondScore.Count)
    IsThirdReward  (FinalScore >= Objective.ThirdScore.Count)
  }
]

UnlockAchievement(Ua UserAchievementEntity) [
  Ua & { IsAchieved true, IsOpened true, IsDirty true }
]

ClaimAchievementReward(Ua UserAchievementEntity & { IsAchieved true, IsReceived false }) [
  Ua & { IsReceived true, IsViewed true, IsDirty false }
]

CompleteSkill(Us UserSkillEntity & { IsOpened true }) [
  Us & { IsCompleted true, IsReceived true, IsDirty true }
]

EvaluateUserRank(Ur UserRankEntity, CurrentScore Int, RankSpec RankEntity) [
  CurrentScore . {
    [ _ >= RankSpec.RequiredScore ] [ Ur & { IsAchieved true, IsCompleted true, IsOpened true } ]
    _                               [ Ur ]
  }
]
