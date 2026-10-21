#
Concrete Cloud Providers (AWS, GCP, Azure...), Kubernetes & Message Brokers
#

CloudProvider "aws" | "gcp" | "azure" | "cloudflare" | "digitalocean" | "hetzner" | "linode" | "oracle" | "alibaba" | "bare-metal"

K8sResourceKind "Pod" | "Deployment" | "StatefulSet" | "DaemonSet" | "Job" | "CronJob" | "Service" | "Ingress" | "ConfigMap" | "Secret" | "PersistentVolumeClaim" | "HorizontalPodAutoscaler"
K8sPodPhase     "Pending" | "Running" | "Succeeded" | "Failed" | "Unknown"
K8sServiceType  "ClusterIP" | "NodePort" | "LoadBalancer" | "ExternalName"

K8sObjectMeta {
  Name        String
  Namespace   String
  Uid         String
  Labels      Map(String, String)
  Annotations Map(String, String)
  Generation  Int
}

ResourceQuotaSpec {
  CpuMillicores       Int
  MemoryMiB           Int
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
  Metadata  K8sObjectMeta
  Type      K8sServiceType
  Selector  Map(String, String)
  ClusterIp String
  Ports     List((Int, Int))
}

ServerlessRuntime  "nodejs20" | "python312" | "rust-provided" | "go1.x" | "java21" | "dotnet8" | "wasm-edge"
StorageClass       "STANDARD" | "INFREQUENT_ACCESS" | "GLACIER_INSTANT" | "GLACIER_DEEP_ARCHIVE" | "MULTI_REGIONAL"
MessageQueueBroker "Kafka" | "RabbitMQ" | "NATS" | "Pulsar" | "SQS" | "RedisStreams"
DeliveryGuarantee  "AtMostOnce" | "AtLeastOnce" | "ExactlyOnce"

ScaleDeployment(d K8sDeployment, targetReplicas Int) [
  D & { Replicas TargetReplicas }
]

StopComputeInstance(inst ComputeInstance & { State "running" }) [
  Inst & { State "stopped" }
]

StartComputeInstance(inst ComputeInstance & { State "stopped" }) [
  Inst & { State "running" }
]
