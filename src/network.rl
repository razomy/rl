#
Abstract Network Node, Socket, DNS & TLS Contracts
#

NetworkNode {
  Host String
  Port Int
}

IpVersion      "IPv4" | "IPv6"
SocketProtocol "TCP" | "UDP" | "QUIC" | "SCTP" | "Unix"

SocketAddr {
  Host      String
  Port      U16
  IpVersion IpVersion
}
