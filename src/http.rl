#
Abstract HTTP Protocol Contracts
#

HttpMethod "GET" | "POST" | "PUT" | "PATCH" | "DELETE" | "HEAD" | "OPTIONS" | "CONNECT" | "TRACE"

HttpStatus {
  Code   Int
  Reason String
}

Cookie {
  Name     String
  Value    String
  Domain   Option(String)
  Path     String
  MaxAge   Option(Int)
  Secure   Bool
  HttpOnly Bool
  SameSite "Strict" | "Lax" | "None"
}

HttpRequest {
  Method      HttpMethod
  Path        List(String)
  QueryParams Map(String, String)
  Headers     Map(String, String)
  Cookies     Map(String, Cookie)
  Body        String
  RemoteAddr  Option(SocketAddr)
}

HttpResponse {
  Status  Int
  Headers Map(String, String)
  Cookies List(Cookie)
  Body    String
}
