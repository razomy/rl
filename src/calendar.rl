#
Concrete Time Units, Calendar, Recurrence & Transitions
#

Minute Unit & { UnitSymbol "min", Dimension "time", Factor 60 }
Hour   Unit & { UnitSymbol "h",   Dimension "time", Factor 3600 }
Day    Unit & { UnitSymbol "d",   Dimension "time", Factor 86400 }
Week   Unit & { UnitSymbol "wk",  Dimension "time", Factor 604800 }
TimeUnit Second | Minute | Hour | Day | Week

Year           Int
MonthIndex     Range(1, 12) & Int
DayOfMonth     Range(1, 31) & Int
HourOfDay      Range(0, 23) & Int
MinuteOfHour   Range(0, 59) & Int
SecondOfMinute Range(0, 60) & Int

Month "january" | "february" | "march" | "april" | "may" | "june"
    | "july" | "august" | "september" | "october" | "november" | "december"
Weekday "monday" | "tuesday" | "wednesday" | "thursday" | "friday" | "saturday" | "sunday"
Weekend "saturday" | "sunday"
Quarter "q1" | "q2" | "q3" | "q4"
DayPart "night" | "morning" | "afternoon" | "evening"

Date {
    Year
    MonthIndex
    DayOfMonth
}
Today Date

TimeOfDay {
    HourOfDay
    MinuteOfHour
    SecondOfMinute
}

TimeZone  String
UtcOffset Range(-720, 840) & Int

DateTime Date & TimeOfDay & { TimeZone, UtcOffset }

CalendarSystem "gregorian" | "julian" | "islamic" | "hebrew" | "chinese" | "persian" | "buddhist" | "hindu"
Era "bce" | "ce"

Calendar {
    CalendarSystem
    TimeZone
    FirstWeekday Weekday
}

Holiday {
    Title String
    Date
}

RecurrenceFrequency "once" | "secondly" | "minutely" | "hourly" | "daily" | "weekly" | "monthly" | "yearly"
RepeatCount Count

Recurrence {
    RecurrenceFrequency
    Every    Count & Positive
    ByDay    List(Weekday)
    ByMonth  List(Month)
    RepeatCount
    Until    Instant
}

Slot { Interval, TimeZone }

Schedule {
    Slot
    Recurrence
    Calendar
}

Elapse(I Instant, D Duration) [
    Instant { Timestamp (Timestamp + D.Value) }
]

Span(I Interval) [
    Duration { Value (End.Timestamp - Start.Timestamp), Unit Second }
]

Plan(X Unscheduled, S Slot) [
    X & Scheduled { Schedule { Slot S } }
]

Reschedule(X Scheduled, S Slot) [
    X & Scheduled { Schedule (Schedule & { Slot S }) }
]

Unplan(X Scheduled) [
    X / Scheduled & Unscheduled Object
]

CheckDeadline(X Scheduled, D Deadline) [
    Now.Timestamp . {
        [ _ > D.Timestamp ] [ X & Overdue { Deadline D } ]
        _                   [ X ]
    }
]

Expire(X Any & { Deadline }) [
    X & Expired { At Now }
]
