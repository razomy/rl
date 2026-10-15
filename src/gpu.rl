_ meta
_ primitive
_ structure
_ math
_ space
_ ui

// =============================================================================
// 1. GPU Backend, Buffers, Batches, Textures & Framebuffers
// =============================================================================

GPUBackendType "None" | "OpenGL" | "Metal" | "Vulkan" | "DirectX12" | "WebGPU" | "Dummy"

GPUPrimType
  "Points" | "Lines" | "LineStrip" | "LineLoop" | "Triangles" | "TriStrip" | "TriFan" | "LinesAdj" | "TrisAdj" | "Patches"

GPUUsageType "Stream" | "Static" | "Dynamic" | "DeviceOnly"

GPUTextureFormat
  "RGBA8_UNORM" | "RGBA8_SRGB" | "RGBA16_UNORM" | "RGBA16_FLOAT" | "RGBA32_FLOAT"
  | "RG8_UNORM" | "RG16_FLOAT" | "RG32_FLOAT" | "R8_UNORM" | "R16_FLOAT" | "R32_FLOAT"
  | "R32_UINT" | "R32_SINT" | "R11G11B10_FLOAT" | "RGB10_A2" | "DEPTH24_STENCIL8"
  | "DEPTH32F_STENCIL8" | "DEPTH_COMPONENT24" | "DEPTH_COMPONENT32F"
  | "BC1_RGBA_UNORM" | "BC3_RGBA_UNORM" | "BC4_R_UNORM" | "BC5_RG_UNORM" | "BC6H_RGB_FLOAT" | "BC7_RGBA_UNORM"
  | "ASTC_4x4_UNORM" | "ETC2_RGB8_UNORM"

GPUTextureUsage "ShaderRead" | "ShaderWrite" | "Attachment" | "HostRead" | "Atomic"

GPUDataFormat "Float" | "Int" | "UInt" | "UByte" | "UInt24_8" | "10_11_11_Rev" | "2_10_10_10_Rev" | "HalfFloat"

GPUBlendMode
  "None" | "Alpha" | "AlphaPremult" | "Additive" | "AdditivePremult" | "Multiply" | "Subtract" | "Invert" | "OIT" | "Background" | "Custom"

GPUDepthTest "None" | "Always" | "Less" | "LessEqual" | "Equal" | "Greater" | "GreaterEqual"
GPUWriteMask "None" | "Red" | "Green" | "Blue" | "Alpha" | "Depth" | "Stencil" | "Color" | "ColorAndDepth"
GPUFaceCullTest "None" | "Front" | "Back"

GPUVertAttr {
  Name   Str
  Type   Str
  Offset Int
}

GPUVertFormat {
  Attributes    List(GPUVertAttr)
  Stride        Int
  Deinterleaved Bool
}

GPUVertBuf {
  Format      GPUVertFormat
  VertexLen   Int
  VertexAlloc Int
  Usage       GPUUsageType
  Status      "Invalid" | "Init" | "Dirty" | "Uploaded"
  Data        List(Byte)
}

GPUIndexBuf {
  IndexType  "UInt16" | "UInt32"
  IndexStart Int
  IndexLen   Int
  IndexBase  Int
  IsSubrange Bool
  Data       List(Int)
}

GPUBatch {
  PrimType           GPUPrimType
  Verts              List(GPUVertBuf)
  Elem               Option(GPUIndexBuf)
  ProceduralVertices Int
  Shader             Option(GPUShader)
  Flag               Int
}

GPUUniformBuf {
  Name        Str
  SizeInBytes Int
  Slot        Int
  Data        List(Byte)
}

GPUStorageBuf {
  Name        Str
  SizeInBytes Int
  Usage       GPUUsageType
  Slot        Int
  Data        List(Byte)
}

GPUSamplerState {
  Filter  "Nearest" | "Linear" | "Anisotropic"
  Mipmap  "None" | "Nearest" | "Linear"
  ExtendX "Extend" | "Repeat" | "MirroredRepeat" | "ClampToBorder"
  ExtendY "Extend" | "Repeat" | "MirroredRepeat" | "ClampToBorder"
  ExtendZ "Extend" | "Repeat" | "MirroredRepeat" | "ClampToBorder"
}

