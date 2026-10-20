#
Concrete Person Roles & Life Transitions
#

Patient   Person & { Diagnosis List(Thing), Drug List(Thing), HealthCondition List(Thing) }
Employee_ Person & { WorksFor List1(Organization) }
Student   Person & { AlumniOf List(EducationalOrganization) }
Author_   Person
Athlete   Person
Musician  Person
Actor_    Person

BirthOf(P Person, Where Place) [ P & Alive { Since Now } & { BirthDate Today, BirthPlace Where } ]
DeathOf(P Person & Alive, Where Place) [ P / Alive & { DeathDate Today, DeathPlace Where } ]
Hire(P Person, O Organization, Title String) [ P & { WorksFor (Cons { Head O, Tail WorksFor }), JobTitle Title } ]
Fire(P Person, O Organization) [ P & { WorksFor (WorksFor / O), JobTitle None } ]
Promote(P Person, Title String) [ P & { JobTitle Title } ]
Graduate(P Person, S EducationalOrganization) [ P & { AlumniOf (Cons { Head S, Tail AlumniOf }) } ]
MarryPerson(A Person, B Person) [ List2(A & { Spouse B }, B & { Spouse A }) ]
HaveChild(A Person, B Person, C Person) [ C & { Parent List2(A, B) } ]
Meet(A Person, B Person) [ A & { Knows (Cons { Head B, Tail Knows }) } ]
FollowPerson(A Person, B Person) [ A & { Follows (Cons { Head B, Tail Follows }) } ]
MoveHome(P Person, L Place) [ P & { HomeLocation L } ]
Naturalise(P Person, C Country) [ P & { Nationality C } ]
Admit(P Person) [ Patient & P ]
Discharge_(P Patient) [ P / Patient ]
