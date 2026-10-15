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
  Region   Str
  ZoneId   Str
}

VpcSubnet {
  SubnetId         Str
  CidrBlock        Str
  Zone             AvailabilityZone
  IsPublic         Bool
  RouteTableId     Str
}

VirtualPrivateCloud {
  VpcId            Str
  Name             Str
  CidrBlock        Str
  Subnets          List(VpcSubnet)
  EnableDnsHostnames Bool
}

InstanceState "pending" | "running" | "stopping" | "stopped" | "shutting-down" | "terminated"

ComputeInstance {
  InstanceId       Str
  InstanceType     Str
  Vcpus            Count
  MemoryGb         Float
  GpuCount         Count
  GpuModel         Option(Str)
  PublicIp         Option(Str)
  PrivateIp        Str
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
  Name        Str
  Namespace   Str
  Uid         Str
  Labels      Map(Str, Str)
  Annotations Map(Str, Str)
  Generation  Int
}

ResourceQuotaSpec {
  CpuMillicores Int
  MemoryMiB     Int
  EphemeralStorageGiB Int
}

K8sProbe {
  Path                Str
  Port                Int
  InitialDelaySeconds Int
  PeriodSeconds       Int
  TimeoutSeconds      Int
  FailureThreshold    Int
}

K8sContainerSpec {
  Name           Str
  Image          Str
  Command        List(Str)
  Args           List(Str)
  Ports          List(Int)
  Requests       ResourceQuotaSpec
  Limits         ResourceQuotaSpec
  LivenessProbe  Option(K8sProbe)
  ReadinessProbe Option(K8sProbe)
}

K8sPod {
  Metadata      K8sObjectMeta
  Containers    List(K8sContainerSpec)
  NodeName      Option(Str)
  Phase         K8sPodPhase
  PodIp         Option(Str)
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
  Selector   Map(Str, Str)
  ClusterIp  Str
  Ports      List((Int, Int))
}

// =============================================================================
// 3. Serverless, Object Storage, CDN & Message Brokers
// =============================================================================

ServerlessRuntime "nodejs20" | "python312" | "rust-provided" | "go1.x" | "java21" | "dotnet8" | "wasm-edge"

ServerlessFunction {
  FunctionName Str
  Runtime      ServerlessRuntime
  Handler      Str
  MemoryMb     Int
  TimeoutSec   Int
  Environment  Map(Str, Str)
  Trigger      "http" | "queue" | "cron" | "storage-event" | "stream"
}

StorageClass "STANDARD" | "INFREQUENT_ACCESS" | "GLACIER_INSTANT" | "GLACIER_DEEP_ARCHIVE" | "MULTI_REGIONAL"

ObjectStorageBucket {
  BucketName        Str
  Region            Str
  StorageClass      StorageClass
  VersioningEnabled Bool
  EncryptionKeyId   Option(Str)
  PublicAccessBlock Bool
}

MessageQueueBroker "Kafka" | "RabbitMQ" | "NATS" | "Pulsar" | "SQS" | "RedisStreams"
DeliveryGuarantee  "AtMostOnce" | "AtLeastOnce" | "ExactlyOnce"

EventTopic {
  TopicName         Str
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
  Name       Str
  Command    Str
  DockerImage Option(Str)
  TimeoutMin Int
  Status     CiStepStatus
}

CiPipeline {
  PipelineId  Str
  RepoUrl     Str
  Branch      Str
  CommitSha   Str
  TriggeredBy Str
  Steps       List(CiPipelineStep)
  Status      CiStepStatus
}

IacResourceAction "no-op" | "create" | "read" | "update" | "replace" | "delete"

IacStateResource {
  Address      Str
  Provider     Str
  ResourceType Str
  Attributes   Map(Str, Any)
}

// =============================================================================
// 5. Observability: OpenTelemetry Traces, Prometheus Metrics & Logs
// =============================================================================

MetricKind "Counter" | "Gauge" | "Histogram" | "Summary" | "UpDownCounter"

TelemetryMetric {
  Name        Str
  Description Str
  Unit        Str
  Kind        MetricKind
  Labels      Map(Str, Str)
  Value       Float
  Timestamp   Instant
}

SpanKind "INTERNAL" | "SERVER" | "CLIENT" | "PRODUCER" | "CONSUMER"
SpanStatus "UNSET" | "OK" | "ERROR"

TraceSpan {
  TraceId      HexStr
  SpanId       HexStr
  ParentSpanId Option(HexStr)
  Operation    Str
  ServiceName  Str
  Kind         SpanKind
  Status       SpanStatus
  StartTimeNs  Int
  EndTimeNs    Int
  Attributes   Map(Str, Any)
}

SloTarget {
  ServiceName         Str
  IndicatorMetric     Str
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
