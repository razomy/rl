# Razomy Language

Razomy language is a metaprogramming language that describes entities and behaviors.

This library is a collection of all human entities in Razomy syntax.

## Syntax

### Types

```rl
[UniqName] [VALUE]
Name String

[UniqName] {
  [KEY] [VALUE]
}

Name {
  First String
}

[UniqName] {
  [KEY] [VALUE]
}
& [OTHER1]
& [OTHER2]

HasParentName {
  ParentName String
}

Name {
  First String
} & HasParentName


[UniqName] [BaseType] {
  [KEY] [Override_VALUE]
}

Jonn String

JonnName HasParentName {
  ParentName Jonn
}

JonnDoy Jonn

JonnDoyName1 JonnName {
  ParentName JonnDoy
}

JonnDoyName2 JonnName {
  ParentName JonnDoy
} & { ParentName "JonnDoyBoy" }

// Access
JonnDoyName2.ParentName // JonnDoyBoy
JonnDoyName2.JonnName.ParentName // JonnDoy - inner values
JonnDoyName2.JonnName.HasParentName.ParentName // Jonn - inner values
JonnDoyName2.HasParentName.ParentName // String

JonnDoyName3 JonnDoyName2 & { D "d" }
JonnDoyName3.ParentName  // JonnDoyBoy
JonnDoyName3.JonnDoyName2.JonnName  // everything else

JonnDoyName3.0  // access by index 0 (ParentName)
JonnDoyName3.-1 // access by index -1 (D)


// =============================================================================
// МИНИМАЛИСТИЧНЫЙ ЯЗЫК: АКСИМАТИКА ТРЕХ СКОБОК (FULL SPECIFICATION V2.1)
// =============================================================================
// {} — Форма  (Структуры данных, Таблицы маршрутизации, Модули)
// [] — Поток  (Трансформации, Предикаты, Вычислительные блоки)
// () — Слот   (Захват объекта в переменную, Прием аргументов, Кортежи)
//
// БАЗОВЫЕ ОПЕРАТОРЫ:
// '.'  — Pipeline        (Передача вычисленных данных слева направо: A . B)
// '.>' — Tap Pipeline    (Выполнение сайд-эффекта и пропуск левых данных дальше)
// '.&' — Enrich Pipeline (Вызов функции справа и слияние результата с левым контекстом)
// '&'  — Merge           (Алгебраическое слияние типов или структур)
// '|'  — Union           (Алгебраическая сумма типов / исходов)
// '/'  — Subtract        (Удаление поля из структуры)
// '_'  — Anon Context    (Обращение к анонимному контексту в предикатах и ветка по умолчанию)
//
// 1. ЖЕЛЕЗНОЕ ПРАВИЛО АВТО-РАСПАКОВКИ (AUTO-UNPACKING):
// Поля известной формы автоматически проецируются в локальную область видимости `[]`:
//   а) При совпадении формы в роутере `{}`.
//   б) При передаче объекта напрямую в блок `[]` через `.` или `.>`.
//   в) Внутри тела функции, если входящий слот явно типизирован (напр. `Fn(O Order)` или `Fn(Order)`).
// Символ `_` (анонимный контекст) запрещен для известных форм.
//
// 2. ПРАВИЛО ГЕНЕАЛОГИИ ПРИ СЛИЯНИИ (LINEAGE NAMESPACING):
// При коллизии имен во время слияния `A & B`, уникальные поля доступны плоско,
// а конфликтующие поля требуют указания предка (например, A.Id, B.Id).
//
// 3. ПРАВИЛО БАЙПАСА ИСХОДОВ (SHORT-CIRCUIT / RAILWAY-FREE):
// Если в пайплайн передается сумма типов `A | B`, а следующая функция ожидает
// строго форму `A`, то ветка `B` автоматически пролетает функцию насквозь без вызова,
// накапливаясь в итоговом Union-типе всего потока (авто-проброс ошибок).
// =============================================================================


// =============================================================================
// 1. АЛГЕБРА ДАННЫХ И СТРУКТУРЫ
// =============================================================================

Str ""
Int 0
Float 0.0
Bool false

// Кортежи выражаются через пайплайн-слот
Point2D (Float, Float)
Origin  (0.0, 0.0)

// Суммы типов
Status "draft" | "published" | "archived"
Primitive Str | Int | Float | Bool

Identifiable { Id Str }
Auditable    { CreatedAt Int, UpdatedAt Int }

User {
  Id           Str
  Name         Str
  Age          Int
  Role         Str
  PasswordHash Str
}

PublicUser   User / User.PasswordHash
DatabaseUser User & Identifiable & Auditable


// =============================================================================
// 2. МОДУЛИ И ПРАВИЛА ПРИЕМА АРГУМЕНТОВ
// =============================================================================

Shell {
  Log(Msg)  [ Msg . native_print ]
  Exec(Cmd) [ Cmd . native_exec ]
}

Cart {
  CartId Str
  Amount Int
}

Db {
  // Слот (Id) захватывает входящую строку целиком
  FindUser(Id) [
    { Id Id, Name "Алиса", Age 25 }
  ]

  // Слот (Ctx) захватывает объект. Роутер {} проверяет соответствие форме 
  // Identifiable и автоматически распаковывает поле Id, если совпало.
  FindCart(Ctx) [
    Ctx . {
      Identifiable [ Cart { CartId "c101", Amount 2500 } ]
    }
  ]
}


// =============================================================================
// 3. ВЫЧИСЛЕНИЯ НА ТИПАХ И СТРУКТУРЫ ВЫСШЕГО РОДА (HKT)
// =============================================================================

Zero {}
Succ(N) { Prev N }

One   Succ(Zero)
Two   Succ(One)
Three Succ(Two)

Tuple(T) ()

FixedVector(T, N) {
  Data Tuple(T)
  Length N
}

None {}
Cons(T) {
  Head T
  Tail List(T)
}
List(T) None | Cons(T)

Leaf {}
Node(T) {
  Value T
  Left Tree(T)
  Right Tree(T)
}
Tree(T) Leaf | Node(T)


// =============================================================================
// 4. УТОЧНЯЮЩИЕ ТИПЫ (REFINEMENTS) И АВТО-РОУТИНГ
// =============================================================================

// Используем '_', так как конкретная форма на этапе типа еще не распакована
IsAdult   [ _.Age >= 18 ]
IsMinor   [ _.Age < 18 ]
IsManager [ _.Role . ("admin" | "manager") ]

Adult   User & IsAdult
Minor   User & IsMinor
Manager User & IsManager

ClassifyAccount(Account) [
  Account . {
    // Поле Name доступно автоматически из-за совпадения с типами,
    // которые наследуют структуру User
    Manager [ "Панель управления: {Name}" . Shell.Log ]
    Adult   [ "Взрослый аккаунт: {Name}" . Shell.Log ]
    Minor   [ "Детский аккаунт: {Name}" . Shell.Log ]
    _       [ "Неизвестный профиль" . Shell.Log ]
  }
]

Circle { Radius Float }
Rect   { Width Float, Height Float }
Shape  Circle | Rect

Area(S) [
  S . {
    // Поля Radius, Width и Height автоматически вливаются в скоуп
    Circle [ 3.14159 * Radius * Radius ]
    Rect   [ Width * Height ]
  }
]


// =============================================================================
// 5. ВЫСШИЙ ПОРЯДОК, ФУНКТОРЫ И КАТАМОРФИЗМЫ
// =============================================================================

Some(T) { Value T }
Option(T) Some(T) | None

ListMap(L, Action) [
  L . {
    None [ None ]
    Cons [
      // Head и Tail доступны автоматически.
      // Круглые скобки используются исключительно для изоляции вычислений слота.
      Cons {
        Head (Head . Action)
        Tail (Tail . ListMap(Action))
      }
    ]
  }
]

Num(Val)  { Value Val }
Add(L, R) { Left L, Right R }
Mul(L, R) { Left L, Right R }
Expr Num | Add(Expr, Expr) | Mul(Expr, Expr)

Cata(Expression, Algebra) [
  Expression . {
    // Value, Left и Right распаковываются автоматически
    Num [ Algebra.OnNum(Value) ]
    Add [ Algebra.OnAdd(Left . Cata(Algebra), Right . Cata(Algebra)) ]
    Mul [ Algebra.OnMul(Left . Cata(Algebra), Right . Cata(Algebra)) ]
  }
]

Algebra {
  OnNum(V)    [ V ]
  OnAdd(A, B) [ A + B ]
  OnMul(A, B) [ A * B ]
}


// =============================================================================
// 6. ОБОГАЩЕНИЕ КОНТЕКСТА ('.&') И ОПЕРАТОР ТАПИНГА ('.>')
// =============================================================================

FinalizeBill(Ctx User & Cart) [
  Ctx & {
    Discount [
      Amount . {
        // Анонимный контекст '_' используется только для сырых значений
        [ _ >= 2000 ] [ 300 ]
        [ _ >= 1000 ] [ 100 ]
        _             [ 0 ]
      }
    ]
    FinalPrice [ Amount - Discount ]
  }
  // Контекст (Ctx & Discount & FinalPrice) доступен целиком
  .> [ "Чек для {Name}: {FinalPrice} руб (Скидка: {Discount})" . Shell.Log ]
]

ProcessOrderPipeline(UserId) [
  UserId
  . Db.FindUser    // На выходе: { Id, Name, Age }
  .& Db.FindCart    // Принимает форму, сливает результат: { Id, Name, Age, CartId, Amount }
  . FinalizeBill   // Обрабатывает итоговый агрегат
]


// =============================================================================
// 7. СЛОЖНЫЙ КЕЙС: РЕКУРСИВНЫЙ АВТОНОМНЫЙ AI-АГЕНТ
// =============================================================================

CompileError { Code Int, Log Str }
BuildSuccess { Status Str, Artifact Str }
BuildResult  BuildSuccess | CompileError

FatalError CompileError & [ _.Code >= 500 ]
Warning    CompileError & [ _.Code < 500 ]

AiQuery    { SystemPrompt Str, UserPrompt Str }
AiResponse { Diff Str, Explanation Str }

Ai {
  Call(Query) [ Query . native_ai_llm_request ]
}

RunBuild [ "cargo build --release" . Shell.Exec ]

AgentLoop(Err, Retries) [
  Retries . {
    [ _ == 0 ] [ "Лимит попыток исчерпан. Требуется человек." . Shell.Log ]

    _ [
      AiQuery {
        SystemPrompt "Ты инженер. Исправь ошибку компиляции git diff патчем."
        // Поле Err.Log берется из явно захваченного слота (Err)
        UserPrompt   "Лог ошибки: {Err.Log}. Напиши патч."
      }
      . Ai.Call
      // Результат Ai.Call (AiResponse) прокидывается сквозь '.>'
      // Поля Explanation и Diff распаковываются автоматически для интерполяции
      .> [ "AI предлагает решение: {Explanation}" . Shell.Log ]
      .> [ "git apply {Diff}" . Shell.Exec ]
      . RunBuild
      . {
        BuildSuccess [
          "Билд успешно собран после патча!" . Shell.Log
        ]

        // Захватываем весь новый объект ошибки в слот (NewErr) для рекурсии
        CompileError(NewErr) [
          NewErr
          .> [ "Патч не помог. Запуск следующей попытки..." . Shell.Log ]
          . AgentLoop(Retries - 1)
        ]
      }
    ]
  }
]


// =============================================================================
// 8. РАЗРЕШЕНИЕ КОЛЛИЗИЙ ПРИ СЛИЯНИИ (LINEAGE NAMESPACING)
// =============================================================================

Order { Id Str, Amount Int }

// При слиянии User (см. раздел 1) и Order возникает коллизия поля `Id`.
UserOrder User & Order

ProcessCombined(CombinedContext) [
  CombinedContext . {
    UserOrder [
      // Уникальные поля доступны плоско:
      "Имя клиента: {Name}, Сумма заказа: {Amount}" . Shell.Log

      // Поля с коллизией требуют указания предка (Lineage):
      "User ID: {User.Id}, Order ID: {Order.Id}" . Shell.Log
    ]
  }
]


// =============================================================================
// 9. ДЕКЛАРАТИВНАЯ МИГРАЦИЯ ТИПОВ
// =============================================================================

ClientAccount {
  AccountId Str
  Name      Str
  IsAdult   Bool
}

// Поля с совпадающими именами (Name) мапятся автоматически.
// Авто-распаковка: аргумент типизирован (U User), поэтому Id, Name, Age доступны в скоупе.
MigrateUser(U User) [
  ClientAccount {
    AccountId Id
    IsAdult   (Age >= 18)
  }
]


// =============================================================================
// 10. ОНТОЛОГИЧЕСКАЯ ТИПИЗАЦИЯ (TYPESTATE) И СБОР ИСХОДОВ (RAILWAY-FREE)
// =============================================================================
// Вместо ошибок пайплайн собирает неразрешенные исходы (Outcomes) в Union-тип.

Reserved   { ReservedAt Int }
Paid       { TransactionId Str }

OutOfStock { Reason Str }
NoMoney    { Reason Str }

// Явная типизация аргумента (O Order) запускает Правило 3 (Байпас).
// Поле Amount доступно плоско благодаря Правилу 1 (Авто-распаковка типизированных слотов).
ReserveStock(O Order) [
  Amount . {
    [ _ > 0 ] [ O & Reserved { ReservedAt 1620000000 } ]
    _         [ OutOfStock { Reason "Пустой склад" } ]
  }
]

ChargePayment(O Order) [
  Amount . {
    [ _ < 50000 ] [ O & Paid { TransactionId "tx_001" } ]
    _             [ NoMoney { Reason "Недостаточно средств" } ]
  }
]

// Компилятор автоматически выводит тип результата этой функции:
// (Order & Reserved & Paid) | OutOfStock | NoMoney
// Форма OutOfStock байпасит функцию ChargePayment (т.к. у нее нет формы Order).
// Нам не нужны Result<T, E> монады или try/catch!
ExecuteFulfillment(InitialOrder) [
  InitialOrder
  . ReserveStock
  . ChargePayment
]

// Функция принимает только те заказы, которые одновременно и Зарезервированы, и Оплачены.
// Коллизий нет, поэтому поля Id и TransactionId доступны плоско.
ShipToCustomer(Order & Reserved & Paid) [
  "Доставка заказа {Id}. Транзакция {TransactionId} подтверждена." . Shell.Log
]


// =============================================================================
// ТОЧКА ВХОДА (MAIN PIPELINE)
// =============================================================================

Main [
  "Старт процесса сборки проекта..." . Shell.Log
  . RunBuild
  . {
    // Требуется полная форма для передачи в агент — используем захват (Err)
    FatalError(Err) [
      Err
      .> [ "Критический сбой компиляции ({Err.Code}). Запуск агента..." . Shell.Log ]
      .  AgentLoop(3)
    ]

    // Нужен только лог — используем авто-распаковку поля Log
    Warning [
      "Предупреждения компилятора: {Log}" . Shell.Log
      .> [ "cargo fix --allow-no-vcs" . Shell.Exec ]
      . [ "Автоматический линтинг завершен." . Shell.Log ]
    ]

    BuildSuccess [
      "Проект абсолютно чист. Готово к релизу!" . Shell.Log
    ]
  }
]


// =============================================================================
// ИМПОРТЫ
// =============================================================================

Base root.base     // named import
{Str} root.base    // element import
_ root.base        // all import
_ base             // relative import
_ ../../../base    // relative import
```
