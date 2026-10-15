_ meta
_ primitive
_ structure
_ string
_ time
_ auth

// =============================================================================
// 1. Symmetric, Asymmetric & Post-Quantum Cryptography
// =============================================================================

SymmetricCipher "AES-128-GCM" | "AES-256-GCM" | "AES-256-CBC" | "ChaCha20-Poly1305" | "XChaCha20-Poly1305" | "Twofish" | "Camellia" | "Serpent"
AsymmetricAlgorithm "RSA-2048" | "RSA-4096" | "ECDSA-P256" | "ECDSA-P384" | "ECDSA-secp256k1" | "Ed25519" | "Ed448" | "X25519" | "X448" | "BLS12-381"
PostQuantumAlgorithm "ML-KEM-512" | "ML-KEM-768" | "ML-KEM-1024" | "ML-DSA-44" | "ML-DSA-65" | "ML-DSA-87" | "SLH-DSA-SPHINCS" | "Falcon-512" | "Classic-McEliece"
KeyDerivationFunction "PBKDF2" | "Argon2id" | "Argon2i" | "Scrypt" | "Bcrypt" | "HKDF-SHA256" | "HKDF-SHA512"

CryptoKeyPair {
  Algorithm  AsymmetricAlgorithm | PostQuantumAlgorithm
  PublicKey  Base64Str
  PrivateKey Base64Str
  CreatedAt  Instant
  ExpiresAt  Option(Instant)
}

EncryptedPayload {
  Cipher         SymmetricCipher
  Ciphertext     Base64Str
  NonceIv        HexStr
  AuthTag        HexStr
  KeyId          Str
}

DigitalSignature {
  Scheme     SignatureScheme
  SignerKey  Base64Str
  Signature  HexStr
  SignedAt   Instant
}

// =============================================================================
// 2. X.509 Certificates, PKI & Hardware Security Modules (HSM / TPM)
// =============================================================================

X509Certificate {
  SerialNumber       HexStr
  SubjectCommonName  Str
  SubjectAltNames    List(Str)
  IssuerCommonName   Str
  ValidFrom          DateTime
  ValidUntil         DateTime
  PublicKeyAlgorithm AsymmetricAlgorithm
  PublicKeyHex       HexStr
  SignatureHex       HexStr
  IsCa               Bool
  OcspStaplingUrl    Option(Url)
  CrlDistributionUrl Option(Url)
}

CertificateChain {
  LeafCert          X509Certificate
  IntermediateCerts List(X509Certificate)
  RootCaCert        X509Certificate
}

HardwareSecurityModule {
  ModuleId        Str
  Vendor          Str
  FipsLevel       "FIPS-140-2-L2" | "FIPS-140-2-L3" | "FIPS-140-3-L3" | "FIPS-140-3-L4"
  SlotsAvailable  Count
  TamperProtected Bool
}

// =============================================================================
// 3. Zero-Knowledge Proofs (ZKP) & Multi-Party Computation (MPC)
// =============================================================================

ZkProofSystem "Groth16" | "PLONK" | "Halo2" | "STARK" | "Bulletproofs" | "Nova" | "SuperNova" | "Marlin"
EllipticCurve "BN254" | "BLS12-381" | "BLS12-377" | "Pasta-Pallas" | "Pasta-Vesta" | "Secp256k1" | "Ed25519"

ZkCircuit {
  CircuitId        Str
  ProofSystem      ZkProofSystem
  Curve            EllipticCurve
  ConstraintsCount Int
  PublicInputs     List(Str)
  PrivateWitnesses List(Str)
}

ZkProof {
  CircuitId    Str
  ProofSystem  ZkProofSystem
  ProofBytes   Base64Str
  PublicInputs List(Str)
  Verified     Bool
}

ShamirSecretShare {
  ShareIndex   Int
  ThresholdK   Int
  TotalSharesN Int
  ShareValue   HexStr
}

