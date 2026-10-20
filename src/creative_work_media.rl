#
Abstract MediaObject, Film/TV/Music Works, Image Buffers, Texture Filters & NLE Strip
#

MediaObject CreativeWork & {
    ContentUrl Url
    EmbedUrl Url
    ContentSize String
    Bitrate String
    Duration_
    EncodingFormat MimeType
    Width QuantitativeValue
    Height QuantitativeValue
    UploadDate DateTime
    PlayerType String
    ProductionCompany Organization
    RegionsAllowed List(Place)
    RequiresSubscription Bool
    StartTime DateTime
    EndTime DateTime
    Sha256 String
}

Movie              CreativeWork & { Actor List(Person), Director List(Person), MusicBy Agent, ProductionCompany Organization, CountryOfOrigin Country, Duration_, Trailer VideoObject, TitleEIDR String, SubtitleLanguage List(Language) }
Clip               CreativeWork & { Actor List(Person), Director List(Person), ClipNumber String, PartOfEpisode Episode, PartOfSeason CreativeWorkSeason, StartOffset Real, EndOffset Real }
CreativeWorkSeason CreativeWork & { Actor List(Person), Director Person, Episode List(Episode), NumberOfEpisodes Count, PartOfSeries CreativeWorkSeries, SeasonNumber String, StartDate Date, EndDate Date, Trailer VideoObject }
Episode            CreativeWork & { Actor List(Person), Director List(Person), Duration_, EpisodeNumber String, PartOfSeason CreativeWorkSeason, PartOfSeries CreativeWorkSeries, Trailer VideoObject }
BroadcastChannel   Intangible & { BroadcastChannelId String, BroadcastServiceTier String, InBroadcastLineup CableOrSatelliteService }
MusicComposition   CreativeWork & { Composer List(Agent), Lyricist Person, Lyrics CreativeWork, MusicalKey String, MusicArrangement MusicComposition, IswcCode String }
MusicRecording     CreativeWork & { ByArtist MusicGroup, Duration_, InAlbum MusicAlbum, InPlaylist MusicPlaylist, IsrcCode String, RecordingOf MusicComposition }
MusicPlaylist      CreativeWork & { NumTracks Count, Track List(MusicRecording) }

ImBuf {
  Width           Int
  Height          Int
  Channels        Int
  ColorMode       ImColorMode
  ByteData        Option(List(Byte))
  FloatData       Option(List(Float))
  ByteColorspace  String
  FloatColorspace String
  Ppm             (Float, Float)
  Filepath        String
  Flags           Int
}

ITextureFilter { Apply Any }

Strip {
  Name         String
  Type         StripType
  Channel      Int
  StartFrame   Float
  Length       Int
  StartOffset  Float
  EndOffset    Float
  BlendOpacity Float
  ColorTag     Int
  RetimingKeys List(SeqRetimingKey)
  Selected     Bool
  Muted        Bool
  Locked       Bool
}
