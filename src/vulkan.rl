#
Vulkan Render Graph & BSL Shader Compiler Tool
#

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
  Text   String
}

BSLScope {
  Type       BSLScopeType
  TokenRange (Int, Int)
  Parent     Int
  Children   List(Int)
}

BSLSymbolVariable {
  Name            String
  TypeName        String
  ArrayDimensions Int
  Offset          Int
  IsConst         Bool
  IsConstexpr     Bool
}

BSLSymbolClass {
  Name    String
  Size    Int
  Align   Int
  IsUnion Bool
  IsEnum  Bool
  Members List(BSLSymbolVariable)
}

BSLSymbolFunction {
  Name         String
  ReturnType   String
  ArgTypes     List(String)
  IsEntryPoint Bool
  IsConstexpr  Bool
}

BSLSymbolTable {
  Classes   Map(String, BSLSymbolClass)
  Functions Map(String, List(BSLSymbolFunction))
  Variables Map(String, BSLSymbolVariable)
}
