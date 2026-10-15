_ thing
_ intangible
_ place
_ creative_work
_ action

// =============================================================================
// Create / Update / Move / Consume / Organize / Play / Search ...
// =============================================================================

CreateAction Action
CookAction    CreateAction & { FoodEstablishment_ Thing, Recipe }
DrawAction    CreateAction
FilmAction    CreateAction
PaintAction   CreateAction
PhotographAction CreateAction
WriteAction   CreateAction & { InLanguage Language }

UpdateAction Action & { TargetCollection Thing }
AddAction     UpdateAction
InsertAction  AddAction & { ToLocation Place }
AppendAction  InsertAction
PrependAction InsertAction
DeleteAction  UpdateAction
ReplaceAction UpdateAction & { Replacee Thing, Replacer Thing }

MoveAction Action & { FromLocation Place, ToLocation Place }
ArriveAction MoveAction
DepartAction MoveAction
TravelAction MoveAction & { Distance_ }

ConsumeAction Action & { ActionAccessibilityRequirement Thing, ExpectsAcceptanceOf Thing }
DrinkAction   ConsumeAction
EatAction     ConsumeAction
InstallAction ConsumeAction
ListenAction  ConsumeAction
PlayGameAction ConsumeAction
ReadAction    ConsumeAction
UseAction     ConsumeAction
WearAction    UseAction
ViewAction    ConsumeAction
WatchAction   ConsumeAction

OrganizeAction Action
AllocateAction OrganizeAction
AcceptAction  AllocateAction
AssignAction  AllocateAction
AuthorizeAction AllocateAction & { Recipient Agent }
RejectAction  AllocateAction
ApplyAction   OrganizeAction
BookmarkAction OrganizeAction
PlanAction    OrganizeAction & { ScheduledTime DateTime }
CancelAction  PlanAction
ReserveAction PlanAction
ScheduleAction PlanAction

PlayAction Action & { Audience, Event_ Thing }
ExerciseAction PlayAction & { Course_ Place, Diet_, Distance_, ExercisePlan, ExerciseType String, Opponent Agent, SportsActivityLocation_ Place }
PerformAction  PlayAction

SearchAction Action & { Query String }
FindAction Action
CheckAction    FindAction
DiscoverAction FindAction
TrackAction    FindAction & { DeliveryMethod }

AchieveAction Action
LoseAction    AchieveAction & { Winner Agent }
TieAction     AchieveAction
WinAction     AchieveAction & { Loser Agent }

ControlAction Action
ActivateAction   ControlAction
DeactivateAction ControlAction
ResumeAction     ControlAction
SuspendAction    ControlAction

SolveMathAction Action & { EduQuestionType String }
SeekToAction Action & { StartOffset Real }

// =============================================================================
// Transitions
// =============================================================================

Create(A Agent, R Thing) [ CreateAction { Agent A, Result R, ActionStatus "CompletedActionStatus" } ]
Update(A Agent, T Thing, C Thing) [ UpdateAction { Agent A, Object T, TargetCollection C } ]
Delete(A Agent, T Thing, C Thing) [ DeleteAction { Agent A, Object T, TargetCollection C } ]
Replace(A Agent, Old Thing, New Thing) [ ReplaceAction { Agent A, Replacee Old, Replacer New } ]
MoveTo(A Agent, From Place, To Place) [ MoveAction { Agent A, FromLocation From, ToLocation To } ]
Arrive(A Agent, To Place) [ ArriveAction { Agent A, ToLocation To } ]
Depart(A Agent, From Place) [ DepartAction { Agent A, FromLocation From } ]
Consume(A Agent, T Thing) [ ConsumeAction { Agent A, Object T } ]
ReadWork(A Agent, W CreativeWork) [ ReadAction { Agent A, Object W } ]
Watch(A Agent, W CreativeWork) [ WatchAction { Agent A, Object W } ]
Listen(A Agent, W CreativeWork) [ ListenAction { Agent A, Object W } ]
Accept(A Agent, T Thing) [ AcceptAction { Agent A, Object T } ]
Reject(A Agent, T Thing) [ RejectAction { Agent A, Object T } ]
Bookmark(A Agent, T Thing) [ BookmarkAction { Agent A, Object T } ]
PlanAt(A Agent, T Thing, W DateTime) [ ScheduleAction { Agent A, Object T, ScheduledTime W } ]
Play_(A Agent, G Thing) [ PlayAction { Agent A, Object G } ]
Search(A Agent, Q String) [ SearchAction { Agent A, Query Q } ]
Discover(A Agent, T Thing) [ DiscoverAction { Agent A, Result T } ]
Win(A Agent, L Agent) [ WinAction { Agent A, Loser L } ]
Lose(A Agent, W Agent) [ LoseAction { Agent A, Winner W } ]
Activate(A Agent, T Thing) [ ActivateAction { Agent A, Object T } ]
Deactivate(A Agent, T Thing) [ DeactivateAction { Agent A, Object T } ]
Suspend(A Agent, T Thing) [ SuspendAction { Agent A, Object T } ]


// =============================================================================
// Уровень 1. Физический ввод (Базовые манипуляции)
// =============================================================================

// Перемещение курсора в определенную область экрана.
Point(A Agent, T Coordinates) [ CursorState ]

// Одиночное, двойное или правое нажатие кнопкой мыши для выбора элемента или вызова меню.
Click(A Agent, T UIElement, P ClickType) [ UIEvent ]

