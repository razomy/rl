#
Abstract Cloud Infrastructure, Compute, Storage, CI/CD, Telemetry & CLI Schemas
#

AvailabilityZone {
  Provider CloudProvider
  Region   String
  ZoneId   String
}

VpcSubnet {
  SubnetId     String
  CidrBlock    String
  Zone         AvailabilityZone
  IsPublic     Bool
  RouteTableId String
}

VirtualPrivateCloud {
  VpcId              String
  Name               String
  CidrBlock          String
  Subnets            List(VpcSubnet)
  EnableDnsHostnames Bool
}

InstanceState "pending" | "running" | "stopping" | "stopped" | "shutting-down" | "terminated"

ComputeInstance {
  InstanceId   String
  InstanceType String
  Vcpus        Count
  MemoryGb     Float
  GpuCount     Count
  GpuModel     Option(String)
  PublicIp     Option(String)
  PrivateIp    String
  State        InstanceState
  Zone         AvailabilityZone
  SpotInstance Bool
}

ServerlessFunction {
  FunctionName String
  Runtime      ServerlessRuntime
  Handler      String
  MemoryMb     Int
  TimeoutSec   Int
  Environment  Map(String, String)
  Trigger      "http" | "queue" | "cron" | "storage-event" | "stream"
}

ObjectStorageBucket {
  BucketName        String
  Region            String
  StorageClass      StorageClass
  VersioningEnabled Bool
  EncryptionKeyId   Option(String)
  PublicAccessBlock Bool
}

EventTopic {
  TopicName         String
  Broker            MessageQueueBroker
  Partitions        Int
  ReplicationFactor Int
  RetentionHours    Int
  Guarantee         DeliveryGuarantee
}

CiStepStatus "queued" | "in_progress" | "succeeded" | "failed" | "skipped" | "cancelled"

CiPipelineStep {
  Name        String
  Command     String
  DockerImage Option(String)
  TimeoutMin  Int
  Status      CiStepStatus
}

CiPipeline {
  PipelineId  String
  RepoUrl     String
  Branch      String
  CommitSha   String
  TriggeredBy String
  Steps       List(CiPipelineStep)
  Status      CiStepStatus
}

IacResourceAction "no-op" | "create" | "read" | "update" | "replace" | "delete"

IacStateResource {
  Address      String
  Provider     String
  ResourceType String
  Attributes   Map(String, Any)
}

MetricKind "Counter" | "Gauge" | "Histogram" | "Summary" | "UpDownCounter"

TelemetryMetric {
  Name        String
  Description String
  Unit        String
  Kind        MetricKind
  Labels      Map(String, String)
  Value       Float
  Timestamp   Instant
}

SpanKind   "INTERNAL" | "SERVER" | "CLIENT" | "PRODUCER" | "CONSUMER"
SpanStatus "UNSET" | "OK" | "ERROR"

TraceSpan {
  TraceId      HexStr
  SpanId       HexStr
  ParentSpanId Option(HexStr)
  Operation    String
  ServiceName  String
  Kind         SpanKind
  Status       SpanStatus
  StartTimeNs  Int
  EndTimeNs    Int
  Attributes   Map(String, Any)
}

SloTarget {
  ServiceName          String
  IndicatorMetric      String
  TargetPercentage     Range(0.0, 100.0) & Float
  EvaluationWindowDays Int
  ErrorBudgetRemaining Fraction
}

Project {
  Interaction {
    Schema(T) {
      Format  T
      Lint    T
      Run     T
      Test    T
      Build   T
      Publish T
      Clean   T
    }
  }
}

Cli {
  Schema Project.Interaction.Schema(String)
}

LaunchCli {
  Launcher String
  Command  String
  BuildCommand(Name String) [ "{Launcher} {Command} {Name}" ]
}

LaunchCliAndCliSchema LaunchCli & Cli.Schema
