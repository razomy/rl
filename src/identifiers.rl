#
Concrete Identifier Schemes, Media Subtypes & Information Transitions
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

Write(A Agent, Content String, L Language) [ Text { Content, Language L } & Draft Object ]
Publish(D Draft, U Url) [ D / Draft & Published { PublishedAt Now, Url U } ]
Retract(P Published, Reason String) [ P / Published & Retracted { RetractedAt Now, Reason } ]
Translate(T Text, Target Language) [ Text { Content T.Content, Language Target } ]
Summarize(T Text) [ Summary { Content T.Content, Language T.Language } ]
Send(M Message) [ M & Sent { SentAt Now } ]
Deliver(M Message & Sent) [ M & Delivered { DeliveredAt Now } ]
MarkRead(M Message & Delivered) [ M & Read { ReadAt Now } ]
Encode(D Data, E Encoding) [ D & { Encoding E } ]
Assign(X Any, I Identifier) [ X & { Identifier I } ]
Archive_(R Record, C Catalog) [ C & { Records (Cons { Head R, Tail Records }) } ]
