#
Abstract Concurrency Primitives, Futures & Actor Contracts
#

ChannelClosed Object

TaskPending      Object
TaskRunning      Object
TaskCompleted(T) { Value T }
TaskFailed(E)    { Error E }
TaskCancelled    Object
TaskState(T, E)  TaskPending | TaskRunning | TaskCompleted(T) | TaskFailed(E) | TaskCancelled

RestartPolicy "always" | "on-failure" | "never" | "exponential-backoff"

SupervisorSpec {
  MaxRestarts   Int
  WithinSeconds Int
  Policy        RestartPolicy
}
