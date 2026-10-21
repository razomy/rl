// Algebraic Expressions & Catamorphisms
Num(Val)  { Value Val }
Add(L, R) { Left L, right R }
Sub(L, R) { Left L, right R }
Mul(L, R) { Left L, right R }
Div(L, R) { Left L, right R }
Expression      Num
| Add(Expression, Expression)
| Sub(Expression, Expression)
| Mul(Expression, Expression)
| Div(Expression, Expression)

Algebra {
  OnNum(V)    [ V ]
  OnAdd(A, B) [ A + B ]
  OnSub(A, B) [ A - B ]
  OnMul(A, B) [ A * B ]
  OnDiv(A, B) [ A / B ]
}

Cata(Expression, Algebra) [
  Expression . {
    Num [ Alg.OnNum(Value) ]
    Add [ Alg.OnAdd(Left . Cata(Alg), Right . Cata(Alg)) ]
    Sub [ Alg.OnSub(Left . Cata(Alg), Right . Cata(Alg)) ]
    Mul [ Alg.OnMul(Left . Cata(Alg), Right . Cata(Alg)) ]
    Div [ Alg.OnDiv(Left . Cata(Alg), Right . Cata(Alg)) ]
  }
]
