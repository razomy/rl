
#
Core Traits & Structural Mixins
#

PrimaryId(T) { Id String }
ForeignId(T) { Id String }
IdRef(T)     { Id String }

IResource        {}
IAttribute       {}
IEntity          { Id String }
Identifiable     { Id String }
Auditable        { CreatedAt Int, UpdatedAt Int }
Versioned        { Version Int }
SoftDeletable    { DeletedAt Option(Int), IsDeleted Bool }
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
HasRange         { From Int, To Int }
HasMetadata      { Metadata Any }

// State Flag Traits
HasActive     { IsActive Bool, IsInactive Bool }
HasEnable     { IsEnable Bool, IsDisable Bool }
HasVisible    { IsVisible Bool, IsInvisible Bool }
HasOpened     { IsOpened Bool }
HasDirty      { IsDirty Bool }
HasViewed     { IsViewed Bool }
HasReceived   { IsReceived Bool }
HasAchieved   { IsAchieved Bool }
HasCompleted  { IsCompleted Bool }
HasTouched    { IsTouched Bool }
HasSelect     { IsSelect Bool, IsDeselect Bool }
HasFocus      { IsFocus Bool, IsFocusout Bool }
HasHighlight  { IsHighlight Bool, IsNotHighlight Bool }
HasValid      { IsValid Bool }
HasLoading    { IsLoading Bool, Progress Float }

ExtendsEntity(TBase, TSelf)      IEntity & HasPrimary(TSelf) & HasForeign(TBase)
ExtendsCountEntity(TBase, TSelf) ExtendsEntity(TBase, TSelf) & HasCount
ExtendsRangeEntity(TBase, TSelf) ExtendsEntity(TBase, TSelf) & HasRange
