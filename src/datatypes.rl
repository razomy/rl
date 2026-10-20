#
Schema.org DataTypes & Thing Transitions
#

Boolean_          Bool
Text_             String
Number_           Real
Integer           Int
URL               Url
CssSelectorType   String
XPathType         String
DateTime_         DateTime
Date_             Date
Time_             TimeOfDay
PronounceableText String
DataType          Boolean_ | Text_ | Number_ | Integer | URL | DateTime_ | Date_ | Time_

Describe(T Thing, D Text) [ T & { Description D } ]
Rename(T Thing, N Name) [ T & { AlternateName Name, Name N } ]
Link(T Thing, U Url) [ T & { SameAs (Cons { Head U, Tail SameAs }) } ]
Identify(T Thing, I Identifier) [ T & { Identifier I } ]
