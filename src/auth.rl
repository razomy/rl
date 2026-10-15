_ structures
_ db
_ primitives

User {
  Id           Str
  Name         Str
  Age          Int
  Role         Str
  PasswordHash Str
}

PublicUser   User / User.PasswordHash
DatabaseUser User & Identifiable & Auditable
GuestUser    PublicUser / PublicUser.Role & { Role "guest" }

IsAdult   [ _.Age >= 18 ]
IsMinor   [ _.Age < 18 ]
IsManager [ _.Role . ("admin" | "manager") ]
NonEmpty  [ _.Length > 0 ]
EmailStr  Str & [ _ . Regex.Matches("^[^@]+@[^@]+\.[^@]+$") ]

Adult   User & IsAdult
Minor   User & IsMinor
Manager User & IsManager

Unauthorized { Reason Str }

AuthMiddleware(Req HttpRequest) [
  Req.Headers . Map.Get("Authorization") . {
    Some [ Req & { AuthUser (Value . Db.FindUserByToken) } ]
    None [ Unauthorized { Reason "Missing Authorization Header" } ]
  }
]
