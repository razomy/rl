#
Maps, Dictionaries, Caches & Probabilistic Data Structures
#

KeyValue(K, V)      { Key K, value V }
KeyValueArray(K, V) { Key K, values List(KvaOrValue(K, V)) }
KvaOrValue(K, V)    KeyValue(K, V) | KeyValueArray(K, V) | V

Dict(T)          Map(String, T)
RecursiveDict(T) Map(String, T | RecursiveDict(T))

Vrd(T)        Map(String, VrdOrValue(T))
VrdOrValue(T) T | Vrd(T)

HashTable(K, V) {
  Buckets List(LinkedList((K, V)))
}

DisjointSet(T) {
  Parent Map(T, T)
  Rank   Map(T, Int)
}

LRUCache(K, V) {
  Capacity Int
  Map      Map(K, DoublyLinkedListNode((K, V)))
  List     DoublyLinkedList((K, V))
}

LFUCache(K, V) {
  Capacity    Int
  Values      Map(K, V)
  Frequencies Map(K, Int)
}

BloomFilter(T) ProbabilisticDataStructure & {
  BitArray     List(Byte)
  NumHashFuncs Int
}

CuckooFilter(T) ProbabilisticDataStructure & {
  Buckets    List(Int)
  BucketSize Int
}

HyperLogLog(T) ProbabilisticDataStructure & {
  Registers List(Byte)
  Precision Int
}

CountMinSketch(T) ProbabilisticDataStructure & {
  Depth Int
  Width Int
  Table List(List(Int))
}