// Захват элемента, его перемещение и отпускание в новой зоне.
DragAndDrop(A Agent, T UIElement, S StartCoords, E EndCoords) [ UIState ]

// Вертикальное или горизонтальное смещение контента на экране.
Scroll(A Agent, T Viewport, Dir Direction, Dist Distance) [ ViewportState ]

// Ввод текстовых символов с помощью физического или виртуального устройства ввода (клавиатуры).
Type(A Agent, T InputField, P String) [ TextData ]

// Нажатие комбинаций клавиш для быстрого вызова системных или программных команд.
ExecuteShortcut(A Agent, P KeyCombination) [ SystemCommand ]

// =============================================================================
// Уровень 2. Управление системой и средой
// =============================================================================

// Включение, выключение, перезагрузка или перевод компьютера в спящий режим.
ManagePower(A Agent, T System, P PowerState) [ SystemState ]

// Ввод пароля, ПИН-кода или биометрии для подтверждения личности и входа в систему.
Authenticate(A Agent, T SecuritySystem, P Credentials) [ AuthToken ]

// Открытие, закрытие, сворачивание, разворачивание, изменение размера окон и переключение между ними.
ManageWindow(A Agent, T Window, P WindowAction) [ UIState ]

// Изменение параметров среды: громкости, яркости, сети или подключение внешних устройств.
ConfigureEnvironment(A Agent, T SystemSettings, Param Parameter, Val Value) [ ConfigState ]

// Установка и удаление программ, обновление ОС, очистка кэша/корзины, проверка безопасности.
MaintainSystem(A Agent, T OperatingSystem, P MaintenanceTask) [ SystemHealth ]

// =============================================================================
// Уровень 3. Управление данными (Операции с файлами)
// =============================================================================

// Открытие файла или объекта для ознакомления с его содержимым без внесения изменений.
Read(A Agent, T Thing) [ ContentStream ]

// Внесение изменений в существующий файл или объект и сохранение результата.
UpdateData(A Agent, T Thing, P NewData) [ Thing ]

// Перемещение файла в корзину или его безвозвратное стирание с носителя.
DeleteData(A Agent, T Thing) [ Boolean ]

// Копирование, вырезание, вставка, переименование, архивирование и перемещение файлов по директориям.
Organize(A Agent, T Thing, Src SourceLocation, Dst TargetLocation, Op OperationType) [ FileSystemState ]

// Поиск нужного файла, папки или программы на локальном носителе по заданным критериям.
SearchLocal(A Agent, T Storage, P Query) [ ThingList ]

// =============================================================================
// Уровень 4. Информационно-сетевые действия
// =============================================================================

// Переход по ссылкам, ввод URL, работа с вкладками браузера, навигация «Вперед/Назад».
NavigateWeb(A Agent, T Browser, P URL) [ WebPage ]

// Формулирование и ввод запроса в поисковую систему в интернете, фильтрация выдачи.
QuerySearchEngine(A Agent, T SearchEngine, P SearchQuery) [ SearchResults ]

// Скачивание (Download) файлов из сети на компьютер или загрузка (Upload) локальных файлов на сервер.
TransferData(A Agent, T DataObject, Src SourceNode, Dst DestinationNode) [ TransferStatus ]

// Регистрация на веб-ресурсах, вход в личные кабинеты, прохождение проверки CAPTCHA.
AuthenticateWeb(A Agent, T WebService, P Credentials) [ Session ]

// =============================================================================
// Уровень 5. Коммуникация и социализация
// =============================================================================

// Написание, отправка и чтение текстовых сообщений в мессенджерах, чатах или по электронной почте.
ExchangeMessage(A Agent, R Recipient, P MessageContent) [ MessageStatus ]

// Совершение аудио- и видеозвонков, участие в веб-конференциях, трансляция экрана.
StreamMediaCall(A Agent, R ParticipantList, P MediaStream) [ CallSession ]

// Публикация постов, комментирование, выставление реакций (лайков) и репост контента в соцсетях.
InteractSocial(A Agent, T SocialObject, P InteractionType) [ SocialEvent ]

// =============================================================================
// Уровень 6. Прикладные задачи
// =============================================================================

// Пассивное потребление медиа: просмотр видео, прослушивание аудио, чтение электронных книг и статей.
ConsumeMedia(A Agent, T MediaContent) [ Experience ]

// Написание, редактирование, верстка и форматирование текстовых документов.
AuthorText(A Agent, T Document, P TextOperations) [ Document ]

// Ввод структурированных данных, использование формул, вычислений и построение графиков в таблицах.
ProcessSpreadsheets(A Agent, T Dataset, P Formulas) [ AnalyticsResult ]

// Создание и обработка визуального/аудио контента: ретушь, рисование, видеомонтаж, 3D-моделирование.
ProduceMultimedia(A Agent, T RawMedia, P EditingTools) [ MediaArtifact ]

// Написание исходного кода, его отладка, компиляция и выполнение скриптов.
DevelopCode(A Agent, T SourceCode, P Compiler) [ Executable ]

// Управление виртуальным персонажем или процессом в интерактивной игровой среде.
PlayGame(A Agent, T GameEnvironment, P GameActions) [ GameState ]

// Выбор товаров на сайтах, добавление в корзину, оформление заказа и проведение онлайн-оплаты.
ExecuteTransaction(A Agent, T ECommercePlatform, C Cart, PayMethod PaymentMethod) [ OrderReceipt ]
