ISyntax Any
SyntaxRole Any
SemanticLayer Any
IdRef Any
ReferenceHirn Any
HasFnHashId Any

#
HIR Ontology
0. Panic Try / Throw
1. State Literal, Sequence, Record, Template
2. Operation Unary, Binary, Cast
3. Flow (Logic) Match, Loop, Block
4. FlowOperator Return, Break, Continue, Yield, MatchArm
5. Declaration Shape (Struct/Class/Interface), Function (Lambda/Method), Module
6. Binding Symbol Binding (Const/Alias/Import), Assign
7. Access Reference, Member, Call
8. Modifier Capabilities & Qualifiers
9. Layer Meta, Docs, Annotations
#
IHirNode ISyntax & {
  syntaxRole SyntaxRole
  semanticLayer SemanticLayer
}

// region Data & Expressions & FLow

#
Базовые примитивные значения.

@replaces LiteralAsn
#
LiteralHirn IHirNode & {
  value Any // String, number, boolean, None
}

#
Выполнение операций (математика, логика, сравнение, удаление).

@replaces UnaryAsn - (например, '!', '~', '++') - 1 операнд
@replaces BinaryAsn - (например, '+', '===') - 2 операнда
@replaces SpreadAsn - оператор '...' (1 операнд)
@replaces ShapingAsn - оператор 'typeof', 'as' (1 операнд)
@replaces TemplateAsn - оператор конкатенации '+' над массивом операндов
@replaces AssignAsn - оператор '=' (operands[0] - ReferenceHirn, operands[1] - значение)
@replaces DeleteAsn - оператор 'delete' (1 операнд)
@replaces QueryAsn, ConstraintAsn - оператор паттерн-матчинга (например, 'matches' или 'satisfies')
#
OperatorHirn IHirNode & {
  operator String
  operands IdRef(HirType)[] // Массив решает проблему унарных, бинарных и n-арных операций
}

#
Ветка выполнения внутри MatchHirn.

@replaces ConditionBranchAsn
@replaces ElseBranchAsn (pattern = true / None)
@replaces SwitchBranchAsn
@replaces MatchBranchAsn
@replaces DefaultBranchAsn (pattern = true / None)
@replaces CatchAsn, DefaultCatchAsn - ветки, где pattern - это ошибка или её тип
@replaces FinallyAsn - ветка, срабатывающая всегда при выходе из TryAsn
#
BranchHirn IHirNode & {
  pattern IdRef(HirType) // Условие срабатывания ветки
  value IdRef(HirType) // Значение или SequenceHirn (блок кода)
}

#
Универсальное ветвление и перехват исключений.

@replaces IfAsn - target boolean, branches [BranchHirn, BranchHirn]
@replaces SwitchAsn - target выражение, branches проверки значений
@replaces TernaryAsn - аналогично IfAsn
@replaces TryAsn - target OperatorHirn (name 'try', body SequenceHirn), branches обрабатывают catch/finally
#
MatchHirn IHirNode & {
  target IdRef(HirType)
  branches IdRef(BranchHirn)[]
}

#
Прерывание потока выполнения (прыжки).

@replaces BreakAsn - operator 'break'
@replaces ContinueAsn - operator 'continue'
@replaces YieldAsn - operator 'yield'
@replaces ReturnAsn - operator 'return'
@replaces ThrowAsn - operator 'throw'
#
GoHirn IHirNode & {
  operator 'break' | 'continue' | 'yield' | 'return' | 'throw'
  value IdRef(HirType) | None // Возвращаемое значение для yield, return, throw
}

#
Универсальный цикл.

@replaces DoWhileAsn, WhileDoAsn - condition есть, body есть
@replaces ForIAsn, ForOfAsn, ForItAsn - инициализация выносится до цикла, апдейт ставится в конец body
#
LoopHirn IHirNode & {
  condition IdRef(HirType) | None // Если undefined — бесконечный цикл
  block IdRef(BlockHirn) // Тело цикла
}

