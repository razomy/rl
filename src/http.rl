_ primitives
_ structures
_ auth

HttpRequest {
  Method  "GET" | "POST" | "PUT" | "DELETE"
  Path    List(Str)
  Headers Map(Str, Str)
  Body    Str
}

HttpResponse { Status Int, Body Str }

Http {
  Get(Url Str) [ native_http_get(Url) ]
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
