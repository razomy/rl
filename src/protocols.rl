#
Concrete HTTP Status Codes, WebSockets, SSE, GraphQL & Router
#

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

Http {
  Get(Url String)             [ native_http_get(Url) ]
  Post(Url String, Body String) [ native_http_post(Url, Body) ]
  Put(Url String, Body String)  [ native_http_put(Url, Body) ]
  Delete(Url String)          [ native_http_delete(Url) ]
  Send(Req HttpRequest)       [ Req . native_http_send ]
  Listen(Port Int, Handler)   [ (Port, Handler) . native_http_listen ]
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
