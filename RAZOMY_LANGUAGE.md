# Razomy Language [Under construction]

Razomy language is a metaprogramming language that describes entities and behaviors.

This library is a collection of all human entities in Razomy Language syntax.

## Syntax

### Types & Core Axioms

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


#
MINIMALIST LANGUAGE: AXIOMATICS OF THREE BRACKETS (FULL SPECIFICATION V3.0)
#
// {} — Form   (Data structures, Routing tables, Pattern Matching, Modules, Maps)
// [] — Stream (Transformations, Predicates, Computation blocks, Generators)
// () — Slot   (Capturing objects into variables, Accepting arguments, Tuples, Isolation)
//
// CORE OPERATORS:
// '.'   — Pipeline          (Pass computed data left-to-right: A . B)
// '.>'  — Tap Pipeline      (Execute side-effect and pass left data further)
// '.&'  — Enrich Pipeline   (Call right function and merge result with left context)
// '.|'  — Parallel Pipeline (Fan-out / Concurrent execution of branches in `{}`)
// '.?'  — Safe/Filter Pipe  (Pass further only if predicate/type matches, else None)
// '&'   — Merge             (Algebraic intersection/merge of types or structures)
// '|'   — Union             (Algebraic sum of types / outcomes)
// '/'   — Subtract          (Remove field from structure or type from union)
// '_'   — Anon Context      (Reference anonymous context in predicates and default branch)
// '..'  — Range / Spread    (Generate sequences `1..10` or spread collections)
// ' . '   — Meta / Decorator  (Attach metadata, macros, or compiler directives to forms)
//
// 1. IRON RULE OF AUTO-UNPACKING:
// Fields of a known form are automatically projected into the local scope `[]`:
//   a) Upon form match inside a router `{}`.
//   b) When passing an object directly into a block `[]` via `.` or `.>`.
//   c) Inside a function body if the incoming slot is explicitly typed (`Fn(O Order)` or `Fn(Order)`).
// The `_` symbol (anonymous context) is strictly forbidden for known forms.
//
// 2. LINEAGE NAMESPACING RULE:
// Upon name collision during merge `A & B`, unique fields are accessed flatly,
// while conflicting fields require specifying the ancestor (e.g., A.Id, B.Id).
//
// 3. OUTCOME BYPASS RULE (SHORT-CIRCUIT / RAILWAY-FREE):
// If a union type `A | B` is passed into a pipeline, and the next function strictly
// expects form `A`, branch `B` automatically bypasses the function without invocation,
// accumulating in the final Union type of the entire stream (auto-error propagation).
// =============================================================================


#
1. DATA ALGEBRA, PRIMITIVES, AND STRUCTURES
#

String   ""
Int   0
Float 0.0
Bool  false
Byte  0x00
Any   _

// Tuples are expressed via pipeline-slots
Point2D (Float, Float)
Origin  (0.0, 0.0)

// Type Unions (Sum Types)
Status    "draft" | "published" | "archived"
Primitive String | Int | Float | Bool | Byte

Identifiable { Id String }
Auditable    { CreatedAt Int, UpdatedAt Int }

User {
  Id           String
  Name         String
  Age          Int
  Role         String
  PasswordHash String
}

// Type Subtraction ('/') and Intersection ('&')
PublicUser   User / User.PasswordHash
DatabaseUser User & Identifiable & Auditable
GuestUser    PublicUser / PublicUser.Role & { Role "guest" }


#
2. ALL PRIMITIVE OPERATIONS (ARITHMETIC, LOGIC, BITWISE, STRINGS)
#

MathOps(A Int, B Int) [
  {
    Add (A + B)
    Sub (A - B)
    Mul (A * B)
    Div (A / B)
    Mod (A % B)
    Pow (A ** B)

    // Bitwise operations
    BitAnd (A . bit_and(B))
    BitOr  (A . bit_or(B))
    BitXor (A . bit_xor(B))
    ShiftL (A << 2)
    ShiftR (A >> 2)
  }
]

LogicOps(X Bool, Y Bool, Val Int) [
  {
    And (X && Y)
    Or  (X || Y)
    Not (!X)
    Eq  (Val == 42)
    Neq (Val != 0)
    Gt  (Val > 10)
    Gte (Val >= 10)
    Lt  (Val < 100)
    Lte (Val <= 100)
    InRange (Val . (1..100)) // Pattern check against range
  }
]

