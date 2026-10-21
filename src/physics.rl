#
Objects, Modifiers, Physics, Scenes, node Trees, sculpt PBVH & Window Manager
#

ObjectType
  "Empty" | "Mesh" | "CurveLegacy" | "Surf" | "Font" | "MBall" | "Lamp"
  | "Camera" | "Lattice" | "Armature" | "Speaker" | "Lightprobe"
  | "GpencilLegacy" | "Curves" | "Pointcloud" | "Volume" | "GreasePencil"

ObjectMode
  "Object" | "Edit" | "Sculpt" | "VertexPaint" | "WeightPaint" | "TexturePaint"
  | "ParticleEdit" | "Pose" | "SculptCurves" | "PaintGreasePencil"
  | "SculptGreasePencil" | "WeightGreasePencil" | "VertexGreasePencil"

ModifierType
  "None" | "Subsurf" | "Lattice" | "Curve" | "Build" | "Mirror" | "Decimate"
  | "Wave" | "Armature" | "Hook" | "Softbody" | "Boolean" | "Array" | "EdgeSplit"
  | "Displace" | "UVProject" | "Smooth" | "Cast" | "MeshDeform" | "ParticleSystem"
  | "ParticleInstance" | "Explode" | "Cloth" | "Collision" | "Bevel" | "Shrinkwrap"
  | "Mask" | "SimpleDeform" | "Multires" | "Surface" | "Fluid" | "ShapeKey"
  | "Solidify" | "Screw" | "Warp" | "WeightVGEdit" | "WeightVGMix" | "WeightVGProximity"
  | "Ocean" | "DynamicPaint" | "Remesh" | "Skin" | "LaplacianSmooth" | "Triangulate"
  | "UVWarp" | "MeshCache" | "LaplacianDeform" | "Wireframe" | "DataTransfer"
  | "NormalEdit" | "CorrectiveSmooth" | "MeshSequenceCache" | "SurfaceDeform"
  | "WeightedNormal" | "Weld" | "Nodes" | "MeshToVolume" | "VolumeDisplace" | "VolumeToMesh"

ModifierData {
  Name          String
  Type          ModifierType
  Mode          Int
  Flag          Int
  PersistentUid Int
  SessionUid    SessionUID
  ExecutionTime Float
  Error         Option(String)
}

NodesModifierData ModifierData & {
  Type          "Nodes"
  NodeGroup     Option(bNodeTree)
  Settings      Option(IDProperty)
  BakeDirectory String
  BakeTarget    Int
  Flag          Int
}

ClothVertex {
  Flags        Int
  V            Float3
  X            Float3
  Xold         Float3
  Mass         Float
  Goal         Float
  Impulse      Float3
  StructStiff  Float
  BendStiff    Float
  ShearStiff   Float
  ShrinkFactor Float
}

ClothSpring {
  Ij           Int
  Kl           Int
  Restlen      Float
  Type         Int
  Flags        Int
  LinStiffness Float
  AngStiffness Float
}

Cloth {
  Verts       List(ClothVertex)
  Springs     List(ClothSpring)
  Numsprings  Int
  MvertNum    Int
  Bvhtree     Option(BVHTree)
  Bvhselftree Option(BVHTree)
}

FluidDomainType   "Gas" | "Liquid"
FluidFlowType     "Smoke" | "Fire" | "SmokeFire" | "Liquid"
FluidFlowBehavior "Inflow" | "Outflow" | "Geometry"

FluidDomainSettings {
  Type            FluidDomainType
  Res             Int3
  ResMin          Int3
  ResMax          Int3
  BaseRes         Int3
  CellSize        Float3
  GlobalSize      Float3
  CacheFrameStart Int
  CacheFrameEnd   Int
  Flags           Int
}

RigidBodyObType  "Active" | "Passive"
RigidBodyConType "Fixed" | "Point" | "Hinge" | "Slider" | "Piston" | "Generic" | "GenericSpring" | "Motor"

