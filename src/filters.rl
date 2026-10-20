#
Concrete Media Objects, Film/TV/Music, Texture Filters, VSE Strips & Transitions
#

AudioObject_        MediaObject & { Transcript Text, Caption String }
AudioObject         AudioObject_
ImageObject         MediaObject & { Caption String, ExifData List(PropertyValue), RepresentativeOfPage Bool, EmbeddedTextCaption String }
Barcode             ImageObject
ImageObjectSnapshot ImageObject
VideoObject         MediaObject & { Actor List(Person), Director List(Person), MusicBy Agent, Caption String, Transcript Text, VideoFrameSize String, VideoQuality String }
VideoObjectSnapshot VideoObject
MusicVideoObject    MediaObject
DataDownload        MediaObject & { MeasurementTechnique String }
LegislationObject   MediaObject
TextObject          MediaObject
3DModel             MediaObject & { IsResizable Bool }
AmpStory            MediaObject

MovieClip     Clip
RadioClip     Clip
TVClip        Clip
VideoGameClip Clip

PodcastSeason CreativeWorkSeason
RadioSeason   CreativeWorkSeason
TVSeason      CreativeWorkSeason

PodcastEpisode Episode
RadioEpisode   Episode
TVEpisode      Episode

MovieSeries     CreativeWorkSeries & { Actor List(Person), Director List(Person) }
PodcastSeries   CreativeWorkSeries & { WebFeed Url }
RadioSeries     CreativeWorkSeries & { NumberOfEpisodes Count, NumberOfSeasons Count }
TVSeries        CreativeWorkSeries & { Actor List(Person), NumberOfEpisodes Count, NumberOfSeasons Count, CountryOfOrigin Country }
VideoGameSeries CreativeWorkSeries & { GamePlatform String, PlayMode GamePlayMode }

BroadcastEvent_   { BroadcastOfEvent Thing, IsLiveBroadcast Bool, VideoFormat String }
RadioChannel      BroadcastChannel
TelevisionChannel BroadcastChannel

MusicAlbum   MusicPlaylist & { AlbumProductionType MusicAlbumProductionType, AlbumReleaseType MusicAlbumReleaseType, ByArtist MusicGroup, AlbumRelease List(MusicRelease) }
MusicRelease MusicPlaylist & { CatalogNumber String, CreditedTo Agent, MusicReleaseFormat MusicReleaseFormatType, RecordLabel Organization, ReleaseOf MusicAlbum }

ReadAndWriteImageExt "jpg" | "jpeg" | "png" | "webp" | "gif" | "avif" | "tiff" | "tif" | "ico" | "heif" | "heic" | "exr" | "hdr" | "dds" | "tga" | "psd" | "jp2" | "dpx" | "cineon"
OnlyReadImageExt     "svg" | "bmp"
AllImageExt          ReadAndWriteImageExt | OnlyReadImageExt

ImColorMode "BW" | "BWA" | "RGB" | "RGBA"

ImageMetadata {
  Width    Int
  Height   Int
  Bands    Int
  Space    String
  HasAlpha Bool
}

VipsImage {
  Width    Int
  Height   Int
  Bands    Int
  Data     List(Byte)
  Metadata ImageMetadata
}

BlurTextureFilter      ITextureFilter & { BlurRadius Float }
BrightenTextureFilter  ITextureFilter & { Brightness Float }
ContrastTextureFilter  ITextureFilter & { Contrast Float }
EmbossTextureFilter    ITextureFilter & { Strength Float, WhiteLevel Float, Direction String, Blend Bool }
EnhanceTextureFilter   ITextureFilter & { Enhance Float }
GrayscaleTextureFilter ITextureFilter
InvertTextureFilter    ITextureFilter
SepiaTextureFilter     ITextureFilter
SolarizeTextureFilter  ITextureFilter
HslTextureFilter       ITextureFilter & { Hue Float, Saturation Float, Luminance Float }
HsvTextureFilter       ITextureFilter & { Hue Float, Saturation Float, Value Float }
MaskTextureFilter      ITextureFilter & { Threshold Float }
ThresholdTextureFilter ITextureFilter & { Threshold Float }
NoiseTextureFilter     ITextureFilter & { Noise Float }
PixelateTextureFilter  ITextureFilter & { PixelSize Int }
PosterizeTextureFilter ITextureFilter & { Levels Int }
RgbTextureFilter       ITextureFilter & { Red Float, Green Float, Blue Float }
RgbaTextureFilter      RgbTextureFilter & { Alpha Float }
UnsharpMaskFilter      ITextureFilter & { Sigma Float, X1 Float, Y2 Float }

StripType
  "Image" | "Meta" | "Scene" | "Movie" | "MovieClip" | "Mask" | "Sound"
  | "Cross" | "Add" | "Sub" | "AlphaOver" | "AlphaUnder" | "GammaCross"
  | "Mul" | "Wipe" | "Glow" | "Transform" | "Color" | "Speed" | "Multicam"
  | "Adjustment" | "GaussianBlur" | "Text" | "ColorMix" | "Compositor"

StripTransform {
  Offset   Vec2f
  Scale    Vec2f
  Rotation Float
  Origin   Vec2f
  Filter   "Nearest" | "Bilinear" | "CubicBSpline" | "CubicMitchell" | "Box" | "Subsampled3x3"
}

StripCrop { Top Int, Bottom Int, Left Int, Right Int }

SeqRetimingKey {
  StripFrameIndex         Float
  RetimingFactor          Float
  OriginalStripFrameIndex Float
  Flag                    Int
}

SplitStripAtFrame(St Strip, SplitFrame Int) [
  (SplitFrame > StartFrame && SplitFrame < (StartFrame + Length)) . {
    true [
      LeftStrip  St & { Length (SplitFrame - StartFrame) }
      RightStrip St & { StartFrame SplitFrame, Length (Length - (SplitFrame - StartFrame)) }
      (LeftStrip, RightStrip)
    ]
    false [ (St, St) ]
  }
]

Upload(M MediaObject, U Url) [ M & { ContentUrl U, UploadDate Now } ]
Embed(M MediaObject, U Url) [ M & { EmbedUrl U } ]
Transcribe(A AudioObject_, T Text) [ A & { Transcript T } ]
Caption_(I ImageObject, C String) [ I & { Caption C } ]
Record(C MusicComposition, G MusicGroup) [ MusicRecording { RecordingOf C, ByArtist G, DateCreated Now } ]
Compile(Name_ Name, Tracks List(MusicRecording), G MusicGroup) [ MusicAlbum { Name Name_, Track Tracks, ByArtist G } ]
ReleaseAlbum(A MusicAlbum, L Organization, F MusicReleaseFormatType) [ MusicRelease { ReleaseOf A, RecordLabel L, MusicReleaseFormat F, DatePublished Now } ]
Film(M Movie, D Person) [ M & { Director List1(D), DateCreated Now } ]
Premiere(M Movie) [ M & { DatePublished Now, CreativeWorkStatus "Published" } ]
Broadcast(E Episode, C BroadcastChannel) [ BroadcastEvent_ { BroadcastOfEvent E, IsLiveBroadcast false } ]
RenewSeries(S TVSeries) [ S & { NumberOfSeasons (NumberOfSeasons + 1) } ]
