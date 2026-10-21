#
Abstract 3D Data-Block (ID), geometry Component & Evaluation Typestates
#

SessionUID { Value Int }
SubFrame   { Frame Int, subframe Float }

ID Identifiable & {
  Name             String
  Type             IDType
  Flag             Int
  Tag              Int
  Users            Int
  SessionUid       SessionUID
  Library          Option(Library)
  LibraryWeakRef   Option(String)
  OverrideLibrary  Option(IDOverrideLibrary)
  Properties       Option(IDProperty)
  SystemProperties Option(IDProperty)
  AssetData        Option(AssetMetaData)
  Preview          Option(PreviewImage)
  AnimData         Option(AnimData)
}

GeometryOwnershipType "Owned" | "Editable" | "ReadOnly"
GeometryComponentType "Mesh" | "PointCloud" | "Curve" | "Instance" | "Volume" | "Edit" | "GreasePencil"

GeometryComponent {
  Type       GeometryComponentType
  Ownership  GeometryOwnershipType
  Attributes AttributeStorage
}

GeometrySet {
  Name       String
  Components Map(GeometryComponentType, GeometryComponent)
  Bundle     Option(Any)
}

IPcgNode {
  Name               String
  Inputs             List(PcgPin)
  Outputs            List(PcgPin)
  Enabled            Bool
  DebugVisualization Bool
}

IOBaseParams {
  Filepath    String
  ForwardAxis AxisSigned
  UpAxis      AxisSigned
  GlobalScale Float
}

// Ontological Typestates
Evaluated         { EvalTimestamp Float }
DepsgraphSynced   { SyncCount Int }
Baked             { BakeDir String, bakedFrameRange Int2 }
LibOverridden     { ReferenceUid SessionUID }
InEditMode        { ActiveTool String }
InvalidTopology   { Reason String }
MissingDependency { MissingIdName String }
