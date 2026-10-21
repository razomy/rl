#
Stream Generators & Examples
#

FizzBuzz(limit Int) [
  (1..Limit) . Map(N [
    (N % 3, N % 5) . {
      (0, 0) [ "FizzBuzz" ]
      (0, _) [ "Fizz" ]
      (_, 0) [ "Buzz" ]
      _      [ "{N}" ]
    }
  ])
]

RangeSum(start Int, end Int) [
  (Start..End) . Sum
]