GPUTexture {
  Name         Str
  Type         "1D" | "1DArray" | "2D" | "2DArray" | "3D" | "Cube" | "CubeArray" | "Buffer"
  Format       GPUTextureFormat
  Usage        Int
  Width        Int
  Height       Int
  Depth        Int
  Mipmaps      Int
  SamplerState GPUSamplerState
}

GPUAttachment {
  Texture Option(GPUTexture)
  Layer   Int
  Mip     Int
}

GPUFrameBuffer {
  Name              Str
  Width             Int
  Height            Int
  DepthAttachment   GPUAttachment
  StencilAttachment GPUAttachment
  ColorAttachments  List(GPUAttachment)
  Viewport          RectI
  Scissor           RectI
  ScissorTest       Bool
}

GPUOffScreen {
  Width        Int
  Height       Int
  Format       GPUTextureFormat
  ColorTexture GPUTexture
  DepthTexture GPUTexture
  FrameBuffer  GPUFrameBuffer
}

GPUViewport {
  Width              Int
  Height             Int
  IsStereo           Bool
  ActiveView         Int
  ColorTextures      List(GPUTexture)
  OverlayTextures    List(GPUTexture)
  DepthTexture       GPUTexture
  FramebufferRender  GPUFrameBuffer
  FramebufferOverlay GPUFrameBuffer
}

// =============================================================================
// 2. Shader Creation, Specialization & Ray Tracing Acceleration Structures
// =============================================================================

GPUSpecializationConstant {
  Name  Str
  Type  "Int" | "UInt" | "Float" | "Bool"
  Value Int | Float | Bool
}

GPUStageInterfaceInfo {
  Name         Str
  InstanceName Str
  Attributes   List((Str, Str, "Smooth" | "Flat" | "NoPerspective"))
}

GPUResourceBinding {
  BindType  "UniformBuf" | "StorageBuf" | "Sampler" | "Image" | "AccelerationStructure" | "InputAttachment"
  Slot      Int
  Name      Str
  TypeName  Str
  Frequency "Pass" | "Batch" | "Geometry"
}

GPUShaderCreateInfo {
  Name                    Str
  VertexInputs            List((Int, Str, Str))
  VertexOutInterfaces     List(GPUStageInterfaceInfo)
  FragmentOutputs         List((Int, Str, Str))
  PushConstants           List((Str, Str, Int))
  SpecializationConstants List(GPUSpecializationConstant)
  Resources               List(GPUResourceBinding)
  VertexSource            Option(Str)
  GeometrySource          Option(Str)
  FragmentSource          Option(Str)
  ComputeSource           Option(Str)
  TypedefSources          List(Str)
  Defines                 List((Str, Str))
  LocalGroupSize          Vec3i
  DepthWrite              "Any" | "Unchanged" | "Greater" | "Less"
}

GPUShader {
  Name      Str
  IsValid   Bool
  IsCompute Bool
  Info      Option(GPUShaderCreateInfo)
}

GPUBottomLevelAS {
  Name       Str
  Geometries List((GPUIndexBuf, GPUVertBuf))
}

GPUTopLevelAS {
  Name      Str
  Instances List((GPUBottomLevelAS, Mat4x4, Byte))
  IsDirty   Bool
}

// =============================================================================
// 3. GPUMaterial & Shader Closures (BSDF / EDF / VDF)
// =============================================================================

GPUMaterialEngine "EEVEE" | "Compositor" | "Cycles"
GPUMaterialStatus "Failed" | "Queued" | "Success"

GPUNodeLink {
  LinkType "Constant" | "Uniform" | "Attribute" | "UniformAttr" | "LayerAttr" | "Texture" | "Output"
  Name     Str
}

GPUNodeStack {
  Type       Str
  Value      Any
  Link       Option(GPUNodeLink)
  HasInput   Bool
  HasOutput  Bool
  SocketType Int
}

GPUPass {
  Shader Option(GPUShader)
  Status GPUMaterialStatus
}

GPUMaterial {
  Name                  Str
  Engine                GPUMaterialEngine
  Material              Any
  Status                GPUMaterialStatus
  Pass                  Option(GPUPass)
  UniformBuf            Option(GPUUniformBuf)
  HasSurfaceOutput      Bool
  HasVolumeOutput       Bool
  HasDisplacementOutput Bool
  Flags                 Int
  Uuid                  Int
}

