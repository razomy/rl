#
Concrete Cryptographic Algorithms, PKI, HSM & Zero-Knowledge Proofs
#

SymmetricCipher       "AES-128-GCM" | "AES-256-GCM" | "AES-256-CBC" | "ChaCha20-Poly1305" | "XChaCha20-Poly1305" | "Twofish" | "Camellia" | "Serpent"
AsymmetricAlgorithm   "RSA-2048" | "RSA-4096" | "ECDSA-P256" | "ECDSA-P384" | "ECDSA-secp256k1" | "Ed25519" | "Ed448" | "X25519" | "X448" | "BLS12-381"
PostQuantumAlgorithm  "ML-KEM-512" | "ML-KEM-768" | "ML-KEM-1024" | "ML-DSA-44" | "ML-DSA-65" | "ML-DSA-87" | "SLH-DSA-SPHINCS" | "Falcon-512" | "Classic-McEliece"
KeyDerivationFunction "PBKDF2" | "Argon2id" | "Argon2i" | "Scrypt" | "Bcrypt" | "HKDF-SHA256" | "HKDF-SHA512"

CertificateChain {
  LeafCert          X509Certificate
  IntermediateCerts List(X509Certificate)
  RootCaCert        X509Certificate
}

HardwareSecurityModule {
  ModuleId        String
  Vendor          String
  FipsLevel       "FIPS-140-2-L2" | "FIPS-140-2-L3" | "FIPS-140-3-L3" | "FIPS-140-3-L4"
  SlotsAvailable  Count
  TamperProtected Bool
}

ZkProofSystem "Groth16" | "PLONK" | "Halo2" | "STARK" | "Bulletproofs" | "Nova" | "SuperNova" | "Marlin"
EllipticCurve "BN254" | "BLS12-381" | "BLS12-377" | "Pasta-Pallas" | "Pasta-Vesta" | "Secp256k1" | "Ed25519"

ShamirSecretShare {
  ShareIndex   Int
  ThresholdK   Int
  TotalSharesN Int
  ShareValue   HexStr
}

VerifyZkProof(P ZkProof) [
  P & { Verified true }
]
