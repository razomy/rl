#
Abstract Temporal Points, Intervals, Schedules & Typestates
#

Timestamp Long
Instant   { Timestamp }
Now       Instant
Duration  Measure(Real & NonNegative, Second)

Start Instant
End   Instant
Interval     { Start, End } & [ _.End.Timestamp >= _.Start.Timestamp ]
OpenInterval { Start }

Deadline Instant
Timeline List(Instant)

Scheduled   { Schedule }
Unscheduled Object
Overdue     { Deadline }
Expired     { At Instant }
