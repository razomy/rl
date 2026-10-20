#
Abstract Semantic Types, Descriptors & Reflection Contracts
#

Any    Any
Number Number
String String
RegExp RegExp
None   None

Property   Any
Expression Any

Tuple(T)   Any
Array(T)   Tuple
List(T)    Array
Object     Tuple(Property)
Function   Object & Tuple(Expression)
Type       Tuple(Object | Function)

return Any
Self   Any

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

Deprecated   { Reason String, Since String }
Experimental { Feature String }
ReadOnly     Object
Serializable Object
Transient    Object
Indexed      Object
Unique       Object
PrimaryKey   Object
