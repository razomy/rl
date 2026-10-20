#
Abstract Cryptography, PKI, ZKP, Vulnerability & Security Incident Contracts
#

CryptoKeyPair {
  Algorithm  AsymmetricAlgorithm | PostQuantumAlgorithm
  PublicKey  Base64Str
  PrivateKey Base64Str
  CreatedAt  Instant
  ExpiresAt  Option(Instant)
}

EncryptedPayload {
  Cipher     SymmetricCipher
  Ciphertext Base64Str
  NonceIv    HexStr
  AuthTag    HexStr
  KeyId      String
}

DigitalSignature {
  Scheme    SignatureScheme
  SignerKey Base64Str
  Signature HexStr
  SignedAt  Instant
}

X509Certificate {
  SerialNumber       HexStr
  SubjectCommonName  String
  SubjectAltNames    List(String)
  IssuerCommonName   String
  ValidFrom          DateTime
  ValidUntil         DateTime
  PublicKeyAlgorithm AsymmetricAlgorithm
  PublicKeyHex       HexStr
  SignatureHex       HexStr
  IsCa               Bool
  OcspStaplingUrl    Option(Url)
  CrlDistributionUrl Option(Url)
}

ZkCircuit {
  CircuitId        String
  ProofSystem      ZkProofSystem
  Curve            EllipticCurve
  ConstraintsCount Int
  PublicInputs     List(String)
  PrivateWitnesses List(String)
}

ZkProof {
  CircuitId    String
  ProofSystem  ZkProofSystem
  ProofBytes   Base64Str
  PublicInputs List(String)
  Verified     Bool
}

CveVulnerability {
  CveId            String
  CweId            String
  Summary          String
  Cvss             CvssScore
  AffectedProducts List(String)
  PatchedVersions  List(String)
  ExploitAvailable Bool
  PublishedAt      Date
}

SecurityIncident {
  IncidentId   String
  Title        String
  Severity     CvssSeverity
  Status       IncidentStatus
  Alerts       List(SiemAlert)
  AssignedTeam String
  CreatedAt    Instant
  ResolvedAt   Option(Instant)
}
