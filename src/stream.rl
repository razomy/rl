_ primitives

Stream {
  Filter(Pred) [ native_stream_filter(Pred) ]
  Map(Action)  [ native_stream_map(Action) ]
  Fold(Init, Op) [ native_stream_fold(Init, Op) ]
  ForEach(Action) [ native_stream_foreach(Action) ]
}

FizzBuzz(Limit Int) [
  (1..Limit) . Stream.Map(N [
    (N % 3, N % 5) . {
      (0, 0) [ "FizzBuzz" ]
      (0, _) [ "Fizz" ]
      (_, 0) [ "Buzz" ]
      _      [ "{N}" ]
    }
  ])
]