RigidBodyOb {
  Type        RigidBodyObType
  Shape       Int
  Flag        Int
  ColGroups   Int
  Mass        Float
  Friction    Float
  Restitution Float
  Margin      Float
  LinDamp     Float
  AngDamp     Float
  Orn         Quaternion
  Pos         Float3
}

RigidBodyCon {
  Type                RigidBodyConType
  Flag                Int
  Ob1                 Option(Object3D)
  Ob2                 Option(Object3D)
  BreakingThreshold   Float
  NumSolverIterations Int
}

XPBDGeometryRef {
  Positions           List(Vec3f)
  Velocities          List(Vec3f)
  PrevPositions       List(Vec3f)
  InvMasses           List(Float)
  Rotations           List(Quat)
  AngularVelocities   List(Vec3f)
  PrevRotations       List(Quat)
  MomentsOfInertia    List(Vec3f)
  InvMomentsOfInertia List(Vec3f)
}

ParticleSettings ID & {
  Type     "PA"
  Flag     Int
  PartType Int
  Totpart  Int
  Sta      Float
  End      Float
  Lifetime Float
  Size     Float
  Mass     Float
}

Material3D ID & {
  Type                "MA"
  SurfaceRenderMethod Int
  BlendMethod         Int
  AlphaThreshold      Float
  R                   Float, g Float, b Float, a Float
  Metallic            Float
  Roughness           Float
  Nodetree            Option(bNodeTree)
  Flag                Int
}

LightType "Local" | "Sun" | "Spot" | "Area"

Light3D ID & {
  Type        "LA"
  LaType      LightType
  R           Float, g Float, b Float
  Energy      Float
  Spotsize    Float
  Spotblend   Float
  AreaSize    Float
  AreaSizey   Float
  SunAngle    Float
  Radius      Float
  Temperature Float
  Tint        Float3
  Nodetree    Option(bNodeTree)
}

Camera3D ID & {
  Type          "CA"
  CamType       Int
  ClipStart     Float
  ClipEnd       Float
  Lens          Float
  OrthoScale    Float
  SensorX       Float
  SensorY       Float
  Shiftx        Float
  Shifty        Float
  DofDistance   Float
  ApertureFstop Float
}

World3D ID & {
  Type     "WO"
  Horr     Float, horg Float, horb Float
  Exposure Float
  Nodetree Option(bNodeTree)
}

Object3D ID & {
  Type                "OB"
  ObType              ObjectType
  Mode                ObjectMode
  Data                Option(ID)
  Parent              Option(Object3D)
  Obmat               Float4x4
  Loc                 Float3
  Scale               Float3
  Rot                 Float3
  Quat                Quaternion
  RotAxis             Float3
  RotAngle            Float
  Rotmode             Int
  Materials           List(Option(Material3D))
  Color               Color4f
  Defbase             List(bDeformGroup)
  Modifiers           List(ModifierData)
  Constraints         List(bConstraint)
  Pose                Option(bPose)
  RigidBodyObject     Option(RigidBodyOb)
  RigidBodyConstraint Option(RigidBodyCon)
}

CollectionObject { Ob Object3D }
CollectionChild  { Collection Collection3D }

Collection3D ID & {
  Type           "GR"
  Gobject        List(CollectionObject)
  Children       List(CollectionChild)
  InstanceOffset Float3
  Flag           Int
  ColorTag       Int
}

ViewLayer {
  Name             String
  Flag             Int
  PassFlag         Int
  Samples          Int
  MaterialOverride Option(Material3D)
  WorldOverride    Option(World3D)
}

Scene3D ID & {
  Type             "SCE"
  Camera           Option(Object3D)
  World            Option(World3D)
  MasterCollection Collection3D
  ViewLayers       List(ViewLayer)
  CursorLocation   Float3
  CursorRotation   Quaternion
  R                RenderData
  ViewSettings     ColorManagedViewSettings
  DisplaySettings  ColorManagedDisplaySettings
  Nodetree         Option(bNodeTree)
  Flag             Int
  UseNodes         Bool
}

