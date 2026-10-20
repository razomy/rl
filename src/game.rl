#
Abstract Game Boards, Generators, RPG Stats & Progression Entities
#

GridCellModel {
  GridPosition   VectorFloat3
  Size           VectorFloat3
  GridCoordinate VectorInt3
}

IBoardEvent IEvent & { Cells List(NumberBlockCellEntity) }

Generator {
  IsActive         Bool
  CoolingSystem    CoolingSystem
  GatheringSystem  GatheringSystem
  ProducingSystem  ProducingSystem
  OverheatSystem   OverheatSystem
  OverGatherSystem OverGatherSystem
  DisposeSystem    DisposeSystem
}

CharacterStats {
  Level           Int
  Experience      Int
  MaxHealth       Float
  CurrentHealth   Float
  MaxMana         Float
  CurrentMana     Float
  Stamina         Float
  Strength        Int
  Dexterity       Int
  Constitution    Int
  Intelligence    Int
  Wisdom          Int
  Charisma        Int
  Luck            Int
  Armor           Float
  MagicResistance Float
  CritChance      Float
  CritMultiplier  Float
  MovementSpeed   Float
  AttackSpeed     Float
}

ImageModel { ImageData Any }
CardTraits HasTitle & HasDescription & HasOpened & HasDirty & { Image ImageModel }
