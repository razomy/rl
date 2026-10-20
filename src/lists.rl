#
Lists, Linked Lists, Queues, Deques & Buffers
#

List1(A)          Cons { Head A, Tail Nil }
List2(A, B)       Cons { Head A, Tail List1(B) }
List3(A, B, C)    Cons { Head A, Tail List2(B, C) }
List4(A, B, C, D) Cons { Head A, Tail List3(B, C, D) }

NonEmptyList(T) {
  Head T
  Tail List(T)
}

DynamicArray(T) List(T)
StaticArray(T)  List(T)

LinkedListNode(T) {
  Value T
  Next  Option(LinkedListNode(T))
}

DoublyLinkedListNode(T) {
  Value T
  Prev  Option(DoublyLinkedListNode(T))
  Next  Option(DoublyLinkedListNode(T))
}

LinkedList(T) {
  Head Option(LinkedListNode(T))
  Size Int
}

DoublyLinkedList(T) {
  Head Option(DoublyLinkedListNode(T))
  Tail Option(DoublyLinkedListNode(T))
  Size Int
}

Deque(T) {
  Front List(T)
  Back  List(T)
}

Stack(T) {
  Items List(T)
  Size  Int
}

Queue(T) {
  InBox  List(T)
  OutBox List(T)
  Size   Int
}

RingBuffer(T) {
  Buffer   List(T)
  Capacity Int
  ReadIdx  Int
  WriteIdx Int
}

PriorityNode(T) { Priority Float, Item T }
PriorityQueue(T) {
  Heap List(PriorityNode(T))
  Size Int
}

SkipListNode(T) {
  Value   T
  Forward List(SkipListNode(T))
}

SkipList(T) {
  Head     Option(SkipListNode(T))
  MaxLevel Int
}
