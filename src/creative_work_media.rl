_ schema.thing
_ schema.enumerations
_ schema.intangible
_ schema.organization
_ schema.person
_ schema.creative_work

// =============================================================================
// MediaObject
// =============================================================================

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

AudioObject_      MediaObject & { Transcript Text, Caption String }
AudioObject       AudioObject_
ImageObject       MediaObject & { Caption String, ExifData List(PropertyValue), RepresentativeOfPage Bool, EmbeddedTextCaption String }
Barcode           ImageObject
ImageObjectSnapshot ImageObject
VideoObject       MediaObject & { Actor List(Person), Director List(Person), MusicBy Agent, Caption String, Transcript Text, VideoFrameSize String, VideoQuality String }
VideoObjectSnapshot VideoObject
MusicVideoObject  MediaObject
DataDownload      MediaObject & { MeasurementTechnique String }
LegislationObject MediaObject
TextObject        MediaObject
3DModel           MediaObject & { IsResizable Bool }
AmpStory          MediaObject

// =============================================================================
// Film, TV, radio
// =============================================================================

Movie CreativeWork & { Actor List(Person), Director List(Person), MusicBy Agent, ProductionCompany Organization, CountryOfOrigin Country, Duration_, Trailer VideoObject, TitleEIDR String, SubtitleLanguage List(Language) }
Clip  CreativeWork & { Actor List(Person), Director List(Person), ClipNumber String, PartOfEpisode Episode, PartOfSeason CreativeWorkSeason, StartOffset Real, EndOffset Real }
MovieClip Clip
RadioClip Clip
TVClip    Clip
VideoGameClip Clip

CreativeWorkSeason CreativeWork & { Actor List(Person), Director Person, Episode List(Episode), NumberOfEpisodes Count, PartOfSeries CreativeWorkSeries, SeasonNumber String, StartDate Date, EndDate Date, Trailer VideoObject }
PodcastSeason CreativeWorkSeason
RadioSeason   CreativeWorkSeason
TVSeason      CreativeWorkSeason

Episode CreativeWork & { Actor List(Person), Director List(Person), Duration_, EpisodeNumber String, PartOfSeason CreativeWorkSeason, PartOfSeries CreativeWorkSeries, Trailer VideoObject }
PodcastEpisode Episode
RadioEpisode   Episode
TVEpisode      Episode

MovieSeries      CreativeWorkSeries & { Actor List(Person), Director List(Person) }
PodcastSeries    CreativeWorkSeries & { WebFeed Url }
RadioSeries      CreativeWorkSeries & { NumberOfEpisodes Count, NumberOfSeasons Count }
TVSeries         CreativeWorkSeries & { Actor List(Person), NumberOfEpisodes Count, NumberOfSeasons Count, CountryOfOrigin Country }
VideoGameSeries  CreativeWorkSeries & { GamePlatform String, PlayMode GamePlayMode }

BroadcastEvent_ { BroadcastOfEvent Thing, IsLiveBroadcast Bool, VideoFormat String }
BroadcastChannel Intangible & { BroadcastChannelId String, BroadcastServiceTier String, InBroadcastLineup CableOrSatelliteService }
RadioChannel  BroadcastChannel
TelevisionChannel BroadcastChannel

// =============================================================================
// Music
// =============================================================================

MusicComposition CreativeWork & { Composer List(Agent), Lyricist Person, Lyrics CreativeWork, MusicalKey String, MusicArrangement MusicComposition, IswcCode String }
MusicRecording   CreativeWork & { ByArtist MusicGroup, Duration_, InAlbum MusicAlbum, InPlaylist MusicPlaylist, IsrcCode String, RecordingOf MusicComposition }
MusicPlaylist    CreativeWork & { NumTracks Count, Track List(MusicRecording) }
MusicAlbum       MusicPlaylist & { AlbumProductionType MusicAlbumProductionType, AlbumReleaseType MusicAlbumReleaseType, ByArtist MusicGroup, AlbumRelease List(MusicRelease) }
MusicRelease     MusicPlaylist & { CatalogNumber String, CreditedTo Agent, MusicReleaseFormat MusicReleaseFormatType, RecordLabel Organization, ReleaseOf MusicAlbum }

// =============================================================================
// Transitions
// =============================================================================

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
