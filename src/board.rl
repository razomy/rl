#
Grid Boards, puzzle Mechanics & Resource Generators
#

EmpedoclesElements "None" | "Water" | "Earth" | "Fire" | "Air" | "Aether" | "Light" | "Dark" | "Lightning" | "Ice"
GridLayoutType     "Rectangle" | "Hexagon" | "Isometric" | "Octagonal"

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

BoardMoveEvent          IBoardEvent
BoardMergeEvent         IBoardEvent
BoardSwapEvent          IBoardEvent
BoardStepEvent          IBoardEvent
BoardStepUndoEvent      IBoardEvent
AfterBoardStepUndoEvent IBoardEvent

IsNeighborCell(target VectorInt3, neighbor VectorInt3) [
  ((Target.X - Neighbor.X) . Math.Abs <= 1) &&
  ((Target.Y - Neighbor.Y) . Math.Abs <= 1) &&
  ((Target.Z - Neighbor.Z) . Math.Abs <= 1)
]

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

OverheatSystem   { Cooling CoolingSystem, maxHeat Float, isActive Bool }
OverGatherSystem { Gathering GatheringSystem, maxCollect Float, isActive Bool }
DisposeSystem    { Producing ProducingSystem, disposeAbility Float, isActive Bool }

CoolingZeroLevelException          { Reason String }
OverheatException                  { Reason String }
OverGatherException                { Reason String }
GatheringTakeMoreThenAbleException { Reason String }
ProducingTakeMoreThenAbleException { Reason String }

HeatCoolingSystem(cs CoolingSystem, amount Float) [
  Cs & { HeatLevel (HeatLevel + Amount) }
]

UpdateCoolingSystem(cs CoolingSystem) [
  CoolAmount (IsActive . { true [ CoolingAbility ], false [ PassiveCoolingAbility ] })
  NextHeat   (HeatLevel - CoolAmount)
  NextHeat . {
    [ _ <= 0.0 ] [ Cs & { HeatLevel 0.0 } ]
    _            [ Cs & { HeatLevel NextHeat } ]
  }
]

CheckOverheat(os OverheatSystem) [
  Os.Cooling.HeatLevel . {
    [ _ > Os.MaxHeat ] [ OverheatException { Reason "Max heat exceeded" } ]
    _                  [ Os ]
  }
]

GatherResources(gs GatheringSystem) [
  Gain (IsActive . { true [ GatheringAbility ], false [ PassiveGatheringAbility ] })
  Gs & {
    Collect (Collect + Gain)
    Cooling (Cooling . HeatCoolingSystem(GatheringHeatProducing))
  }
]

ProduceResources(ps ProducingSystem) [
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
