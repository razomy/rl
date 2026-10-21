#
Abstract MediaObject, Film/TV/Music Works, image Buffers, texture Filters & NLE Strip
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

Movie              CreativeWork & { Actor List(Person), director List(Person), musicBy Agent, productionCompany Organization, countryOfOrigin Country, Duration_, trailer VideoObject, titleEIDR String, subtitleLanguage List(Language) }
Clip               CreativeWork & { Actor List(Person), director List(Person), clipNumber String, partOfEpisode Episode, partOfSeason CreativeWorkSeason, startOffset Real, endOffset Real }
CreativeWorkSeason CreativeWork & { Actor List(Person), director Person, episode List(Episode), numberOfEpisodes Count, partOfSeries CreativeWorkSeries, seasonNumber String, startDate Date, endDate Date, trailer VideoObject }
Episode            CreativeWork & { Actor List(Person), director List(Person), Duration_, episodeNumber String, partOfSeason CreativeWorkSeason, partOfSeries CreativeWorkSeries, trailer VideoObject }
BroadcastChannel   Intangible & { BroadcastChannelId String, broadcastServiceTier String, inBroadcastLineup CableOrSatelliteService }
MusicComposition   CreativeWork & { Composer List(Agent), lyricist Person, lyrics CreativeWork, musicalKey String, musicArrangement MusicComposition, iswcCode String }
MusicRecording     CreativeWork & { ByArtist MusicGroup, Duration_, inAlbum MusicAlbum, inPlaylist MusicPlaylist, isrcCode String, recordingOf MusicComposition }
MusicPlaylist      CreativeWork & { NumTracks Count, track List(MusicRecording) }

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
