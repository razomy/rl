#
Spans, Indexing & Implicit Memory Sharing
#

FixedVector(T, N) {
  Data   Tuple(T)
  Length N
}

Offset     { Value Int }
Index      { Value Int }
OutIndex   { Value Int }
IndexOrOut Index | OutIndex

IndexRange {
  Start Int
  Size  Int
}

IndexMaskSegment {
  Offset      Int
  BaseIndices List(Int)
}

IndexMask {
  IndicesNum  Int
  SegmentsNum Int
  Segments    List(IndexMaskSegment)
  BeginInSeg  Int
  EndInSeg    Int
}

OffsetIndices {
  Offsets List(Int)
}

GroupedSpan(T) {
  Offsets OffsetIndices
  Data    List(T)
}

ImplicitSharingInfo {
  StrongUsers Int
  WeakUsers   Int
  Version     Int
}

ImplicitSharingInfoAndData {
  SharingInfo Option(ImplicitSharingInfo)
  Data        Any
}

GPointer { Type String, Data Any }
GSpan    { Type String, Data Any, Size Int }
GArray   GSpan & { Capacity Int }
GVArray  GSpan & { IsSingle Bool }
GList    { CppType String, Data Any, Size Int }
