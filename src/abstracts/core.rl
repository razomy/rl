_ abstracts.meta

Int Number

Cons(T) { Head T, Tail List(T) }
List(T) None | Cons(T)
List1(A)       Cons { Head A, Tail None }
List2(A, B)    Cons { Head A, Tail List1(B) }
List3(A, B, C) Cons { Head A, Tail List2(B, C) }

Shell {
  Log(Msg)  [ Msg . native_print ]
  Exec(Cmd) [ Cmd . native_exec ]
}
