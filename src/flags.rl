#
State Flag Traits
#

HasActive    { IsActive Bool, isInactive Bool }
HasEnable    { IsEnable Bool, isDisable Bool }
HasVisible   { IsVisible Bool, isInvisible Bool }
HasOpened    { IsOpened Bool }
HasDirty     { IsDirty Bool }
HasViewed    { IsViewed Bool }
HasReceived  { IsReceived Bool }
HasAchieved  { IsAchieved Bool }
HasCompleted { IsCompleted Bool }
HasTouched   { IsTouched Bool }
HasSelect    { IsSelect Bool, isDeselect Bool }
HasFocus     { IsFocus Bool, isFocusout Bool }
HasHighlight { IsHighlight Bool, isNotHighlight Bool }
HasValid     { IsValid Bool }
HasLoading   { IsLoading Bool, progress Float }
