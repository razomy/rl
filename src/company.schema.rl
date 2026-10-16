// =============================================================================
// 1. БАЗОВЫЕ ПРИМИТИВЫ И МОДИФИКАТОРЫ СХЕМЫ
// =============================================================================

// Модификаторы узлов (вместо методов .mult().opt().skip())
Mult   Any
Opt    Any
Skip   Any

// Примитивы ФС и суффиксы
File  Any
FileUrl String
CommandStr String
Folder Any
Chunk  ".chunk"
drawio  ".drawio"
csv  ".csv"

// Часто используемые комбинации модификаторов (чтобы не дублировать)
MultOpt     Mult & Opt
SkipMultOpt Skip & Mult & Opt


// =============================================================================
// 2. ПЕРЕИСПОЛЬЗУЕМЫЕ КОМАНДЫ И БЛОКИ (DRY)
// =============================================================================

// Вместо дублирования n('do <File>').mult().opt() в трех местах:
DoCmd           "do" & FileUrl & MultOpt
StartInlineCmd  "start" & FileUrl & MultOpt
StartCompanyCmd "start_company" & FileUrl & MultOpt
ReadInlineCmd   "read" & FileUrl & MultOpt
RunCmd          "run" & CommandStr & MultOpt

// Общее правило для scopes и orders в configSchema
ScopeRule {
  ScopeName {
    FileRegex String & Mult
  } & Mult
}


// =============================================================================
// 3. СХЕМЫ КОНФИГУРАЦИИ И ЗАПУСКА
// =============================================================================

StartSchema {
  StartCompanyCmd
  StartInlineCmd
  ReadInlineCmd
  RunCmd
  DoCmd
  start "start" & { File & Mult } & MultOpt
  read  "read" & { File & Mult } & MultOpt
}

Reader "human" | "ai" | "program"

ConfigSchema {
  order       "order" & { File & Mult } & Opt
  scopes      "scopes" & ScopeRule & Opt
  orders      "orders" & ScopeRule & Opt
  reader      "reader" & { Reader } & Opt
  system      "system" & { "computer.os.macos" } & Opt
  editor      "editor" & {  } & Opt
  language    "language" & File & Opt
  schema      "schema" & File & Opt
  start       "start" & File & Opt
  environment "environment" & { source_dir "source_dir" & {  } } & Opt
  templates   "templates" & {
    TemplateName {
      Action String & Skip & Mult
    } & Mult
  } & Opt
}

// Переиспользуемые корневые файлы/папки
Git    ".git" & Folder & Skip
Config "config" & ConfigSchema & File
Start  "start" & StartSchema & File


// =============================================================================
// 4. УЗЛЫ ДОМЕННОЙ ЛОГИКИ (STRATEGY, TASKS, PLAN, WEB, OPERATION)
// =============================================================================

// Рекурсивная форма: Task и SubTask имели 100% одинаковые поля в JS.
// Вынесено в единую структуру TaskItem!
TaskItem {
  cron     "cron" & { Time String } & Opt
  priority "priority" & { Priority String } & Opt
  duration "duration" & { Priority String } & Opt
  examples "examples" & { Example String & Mult } & Opt
  SubTask  TaskItem & MultOpt // Рекурсия вместо дублирования кода!
}

TaskSchema {
  DoCmd
  Task TaskItem & Mult
}

PlanSchema {
  DoCmd
  Goal {
    Objective {
      responsible "responsible" & { Unit String & Mult } & Opt
      deps        "deps" & { Unit String & Mult } & Opt
      Description String & MultOpt
    } & MultOpt
  } & Mult
}

CompetitorsSchema Folder & {
  Name {
    "on Google Play" & Opt
    Url String & Opt
  } & Mult
}

AudienceSchema Folder & {
  Key {
    Value String & MultOpt
  } & Mult
}

StrategySchema Folder & {
  plan        "plan" & PlanSchema & Opt
  audience    "audience" & AudienceSchema & Opt
  competitors "competitors" & CompetitorsSchema & Opt
  tasks       "tasks" & TaskSchema & Opt
  plan        "plan" & drawio & Skip & Opt // @deprecated
  tasks        "tasks" & csv & Skip & Opt // @deprecated
}

WebSchema Folder & {
  Dockerfile "Dockerfile" & File & Opt
  Files      File & SkipMultOpt
}

DescriptionSchema Folder & {
  Statement {
    SubStatement String & MultOpt
  } & Mult
}

// Переиспользуемый блок данных для OperationSchema
SkippedData { Data String & SkipMultOpt }

OperationSchema Folder & {
  admin "admin" & {
    env "env" & {
      dev "dev" & SkipMultOpt
      prod "prod" & SkipMultOpt
      Env String & SkipMultOpt
      Key String & SkipMultOpt
    } & MultOpt
    SkippedData
  } & MultOpt

  Actor {
    Action SkippedData & MultOpt
  } & MultOpt
}


// =============================================================================
// 5. ВЫСОКОУРОВНЕВЫЕ СХЕМЫ (ARCHIVE, COMPANY, VISION, UNIVERSE)
// =============================================================================

ArchiveSchema {
  ArchiveChunk Chunk & Skip & Mult    // @deprecated (<ArchiveName>.chunk)
  ArchiveName  String & SkipMultOpt    // @deprecated (<ArchiveName>)
}

CompanySchema Folder & {
  Config & Opt
  Start & Opt
  challenge   "challenge" & DescriptionSchema & Opt
  description "description" & DescriptionSchema & Opt
  strategy    "strategy" & StrategySchema & Opt
  operation   "operation" & OperationSchema & Opt
  web         "web" & Chunk & WebSchema & Opt
  server      "server" & Chunk & WebSchema & Opt

  // Пропускаемые папки и чанки без внутренней схемы
  research "research" & Skip & Opt
  structure "structure" & Skip & Opt
  content "content" & Skip & Opt
  archive "archive" & Skip & Opt
  native "native" & Chunk & Skip & Opt
  Challenge   Chunk & SkipMultOpt
}

VisionSchema Folder & {
  Config & Opt
  Start
  description "description" & DescriptionSchema
  archive     "archive" & ArchiveSchema & Opt
  CompanyName CompanySchema & Mult
}

UNIVERSE_SCHEMA Folder & {
  Git
  Config
  Start
  VisionName VisionSchema & Mult
}