// =============================================================================
// 4. Threat Intelligence, Vulnerabilities (CVE / CVSS) & MITRE ATT&CK
// =============================================================================

CvssSeverity "NONE" | "LOW" | "MEDIUM" | "HIGH" | "CRITICAL"
AttackVector "NETWORK" | "ADJACENT_NETWORK" | "LOCAL" | "PHYSICAL"
AttackComplexity "LOW" | "HIGH"

CvssScore {
  Version          "3.1" | "4.0"
  BaseScore        Range(0.0, 10.0) & Float
  Severity         CvssSeverity
  VectorString     Str
  AttackVector     AttackVector
  AttackComplexity AttackComplexity
}

CveVulnerability {
  CveId            Str
  CweId            Str
  Summary          Str
  Cvss             CvssScore
  AffectedProducts List(Str)
  PatchedVersions  List(Str)
  ExploitAvailable Bool
  PublishedAt      Date
}

MitreTactic
  "Reconnaissance" | "ResourceDevelopment" | "InitialAccess" | "Execution"
  | "Persistence" | "PrivilegeEscalation" | "DefenseEvasion" | "CredentialAccess"
  | "Discovery" | "LateralMovement" | "Collection" | "CommandAndControl"
  | "Exfiltration" | "Impact"

MitreTechnique {
  TechniqueId Str
  Name        Str
  Tactic      MitreTactic
  Platforms   List(Str)
  Detections  List(Str)
}

MalwareCategory "Ransomware" | "Trojan" | "Worm" | "Spyware" | "Rootkit" | "Botnet" | "Keylogger" | "Cryptojacker" | "Fileless" | "APT"

IndicatorOfCompromise {
  IocType     "IPv4" | "IPv6" | "Domain" | "URL" | "FileHashSHA256" | "FileHashMD5" | "Email" | "RegistryKey" | "YaraRule"
  Value       Str
  Confidence  Fraction
  ThreatActor Option(Str)
  FirstSeen   Instant
  LastSeen    Instant
}

// =============================================================================
// 5. Network Security, Firewalls, WAF, SIEM & Incident Response
// =============================================================================

FirewallAction "ALLOW" | "DENY" | "DROP" | "REJECT" | "LOG" | "RATE_LIMIT"
NetworkDirection "INBOUND" | "OUTBOUND" | "BIDIRECTIONAL"

FirewallRule {
  RuleId          Str
  Priority        Int
  Direction       NetworkDirection
  Protocol        "TCP" | "UDP" | "ICMP" | "ANY"
  SourceCidr      Str
  DestinationCidr Str
  PortRange       (Int, Int)
  Action          FirewallAction
  Enabled         Bool
}

WafThreatType "SQLInjection" | "XSS" | "CSRF" | "SSRF" | "PathTraversal" | "RemoteCodeExecution" | "XXE" | "BotAbuse" | "DDoS"

SiemAlert {
  AlertId       Str
  Severity      CvssSeverity
  RuleName      Str
  SourceIp      Option(Str)
  DestinationIp Option(Str)
  Technique     Option(MitreTechnique)
  RawLog        Str
  TriggeredAt   Instant
}

IncidentStatus "Detected" | "Triaged" | "Contained" | "Eradicated" | "Recovered" | "PostMortemClosed"

SecurityIncident {
  IncidentId   Str
  Title        Str
  Severity     CvssSeverity
  Status       IncidentStatus
  Alerts       List(SiemAlert)
  AssignedTeam Str
  CreatedAt    Instant
  ResolvedAt   Option(Instant)
}

// =============================================================================
// 6. Security Transitions
// =============================================================================

VerifyZkProof(P ZkProof) [
  P & { Verified true }
]

ContainIncident(Inc SecurityIncident & { Status "Triaged" }) [
  Inc & { Status "Contained" }
]

ResolveIncident(Inc SecurityIncident & { Status "Contained" }) [
  Inc & { Status "Recovered", ResolvedAt (Some { Value Now }) }
]
