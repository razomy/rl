#
Assertions & Test Suite Runner
#

AssertEq(Name String, Expected, Actual) [
  (Expected == Actual) . {
    true  [ TestPassed { Name Name, DurationMs 0.0 } ]
    false [ TestFailed { Name Name, Expected Expected, Actual Actual } ]
  }
]

AssertNeq(Name String, Unexpected, Actual) [
  (Unexpected != Actual) . {
    true  [ TestPassed { Name Name, DurationMs 0.0 } ]
    false [ TestFailed { Name Name, Expected "!= {Unexpected}", Actual Actual } ]
  }
]

AssertTrue(Name String, Cond Bool) [
  AssertEq(Name, true, Cond)
]

AssertFalse(Name String, Cond Bool) [
  AssertEq(Name, false, Cond)
]

RunTestSuite() [
  [
    AssertEq("Math Addition", 4, (2 + 2))
    AssertEq("Area of Rect", 20.0, (Rect { Width 4.0, Height 5.0 } . Area))
    AssertEq("User Migration", true, (User { Id "1", Name "Bob", Age 20, Role "user", PasswordHash "x" } . MigrateUser . _.IsAdult))
  ]
  . ForEach(Result [
    Result . {
      TestPassed  [ "[PASS] {Name}" . Shell.Log ]
      TestSkipped [ "[SKIP] {Name}: {Reason}" . Shell.Log ]
      TestFailed  [ "[FAIL] {Name}: Expected {Expected}, got {Actual}" . Shell.Log ]
    }
  ])
]
