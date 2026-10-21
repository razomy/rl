#
Color Management (OpenColorIO), Curves, Histograms & Scopes
#

CBData {
  R   Float, g Float, b Float, a Float
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
