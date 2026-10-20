#
Abstract GPU Buffers, Shaders, Materials & Closures
#

GPUVertAttr {
  Name   String
  Type   String
  Offset Int
}

GPUVertFormat {
  Attributes    List(GPUVertAttr)
  Stride        Int
  Deinterleaved Bool
}

GPUShader {
  Name      String
  IsValid   Bool
  IsCompute Bool
  Info      Option(GPUShaderCreateInfo)
}

GPUPass {
  Shader Option(GPUShader)
  Status GPUMaterialStatus
}

GPUMaterial {
  Name                  String
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