#
Последовательность выполнения действий.
Возвращает результат выполнения последнего элемента (решает проблему return).

@replaces BlockAsn
@replaces StyleBlockAsn - стилизация и блоки `{` сворачиваются в этот узел
#
BlockHirn IHirNode & {
  statements IdRef(HirType)[]
}

// endregion Control Flow & FLow

// region Declarations & Entities

#
Базовый интерфейс для идентификаторов (деклараций).

@replaces ModifierAsnTypes - ВСЕ модификаторы вынесены в массив (const, let, export, override, async и т.д.)
@replaces AwaitAsn - превращается в строковый модификатор 'async'
@replaces ExportModifierAsn, OverrideModifierAsn, FunctionModifierAsn,
          ParameterModifierAsn, InheritModifierAsn, InstanceModifierAsn -) все становятся строками в `modifiers`
@replaces MappedAsn - уходит в `shape`
@replaces ILayerAsn (DocsAsn, CommentAsn, FunctionDocsAsn) - уходят в метаданные движка (не являются исполняемым кодом)
#
IIdentityHirn IHirNode & {
  name String | None // Optional для анонимных сущностей (лямбды, элементы массивов)
  modifiers IdRef(HirType)[] // 'const', 'export', 'async', 'generator' и т.д.
}

#
Объявление переменных, параметров, свойств объектов.

@replaces InstanceAsn - (например, let a = 1)
@replaces AliasAsn
@replaces ParameterAsn - используется внутри FunctionHirn.parameters
@replaces PropertyAsn - используется внутри StructHirn.properties
#
BindingHirn(T IdRef(HirType)) IIdentityHirn & {
  shape IdRef(ReferenceHirn) | None // Type/Interface/Constraint
  value T | None // Значение
  doc {
    description String
  }
}

FunctionDocExampleHirn {
  code String
  expected String
}

#
Функции и Лямбды.

@replaces FunctionAsn
@replaces LambdaAsn - то же самое, но `name undefined`
#
FunctionHirn IIdentityHirn & HasFnHashId & {
  parameters IdRef(BindingHirn)[]
  returnShape IdRef(ReferenceHirn) | None
  block IdRef(HirType) | None
  doc{
    title String | None
    description String | None
    returnDescription String | None
    examples FunctionDocExampleHirn[]

  }
}

#
Сложные структуры данных (объекты, классы, массивы, модули).

@replaces ObjectAsn - свойства описаны в properties (BindingHirn)
@replaces ArrayAsn, TupleAsn - properties содержат BindingHirn без `name`
@replaces StructAsn, InterfaceAsn, ClassAsn, EnumAsn
@replaces ModuleAsn - модуль это просто корневой StructHirn
#
StructHirn IIdentityHirn & {
  properties IdRef(HirType)[] // Поля, методы, элементы массива
  doc{
    description String
  }
}

#
Чтение значений, обращение к свойствам, вызовы функций.

@replaces ReferenceAsn - чтение переменной (target = String, args = undefined)
@replaces MemberAsn, ArgumentMemberAsn - доступ к свойству (target = объект, property = ключ)
@replaces CallAsn - вызов функции (target = функция, arguments = [...])
@replaces ImportAsn - системный вызов (например target = 'require', arguments = ['module_name'])
@replaces MacroCallAsn, DecoratorAsn - разворачиваются в обычный CallHirn
#
ReferenceHirn IHirNode & {
  target IdRef(HirType) | None // Название переменной ИЛИ узел (например, результат функции)
  property IdRef(HirType) | None // Для obj.prop или arr[1]
  arguments_ IdRef(HirType)[] // Наличие этого массива (даже []) означает Вызов (Call)
}

// endregion Declarations & Entities

#
Итоговое объединение всех доступных узлов Hirn.
#
HirType
| LiteralHirn
| OperatorHirn
| BlockHirn
| MatchHirn
| BranchHirn
| LoopHirn
| GoHirn
| BindingHirn
| FunctionHirn
| StructHirn
| ReferenceHirn
