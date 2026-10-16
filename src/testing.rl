_ primitive
_ primitive
_ structure
_ shell
_ stream
_ space
_ auth

// =============================================================================
// Unit Testing, Property-Based Testing, Mocking & Benchmarking
// =============================================================================

TestPassed  { Name String, DurationMs Float }
TestFailed  { Name String, Expected Any, Actual Any }
TestSkipped { Name String, Reason String }
TestResult  TestPassed | TestFailed | TestSkipped

TestSuite {
  SuiteName String
  Tests     List(TestResult)
}

BenchmarkResult {
  Name         String
  Iterations   Int
  MeanTimeNs   Float
  MedianTimeNs Float
  MinTimeNs    Float
  MaxTimeNs    Float
  OpsPerSec    Float
}

MockCall {
  Args      List(Any)
  Timestamp Int
}

MockFn(ReturnType) {
  Calls       List(MockCall)
  ReturnValue ReturnType
}

// =============================================================================
// Assertions
// =============================================================================

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

// =============================================================================
// Test Suite Runner
// =============================================================================

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
