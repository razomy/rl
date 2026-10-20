#
Abstract Render Passes, Draw Engine & Ontological Rendering Typestates
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

DrawEngine {
  Name String
  Used Bool
}

GpuReady            { VramAllocatedBytes Int }
GpuCompiled         { ShaderHandle GPUShader, CompiledAt Int }
RenderAllocated     { OffScreen GPUOffScreen, Viewport GPUViewport }
ShaderCompileError  { ShaderName String, ErrorLog String }
ShaderCompileFailed { Log String, Stage String }
OutOfVram           { RequestedBytes Int, AvailableBytes Int }
