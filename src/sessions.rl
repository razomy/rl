#
Concrete User Refinements, Auth Providers, Sessions, MFA & JWT/OAuth2 Tokens
#

RoleType "guest" | "user" | "moderator" | "manager" | "admin" | "superadmin" | "service"

PublicUser   User / User.PasswordHash
DatabaseUser User & Identifiable & Auditable
GuestUser    PublicUser / PublicUser.Role & { Role "guest" }

IsAdult   [ _.Age >= 18 ]
IsMinor   [ _.Age < 18 ]
IsManager [ _.Role . ("admin" | "manager") ]

Adult   User & IsAdult
Minor   User & IsMinor
Manager User & IsManager

AuthProviderType "google" | "apple" | "credentials" | "github" | "microsoft" | "discord" | "gitlab" | "saml" | "oidc" | "webauthn"
DeviceType       "mobile" | "desktop" | "tablet" | "tv" | "watch" | "vr" | "bot"
TokenTypeAuth    "VERIFY_EMAIL" | "RESET_PASSWORD" | "MAGIC_LINK" | "INVITE" | "API_KEY"
AuthAction       "LOGIN" | "LOGOUT" | "REGISTER" | "PASSWORD_RESET" | "MFA_CHALLENGE" | "TOKEN_REFRESH" | "REVOKE_SESSION"

AuthProvider {
  Provider          AuthProviderType
  ProviderAccountId String
  Email             Option(String)
  AccessToken       Option(String)
  RefreshToken      Option(String)
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
