_ meta
_ primitive
_ structure
_ string
_ time
_ http
_ computing

// =============================================================================
// 1. Cloud Providers, Regions, VPC & Compute Instances
// =============================================================================

CloudProvider "aws" | "gcp" | "azure" | "cloudflare" | "digitalocean" | "hetzner" | "linode" | "oracle" | "alibaba" | "bare-metal"

AvailabilityZone {
  Provider CloudProvider
  Region   String
  ZoneId   String
}

VpcSubnet {
  SubnetId         String
  CidrBlock        String
  Zone             AvailabilityZone
  IsPublic         Bool
  RouteTableId     String
}

VirtualPrivateCloud {
  VpcId            String
  Name             String
  CidrBlock        String
  Subnets          List(VpcSubnet)
  EnableDnsHostnames Bool
}

InstanceState "pending" | "running" | "stopping" | "stopped" | "shutting-down" | "terminated"

ComputeInstance {
  InstanceId       String
  InstanceType     String
  Vcpus            Count
  MemoryGb         Float
  GpuCount         Count
  GpuModel         Option(String)
  PublicIp         Option(String)
  PrivateIp        String
  State            InstanceState
  Zone             AvailabilityZone
  SpotInstance     Bool
}

// =============================================================================
// 2. Kubernetes (K8s) Orchestration & Service Mesh
// =============================================================================

K8sResourceKind "Pod" | "Deployment" | "StatefulSet" | "DaemonSet" | "Job" | "CronJob" | "Service" | "Ingress" | "ConfigMap" | "Secret" | "PersistentVolumeClaim" | "HorizontalPodAutoscaler"
K8sPodPhase "Pending" | "Running" | "Succeeded" | "Failed" | "Unknown"
K8sServiceType "ClusterIP" | "NodePort" | "LoadBalancer" | "ExternalName"

K8sObjectMeta {
  Name        String
  Namespace   String
  Uid         String
  Labels      Map(String, String)
  Annotations Map(String, String)
  Generation  Int
}

ResourceQuotaSpec {
  CpuMillicores Int
  MemoryMiB     Int
  EphemeralStorageGiB Int
}

K8sProbe {
  Path                String
  Port                Int
  InitialDelaySeconds Int
  PeriodSeconds       Int
  TimeoutSeconds      Int
  FailureThreshold    Int
}

K8sContainerSpec {
  Name           String
  Image          String
  Command        List(String)
  Args           List(String)
  Ports          List(Int)
  Requests       ResourceQuotaSpec
  Limits         ResourceQuotaSpec
  LivenessProbe  Option(K8sProbe)
  ReadinessProbe Option(K8sProbe)
}

K8sPod {
  Metadata      K8sObjectMeta
  Containers    List(K8sContainerSpec)
  NodeName      Option(String)
  Phase         K8sPodPhase
  PodIp         Option(String)
  RestartPolicy "Always" | "OnFailure" | "Never"
}

K8sDeployment {
  Metadata          K8sObjectMeta
  Replicas          Int
  AvailableReplicas Int
  Strategy          "RollingUpdate" | "Recreate"
  PodTemplate       K8sPod
}

K8sService {
  Metadata   K8sObjectMeta
  Type       K8sServiceType
  Selector   Map(String, String)
  ClusterIp  String
  Ports      List((Int, Int))
}

// =============================================================================
// 3. Serverless, Object Storage, CDN & Message Brokers
// =============================================================================

ServerlessRuntime "nodejs20" | "python312" | "rust-provided" | "go1.x" | "java21" | "dotnet8" | "wasm-edge"

ServerlessFunction {
  FunctionName String
  Runtime      ServerlessRuntime
  Handler      String
  MemoryMb     Int
  TimeoutSec   Int
  Environment  Map(String, String)
  Trigger      "http" | "queue" | "cron" | "storage-event" | "stream"
}

StorageClass "STANDARD" | "INFREQUENT_ACCESS" | "GLACIER_INSTANT" | "GLACIER_DEEP_ARCHIVE" | "MULTI_REGIONAL"

ObjectStorageBucket {
  BucketName        String
  Region            String
  StorageClass      StorageClass
  VersioningEnabled Bool
  EncryptionKeyId   Option(String)
  PublicAccessBlock Bool
}

MessageQueueBroker "Kafka" | "RabbitMQ" | "NATS" | "Pulsar" | "SQS" | "RedisStreams"
DeliveryGuarantee  "AtMostOnce" | "AtLeastOnce" | "ExactlyOnce"

EventTopic {
  TopicName         String
  Broker            MessageQueueBroker
  Partitions        Int
  ReplicationFactor Int
  RetentionHours    Int
  Guarantee         DeliveryGuarantee
}

// =============================================================================
// 4. CI/CD Pipelines & Infrastructure as Code (Terraform / Pulumi)
// =============================================================================

CiStepStatus "queued" | "in_progress" | "succeeded" | "failed" | "skipped" | "cancelled"

CiPipelineStep {
  Name       String
  Command    String
  DockerImage Option(String)
  TimeoutMin Int
  Status     CiStepStatus
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

// =============================================================================
// 5. Observability: OpenTelemetry Traces, Prometheus Metrics & Logs
// =============================================================================

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

SpanKind "INTERNAL" | "SERVER" | "CLIENT" | "PRODUCER" | "CONSUMER"
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
  ServiceName         String
  IndicatorMetric     String
  TargetPercentage    Range(0.0, 100.0) & Float
  EvaluationWindowDays Int
  ErrorBudgetRemaining Fraction
}

// =============================================================================
// 6. Cloud & DevOps Transitions
// =============================================================================

ScaleDeployment(D K8sDeployment, TargetReplicas Int) [
  D & { Replicas TargetReplicas }
]

StopComputeInstance(Inst ComputeInstance & { State "running" }) [
  Inst & { State "stopped" }
]

StartComputeInstance(Inst ComputeInstance & { State "stopped" }) [
  Inst & { State "running" }
]