StringOps(First String, Last String) [
  Full "{First} {Last}" // Native interpolation
  Full
  . Trim
  . ToUpper
  . Split(" ")
]

StringOpsBi(First String, Last String) [
  Full "{First} {Last}" // Native interpolation
  Full
  & Trim // bi-directinal
  & ToUpper
  . Split(" ") // sequencial
]


#
3. MODULES AND ARGUMENT ACCEPTANCE RULES
#

Shell {
  Log(Msg)  [ Msg . native_print ]
  Exec [ _ . native_exec ]
}

Cart {
  CartId String
  Amount Int
}

Db {
  // Slot (Id) captures the incoming string in its entirety
  FindUser(Id) [
    { Id Id, Name "Alice", Age 25 }
  ]

  // Slot (Ctx) captures the object. Router {} checks conformance to the
  // Identifiable form and automatically unpacks the Id field if matched.
  FindCart(Ctx) [
    Ctx . {
      Identifiable [ Cart { CartId "c101", Amount 2500 } ]
    }
  ]
}


#
4. TYPE-LEVEL COMPUTATIONS AND HIGHER-KINDED TYPES (HKT)
#

Zero {}
Succ(N) { Prev N }

One   Succ(Zero)
Two   Succ(One)
Three Succ(Two)

Tuple(T) ()

FixedVector(T, N) {
  Data   Tuple(T)
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
  Left  Tree(T)
  Right Tree(T)
}
Tree(T) Leaf | Node(T)

// Generic Key-Value Map and Set
Map(K, V) { (K) V }
Set(T)    { (T) Bool }


#
5. REFINEMENT TYPES AND AUTO-ROUTING
#

// Use '_' because the concrete form is not yet unpacked at the type definition stage
IsAdult   [ _.Age >= 18 ]
IsMinor   [ _.Age < 18 ]
IsManager [ _.Role . ("admin" | "manager") ]
NonEmpty  [ _.Length > 0 ]
EmailStr  String & [ _ . Regex.Matches("^[^@]+@[^@]+\.[^@]+$") ]

Adult   User & IsAdult
Minor   User & IsMinor
Manager User & IsManager

ClassifyAccount(Account) [
  Account . {
    // Field 'Name' is available automatically due to matching types
    // that inherit the User structure
    Manager [ "Dashboard: {Name}" . Shell.Log ]
    Adult   [ "Adult account: {Name}" . Shell.Log ]
    Minor   [ "Child account: {Name}" . Shell.Log ]
    _       [ "Unknown profile" . Shell.Log ]
  }
]

Circle { Radius Float }
Rect   { Width Float, Height Float }
Shape  Circle | Rect

Area(S) [
  S . {
    // Fields Radius, Width, and Height are automatically projected into scope
    Circle [ 3.14159 * Radius * Radius ]
    Rect   [ Width * Height ]
  }
]


#
6. HIGHER-ORDER FUNCTIONS, FUNCTORS, AND CATAMORPHISMS
#

Some(T)   { Value T }
Option(T) Some(T) | None

