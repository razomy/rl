#
Core Traits, identity References & Structural Mixins
#

PrimaryId(T) { Id String }
ForeignId(T) { Id String }
IdRef(T)     { Id String }

IResource        Object
IAttribute       Object
IEntity          { Id String }
Identifiable     { Id String }
Auditable        { CreatedAt Int, updatedAt Int }
Versioned        { Version Int }
SoftDeletable    { DeletedAt Option(Int), isDeleted Bool }
Timestamped      Auditable & SoftDeletable
Named            { Name String }
Tagged           { Tags List(String) }
Metadata         { MetaMap Map(String, Any) }

HasId(T)         { Id T }
HasPrimary(T)    { PrimaryId PrimaryId(T) }
HasForeign(T)    { EntityId ForeignId(T) }
HasName          { Name String }
HasFullName      { FullName String }
HasTitle         { Title String }
HasDescription   { Description String }
HasSlug          { Slug String }
HasValue(T)      { Value T }
HasCount         { Count Int }
HasRange         { From Int, to Int }
HasMetadata      { Metadata Any }

ExtendsEntity(TBase, TSelf)      IEntity & HasPrimary(TSelf) & HasForeign(TBase)
ExtendsCountEntity(TBase, TSelf) ExtendsEntity(TBase, TSelf) & HasCount
ExtendsRangeEntity(TBase, TSelf) ExtendsEntity(TBase, TSelf) & HasRange
