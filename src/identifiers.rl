#
Concrete Identifier Schemes, media Subtypes & Information Transitions
#

Uuid Identifier & { Scheme "uuid" }
Isbn Identifier & { Scheme "isbn" }
Issn Identifier & { Scheme "issn" }
Doi  Identifier & { Scheme "doi" }
Gtin Identifier & { Scheme "gtin" }
Iban Identifier & { Scheme "iban" }
Vin  Identifier & { Scheme "vin" }

Image Media & { MediaKind "image" }
Audio Media & { MediaKind "audio" }
Video Media & { MediaKind "video" }

Write(a Agent, content String, l Language) [ Text { Content, language L } & Draft Object ]
Publish(d Draft, u Url) [ D / Draft & Published { PublishedAt Now, url U } ]
Retract(p Published, reason String) [ P / Published & Retracted { RetractedAt Now, Reason } ]
Translate(t Text, target Language) [ Text { Content T.Content, language Target } ]
Summarize(t Text) [ Summary { Content T.Content, language T.Language } ]
Send(m Message) [ m & Sent { SentAt Now } ]
Deliver(m Message & Sent) [ m & Delivered { DeliveredAt Now } ]
MarkRead(m Message & Delivered) [ m & Read { ReadAt Now } ]
Encode(d Data, e Encoding) [ d & { Encoding E } ]
Assign(x Any, i Identifier) [ x & { Identifier I } ]
Archive_(r Record, c Catalog) [ c & { Records (Cons { Head R, tail Records }) } ]
