_ meta
_ primitive
_ structure
_ string
_ db

// =============================================================================
// Users, Roles, Permissions (RBAC / ABAC / ACL) & Cryptography
// =============================================================================

RoleType "guest" | "user" | "moderator" | "manager" | "admin" | "superadmin" | "service"

PermissionScope {
  Resource Str
  Actions  List("create" | "read" | "update" | "delete" | "execute" | "manage")
}

AccessLevel "DENIED" | "VIEWER" | "COMMENTER" | "EDITOR" | "ADMIN" | "OWNER"

AccessPolicy {
  SubjectId   Str
  ResourceId  Str
  AccessLevel AccessLevel
}

User {
  Id           Str
  Name         Str
  Age          Int
  Role         Str
  PasswordHash Str
}

// Type Subtraction ('/') and Intersection ('&')
PublicUser   User / User.PasswordHash
DatabaseUser User & Identifiable & Auditable
GuestUser    PublicUser / PublicUser.Role & { Role "guest" }

// Refinement Types
IsAdult   [ _.Age >= 18 ]
IsMinor   [ _.Age < 18 ]
IsManager [ _.Role . ("admin" | "manager") ]
NonEmpty  [ _.Length > 0 ]
EmailStr  Str & [ _ . Regex.Matches("^[^@]+@[^@]+\\.[^@]+$") ]

Adult   User & IsAdult
Minor   User & IsMinor
Manager User & IsManager

// =============================================================================
// Sessions, MFA, Recovery Codes & Security Profiles
// =============================================================================

AuthProviderType "google" | "apple" | "credentials" | "github" | "microsoft" | "discord" | "gitlab" | "saml" | "oidc" | "webauthn"
DeviceType       "mobile" | "desktop" | "tablet" | "tv" | "watch" | "vr" | "bot"
TokenTypeAuth    "VERIFY_EMAIL" | "RESET_PASSWORD" | "MAGIC_LINK" | "INVITE" | "API_KEY"
AuthAction       "LOGIN" | "LOGOUT" | "REGISTER" | "PASSWORD_RESET" | "MFA_CHALLENGE" | "TOKEN_REFRESH" | "REVOKE_SESSION"

SecurityProfile {
  IsBanned            Bool
  BanReason           Option(Str)
  FailedLoginAttempts Int
  LockedUntil         Option(Int)
  TwoFactorEnabled    Bool
  TwoFactorSecret     Option(Str)
  PasswordChangedAt   Option(Int)
}

AuthProvider {
  Provider          AuthProviderType
  ProviderAccountId Str
  Email             Option(Str)
  AccessToken       Option(Str)
  RefreshToken      Option(Str)
}

AuthSession {
  SessionToken Str
  UserAgent    Option(Str)
  IpAddress    Option(Str)
  DeviceType   Option(DeviceType)
  Location     Option(Str)
  ExpiresAt    Int
}

RecoveryCode {
  CodeHash Str
  IsUsed   Bool
  UsedAt   Option(Int)
}

VerificationToken {
  Identifier Str
  Token      Str
  Type       TokenTypeAuth
  Payload    Option(Any)
  ExpiresAt  Int
}

AuthEvent {
  Action    AuthAction
  IpAddress Option(Str)
  UserAgent Option(Str)
  CreatedAt Int
}

UserAuth IEntity & {
  UserId        IdRef(User)
  Securities    List(IdRef(SecurityProfile))
  Providers     List(IdRef(AuthProvider))
  Sessions      List(IdRef(AuthSession))
  RecoveryCodes List(IdRef(RecoveryCode))
  AuthEvents    List(IdRef(AuthEvent))
}

// =============================================================================
// Tokens, JWT, OAuth2 & Security Errors
// =============================================================================

JwtHeader {
  Alg "HS256" | "HS512" | "RS256" | "ES256" | "EdDSA"
  Typ "JWT"
}

JwtClaims {
  Sub   Str
  Iss   Str
  Aud   Str
  Exp   Int
  Iat   Int
  Roles List(Str)
}

JwtToken {
  Header    JwtHeader
  Claims    JwtClaims
  Signature Str
}

OAuthToken {
  AccessToken  Str
  RefreshToken Option(Str)
  TokenType    "Bearer"
  ExpiresIn    Int
  Scope        Str
}

ApiKey {
  KeyId      Str
  Prefix     Str
  SecretHash Str
  OwnerId    Str
  Scopes     List(Str)
  ExpiresAt  Option(Int)
}

Unauthorized { Reason Str }
Forbidden    { Reason Str, RequiredPermission Str }

// =============================================================================
// Cryptography & Hashing
// =============================================================================

HashAlgorithm   "sha256" | "sha512" | "sha3-256" | "blake3" | "argon2id" | "bcrypt" | "scrypt" | "pbkdf2"
CipherAlgorithm "aes-256-gcm" | "aes-128-gcm" | "chacha20-poly1305" | "xchacha20-poly1305" | "rsa-oaep"
SignatureScheme "ed25519" | "ecdsa-secp256k1" | "ecdsa-p256" | "rsa-pss" | "bls12-381" | "ml-dsa-dilithium"

Crypto {
  Hash(Data Str, Alg HashAlgorithm)                 [ (Data, Alg) . native_crypto_hash ]
  VerifyHash(Data Str, Hash Str)                    [ (Data, Hash) . native_crypto_verify ]
  Hmac(Key Str, Data Str)                           [ (Key, Data) . native_crypto_hmac ]
  Encrypt(Key Str, Plain Str, Alg CipherAlgorithm)  [ (Key, Plain, Alg) . native_crypto_encrypt ]
  Decrypt(Key Str, Cipher Str, Alg CipherAlgorithm) [ (Key, Cipher, Alg) . native_crypto_decrypt ]
  RandomBytes(Count Int)                            [ Count . native_crypto_random_bytes ]
  RandomUuid()                                      [ native_crypto_uuid ]
}

// =============================================================================
// Auth Middleware & Account Classification
// =============================================================================

AuthMiddleware(Req) [
  Req.Headers . Map.Get("Authorization") . {
    Some [ Req & { AuthUser (Value . Db.FindUserByToken) } ]
    None [ Unauthorized { Reason "Missing Authorization Header" } ]
  }
]

ClassifyAccount(Account) [
  Account . {
    Manager [ "Dashboard: {Name}" . Shell.Log ]
    Adult   [ "Adult account: {Name}" . Shell.Log ]
    Minor   [ "Child account: {Name}" . Shell.Log ]
    _       [ "Unknown profile" . Shell.Log ]
  }
]

ClientAccount {
  AccountId Str
  Name      Str
  IsAdult   Bool
}

MigrateUser(U User) [
  ClientAccount {
    AccountId Id
    IsAdult   (Age >= 18)
  }
]
