#
Levels 3-6: File System, web Operations, digital Communication & Applied Tasks
#

ContentStream {
  MimeType MimeType
  Size     Int
  Data     String
}

NewData {
  Payload   String
  Overwrite Bool
}

SourceLocation String
TargetLocation String
OperationType  "copy" | "cut" | "paste" | "rename" | "archive" | "extract" | "move" | "symlink"

FileEntry Thing & {
  Path        String
  Size        Int
  IsDirectory Bool
  Permissions String
  ModifiedAt  DateTime
}

FileSystemState {
  RootPath  String
  Entries   List(FileEntry)
  FreeSpace Int
}

Query     String
ThingList List(Thing)

Browser WebApplication & {
  CurrentUrl URL
  Tabs       List(WebPage)
  History    List(URL)
}

SearchEngine WebApplication & {
  Endpoint URL
  Provider String
}
SearchQuery {
  Text    String
  Filters Map(String, String)
  Limit   Count
}
SearchResults {
  Query      SearchQuery
  Items      List(WebPage)
  TotalCount Count
}

DataObject MediaObject & {
  Checksum String
}
SourceNode      URL | String
DestinationNode URL | String
TransferStatus {
  BytesTransferred Int
  TotalBytes       Int
  Direction        "upload" | "download"
  State            "pending" | "in_progress" | "completed" | "failed"
}

WebService Service & {
  BaseUrl URL
}

Recipient Agent
MessageContent {
  Subject     Option(String)
  Body        String
  Attachments List(MediaObject)
}
MessageStatus {
  MessageId String
  State     "queued" | "sent" | "delivered" | "read" | "failed"
  Timestamp DateTime
}

ParticipantList List(Agent)
MediaStream {
  HasAudio    Bool
  HasVideo    Bool
  ScreenShare Bool
  BitrateKbps Int
}
CallSession {
  SessionId    String
  Participants ParticipantList
  Stream       MediaStream
  StartedAt    DateTime
  IsActive     Bool
}

SocialObject    SocialMediaPosting | Comment | MediaObject
InteractionType "post" | "comment" | "like" | "dislike" | "repost" | "bookmark" | "report"

MediaContent MediaObject
Experience {
  Consumer    Agent
  Media       MediaContent
  Progress    Float
  CompletedAt Option(DateTime)
}

Document       DigitalDocument
TextOperations List("insert" | "delete" | "replace" | "format_bold" | "format_italic" | "align" | "paginate")

Formulas List(String)
AnalyticsResult {
  Summary Map(String, Float)
  Charts  List(ImageObject)
}

RawMedia      MediaObject
EditingTools  List(String)
MediaArtifact MediaObject

SourceCode SoftwareSourceCode
Compiler   SoftwareApplication
Executable SoftwareApplication & {
  BinaryPath String
  TargetArch String
}

GameEnvironment VideoGame
GameActions     List(String)
GameState {
  Score     Int
  Level     Int
  Position  Coordinates
  Inventory List(Thing)
  IsRunning Bool
}

ECommercePlatform WebApplication
CartItem {
  Product  Product
  Quantity Count
  Price    Float
}
OrderReceipt {
  ReceiptId     String
  Order         Order
  PaidAmount    MonetaryAmount
  PaymentMethod PaymentMethod
  Timestamp     DateTime
}
