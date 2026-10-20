#
Abstract Users, Access Policies, Sessions, Tokens & Auth Errors
#

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

SecurityProfile {
  IsBanned            Bool
  BanReason           Option(String)
  FailedLoginAttempts Int
  LockedUntil         Option(Int)
  TwoFactorEnabled    Bool
  TwoFactorSecret     Option(String)
  PasswordChangedAt   Option(Int)
}

AuthSession {
  SessionToken String
  UserAgent    Option(String)
  IpAddress    Option(String)
  DeviceType   Option(DeviceType)
  Location     Option(String)
  ExpiresAt    Int
}

Unauthorized { Reason String }
Forbidden    { Reason String, RequiredPermission String }
