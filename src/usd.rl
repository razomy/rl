#
Universal Scene Description (USD), Procedural Content Generation (PCG) & 3D I/O
#

PrimvarInterpolation "constant" | "uniform" | "vertex" | "faceVarying" | "varying"
UsdSpecifier         "def" | "over" | "class"
UsdModelKind         "group" | "assembly" | "component" | "subcomponent"

TimeSamplesIn  { Kind "TimeSamples", Samples Map(Float, Any), Interpolation String }
AttributeIn    { Kind "Attribute", Name String, ShapeName String, Value Any, TimeSamples Option(IdRef(TimeSamplesIn)) }
PrimvarIn      { Kind "Primvar", Name String, ShapeName String, Interpolation PrimvarInterpolation, ElementSize Int, Indices List(Int), Value Any }
RelationshipIn { Kind "Relationship", Name String, Targets List(String) }
PropertyIn     AttributeIn | PrimvarIn | RelationshipIn

SublayerArcIn    { Kind "SublayerArc", LayerRef IdRef(LayerIn), LayerPosition Int }
InheritArcIn     { Kind "InheritArc", TargetPath String }
VariantSetIn     { Kind "VariantSet", Name String, SelectedVariant String, Variants Map(String, IdRef(PrimIn)) }
ReferenceArcIn   { Kind "ReferenceArc", AssetPath String, TargetPrim String, LayerOffsetTime Float, LayerScaleTime Float }
PayloadArcIn     { Kind "PayloadArc", AssetPath String, TargetPrim String, IsLoaded Bool }
SpecializeArcIn  { Kind "SpecializeArc", TargetPath String }
CompositionArcIn SublayerArcIn | InheritArcIn | VariantSetIn | ReferenceArcIn | PayloadArcIn | SpecializeArcIn

PrimIn {
  Kind            "Prim"
  Name            String
  Specifier       UsdSpecifier
  ShapeName       String
  ModelKind       UsdModelKind
  Active          Bool
  Visibility      String
  Children        List(IdRef(PrimIn))
  Properties      List(IdRef(PropertyIn))
  CompositionArcs List(IdRef(CompositionArcIn))
}

InstanceablePrimIn PrimIn & { IsInstance Bool, MasterPrimPath String }

PointInstancerIn PrimIn & {
  Prototypes   List(IdRef(PrimIn))
  ProtoIndices List(Int)
  Positions    List(VectorFloat3)
  Orientations List(Quaternion)
  Scales       List(VectorFloat3)
}

LayerIn {
  Kind        "Layer"
  Identifier  String
  SubLayers   List(IdRef(LayerIn))
  DefaultPrim String
  IsAnonymous Bool
}

StageIn {
  Kind               "Stage"
  RootLayer          IdRef(LayerIn)
  SessionLayer       IdRef(LayerIn)
  DefaultPrim        IdRef(PrimIn)
  TimeCodesPerSecond Float
  FramesPerSecond    Float
}

PcgPinDirection     "In" | "Out"
PcgDataType         "Point" | "Surface" | "Spline" | "Volume" | "Mesh" | "Attribute"
SpatialSetOperation "Union" | "Intersection" | "Difference"

PcgPin {
  PinName           String
  Direction         PcgPinDirection
  AllowedTypes      List(PcgDataType)
  IsMultiConnection Bool
}

PcgEdge {
  FromNodeId  String
  FromPinName String
  ToNodeId    String
  ToPinName   String
}

PcgPoint {
  Transform  Transform3d
  Density    Float
  Steepness  Float
  BoundsMin  VectorFloat3
  BoundsMax  VectorFloat3
  Seed       Int
  Color      RgbaColorFloat
  Attributes Map(String, Any)
}

SurfaceSamplerNode IPcgNode & {
  Kind                  "SurfaceSampler"
  SamplingMethod        String
  PointsPerSquaredMeter Float
  PointExtents          VectorFloat3
  Looseness             Float
}

SplineSamplerNode IPcgNode & {
  Kind              "SplineSampler"
  SampleDistance    Float
  SubdivisionMethod String
  FillInteriorSpace Bool
}

NoiseFieldNode IPcgNode & {
  Kind                "NoiseField"
  NoiseType           String
  Frequency           Float
  Octaves             Int
  Lacunarity          Float
  TargetAttributeName String
}

