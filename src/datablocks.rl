#
Core Data-Blocks (ID), Main Database, Undo & RNA Reflection
#

IDType
  "SCE" | "LI" | "OB" | "ME" | "CU_LEGACY" | "MB" | "MA" | "TE" | "IM" | "LT"
  | "LA" | "CA" | "KE" | "WO" | "SCR" | "VF" | "TXT" | "SPK" | "LP" | "SO"
  | "GR" | "AR" | "AC" | "NT" | "BR" | "PA" | "GD_LEGACY" | "WM" | "MC" | "MSK"
  | "LS" | "PAL" | "PC" | "CF" | "WS" | "CV" | "PT" | "VO" | "GP"

IDPropertyType "STRING" | "INT" | "FLOAT" | "ARRAY" | "GROUP" | "ID" | "DOUBLE" | "IDPARRAY" | "BOOLEAN" | "ENUM"

IDProperty {
  Name    String
  Type    IDPropertyType
  Subtype String
  Flag    Int
  Value   Any
  UiData  Option(Any)
}

IDOverrideLibraryPropertyOperation {
  Operation      Int
  Flag           Int
  SubitemRefName Option(String)
  SubitemLocName Option(String)
  SubitemRefIdx  Int
  SubitemLocIdx  Int
}

IDOverrideLibraryProperty {
  RnaPath    String
  Operations List(IDOverrideLibraryPropertyOperation)
  Tag        Int
}

IDOverrideLibrary {
  Reference     Option(ID)
  Properties    List(IDOverrideLibraryProperty)
  HierarchyRoot Option(ID)
  Flag          Int
}

PackedFile {
  Size        Int
  Seek        Int
  Data        Any
  SharingInfo Option(ImplicitSharingInfo)
}

PreviewImage {
  Width     Int
  Height    Int
  RectByte  List(Byte)
  RectFloat List(Float)
  IconId    Int
  Flag      Int
}

AssetTag { Name String }

AssetMetaData {
  Properties        Option(IDProperty)
  CatalogId         String
  CatalogSimpleName String
  Author            String
  Description       String
  Copyright         String
  License           String
  Tags              List(AssetTag)
  ActiveTag         Int
}

Library ID & {
  Filepath          String
  FilepathAbs       String
  Parent            Option(Library)
  PackedFile        Option(PackedFile)
  VersionFile       Int
  SubversionFile    Int
  ArchivedLibraries List(Library)
}

PointerRNA {
  OwnerId   Option(ID)
  Type      Option(StructRNA)
  Data      Any
  Ancestors List(PointerRNA)
}

PropertyRNA {
  Identifier         String
  Name               String
  Description        String
  TranslationContext String
  Type               "Boolean" | "Int" | "Float" | "String" | "Enum" | "Pointer" | "Collection"
  Subtype            String
  Flag               Int
  OverrideFlag       Int
  ArrayDimension     Int
  IsEditable         Bool
  IsAnimatable       Bool
}

FunctionRNA {
  Identifier  String
  Description String
  Flag        Int
  Parameters  List(PropertyRNA)
  ReturnProp  Option(PropertyRNA)
}

StructRNA {
  Identifier         String
  Name               String
  Description        String
  TranslationContext String
  Icon               Int
  Base               Option(StructRNA)
  NameProperty       Option(PropertyRNA)
  IteratorProperty   Option(PropertyRNA)
  Properties         List(PropertyRNA)
  Functions          List(FunctionRNA)
}

Main {
  Filepath          String
  VersionFile       Int
  SubversionFile    Int
  MinVersionFile    Int
  MinSubversionFile Int
  IsGlobalMain      Bool
  Scenes            List(Scene3D)
  Libraries         List(Library)
  Objects           List(Object3D)
  Meshes            List(Mesh3D)
  Materials         List(Material3D)
  Lights            List(Light3D)
  Cameras           List(Camera3D)
  Shapekeys         List(Key)
  Worlds            List(World3D)
  Collections       List(Collection3D)
  Armatures         List(bArmature)
  Actions           List(Action3D)
  Nodetrees         List(bNodeTree)
  Brushes           List(Brush)
  Particles         List(ParticleSettings)
  GreasePencils     List(GreasePencil)
  HairCurves        List(Curves)
  Pointclouds       List(PointCloud)
  Volumes           List(Volume3D)
}

UndoType {
  Identifier String
  Flags      Int
  StepSize   Int
}

UndoStep {
  Name            String
  Type            UndoType
  DataSize        Int
  Skip            Bool
  UseMemfileStep  Bool
  UseOldBmainData Bool
  IsApplied       Bool
}

UndoStack {
  Steps             List(UndoStep)
  StepActive        Option(UndoStep)
  StepActiveMemfile Option(UndoStep)
  StepInit          Option(UndoStep)
  GroupLevel        Int
}
