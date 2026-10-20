#
Shader Creation, Ray Tracing AS, GPUMaterial & Shader Closures
#

GPUSpecializationConstant {
  Name  String
  Type  "Int" | "UInt" | "Float" | "Bool"
  Value Int | Float | Bool
}

GPUStageInterfaceInfo {
  Name         String
  InstanceName String
  Attributes   List((String, String, "Smooth" | "Flat" | "NoPerspective"))
}

GPUResourceBinding {
  BindType  "UniformBuf" | "StorageBuf" | "Sampler" | "Image" | "AccelerationStructure" | "InputAttachment"
  Slot      Int
  Name      String
  TypeName  String
  Frequency "Pass" | "Batch" | "Geometry"
}

GPUShaderCreateInfo {
  Name                    String
  VertexInputs            List((Int, String, String))
  VertexOutInterfaces     List(GPUStageInterfaceInfo)
  FragmentOutputs         List((Int, String, String))
  PushConstants           List((String, String, Int))
  SpecializationConstants List(GPUSpecializationConstant)
  Resources               List(GPUResourceBinding)
  VertexSource            Option(String)
  GeometrySource          Option(String)
  FragmentSource          Option(String)
  ComputeSource           Option(String)
  TypedefSources          List(String)
  Defines                 List((String, String))
  LocalGroupSize          Vec3i
  DepthWrite              "Any" | "Unchanged" | "Greater" | "Less"
}

GPUBottomLevelAS {
  Name       String
  Geometries List((GPUIndexBuf, GPUVertBuf))
}

GPUTopLevelAS {
  Name      String
  Instances List((GPUBottomLevelAS, Mat4x4, Byte))
  IsDirty   Bool
}

GPUMaterialEngine "EEVEE" | "Compositor" | "Cycles"
GPUMaterialStatus "Failed" | "Queued" | "Success"

GPUNodeLink {
  LinkType "Constant" | "Uniform" | "Attribute" | "UniformAttr" | "LayerAttr" | "Texture" | "Output"
  Name     String
}

GPUNodeStack {
  Type       String
  Value      Any
  Link       Option(GPUNodeLink)
  HasInput   Bool
  HasOutput  Bool
  SocketType Int
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
