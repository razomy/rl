_ meta
_ primitive
_ structure
_ string
_ db
_ auth

// =============================================================================
// Network Layer (IP, TCP, UDP, DNS, TLS)
// =============================================================================

IpVersion "IPv4" | "IPv6"
SocketProtocol "TCP" | "UDP" | "QUIC" | "SCTP" | "Unix"

SocketAddr {
  Host      String
  Port      U16
  IpVersion IpVersion
}

DnsRecordType "A" | "AAAA" | "CNAME" | "MX" | "TXT" | "NS" | "SRV" | "CAA"
DnsRecord {
  Name  String
  Type  DnsRecordType
  Value String
  Ttl   Int
}

TlsConfig {
  CertPath   String
  KeyPath    String
  CaPath     Option(String)
  MinVersion "TLS1.2" | "TLS1.3"
}

// =============================================================================
// HTTP Protocol, Headers, Cookies & Status Codes
// =============================================================================

HttpMethod "GET" | "POST" | "PUT" | "PATCH" | "DELETE" | "HEAD" | "OPTIONS" | "CONNECT" | "TRACE"

HttpStatus {
  Code   Int
  Reason String
}

HttpOk                  HttpStatus & { Code 200, Reason "OK" }
HttpCreated             HttpStatus & { Code 201, Reason "Created" }
HttpNoContent           HttpStatus & { Code 204, Reason "No Content" }
HttpBadRequest          HttpStatus & { Code 400, Reason "Bad Request" }
HttpUnauthorized        HttpStatus & { Code 401, Reason "Unauthorized" }
HttpForbidden           HttpStatus & { Code 403, Reason "Forbidden" }
HttpNotFound            HttpStatus & { Code 404, Reason "Not Found" }
HttpConflict            HttpStatus & { Code 409, Reason "Conflict" }
HttpUnprocessableEntity HttpStatus & { Code 422, Reason "Unprocessable Entity" }
HttpTooManyRequests     HttpStatus & { Code 429, Reason "Too Many Requests" }
HttpInternalServerError HttpStatus & { Code 500, Reason "Internal Server Error" }
HttpServiceUnavailable  HttpStatus & { Code 503, Reason "Service Unavailable" }

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

// =============================================================================
// WebSockets, SSE, GraphQL & gRPC
// =============================================================================

WsFrameType "text" | "binary" | "ping" | "pong" | "close"
WsMessage {
  FrameType WsFrameType
  Payload   String
}

SseEvent {
  Id    Option(String)
  Event Option(String)
  Data  String
  Retry Option(Int)
}

GraphQlRequest {
  Query         String
  OperationName Option(String)
  Variables     Map(String, Any)
}

GraphQlResponse {
  Data   Option(Any)
  Errors List(String)
}

// =============================================================================
// HTTP Client & Declarative API Router
// =============================================================================

Http {
  Get(Url String)                     [ native_http_get(Url) ]
  Post(Url String, Body String)          [ native_http_post(Url, Body) ]
  Put(Url String, Body String)           [ native_http_put(Url, Body) ]
  Delete(Url String)                  [ native_http_delete(Url) ]
  Send(Req HttpRequest)            [ Req . native_http_send ]
  Listen(Port Int, Handler)        [ (Port, Handler) . native_http_listen ]
}

ApiRouter(Req HttpRequest) [
  Req . {
    { Method "GET", Path ["health"] } [
      HttpResponse { Status 200, Body "OK" }
    ]

    { Method "GET", Path ["users", Id] } [
      Req . AuthMiddleware . {
        Unauthorized [ HttpResponse { Status 401, Body Reason } ]
        HttpRequest  [
          Id . Db.FindUser . Json.Encode . (JsonStr [
            HttpResponse { Status 200, Body JsonStr }
          ])
        ]
      }
    ]

    _ [ HttpResponse { Status 404, Body "Not Found" } ]
  }
]
