#
DNS Records & TLS Configuration
#

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
