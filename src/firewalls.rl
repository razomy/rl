#
Threat Intelligence (CVE / CVSS / MITRE ATT&CK), Firewalls, WAF & SIEM
#

CvssSeverity     "NONE" | "LOW" | "MEDIUM" | "HIGH" | "CRITICAL"
AttackVector     "NETWORK" | "ADJACENT_NETWORK" | "LOCAL" | "PHYSICAL"
AttackComplexity "LOW" | "HIGH"

CvssScore {
  Version          "3.1" | "4.0"
  BaseScore        Range(0.0, 10.0) & Float
  Severity         CvssSeverity
  VectorString     String
  AttackVector     AttackVector
  AttackComplexity AttackComplexity
}

MitreTactic
  "Reconnaissance" | "ResourceDevelopment" | "InitialAccess" | "Execution"
  | "Persistence" | "PrivilegeEscalation" | "DefenseEvasion" | "CredentialAccess"
  | "Discovery" | "LateralMovement" | "Collection" | "CommandAndControl"
  | "Exfiltration" | "Impact"

MitreTechnique {
  TechniqueId String
  Name        String
  Tactic      MitreTactic
  Platforms   List(String)
  Detections  List(String)
}

MalwareCategory "Ransomware" | "Trojan" | "Worm" | "Spyware" | "Rootkit" | "Botnet" | "Keylogger" | "Cryptojacker" | "Fileless" | "APT"

IndicatorOfCompromise {
  IocType     "IPv4" | "IPv6" | "Domain" | "URL" | "FileHashSHA256" | "FileHashMD5" | "Email" | "RegistryKey" | "YaraRule"
  Value       String
  Confidence  Fraction
  ThreatActor Option(String)
  FirstSeen   Instant
  LastSeen    Instant
}

FirewallAction   "ALLOW" | "DENY" | "DROP" | "REJECT" | "LOG" | "RATE_LIMIT"
NetworkDirection "INBOUND" | "OUTBOUND" | "BIDIRECTIONAL"

FirewallRule {
  RuleId          String
  Priority        Int
  Direction       NetworkDirection
  Protocol        "TCP" | "UDP" | "ICMP" | "ANY"
  SourceCidr      String
  DestinationCidr String
  PortRange       (Int, Int)
  Action          FirewallAction
  Enabled         Bool
}

WafThreatType "SQLInjection" | "XSS" | "CSRF" | "SSRF" | "PathTraversal" | "RemoteCodeExecution" | "XXE" | "BotAbuse" | "DDoS"

SiemAlert {
  AlertId       String
  Severity      CvssSeverity
  RuleName      String
  SourceIp      Option(String)
  DestinationIp Option(String)
  Technique     Option(MitreTechnique)
  RawLog        String
  TriggeredAt   Instant
}

IncidentStatus "Detected" | "Triaged" | "Contained" | "Eradicated" | "Recovered" | "PostMortemClosed"

ContainIncident(inc SecurityIncident & { Status "Triaged" }) [
  Inc & { Status "Contained" }
]

ResolveIncident(inc SecurityIncident & { Status "Contained" }) [
  Inc & { Status "Recovered", ResolvedAt (Some { Value Now }) }
]
