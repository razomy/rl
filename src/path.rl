#
Unified Path Abstractions & Traits
#

Slug               String
AbsolutePathString Slug
RelativePathString Slug
PathString         AbsolutePathString | RelativePathString
FilePathString     PathString
DirPathString      PathString
SourcePathString   DirPathString

Url String & [ _ . ("http" | "https" | "ftp" | "mailto" | "file") ]

HasPath       { Path PathString }
HasDirPath    { DirPath DirPathString }
HasFileName   { FileName String }
HasFilePath   { FilePath FilePathString }
HasSourcePath { SourcePath SourcePathString }
