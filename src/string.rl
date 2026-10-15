_ primitives

StringOps(First Str, Last Str) [
  Full "{First} {Last}"
  Full
  . Str.Trim
  . Str.ToUpper
  . Str.Split(" ")
]