TransformPointsNode IPcgNode & {
  Kind         "TransformPoints"
  OffsetMin    VectorFloat3
  OffsetMax    VectorFloat3
  RotationMin  VectorFloat3
  RotationMax  VectorFloat3
  UniformScale Bool
  ScaleMin     VectorFloat3
  ScaleMax     VectorFloat3
}

WaveFunctionCollapseNode IPcgNode & {
  Kind                  "WaveFunctionCollapse"
  GridSize              VectorInt3
  TileSize              VectorFloat3
  AdjacencyRuleSetAsset String
  PeriodicWrap          Bool
}

LSystemGrammarNode IPcgNode & {
  Kind       "LSystemGrammar"
  Axiom      String
  Rules      Map(String, String)
  Iterations Int
  AngleStep  Float
  StepLength Float
}

MeshSpawnEntry {
  MeshAssetPath   String
  Weight          Float
  ScaleAdjustment VectorFloat3
  CollisionPreset String
}

StaticMeshSpawnerNode IPcgNode & {
  Kind                 "StaticMeshSpawner"
  MeshEntries          List(MeshSpawnEntry)
  InstancingStrategy   String
  ApplyColorToMaterial Bool
  CastShadows          Bool
}

PcgGraph {
  Nodes             List(IdRef(IPcgNode))
  Edges             List(PcgEdge)
  ExposedParameters Map(String, Any)
}

PathReferenceMode "Auto" | "Absolute" | "Relative" | "Match" | "Strip" | "Copy"

AlembicExportParams IOBaseParams & {
  FrameStart      Float
  FrameEnd        Float
  SelectedOnly    Bool
  ExportUvs       Bool
  ExportNormals   Bool
  ExportVColors   Bool
  ApplySubdiv     Bool
  CurvesAsMesh    Bool
  ExportHair      Bool
  ExportParticles Bool
  EvaluationMode  EvaluationMode
}

FBXImportParams IOBaseParams & {
  VertexColors      "None" | "sRGB" | "Linear"
  ValidateMeshes    Bool
  UseCustomNormals  Bool
  ImportSubdivision Bool
  UseCustomProps    Bool
  IgnoreLeafBones   Bool
  UseAnim           Bool
  AnimOffset        Float
}

OBJExportParams IOBaseParams & {
  ExportAnimation        Bool
  StartFrame             Int
  EndFrame               Int
  ExportSelectedObjects  Bool
  ApplyModifiers         Bool
  ExportEvalMode         EvaluationMode
  ExportUv               Bool
  ExportNormals          Bool
  ExportColors           Bool
  ExportMaterials        Bool
  ExportTriangulatedMesh Bool
  ExportCurvesAsNurbs    Bool
  PathMode               PathReferenceMode
}

GLTFExportParams IOBaseParams & {
  Format             "GLB" | "GLTF_SEPARATE" | "GLTF_EMBEDDED"
  ExportDraco        Bool
  DracoCompression   Int
  ExportAnimations   Bool
  ExportMorphTargets Bool
  ExportSkins        Bool
  ExportLights       Bool
  ExportCameras      Bool
}

ValidateMeshTopology(M Mesh3D) [
  VertsNum . {
    [ _ >= 0 ] [ M & Evaluated { EvalTimestamp 1.0 } ]
    _          [ InvalidTopology { Reason "Negative vertex count" } ]
  }
]

CreateMain(Path String) [
  Main {
    Filepath          Path
    VersionFile       400
    SubversionFile    0
    MinVersionFile    400
    MinSubversionFile 0
    IsGlobalMain      true
  }
]

CreateObject3D(NameStr String, Kind ObjectType, DataBlock Option(ID)) [
  Object3D {
    Id     NameStr
    Name   NameStr
    Type   "OB"
    ObType Kind
    Mode   "Object"
    Data   DataBlock
    Scale  (1.0, 1.0, 1.0)
    Quat   Quaternion { W 1.0, X 0.0, Y 0.0, Z 0.0 }
    Users  1
  }
]

LinkObjectToCollection(Coll Collection3D, Ob Object3D) [
  Coll & {
    Gobject (Coll.Gobject + [CollectionObject { Ob Ob }])
  }
]

SetObjectMode(Ob Object3D, TargetMode ObjectMode) [
  TargetMode . {
    "Edit" [ Ob & InEditMode { ActiveTool "builtin.select_box" } & { Mode "Edit" } ]
    _      [ Ob & { Mode TargetMode } ]
  }
]
