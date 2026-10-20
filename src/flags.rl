#
State Flag Traits
#

HasActive    { IsActive Bool, IsInactive Bool }
HasEnable    { IsEnable Bool, IsDisable Bool }
HasVisible   { IsVisible Bool, IsInvisible Bool }
HasOpened    { IsOpened Bool }
HasDirty     { IsDirty Bool }
HasViewed    { IsViewed Bool }
HasReceived  { IsReceived Bool }
HasAchieved  { IsAchieved Bool }
HasCompleted { IsCompleted Bool }
HasTouched   { IsTouched Bool }
HasSelect    { IsSelect Bool, IsDeselect Bool }
HasFocus     { IsFocus Bool, IsFocusout Bool }
HasHighlight { IsHighlight Bool, IsNotHighlight Bool }
HasValid     { IsValid Bool }
HasLoading   { IsLoading Bool, Progress Float }
