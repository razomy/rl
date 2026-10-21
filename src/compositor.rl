#
Render Data, realtime Compositor & Viewport Engines (EEVEE / Workbench / Overlay)
#

RenderStats {
  Frame         Int
  LocalView     Bool
  StartTime     Float
  LastFrameTime Float
  SceneName     String
  InfoStr       String
  StatStr       String
  MemUsed       Int
  MemPeak       Int
}

SceneRenderView {
  Name         String
  Suffix       String
  Viewflag     Int
  CameraSuffix String
}

ImageFormatData {
  Imtype                   Int
  Depth                    Int
  Planes                   Int
  Quality                  Int
  Compress                 Int
  ExrCodec                 Int
  ViewsFormat              Int
  ColorManagement          Int
  MediaType                Int
  ViewSettings             ColorManagedViewSettings
  DisplaySettings          ColorManagedDisplaySettings
  LinearColorspaceSettings ColorManagedColorspaceSettings
}

RenderData {
  ImFormat    ImageFormatData
  Xsch        Int
  Ysch        Int
  Size        Int
  Xasp        Float
  Yasp        Float
  Sfra        Int
  Efra        Int
  Cfie        Int
  Subframe    Float
  FrameStep   Int
  Blurfac     Float
  BakeMode    Int
  BakeFilter  Int
  BakeSamples Int
  Engine      String
  Views       List(SceneRenderView)
}

CompositorExecutionMode "Render" | "Preview"
CompositorResultType    "Float" | "Float2" | "Float3" | "Float4" | "Color" | "Int" | "Int2" | "Int3" | "Bool" | "Float4x4" | "Menu" | "String"
CompositorPrecision     "Half" | "Full"

CompositorDomain {
  DataSize       Int2
  DisplaySize    Int2
  DataOffset     Int2
  Transformation Float3x3
  IsTransposed   Bool
}

CryptomatteMetaData {
  Hash       String
  Conversion String
  Manifest   String
}

CompositorMetaData {
  IsNonColorData Bool
  Cryptomatte    CryptomatteMetaData
  Fields         Map(String, String)
}

CompositorResult {
  Type           CompositorResultType
  Precision      CompositorPrecision
  Domain         CompositorDomain
  IsSingleValue  Bool
  SingleValue    Any
  ReferenceCount Int
  MetaData       CompositorMetaData
  Texture        Option(GPUTexture)
}

InputRealizationMode "None" | "Transforms" | "OperationDomain"
ImplicitInputType    "UniformImageCoordinates" | "SceneFrame"

InputDescriptor {
  Type               CompositorResultType
  RealizationMode    InputRealizationMode
  ImplicitInput      Option(ImplicitInputType)
  DomainPriority     Int
  ExpectsSingleValue Bool
  SkipTypeConversion Bool
}

CompositorOperation {
  Results               Map(String, CompositorResult)
  InputDescriptors      Map(String, InputDescriptor)
  ResultsMappedToInputs Map(String, CompositorResult)
}

DRWSelectStage "PassPre" | "PassPost"
DRWState       Int

DRWView {
  Viewmat      Float4x4
  Viewinv      Float4x4
  Winmat       Float4x4
  Wininv       Float4x4
  Persmat      Float4x4
  Persinv      Float4x4
  ClipPlanes   List(Float4)
  IsInverted   Bool
  VisibilityOk Bool
}

DRWPass {
  Name  String
  State DRWState
}

EEVEECameraType "Persp" | "Ortho" | "PanoEquirect" | "PanoEquisolid" | "PanoEquidistant" | "PanoMirror" | "PanoEquiangularCubemapFace" | "PanoFisheyeLensPolynomial" | "PanoCentralCylindrical"

EEVEECameraData {
  Persmat              Float4x4
  Persinv              Float4x4
  Viewmat              Float4x4
  Viewinv              Float4x4
  Winmat               Float4x4
  Wininv               Float4x4
  UvScale              Float2
  UvBias               Float2
  ClipNear             Float
  ClipFar              Float
  Type                 EEVEECameraType
  ScreenDiagonalLength Float
  Initialized          Bool
}

EEVEEDebugMode
  "None" | "LightCulling" | "HizValidation" | "IrradianceCacheSurfelsNormal"
  | "IrradianceCacheSurfelsIrradiance" | "IrradianceCacheSurfelsVisibility"
  | "IrradianceCacheSurfelsCluster" | "IrradianceCacheVirtualOffset"
  | "IrradianceCacheValidity" | "ShadowTilemaps" | "ShadowValues"
  | "ShadowTileRandomColor" | "ShadowTilemapRandomColor" | "ShadowAtomicCost"
  | "GbufferStorage" | "GbufferEvaluation" | "DofPlanes"

EEVEEGBuffer {
  HeaderLayerCount  Int
  ClosureLayerCount Int
  NormalLayerCount  Int
}

EEVEELightType "Sun" | "Point" | "Spot" | "Area" | "Ellipse"

EEVEELightData {
  ObjectToWorld      Transform
  PowerFactor        Float4
  ShapePower         Float
  PointPower         Float
  ResourceId         Int
  Flags              Int
  Color              Float3
  Type               EEVEELightType
  ClipNear           Int
  ClipFar            Int
  TilemapIndex       Int
  FilterRadius       Float
  LodBias            Float
  LodMin             Float
  LightSetMembership Int2
}

EEVEEShadowProjectionType "Cubeface" | "Clipmap" | "Cascade"

EEVEEShadowTileMapData {
  Viewmat             Float4x4
  Winmat              Float4x4
  Corners             (Float4, Float4, Float4, Float4)
  GridOffset          Int2
  GridShift           Int2
  ProjectionType      EEVEEShadowProjectionType
  TilesIndex          Int
  ClipDataIndex       Int
  LightType           EEVEELightType
  IsDirty             Bool
  EffectiveLodMin     Int
  ClipNear            Float
  ClipFar             Float
  HalfSize            Float
  CenterOffset        Float2
  ShadowSetMembership Int2
}

EEVEEInstance DrawEngine & {
  Name                     "EEVEE"
  Gbuffer                  EEVEEGBuffer
  DebugMode                EEVEEDebugMode
  IsLightBake              Bool
  IsImageRender            Bool
  IsViewportImageRender    Bool
  IsPlayback               Bool
  IsNavigating             Bool
  IsPainting               Bool
  IsTransforming           Bool
  IsViewportCompositorUsed Bool
  DrawOverlays             Bool
  UseSurfaces              Bool
  UseCurves                Bool
  UseVolumes               Bool
  SampleIndex              Int
  SampleCount              Int
}

WorkbenchLightingType "Flat" | "Studio" | "Matcap"

WorkbenchInstance DrawEngine & {
  Name         "Workbench"
  LightingType WorkbenchLightingType
  XrayMode     Bool
  XrayAlpha    Float
}

OverlayInstance DrawEngine & {
  Name            "Overlay"
  ClippingEnabled Bool
}

CompileEEVEEShaders(e EEVEEInstance) [
  E.SampleCount . {
    [ _ > 0 ] [ e & GpuReady { VramAllocatedBytes 67108864 } ]
    _         [ ShaderCompileError { ShaderName "eevee_deferred_light_eval", ErrorLog "Zero sample count" } ]
  }
]

ExecuteEEVEEFrameRender(engine EEVEEInstance & GpuReady) [
  "Rendering EEVEE frame (Sample {SampleIndex}/{SampleCount}, VRAM: {VramAllocatedBytes}B)" . Shell.Log
]
