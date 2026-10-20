#
Abstract Declarative Stream Combinators
#

Stream {
  Filter(Pred)               [ native_stream_filter(Pred) ]
  Map(Action)                [ native_stream_map(Action) ]
  FlatMap(Action)            [ native_stream_flat_map(Action) ]
  Fold(Init, Op)             [ native_stream_fold(Init, Op) ]
  Reduce(Op)                 [ native_stream_reduce(Op) ]
  Scan(Init, Op)             [ native_stream_scan(Init, Op) ]
  ForEach(Action)            [ native_stream_foreach(Action) ]
  Take(Count Int)            [ native_stream_take(Count) ]
  Drop(Count Int)            [ native_stream_drop(Count) ]
  TakeWhile(Pred)            [ native_stream_take_while(Pred) ]
  DropWhile(Pred)            [ native_stream_drop_while(Pred) ]
  Chunk(Size Int)            [ native_stream_chunk(Size) ]
  Window(Size Int, Step Int) [ native_stream_window(Size, Step) ]
  Zip(Other)                 [ native_stream_zip(Other) ]
  Enumerate()                [ native_stream_enumerate ]
  Partition(Pred)            [ native_stream_partition(Pred) ]
  GroupBy(KeyFn)             [ native_stream_group_by(KeyFn) ]
  SortBy(CompareFn)          [ native_stream_sort_by(CompareFn) ]
  Distinct()                 [ native_stream_distinct ]
  Reverse()                  [ native_stream_reverse ]
  Any(Pred)                  [ native_stream_any(Pred) ]
  All(Pred)                  [ native_stream_all(Pred) ]
  Find(Pred)                 [ native_stream_find(Pred) ]
  Count()                    [ native_stream_count ]
  Sum()                      [ Fold(0, (Acc, X) [ Acc + X ]) ]
  CollectList()              [ native_stream_collect_list ]
  CollectSet()               [ native_stream_collect_set ]
  CollectMap()               [ native_stream_collect_map ]
}
