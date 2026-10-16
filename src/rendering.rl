_ primitive
_ primitive
_ structure
_ math
_ space
_ ui
_ gpu

#
1. Color Management (OpenColorIO), Curves, Histograms & Scopes
#

CBData {
  R   Float, G Float, B Float, A Float
  Pos Float
  Cur Int
}

ColorBand {
  Tot       Int
  Cur       Int
  Ipo       Int
  ColorMode Int
  HueInterp Int
  Data      List(CBData)
}

CurveMapPoint {
  X      Float
  Y      Float
  Flag   Int
  Shorty Int
}

CurveMap {
  Totpoint    Int
  Flag        Int
  Range       Float
  Mintable    Float
  Maxtable    Float
  ExtIn       Float2
  ExtOut      Float2
  Curve       List(CurveMapPoint)
  Table       List(CurveMapPoint)
  Premultable List(CurveMapPoint)
  Shorty      Float2
}

CurveMapping {
  Flag             Int
  Cur              Int
  Preset           Int
  ChangedTimestamp Int
  Curr             Rctf
  Clipr            Rctf
  Cm               (CurveMap, CurveMap, CurveMap, CurveMap)
  Black            Float3
  White            Float3
  Bwmul            Float3
  Sample           Float3
  Tone             Int
}

CurveProfilePoint {
  X     Float
  Y     Float
  Flag  Int
  H1    Int
  H2    Int
  H1Loc Float2
  H2Loc Float2
}

CurveProfile {
  PathLen     Int
  SegmentsLen Int
  Preset      Int
  Path        List(CurveProfilePoint)
  Table       List(CurveProfilePoint)
  Segments    List(CurveProfilePoint)
  Flag        Int
  ViewRect    Rctf
  ClipRect    Rctf
}

OCIOColorSpace {
  Index             Int
  Name              String
  Description       String
  Family            String
  InteropId         String
  IsSceneLinear     Bool
  IsSrgb            Bool
  IsData            Bool
  IsDisplayReferred Bool
}

OCIOView {
  Index            Int
  Name             String
  Description      String
  IsHdr            Bool
  Gamut            "Unknown" | "Rec709" | "P3D65" | "Rec2020" | "ACES_AP0" | "ACES_AP1"
  TransferFunction "Unknown" | "sRGB" | "ExtendedsRGB" | "Gamma22" | "Gamma24" | "PQ" | "HLG" | "AgX" | "Filmic"
  MaxNits          Int
}

OCIODisplay {
  Index       Int
  Name        String
  UiName      String
  Description String
  Views       List(OCIOView)
}

OCIOLook {
  Index        Int
  Name         String
  UiName       String
  ProcessSpace String
  IsNoop       Bool
}

OCIOConfig {
  ColorSpaces List(OCIOColorSpace)
  Displays    List(OCIODisplay)
  Looks       List(OCIOLook)
  LumaCoefs   Vec3f
  XyzToLinear Mat3x3
}

ColorManagedViewSettings {
  Flag                    Int
  Look                    String
  ViewTransform           String
  Exposure                Float
  Gamma                   Float
  CurveMapping            Option(CurveMapping)
  WhiteBalanceTemperature Float
  WhiteBalanceTint        Float
}

ColorManagedDisplaySettings {
  DisplayDevice String
  Emulation     Int
}

ColorManagedColorspaceSettings {
  Name String
}

Histogram {
  Channels Int
  XRes     Int
  DataR    List(Float)
  DataG    List(Float)
  DataB    List(Float)
  DataLuma List(Float)
  DataA    List(Float)
  Xmax     Float
  Ymax     Float
  Mode     Int
  Flag     Int
  Height   Int
}

Scopes {
  Ok             Int
  SampleFull     Int
  SampleLines    Int
  Accuracy       Float
  WavefrmMode    Int
  WavefrmAlpha   Float
  WavefrmYmax    Float
  WavefrmHeight  Int
  VecscopeAlpha  Float
  VecscopeHeight Int
  VecscopeMode   Int
  Minmax         (Float2, Float2, Float2)
  Hist           Histogram
}

#
2. Render Engine, Passes, Layers, Results & Bake
#

EvaluationMode "Viewport" | "Render"

RenderPass {
  Name     String
  FullName String
  ChanId   String
  View     String
  ViewId   Int
  Channels Int
  RectX    Int
  RectY    Int
}

RenderLayer {
  Name     String
  RectX    Int
  RectY    Int
  LayFlag  Int
  PassFlag Int
  Passes   List(RenderPass)
}

RenderResult {
  RectX        Int
  RectY        Int
  TileRect     RectI
  FrameNr      Int
  Ppm          (Float, Float)
  HaveCombined Bool
  Layers       List(RenderLayer)
  Text         Option(String)
  Error        Option(String)
}

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
  ImFormat         ImageFormatData
  Xsch             Int
  Ysch             Int
  Size             Int
  Xasp             Float
  Yasp             Float
  Sfra             Int
  Efra             Int
  Cfie             Int
  Subframe         Float
  FrameStep        Int
  Blurfac          Float
  BakeMode         Int
  BakeFilter       Int
  BakeSamples      Int
  Engine           String
  Views            List(SceneRenderView)
}

#
3. Realtime Compositor System (COM)
#

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

#
4. Viewport Draw Manager, EEVEE, Workbench & Overlay Engines
#

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

DrawEngine {
  Name String
  Used Bool
}

EEVEECameraType "Persp" | "Ortho" | "PanoEquirect" | "PanoEquisolid" | "PanoEquidistant" | "PanoMirror" | "PanoEquiangularCubemapFace" | "PanoFisheyeLensPolynomial" | "PanoCentralCylindrical"

EEVEECameraData {
  Persmat               Float4x4
  Persinv               Float4x4
  Viewmat               Float4x4
  Viewinv               Float4x4
  Winmat                Float4x4
  Wininv                Float4x4
  UvScale               Float2
  UvBias                Float2
  ClipNear              Float
  ClipFar               Float
  Type                  EEVEECameraType
  ScreenDiagonalLength  Float
  Initialized           Bool
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

#
5. Ontological Typestates for Shader Compilation & Rendering
#

GpuReady            { VramAllocatedBytes Int }
GpuCompiled         { ShaderHandle GPUShader, CompiledAt Int }
RenderAllocated     { OffScreen GPUOffScreen, Viewport GPUViewport }
ShaderCompileError  { ShaderName String, ErrorLog String }
ShaderCompileFailed { Log String, Stage String }
OutOfVram           { RequestedBytes Int, AvailableBytes Int }

CompileEEVEEShaders(E EEVEEInstance) [
  E.SampleCount . {
    [ _ > 0 ] [ E & GpuReady { VramAllocatedBytes 67108864 } ]
    _         [ ShaderCompileError { ShaderName "eevee_deferred_light_eval", ErrorLog "Zero sample count" } ]
  }
]

ExecuteEEVEEFrameRender(Engine EEVEEInstance & GpuReady) [
  "Rendering EEVEE frame (Sample {SampleIndex}/{SampleCount}, VRAM: {VramAllocatedBytes}B)" . Shell.Log
]
