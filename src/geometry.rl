
#
Attributes, Geometry Components, Mesh, BMesh, Curves, Volume & GreasePencil
#

AttrStorageType "Array" | "Single"
AttrType        "Bool" | "Int8" | "Int16_2D" | "Int32" | "Int32_2D" | "Float" | "Float2" | "Float3" | "Float4" | "Float4x4" | "ColorByte" | "ColorFloat" | "Quaternion" | "String"
AttrDomain      "Point" | "Edge" | "Face" | "Corner" | "Curve" | "Instance" | "Layer"

Attribute {
  Name        String
  Domain      AttrDomain
  DataType    AttrType
  StorageType AttrStorageType
  Data        GList
}

AttributeStorage {
  Attributes List(Attribute)
}

MFDataType    { Category "Single" | "Vector", BaseType AttrType }
MFParamType   { Category "SingleInput" | "VectorInput" | "SingleOutput" | "VectorOutput" | "SingleMutable" | "VectorMutable", DataType MFDataType }
MFParamInfo   { Name String, Type MFParamType, Flag "None" | "SupportsUnusedOutput" }
MFSignature   { FunctionName String, Params List(MFParamInfo) }
MultiFunction { Signature MFSignature }

LFValueUsage "Used" | "Maybe" | "Unused"
LFInput      { DebugName String, Type AttrType, Usage LFValueUsage }
LFOutput     { DebugName String, Type AttrType }
LazyFunction { DebugName String, Inputs List(LFInput), Outputs List(LFOutput), AllowMissingRequestedInputs Bool }

MeshComponent         GeometryComponent & { Type "Mesh", Mesh Option(Mesh3D) }
PointCloudComponent   GeometryComponent & { Type "PointCloud", PointCloud Option(PointCloud) }
CurveComponent        GeometryComponent & { Type "Curve", Curves Option(Curves) }
InstancesComponent    GeometryComponent & { Type "Instance", Instances Option(Instances) }
VolumeComponent       GeometryComponent & { Type "Volume", Volume Option(Volume3D) }
GreasePencilComponent GeometryComponent & { Type "GreasePencil", GreasePencil Option(GreasePencil) }

InstanceReferenceType "None" | "Object" | "Collection" | "GeometrySet"

InstanceReference {
  Type        InstanceReferenceType
  Object      Option(Object3D)
  Collection  Option(Collection3D)
  GeometrySet Option(GeometrySet)
}

Instances {
  References       List(InstanceReference)
  ReferenceHandles List(Int)
  Transforms       List(Float4x4)
  InstancesNum     Int
  Attributes       AttributeStorage
}

bDeformWeight { DefNr Int, Weight Float }
MDeformVert   { Dw List(bDeformWeight), Flag Int }
bDeformGroup  { Name String, Flag Int }

KeyBlock {
  Name      String
  Curval    Float
  Type      Int
  Relative  Int
  Flag      Int
  TotElem   Int
  Uid       Int
  Data      List(Float3)
  Vgroup    String
  Slidermin Float
  Slidermax Float
}

Key ID & {
  Type     "KE"
  TypeMode Int
  ElemSize Int
  Refkey   Option(KeyBlock)
  Block    List(KeyBlock)
  From     Option(ID)
  Totkey   Int
  Flag     Int
  Ctime    Float
  UidGen   Int
}

BMHeader { Index Int, Htype Int, Hflag Int }
BMVert   { Head BMHeader, Co Float3, No Float3, Edge Option(BMEdge) }
BMEdge   { Head BMHeader, V1 BMVert, V2 BMVert, Loop Option(BMLoop) }
BMLoop   { Head BMHeader, V BMVert, E BMEdge, F BMFace, Next BMLoop, Prev BMLoop, RadialNext BMLoop, RadialPrev BMLoop }
BMFace   { Head BMHeader, LFirst BMLoop, Len Int, No Float3, MatNr Int }
BMElem   BMVert | BMEdge | BMLoop | BMFace

BMesh {
  Totvert    Int
  Totedge    Int
  Totloop    Int
  Totface    Int
  Selectmode Int
  Verts      List(BMVert)
  Edges      List(BMEdge)
  Faces      List(BMFace)
  ActiveFace Option(BMFace)
}

SubdivVtxBoundaryInterpolation "None" | "EdgeOnly" | "EdgeAndCorner"
SubdivFVarLinearInterpolation  "None" | "CornersOnly" | "CornersPlus1" | "CornersPlus2" | "Boundaries" | "All"

SubdivSettings {
  IsSimple                 Bool
  IsAdaptive               Bool
  Level                    Int
  UseCreases               Bool
  VtxBoundaryInterpolation SubdivVtxBoundaryInterpolation
  FvarLinearInterpolation  SubdivFVarLinearInterpolation
}

