_ primitive
_ structure
_ string
_ db

#
Users, Roles, Permissions (RBAC / ABAC / ACL) & Cryptography
#

RoleType "guest" | "user" | "moderator" | "manager" | "admin" | "superadmin" | "service"

PermissionScope {
  Resource String
  Actions  List("create" | "read" | "update" | "delete" | "execute" | "manage")
}

AccessLevel "DENIED" | "VIEWER" | "COMMENTER" | "EDITOR" | "ADMIN" | "OWNER"

AccessPolicy {
  SubjectId   String
  ResourceId  String
  AccessLevel AccessLevel
}

User {
  Id           String
  Name         String
  Age          Int
  Role         String
  PasswordHash String
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
EmailStr  String & [ _ . Regex.Matches("^[^@]+@[^@]+\\.[^@]+$") ]

Adult   User & IsAdult
Minor   User & IsMinor
Manager User & IsManager

#
Sessions, MFA, Recovery Codes & Security Profiles
#

AuthProviderType "google" | "apple" | "credentials" | "github" | "microsoft" | "discord" | "gitlab" | "saml" | "oidc" | "webauthn"
DeviceType       "mobile" | "desktop" | "tablet" | "tv" | "watch" | "vr" | "bot"
TokenTypeAuth    "VERIFY_EMAIL" | "RESET_PASSWORD" | "MAGIC_LINK" | "INVITE" | "API_KEY"
AuthAction       "LOGIN" | "LOGOUT" | "REGISTER" | "PASSWORD_RESET" | "MFA_CHALLENGE" | "TOKEN_REFRESH" | "REVOKE_SESSION"

SecurityProfile {
  IsBanned            Bool
  BanReason           Option(String)
  FailedLoginAttempts Int
  LockedUntil         Option(Int)
  TwoFactorEnabled    Bool
  TwoFactorSecret     Option(String)
  PasswordChangedAt   Option(Int)
}

AuthProvider {
  Provider          AuthProviderType
  ProviderAccountId String
  Email             Option(String)
  AccessToken       Option(String)
  RefreshToken      Option(String)
}

AuthSession {
  SessionToken String
  UserAgent    Option(String)
  IpAddress    Option(String)
  DeviceType   Option(DeviceType)
  Location     Option(String)
  ExpiresAt    Int
}

RecoveryCode {
  CodeHash String
  IsUsed   Bool
  UsedAt   Option(Int)
}

VerificationToken {
  Identifier String
  Token      String
  Type       TokenTypeAuth
  Payload    Option(Any)
  ExpiresAt  Int
}

AuthEvent {
  Action    AuthAction
  IpAddress Option(String)
  UserAgent Option(String)
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

#
Tokens, JWT, OAuth2 & Security Errors
#

JwtHeader {
  Alg "HS256" | "HS512" | "RS256" | "ES256" | "EdDSA"
  Typ "JWT"
}

JwtClaims {
  Sub   String
  Iss   String
  Aud   String
  Exp   Int
  Iat   Int
  Roles List(String)
}

JwtToken {
  Header    JwtHeader
  Claims    JwtClaims
  Signature String
}

OAuthToken {
  AccessToken  String
  RefreshToken Option(String)
  TokenType    "Bearer"
  ExpiresIn    Int
  Scope        String
}

ApiKey {
  KeyId      String
  Prefix     String
  SecretHash String
  OwnerId    String
  Scopes     List(String)
  ExpiresAt  Option(Int)
}

Unauthorized { Reason String }
Forbidden    { Reason String, RequiredPermission String }

#
Cryptography & Hashing
#

HashAlgorithm   "sha256" | "sha512" | "sha3-256" | "blake3" | "argon2id" | "bcrypt" | "scrypt" | "pbkdf2"
CipherAlgorithm "aes-256-gcm" | "aes-128-gcm" | "chacha20-poly1305" | "xchacha20-poly1305" | "rsa-oaep"
SignatureScheme "ed25519" | "ecdsa-secp256k1" | "ecdsa-p256" | "rsa-pss" | "bls12-381" | "ml-dsa-dilithium"

Crypto {
  Hash(Data String, Alg HashAlgorithm)                 [ (Data, Alg) . native_crypto_hash ]
  VerifyHash(Data String, Hash String)                    [ (Data, Hash) . native_crypto_verify ]
  Hmac(Key String, Data String)                           [ (Key, Data) . native_crypto_hmac ]
  Encrypt(Key String, Plain String, Alg CipherAlgorithm)  [ (Key, Plain, Alg) . native_crypto_encrypt ]
  Decrypt(Key String, Cipher String, Alg CipherAlgorithm) [ (Key, Cipher, Alg) . native_crypto_decrypt ]
  RandomBytes(Count Int)                            [ Count . native_crypto_random_bytes ]
  RandomUuid()                                      [ native_crypto_uuid ]
}

#
Auth Middleware & Account Classification
#

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
  AccountId String
  Name      String
  IsAdult   Bool
}

MigrateUser(U User) [
  ClientAccount {
    AccountId Id
    IsAdult   (Age >= 18)
  }
]
