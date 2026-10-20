#
Abstract Thing (schema.org root)
#

Description               Text
DisambiguatingDescription Text
AlternateName             Name
SameAs                    List(Url)
AdditionalType            Url
MainEntityOfPage          Url
PotentialAction           List(Any)
SubjectOf                 List(Any)

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