ClosureDiffuse          { Color Vec3f, Normal Vec3f }
ClosureSubsurface       { Color Vec3f, Normal Vec3f, SssRadius Vec3f }
ClosureTranslucent      { Color Vec3f, Normal Vec3f }
ClosureReflection       { Color Vec3f, Normal Vec3f, Roughness Float }
ClosureRefraction       { Color Vec3f, Normal Vec3f, Roughness Float, Ior Float }
ClosureSheen            { Color Vec3f, Normal Vec3f, Roughness Float }
ClosureHair             { Color Vec3f, Tangent Vec3f, RoughnessU Float, RoughnessV Float, Shift Float }
ClosureVolumeScatter    { Scattering Vec3f, Anisotropy Float }
ClosureVolumeAbsorption { Absorption Vec3f }
ClosureEmission         { Emission Vec3f }
ClosureTransparency     { Transmittance Vec3f, Holdout Float }

ShaderClosure
  ClosureDiffuse | ClosureSubsurface | ClosureTranslucent | ClosureReflection
  | ClosureRefraction | ClosureSheen | ClosureHair | ClosureVolumeScatter
  | ClosureVolumeAbsorption | ClosureEmission | ClosureTransparency

// =============================================================================
// 4. Vulkan Render Graph & BSL Shader Compiler Tool
// =============================================================================

VKNodeType
  "BeginRendering" | "EndRendering" | "ClearAttachments" | "ClearColorImage"
  | "ClearDepthStencilImage" | "FillBuffer" | "UpdateBuffer" | "CopyBuffer"
  | "CopyImage" | "CopyBufferToImage" | "CopyImageToBuffer" | "BlitImage"
  | "Synchronization" | "UpdateMipmaps" | "Dispatch" | "DispatchIndirect"
  | "Draw" | "DrawIndexed" | "DrawIndirect" | "DrawIndexedIndirect"
  | "BeginQuery" | "EndQuery" | "ResetQueryPool" | "BuildAccelerationStructure"

VKResourceAccess {
  ResourceHandle Int
  ResourceType   "None" | "Image" | "Buffer"
  AccessFlags    Int
  ImageLayout    Int
}

VKRenderGraphNode {
  NodeType     VKNodeType
  StorageIndex Int
  Inputs       List(VKResourceAccess)
  Outputs      List(VKResourceAccess)
}

VKRenderGraph {
  Nodes List(VKRenderGraphNode)
}

BSLTokenType
  "Invalid" | "Word" | "Number" | "String" | "NewLine" | "Space" | "Comment"
  | "Dot" | "Hash" | "Ampersand" | "ParOpen" | "ParClose" | "BracketOpen"
  | "BracketClose" | "SquareOpen" | "SquareClose" | "AngleOpen" | "AngleClose"
  | "Assign" | "SemiColon" | "Colon" | "Comma" | "Plus" | "Minus" | "Star" | "Slash"

BSLScopeType
  "Invalid" | "Global" | "Namespace" | "Struct" | "Function" | "LoopArgs"
  | "LoopBody" | "SwitchArg" | "SwitchBody" | "FunctionArgs" | "FunctionCall"
  | "Template" | "TemplateArg" | "Subscript" | "Preprocessor" | "Assignment"
  | "Attributes" | "Attribute" | "Local" | "Statement"

BSLToken {
  Type   BSLTokenType
  Offset Int
  Length Int
  Text   Str
}

BSLScope {
  Type       BSLScopeType
  TokenRange (Int, Int)
  Parent     Int
  Children   List(Int)
}

BSLSymbolVariable {
  Name            Str
  TypeName        Str
  ArrayDimensions Int
  Offset          Int
  IsConst         Bool
  IsConstexpr     Bool
}

BSLSymbolClass {
  Name    Str
  Size    Int
  Align   Int
  IsUnion Bool
  IsEnum  Bool
  Members List(BSLSymbolVariable)
}

BSLSymbolFunction {
  Name         Str
  ReturnType   Str
  ArgTypes     List(Str)
  IsEntryPoint Bool
  IsConstexpr  Bool
}

BSLSymbolTable {
  Classes   Map(Str, BSLSymbolClass)
  Functions Map(Str, List(BSLSymbolFunction))
  Variables Map(Str, BSLSymbolVariable)
}
