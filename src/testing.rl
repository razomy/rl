_ primitives
_ shell
_ stream

TestPassed { Name Str }
TestFailed { Name Str, Expected Any, Actual Any }
TestResult TestPassed | TestFailed

AssertEq(Name Str, Expected, Actual) [
  (Expected == Actual) . {
    true  [ TestPassed { Name Name } ]
    false [ TestFailed { Name Name, Expected Expected, Actual Actual } ]
  }
]

RunTestSuite() [
  [
    AssertEq("Math Addition", 4, (2 + 2))
    AssertEq("Area of Rect", 20.0, (Rect { Width 4.0, Height 5.0 } . Area))
    AssertEq("User Migration", true, (User { Id "1", Name "Bob", Age 20, Role "user", PasswordHash "x" } . MigrateUser . _.IsAdult))
  ]
  . Stream.ForEach(Result [
    Result . {
      TestPassed [ "[PASS] {Name}" . Shell.Log ]
      TestFailed [ "[FAIL] {Name}: Expected {Expected}, got {Actual}" . Shell.Log ]
    }
  ])
]
