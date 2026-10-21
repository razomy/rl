#
Concrete Media Objects, Film/TV/Music, texture Filters, vSE Strips & Transitions
#

AudioObject_        MediaObject & { Transcript Text, caption String }
AudioObject         AudioObject_
ImageObject         MediaObject & { Caption String, exifData List(PropertyValue), representativeOfPage Bool, embeddedTextCaption String }
Barcode             ImageObject
ImageObjectSnapshot ImageObject
VideoObject         MediaObject & { Actor List(Person), director List(Person), musicBy Agent, caption String, transcript Text, videoFrameSize String, videoQuality String }
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

MovieSeries     CreativeWorkSeries & { Actor List(Person), director List(Person) }
PodcastSeries   CreativeWorkSeries & { WebFeed Url }
RadioSeries     CreativeWorkSeries & { NumberOfEpisodes Count, numberOfSeasons Count }
TVSeries        CreativeWorkSeries & { Actor List(Person), numberOfEpisodes Count, numberOfSeasons Count, countryOfOrigin Country }
VideoGameSeries CreativeWorkSeries & { GamePlatform String, playMode GamePlayMode }

BroadcastEvent_   { BroadcastOfEvent Thing, isLiveBroadcast Bool, videoFormat String }
RadioChannel      BroadcastChannel
TelevisionChannel BroadcastChannel

MusicAlbum   MusicPlaylist & { AlbumProductionType MusicAlbumProductionType, albumReleaseType MusicAlbumReleaseType, byArtist MusicGroup, albumRelease List(MusicRelease) }
MusicRelease MusicPlaylist & { CatalogNumber String, creditedTo Agent, musicReleaseFormat MusicReleaseFormatType, recordLabel Organization, releaseOf MusicAlbum }

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
EmbossTextureFilter    ITextureFilter & { Strength Float, whiteLevel Float, direction String, blend Bool }
EnhanceTextureFilter   ITextureFilter & { Enhance Float }
GrayscaleTextureFilter ITextureFilter
InvertTextureFilter    ITextureFilter
SepiaTextureFilter     ITextureFilter
SolarizeTextureFilter  ITextureFilter
HslTextureFilter       ITextureFilter & { Hue Float, saturation Float, luminance Float }
HsvTextureFilter       ITextureFilter & { Hue Float, saturation Float, value Float }
MaskTextureFilter      ITextureFilter & { Threshold Float }
ThresholdTextureFilter ITextureFilter & { Threshold Float }
NoiseTextureFilter     ITextureFilter & { Noise Float }
PixelateTextureFilter  ITextureFilter & { PixelSize Int }
PosterizeTextureFilter ITextureFilter & { Levels Int }
RgbTextureFilter       ITextureFilter & { Red Float, green Float, blue Float }
RgbaTextureFilter      RgbTextureFilter & { Alpha Float }
UnsharpMaskFilter      ITextureFilter & { Sigma Float, x1 Float, y2 Float }

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

StripCrop { Top Int, bottom Int, left Int, right Int }

SeqRetimingKey {
  StripFrameIndex         Float
  RetimingFactor          Float
  OriginalStripFrameIndex Float
  Flag                    Int
}

SplitStripAtFrame(st Strip, splitFrame Int) [
  (SplitFrame > StartFrame && SplitFrame < (StartFrame + Length)) . {
    true [
      LeftStrip  St & { Length (SplitFrame - StartFrame) }
      RightStrip St & { StartFrame SplitFrame, Length (Length - (SplitFrame - StartFrame)) }
      (LeftStrip, RightStrip)
    ]
    false [ (St, St) ]
  }
]

Upload(m MediaObject, u Url) [ m & { ContentUrl U, uploadDate Now } ]
Embed(m MediaObject, u Url) [ m & { EmbedUrl U } ]
Transcribe(a AudioObject_, t Text) [ a & { Transcript T } ]
Caption_(i ImageObject, c String) [ i & { Caption C } ]
Record(c MusicComposition, g MusicGroup) [ MusicRecording { RecordingOf C, byArtist G, dateCreated Now } ]
Compile(name_ Name, tracks List(MusicRecording), g MusicGroup) [ MusicAlbum { Name Name_, track Tracks, byArtist G } ]
ReleaseAlbum(a MusicAlbum, l Organization, f MusicReleaseFormatType) [ MusicRelease { ReleaseOf A, recordLabel L, musicReleaseFormat F, datePublished Now } ]
Film(m Movie, d Person) [ m & { Director List1(D), dateCreated Now } ]
Premiere(m Movie) [ m & { DatePublished Now, CreativeWorkStatus "Published" } ]
Broadcast(e Episode, c BroadcastChannel) [ BroadcastEvent_ { BroadcastOfEvent E, IsLiveBroadcast false } ]
RenewSeries(s TVSeries) [ s & { NumberOfSeasons (NumberOfSeasons + 1) } ]
