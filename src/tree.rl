#
Trees, Tries, Heaps & Spatial Search Trees (KDTree, BVH)
#

Leaf Object
Node(T) {
  Value T
  Left  Tree(T)
  Right Tree(T)
}
Tree(T) Leaf | Node(T)

TreeNode(T) HasValue(T) & HasParent(TreeNode(T)) & HasChildren(TreeNode(T)) & HasOrder(TreeNode(T))

RoseNode(T) {
  Value    T
  Children List(RoseNode(T))
}
RoseTree(T) RoseNode(T)

BinaryTreeNode(T) {
  Value T
  Left  Option(BinaryTreeNode(T))
  Right Option(BinaryTreeNode(T))
}
BinaryTree(T) { Root Option(BinaryTreeNode(T)) }

BalancedTreeType "AVL" | "RedBlack" | "Treap" | "Splay" | "WeightBalanced"
BalancedTree(T)  BinaryTree(T) & { TreeType BalancedTreeType }

BTreeNode(K, V) {
  Keys     List(K)
  Values   List(V)
  Children List(BTreeNode(K, V))
  IsLeaf   Bool
}
BTree(K, V) { Root Option(BTreeNode(K, V)), Degree Int }

TrieNode(V) {
  Value      Option(V)
  Children   Map(Char, TrieNode(V))
  IsTerminal Bool
}
Trie(V)      TrieNode(V)
RadixTree(V) Trie(V)
SuffixTree   { Text String, Root TrieNode(Int) }

HeapType       "MinHeap" | "MaxHeap" | "FibonacciHeap" | "PairingHeap" | "BinomialHeap"
Heap(T)        { HeapType HeapType, Array List(T) }
SegmentTree(T) { Array List(T), Size Int }
FenwickTree(T) { Tree List(T), Size Int }
MerkleNode     { Hash String, Left Option(MerkleNode), Right Option(MerkleNode) }
MerkleTree     { Root Option(MerkleNode), Leaves List(String) }

KDTreeNode(T) {
  Left  Int
  Right Int
  Co    T
  Index Int
  Dim   Int
}

KDTree(T) {
  Nodes        List(KDTreeNode(T))
  Root         Int
  MaxNodeIndex Int
  IsBalanced   Bool
}

BVHTreeAxisRange { Min Float, Max Float }
BVHTreeOverlap   { IndexA Int, IndexB Int }
BVHTreeNearest   { Index Int, Co (Float, Float, Float), No (Float, Float, Float), DistSq Float, Flags Int }
BVHTreeRay       { Origin (Float, Float, Float), Direction (Float, Float, Float), Radius Float }
BVHTreeRayHit    { Index Int, Co (Float, Float, Float), No (Float, Float, Float), Dist Float }

BVHTree {
  Epsilon  Float
  TreeType Int
  Len      Int
}