Depsgraph {
  Bmain              Main
  InputScene         Scene3D
  InputViewLayer     ViewLayer
  EvaluatedScene     Scene3D
  EvaluatedViewLayer ViewLayer
  Mode               EvaluationMode
  Ctime              Float
  IsFullyEvaluated   Bool
}

NodeSocketDatatype
  "Custom" | "Value" | "Int" | "Boolean" | "Vector" | "RGBA" | "Shader"
  | "String" | "Object" | "Image" | "Geometry" | "Collection" | "Texture"
  | "Material" | "Rotation" | "Menu" | "Matrix" | "Bundle" | "Closure"

NodeSocketInOut "Input" | "Output"

bNodeSocket {
  Identifier   String
  Name         String
  Label        String
  Description  String
  Idname       String
  Type         NodeSocketDatatype
  InOut        NodeSocketInOut
  Flag         Int
  DefaultValue Any
  Location     Float2
}

bNodeLink {
  FromNode         Option(bNode)
  ToNode           Option(bNode)
  FromSock         Option(bNodeSocket)
  ToSock           Option(bNodeSocket)
  Flag             Int
  MultiInputSortId Int
}

bNode {
  Name       String
  Label      String
  Idname     String
  Identifier Int
  Flag       Int
  Color      Float3
  Locx       Float, locy Float
  Width      Float, height Float
  Parent     Option(bNode)
  Id         Option(ID)
  Storage    Any
  Inputs     List(bNodeSocket)
  Outputs    List(bNodeSocket)
}

bNodeTree ID & {
  Type              "NT"
  Idname            String
  TreeType          Int
  Flag              Int
  Nodes             List(bNode)
  Links             List(bNodeLink)
  ViewCenter        Float2
  ActiveOutputIndex Int
  ColorTag          Int
  Description       String
}

PBVHType "Mesh" | "Grids" | "BMesh"

PBVHNode {
  Parent         Int
  Bounds         Bounds(Float3)
  BoundsOrig     Bounds(Float3)
  ChildrenOffset Int
  Flag           Int
}

PBVHTree {
  TreeType        PBVHType
  PrimIndices     List(Int)
  BoundsDirty     List(Bool)
  NormalsDirty    List(Bool)
  VisibilityDirty List(Bool)
  Nodes           List(PBVHNode)
}

Brush ID & {
  Type            "BR"
  Curve           Option(CurveMapping)
  Blend           Int
  Weight          Float
  Size            Int
  Alpha           Float
  Hardness        Float
  Rgb             Float3
  SecondaryRgb    Float3
  SculptBrushType Int
}

SpaceTypeID  "Empty" | "View3D" | "Graph" | "Outliner" | "Properties" | "File" | "Image" | "Info" | "Sequence" | "Text" | "Action" | "Nla" | "Script" | "Node" | "Console" | "UserPref" | "Clip" | "Topbar" | "Statusbar" | "Spreadsheet" | "Project"
RegionTypeID "Window" | "Header" | "Channels" | "Temporary" | "UI" | "Tools" | "ToolProps" | "Preview" | "Hud" | "NavigationBar" | "Execute" | "Footer" | "ToolHeader" | "Xr" | "AssetShelf"

wmOperatorStatus "RunningModal" | "Cancelled" | "Finished" | "PassThrough" | "Interface"

wmOperatorType {
  Name        String
  Idname      String
  Description String
  UndoGroup   String
  Srna        Option(StructRNA)
  Flag        Int
}

wmOperator {
  Idname     String
  Properties Option(IDProperty)
  Type       Option(wmOperatorType)
  Customdata Any
  Ptr        Option(PointerRNA)
  Flag       Int
}

wmWindow {
  Winid         Int
  Scene         Option(Scene3D)
  ViewLayerName String
  Posx          Int, posy Int
  Sizex         Int, sizey Int
  Windowstate   Int
  Active        Int
}

wmWindowManager ID & {
  Type              "WM"
  Windows           List(wmWindow)
  Windrawable       Option(wmWindow)
  Winactive         Option(wmWindow)
  Operators         List(wmOperator)
  UndoStack         Option(UndoStack)
  IsInterfaceLocked Bool
}
