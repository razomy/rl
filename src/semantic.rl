#
Abstract Semantic Types, Descriptors & Reflection Contracts
#

Property   Any
Expression Any
Record Any

Function   Object & Tuple(Expression)
Type       Tuple(Object | Function)

return Any
Self   Any

# Type Relation From-To for auto type calculation #
For(T) Any

// Type-level Peano Naturals
Zero    Object
Succ(N) { Prev N }
One     Succ(Zero)
Two     Succ(One)
Three   Succ(Two)
Four    Succ(Three)
Five    Succ(Four)

FieldDescriptor {
  Name        String
  Type        String
  Value       Any
  IsOptional  Bool
  Annotations List(String)
}

TypeDescriptor {
  TypeName  String
  Lineage   List(String)
  Fields    List(FieldDescriptor)
  IsUnion   Bool
  IsGeneric Bool
}

Deprecated   { Reason String, since String }
Experimental { Feature String }
ReadOnly     Object
Serializable Object
Transient    Object
Indexed      Object
Unique       Object
PrimaryKey   Object