SubdivCCG {
  Level         Int
  GridSize      Int
  GridArea      Int
  GridsNum      Int
  Positions     List(Float3)
  Normals       List(Float3)
  Masks         List(Float)
  Faces         OffsetIndices
  GridToFaceMap List(Int)
}

Mesh3D ID & {
  Type             "ME"
  VertsNum         Int
  EdgesNum         Int
  FacesNum         Int
  CornersNum       Int
  FaceOffsets      List(Int)
  Attributes       AttributeStorage
  Materials        List(Material3D)
  Key              Option(Key)
  SubdivCcg        Option(SubdivCCG)
  TexspaceLocation Float3
  TexspaceSize     Float3
  Symmetry         Int
  RemeshVoxelSize  Float
  RemeshVoxelAdapt Float
  RemeshMode       Int
}

CurveType  "CatmullRom" | "Poly" | "Bezier" | "Nurbs"
HandleType "Free" | "Auto" | "Vector" | "Align"
NormalMode "MinimumTwist" | "ZUp" | "Free"
KnotsMode  "Normal" | "EndPoint" | "Bezier" | "Custom"

CurvesGeometry {
  PointsNum          Int
  CurvesNum          Int
  CurveOffsets       List(Int)
  CustomKnots        List(Float)
  Attributes         AttributeStorage
  TypeCounts         (Int, Int, Int, Int)
  EvaluatedPositions Option(List(Float3))
  EvaluatedTangents  Option(List(Float3))
  EvaluatedNormals   Option(List(Float3))
  EvaluatedLengths   Option(List(Float))
  Bounds             Option(Bounds(Float3))
}

Curves ID & {
  Type            "CV"
  Geometry        CurvesGeometry
  Materials       List(Material3D)
  Surface         Option(Object3D)
  SurfaceUvMap    String
  Symmetry        Int
  SelectionDomain AttrDomain
  Flag            Int
}

PointCloud ID & {
  Type       "PT"
  Totpoint   Int
  Attributes AttributeStorage
  Materials  List(Material3D)
  Flag       Int
}

VolumeGridType "Unknown" | "Boolean" | "Float" | "Double" | "Int" | "Int64" | "Vec3f" | "Vec3d" | "Vec3i" | "Mask" | "Points"

VolumeGridData {
  Name             String
  GridType         VolumeGridType
  IsLoaded         Bool
  ActiveVoxels     Int
  ActiveLeafVoxels Int
  ActiveTiles      Int
  SizeInBytes      Int
  ActiveBounds     Bounds(Int3)
  Transform        Float4x4
  ErrorMessage     String
}

Volume3D ID & {
  Type          "VO"
  Filepath      String
  PackedFile    Option(PackedFile)
  IsSequence    Bool
  SequenceMode  Int
  FrameStart    Int
  FrameDuration Int
  FrameOffset   Int
  Flag          Int
  ActiveGrid    Int
  Materials     List(Material3D)
  Grids         List(VolumeGridData)
  VelocityGrid  String
  VelocityUnit  Int
  VelocityScale Float
}

GreasePencilDrawing {
  Strokes           CurvesGeometry
  CurvePlaneNormals List(Float3)
  TextureMatrices   List(Float4x2)
  UserCount         Int
}

GreasePencilFrame {
  DrawingIndex Int
  Flag         Int
  Type         BezTripleKeyframeType
}

GreasePencilLayerMask {
  LayerName String
  Flag      Int
}

GreasePencilTreeNode {
  Name   String
  Flag   Int
  Color  Float3
  Parent Option(GreasePencilLayerGroup)
}

GreasePencilLayer GreasePencilTreeNode & {
  Frames        Map(Int, GreasePencilFrame)
  BlendMode     Int
  Opacity       Float
  ParentObject  Option(Object3D)
  Parsubstr     String
  ParentInverse Float4x4
  Translation   Float3
  Rotation      Float3
  Scale         Float3
  ViewLayerName String
  Masks         List(GreasePencilLayerMask)
}

GreasePencilLayerGroup GreasePencilTreeNode & {
  Children   List(GreasePencilTreeNode)
  ColorTag   Int
  IsExpanded Bool
}

GreasePencil ID & {
  Type                 "GP"
  Drawings             List(GreasePencilDrawing)
  RootGroup            GreasePencilLayerGroup
  ActiveNode           Option(GreasePencilTreeNode)
  Materials            List(Material3D)
  VertexGroupNames     List(bDeformGroup)
  VertexGroupActiveIdx Int
  Flag                 Int
}
