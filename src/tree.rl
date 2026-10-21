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
BTree(K, V) { Root Option(BTreeNode(K, V)), degree Int }

TrieNode(V) {
  Value      Option(V)
  Children   Map(Char, TrieNode(V))
  IsTerminal Bool
}
Trie(V)      TrieNode(V)
RadixTree(V) Trie(V)
SuffixTree   { Text String, root TrieNode(Int) }

HeapType       "MinHeap" | "MaxHeap" | "FibonacciHeap" | "PairingHeap" | "BinomialHeap"
Heap(T)        { HeapType HeapType, array List(T) }
SegmentTree(T) { Array List(T), size Int }
FenwickTree(T) { Tree List(T), size Int }
MerkleNode     { Hash String, left Option(MerkleNode), right Option(MerkleNode) }
MerkleTree     { Root Option(MerkleNode), leaves List(String) }

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

BVHTreeAxisRange { Min Float, max Float }
BVHTreeOverlap   { IndexA Int, indexB Int }
BVHTreeNearest   { Index Int, Co (Float, Float, Float), No (Float, Float, Float), distSq Float, flags Int }
BVHTreeRay       { Origin (Float, Float, Float), Direction (Float, Float, Float), radius Float }
BVHTreeRayHit    { Index Int, Co (Float, Float, Float), No (Float, Float, Float), dist Float }

BVHTree {
  Epsilon  Float
  TreeType Int
  Len      Int
}
