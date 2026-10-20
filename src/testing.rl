#
Abstract Test Results, Test Suites, Benchmarks & Mock Functions
#

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
