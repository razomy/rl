#
GPU Backend, Buffers, Batches, Textures & Framebuffers
#

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

GPUDepthTest    "None" | "Always" | "Less" | "LessEqual" | "Equal" | "Greater" | "GreaterEqual"
GPUWriteMask    "None" | "Red" | "Green" | "Blue" | "Alpha" | "Depth" | "Stencil" | "Color" | "ColorAndDepth"
GPUFaceCullTest "None" | "Front" | "Back"

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
  Name        String
  SizeInBytes Int
  Slot        Int
  Data        List(Byte)
}

GPUStorageBuf {
  Name        String
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
  Name         String
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
  Name              String
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
