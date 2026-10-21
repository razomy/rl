#
Concrete Person Roles & Life Transitions
#

Patient   Person & { Diagnosis List(Thing), drug List(Thing), healthCondition List(Thing) }
Employee_ Person & { WorksFor List1(Organization) }
Student   Person & { AlumniOf List(EducationalOrganization) }
Author_   Person
Athlete   Person
Musician  Person
Actor_    Person

BirthOf(p Person, where Place) [ p & Alive { Since Now } & { BirthDate Today, birthPlace Where } ]
DeathOf(p Person & Alive, where Place) [ P / Alive & { DeathDate Today, deathPlace Where } ]
Hire(p Person, o Organization, title String) [ p & { WorksFor (Cons { Head O, tail WorksFor }), jobTitle Title } ]
Fire(p Person, o Organization) [ p & { WorksFor (WorksFor / O), jobTitle None } ]
Promote(p Person, title String) [ p & { JobTitle Title } ]
Graduate(p Person, s EducationalOrganization) [ p & { AlumniOf (Cons { Head S, tail AlumniOf }) } ]
MarryPerson(a Person, b Person) [ List2(A & { Spouse B }, B & { Spouse A }) ]
HaveChild(a Person, b Person, c Person) [ c & { Parent List2(A, B) } ]
Meet(a Person, b Person) [ a & { Knows (Cons { Head B, tail Knows }) } ]
FollowPerson(a Person, b Person) [ a & { Follows (Cons { Head B, tail Follows }) } ]
MoveHome(p Person, l Place) [ p & { HomeLocation L } ]
Naturalise(p Person, c Country) [ p & { Nationality C } ]
Admit(p Person) [ Patient & P ]
Discharge_(p Patient) [ P / Patient ]
