_ meta

Cons(T) { Head T, Tail List(T) }
List None | Cons(Any)
List1(A)       Cons { Head A, Tail None }
List2(A, B)    Cons { Head A, Tail List1(B) }
List3(A, B, C) Cons { Head A, Tail List2(B, C) }
