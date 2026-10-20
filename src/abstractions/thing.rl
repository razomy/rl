_ primitive
_ structure
_ quantity
_ time
_ space
_ energy
_ matter
_ cosmos
_ life
_ agent
_ information
_ society
_ economy
_ artifact
_ event

#
Thing (schema.org root)
#

Description           Text
DisambiguatingDescription Text
AlternateName         Name
SameAs                List(Url)
AdditionalType        Url
MainEntityOfPage      Url
PotentialAction       List(Any)
SubjectOf             List(Any)

Thing {
    Name
    AlternateName
    Description
    DisambiguatingDescription
    Identifier
    Image
    Url
    SameAs
    AdditionalType
    MainEntityOfPage
    PotentialAction
    SubjectOf
}

#
DataTypes
#

Boolean_  Bool
Text_     String
Number_   Real
Integer   Int
URL       Url
CssSelectorType String
XPathType String
DateTime_ DateTime
Date_     Date
Time_     TimeOfDay
PronounceableText String
DataType Boolean_ | Text_ | Number_ | Integer | URL | DateTime_ | Date_ | Time_

#
Transitions
#

Describe(T Thing, D Text) [ T & { Description D } ]
Rename(T Thing, N Name) [ T & { AlternateName Name, Name N } ]
Link(T Thing, U Url) [ T & { SameAs (Cons { Head U, Tail SameAs }) } ]
Identify(T Thing, I Identifier) [ T & { Identifier I } ]
