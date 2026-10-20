#
Typography, Spacing, Borders, Shadows & Theme Palettes
#

FontWeight "thin" | "light" | "regular" | "medium" | "semibold" | "bold" | "black"
FontStyle  "normal" | "italic" | "oblique" | "bold" | "underline" | "strikethrough"
TextAlign  "left" | "center" | "right" | "justify"

TypographyToken {
  FontFamily    String
  FontSizePx    Float
  LineHeight    Float
  FontWeight    FontWeight
  LetterSpacing Float
}

SpacingScale {
  Xs  Float
  Sm  Float
  Md  Float
  Lg  Float
  Xl  Float
  Xxl Float
}

ShadowToken {
  OffsetX Float
  OffsetY Float
  Blur    Float
  Spread  Float
  Color   Color
}

BorderToken {
  Width  Float
  Style  "solid" | "dashed" | "dotted" | "double" | "none"
  Radius Float
  Color  Color
}

ThemePalette {
  Primary    Color
  Secondary  Color
  Accent     Color
  Background Color
  Surface    Color
  Text       Color
  Success    Color
  Warning    Color
  Error      Color
  Info       Color
}

ThemeColorPalette {
  ColorFarFar       RgbaColorFloat
  ColorFar          RgbaColorFloat
  Color             RgbaColorFloat
  ColorNear         RgbaColorFloat
  ColorNearNear     RgbaColorFloat
  ColorDisabledFar  RgbaColorFloat
  ColorDisabled     RgbaColorFloat
  ColorDisabledNear RgbaColorFloat
  OnColor           RgbaColorFloat
}
