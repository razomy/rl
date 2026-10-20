#
CSP Channels & Synchronization Primitives
#

Channel(T) {
  Capacity    Int
  Send(Val T) [ (Self, Val) . native_chan_send ]
  Recv()      [ Self . native_chan_recv ]
  TryRecv()   [ Self . native_chan_try_recv ]
  Close()     [ Self . native_chan_close ]
}

Mutex(T) {
  Lock()           [ Self . native_mutex_lock ]
  Unlock()         [ Self . native_mutex_unlock ]
  WithLock(Action) [
    Self . Mutex.Lock
    . Action
    .> [ Self . Mutex.Unlock ]
  ]
}

RwLock(T) {
  ReadLock()  [ Self . native_rwlock_read ]
  WriteLock() [ Self . native_rwlock_write ]
  Unlock()    [ Self . native_rwlock_unlock ]
}

Semaphore {
  Permits   Int
  Acquire() [ Self . native_sem_acquire ]
  Release() [ Self . native_sem_release ]
}

WaitGroup {
  Count      Int
  Add(N Int) [ (Self, N) . native_wg_add ]
  Done()     [ Self . native_wg_done ]
  Wait()     [ Self . native_wg_wait ]
}
