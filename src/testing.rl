#
Abstract Test Results, test Suites, Benchmarks & Mock Functions
#

TestPassed  { Name String, durationMs Float }
TestFailed  { Name String, expected Any, actual Any }
TestSkipped { Name String, reason String }
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
