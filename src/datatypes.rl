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

Describe(t Thing, d Text) [ t & { Description D } ]
Rename(t Thing, n Name) [ t & { AlternateName Name, name N } ]
Link(t Thing, u Url) [ t & { SameAs (Cons { Head U, tail SameAs }) } ]
Identify(t Thing, i Identifier) [ t & { Identifier I } ]