ListMap(L, Action) [
  L . {
    None [ None ]
    Cons [
      // Head and Tail are available automatically.
      // Parentheses are used exclusively to isolate slot computations.
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
Expr      Num | Add(Expr, Expr) | Mul(Expr, Expr)

Cata(Expression, Algebra) [
  Expression . {
    // Value, Left, and Right are unpacked automatically
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


#
7. COLLECTIONS, STREAMS, GENERATORS, AND PIPELINE ITERATION
#
// Replaces traditional for/while loops with declarative stream pipelines.

Item  { Name String, Price Int, InStock Bool }
OrderList [
  Item { Name "Laptop", Price 1200, InStock true }
  Item { Name "Mouse",  Price 25,   InStock false }
  Item { Name "Screen", Price 400,  InStock true }
]

CalculateTotalInStock(Items) [
  Items
  . Filter([ _.InStock == true ])
  . Map([ _.Price ])
  . Fold(0, (Acc, Price) [ Acc + Price ])
]

// Range generator andcomprehension
FizzBuzz(Limit Int) [
  (1..Limit) . Map(N [
    (N % 3, N % 5) . {
      (0, 0) [ "FizzBuzz" ]
      (0, _) [ "Fizz" ]
      (_, 0) [ "Buzz" ]
      _      [ "{N}" ]
    }
  ])
]

// Dictionary / Map Manipulation
ConfigMap {
  "host" "localhost"
  "port" "8080"
}

UpdatedConfig ConfigMap & { "port" "9090", "tls" "true" } / "host"


#
8. CONTEXT ENRICHMENT ('.&') AND TAPPING OPERATOR ('.>')
#

FinalizeBill(Ctx User & Cart) [
  Ctx & {
    Discount [
      Amount . {
        // Anonymous context '_' is used only for raw/primitive values
        [ _ >= 2000 ] [ 300 ]
        [ _ >= 1000 ] [ 100 ]
        _             [ 0 ]
      }
    ]
    FinalPrice [ Amount - Discount ]
  }
  // Context (Ctx & Discount & FinalPrice) is available in its entirety
  .> [ "Receipt for {Name}: {FinalPrice} USD (Discount: {Discount})" . Shell.Log ]
]

ProcessOrderPipeline(UserId) [
  UserId
  . Db.FindUser    // Output: { Id, Name, Age }
  .& Db.FindCart   // Accepts form, merges result: { Id, Name, Age, CartId, Amount }
  . FinalizeBill   // Processes the final aggregate
]


#
9. LINEAGE NAMESPACING (COLLISION RESOLUTION UPON MERGE)
#

Order { Id String, Amount Int }

// Merging User (see section 1) and Order causes a collision on the `Id` field.
UserOrder User & Order

ProcessCombined(CombinedContext) [
  CombinedContext . {
    UserOrder [
      // Unique fields are accessed flatly:
      "Client Name: {Name}, Order Amount: {Amount}" . Shell.Log

      // Colliding fields require specifying the ancestor (Lineage):
      "User ID: {User.Id}, Order ID: {Order.Id}" . Shell.Log
    ]
  }
]


#
10. DECLARATIVE TYPE MIGRATION AND STRUCTURAL PROJECTION
#

ClientAccount {
  AccountId String
  Name      String
  IsAdult   Bool
}

// Fields with matching names (Name) are mapped automatically.
// Auto-unpacking: argument is typed (U User), so Id, Name, Age are in scope.
MigrateUser(U User) [
  ClientAccount {
    AccountId Id
    IsAdult   (Age >= 18)
  }
]


#
11. ONTOLOGICAL TYPING (TYPESTATE) & OUTCOME COLLECTION (RAILWAY-FREE)
#
// Instead of exceptions, the pipeline collects unresolved outcomes into a Union.

Reserved   { ReservedAt Int }
Paid       { TransactionId String }

OutOfStock { Reason String }
NoMoney    { Reason String }

// Explicit typing of argument (O Order) triggers Rule 3 (Bypass).
// Field Amount is flatly accessible thanks to Rule 1 (Auto-unpacking of typed slots).
ReserveStock(O Order) [
  Amount . {
    [ _ > 0 ] [ O & Reserved { ReservedAt 1620000000 } ]
    _         [ OutOfStock { Reason "Warehouse empty" } ]
  }
]

ChargePayment(O Order) [
  Amount . {
    [ _ < 50000 ] [ O & Paid { TransactionId "tx_001" } ]
    _             [ NoMoney { Reason "Insufficient funds" } ]
  }
]

// Compiler automatically infers the return type of this function:
// (Order & Reserved & Paid) | OutOfStock | NoMoney
// The OutOfStock form bypasses ChargePayment (since it lacks the Order form).
// We do not need Result<T, E> monads or try/catch!
ExecuteFulfillment(InitialOrder) [
  InitialOrder
  . ReserveStock
  . ChargePayment
]

// Function accepts only orders that are simultaneously Reserved and Paid.
// No collisions exist, so Id and TransactionId are accessed flatly.
ShipToCustomer(Order & Reserved & Paid) [
  "Shipping order {Id}. Transaction {TransactionId} confirmed." . Shell.Log
]


#
12. CONCURRENCY, PARALLELISM ('.|'), AND CHANNELS
#

FetchProfile(Id String)         [ Http.Get("https://api.ex/users/{Id}") ]
FetchRecommendations(Id String) [ Http.Get("https://api.ex/recs/{Id}") ]
FetchAds()                   [ Http.Get("https://api.ex/ads") ]

// Parallel Fan-Out Operator '.|': executes all branches in '{}' concurrently
// and merges their results using '&' when all complete.
LoadDashboardData(UserId String) [
  UserId .| {
    Profile [ _ . FetchProfile ]
    Recs    [ _ . FetchRecommendations ]
    Ads     [ FetchAds() ]
  }
  // Output type: { Profile ..., Recs ..., Ads ... }
]

// CSP Channels and Actors for stateful concurrency
Channel(T) {
  Send(Val T) [ (Self, Val) . native_chan_send ]
  Recv()      [ Self . native_chan_recv ]
}

WorkerLoop(Jobs Channel(String), Results Channel(Int)) [
  Jobs.Recv() . {
    None [ "Channel closed, terminating worker." . Shell.Log ]
    Some [
      Value
      . Length
      .> (Len [ Results.Send(Len) ])
      . [ WorkerLoop(Jobs, Results) ] // Tail-recursive actor loop
    ]
  }
]


#
13. STATE MANAGEMENT (PURE STATE TRANSITIONS & ATOMS)
#
// Razomy avoids mutable variables; state is managed via recursive stream loops
// or thread-safe transactional Atoms.

CounterState { Count Int }
Increment    { By Int }
Decrement    { By Int }
Reset        {}
CounterMsg   Increment | Decrement | Reset

// Pure Reducer
UpdateCounter(State CounterState, Msg CounterMsg) [
  Msg . {
    Increment [ CounterState { Count (State.Count + By) } ]
    Decrement [ CounterState { Count (State.Count - By) } ]
    Reset     [ CounterState { Count 0 } ]
  }
]

// Managed Transactional Reference (Atom)
Atom(T) {
  Read()          [ Self . native_atom_read ]
  Swap(Transition)[ (Self, Transition) . native_atom_swap ]
}

GlobalCounter Atom(CounterState { Count 0 })

ModifyGlobalCounter() [
  GlobalCounter.Swap(State [ UpdateCounter(State, Increment { By 5 }) ])
]


#
14. RESOURCE MANAGEMENT, I/O, AND SCOPED LIFETIMES
#

FileHandle { Fd Int, Path String }
IoError    { Msg String }

Fs {
  Open(Path String)            [ Path . native_fs_open ] // Returns FileHandle | IoError
  Read(F FileHandle)        [ Fd . native_fs_read ]   // Returns String | IoError
  Close(F FileHandle)       [ Fd . native_fs_close ]

  // Bracket pattern: guarantees resource cleanup regardless of outcome
  WithFile(Path String, Action) [
    Path . Fs.Open . {
      FileHandle(F) [
        F . Action
        .> [ F . Fs.Close ] // Executed as a tap effect even if Action returns an Error form
      ]
      // IoError automatically bypasses via Rule 3
    }
  ]
}

ReadConfig(Path String) [
  Fs.WithFile(Path, F [
    F . Fs.Read . Json.Parse
  ])
]


#
15. WEB SERVER, ROUTING, AND MIDDLEWARE PIPELINES
#

HttpRequest {
  Method  "GET" | "POST" | "PUT" | "DELETE"
  Path    List(String)
  Headers Map(String, String)
  Body    String
}

HttpResponse { Status Int, Body String }
Unauthorized { Reason String }

// Middleware enriches the request with an AuthenticatedUser or returns Unauthorized
AuthMiddleware(Req HttpRequest) [
  Req.Headers . Map.Get("Authorization") . {
    Some [ Req & { AuthUser (Value . Db.FindUserByToken) } ]
    None [ Unauthorized { Reason "Missing Authorization Header" } ]
  }
]

// Declarative HTTP Router using Form pattern matching
ApiRouter(Req HttpRequest) [
  Req . {
    // Public route
    { Method "GET", Path ["health"] } [
      HttpResponse { Status 200, Body "OK" }
    ]

    // Protected routes (piped through AuthMiddleware)
    { Method "GET", Path ["users", Id] } [
      Req . AuthMiddleware . {
        Unauthorized [ HttpResponse { Status 401, Body Reason } ]
        HttpRequest  [
          Id . Db.FindUser . Json.Encode . (JsonStr [
            HttpResponse { Status 200, Body JsonStr }
          ])
        ]
      }
    ]

    _ [ HttpResponse { Status 404, Body "Not Found" } ]
  }
]


#
16. METAPROGRAMMING, REFLECTION, AND AST MACROS ('.')
#
// Since Everything is a Form, Razomy code can inspect and generate Razomy types.

// Macro that automatically generates JSON serialization for any Form
DeriveJson(TargetForm) [
  TargetForm & {
    ToJson() [
      Self . Meta.FieldsOf . Map(Field [
        "\"{Field.Name}\": {Field.Value . Json.FormatValue}"
      ])
      . Join(", ")
      . (Inner [ "\{ {Inner} \}" ])
    ]
  }
]

Product {
  Id    Int
  Title String
} . DeriveJson

// Reflection: Inspecting fields at runtime/compile-time
InspectEntity(Entity) [
  Entity . Meta.TypeOf . {
    TypeName [ "Inspecting type: {TypeName}" . Shell.Log ]
  }
  Entity . Meta.FieldsOf . ForEach(F [
    "Field {F.Name} has type {F.Type} and value {F.Value}" . Shell.Log
  ])
]


#
17. TESTING AND PROPERTY-BASED ASSERTIONS
#

TestPassed { Name String }
TestFailed { Name String, Expected Any, Actual Any }
TestResult TestPassed | TestFailed

AssertEq(Name String, Expected, Actual) [
  (Expected == Actual) . {
    true  [ TestPassed { Name Name } ]
    false [ TestFailed { Name Name, Expected Expected, Actual Actual } ]
  }
]

RunTestSuite() [
  [
    AssertEq("Math Addition", 4, (2 + 2))
    AssertEq("Area of Rect", 20.0, (Rect { Width 4.0, Height 5.0 } . Area))
    AssertEq("User Migration", true, (User { Id "1", Name "Bob", Age 20, Role "user", PasswordHash "x" } . MigrateUser . _.IsAdult))
  ]
  . ForEach(Result [
    Result . {
      TestPassed [ "[PASS] {Name}" . Shell.Log ]
      TestFailed [ "[FAIL] {Name}: Expected {Expected}, got {Actual}" . Shell.Log ]
    }
  ])
]


#
18. COMPLEX CASE: RECURSIVE AUTONOMOUS AI AGENT
#

CompileError { Code Int, Log String }
BuildSuccess { Status String, Artifact String }
BuildResult  BuildSuccess | CompileError

FatalError CompileError & [ _.Code >= 500 ]
Warning    CompileError & [ _.Code < 500 ]

AiQuery    { SystemPrompt String, UserPrompt String }
AiResponse { Diff String, Explanation String }

Ai {
  Call(Query) [ Query . native_ai_llm_request ]
}

RunBuild [ "cargo build --release" . Shell.Exec ]

AgentLoop(Err, Retries) [
  Retries . {
    [ _ == 0 ] [ "Retry limit reached. Human intervention required." . Shell.Log ]

    _ [
      AiQuery {
        SystemPrompt "You are an engineer. Fix the compilation error with a git diff patch."
        // Field Err.Log is taken from the explicitly captured slot (Err)
        UserPrompt   "Error log: {Err.Log}. Write a patch."
      }
      . Ai.Call
      // Result of Ai.Call (AiResponse) passes through '.>'
      // Fields Explanation and Diff are unpacked automatically for interpolation
      .> [ "AI suggests solution: {Explanation}" . Shell.Log ]
      .> [ "git apply {Diff}" . Shell.Exec ]
      . RunBuild
      . {
        BuildSuccess [
          "Build succeeded after applying patch!" . Shell.Log
        ]

        // Capture the entire new error object into slot (NewErr) for recursion
        CompileError(NewErr) [
          NewErr
          .> [ "Patch did not help. Starting next attempt..." . Shell.Log ]
          . AgentLoop(Retries - 1)
        ]
      }
    ]
  }
]


#
19. ENTRY POINT (MAIN PIPELINE)
#

Main [
  "Starting test suite..." . Shell.Log
  . RunTestSuite
  . [ "Starting project build process..." . Shell.Log ]
  . RunBuild
  . {
    // Full form is required to pass into the agent — use slot capture (Err)
    FatalError(Err) [
      Err
      .> [ "Critical compilation failure ({Err.Code}). Launching agent..." . Shell.Log ]
      .  AgentLoop(3)
    ]

    // Only the log is needed — use auto-unpacking of the Log field
    Warning [
      "Compiler warnings: {Log}" . Shell.Log
      .> [ "cargo fix --allow-no-vcs" . Shell.Exec ]
      .  [ "Automatic linting completed." . Shell.Log ]
    ]

    BuildSuccess [
      "Project is completely clean. Ready for release!" . Shell.Log
    ]
  }
]


#
20. IMPORTS & MODULE SYSTEM
#
// Import are auto by default
// if there is name conflic u can specify
Base root.base             // Named import
{String, Int} root.base       // Element import
_ root.base                // Wildcard import (all)
_ base                     // Relative import
_ ../../../base            // Deep relative import
Http std.net.http          // Standard library import
```
