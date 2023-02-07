PROGRAM lists;

TYPE

NodePtr = ^Node;
Node = RECORD
  data: INTEGER;
  next: NodePtr;
END;
ListPtr = NodePtr;


PROCEDURE InitList(VAR l: Listptr);
BEGIN
  l := NIL;
END;

PROCEDURE DisposeList(l: Listptr);
VAR
  n, next: NodePtr;
BEGIN
  n := l;
  WHILE n <> NIL DO BEGIN
    next := n^.next;
    Dispose(n);
    n := next; 
  END;
END;


FUNCTION NewNode(value: INTEGER): NodePtr;
BEGIN
  New(NewNode);
  NewNode^.data := value;
  NewNode^.next := NIL;
END;



PROCEDURE AppendValue(VAR l: ListPtr; node: NodePtr);
VAR
  n: NodePtr;
BEGIN
  IF l = NIL THEN
    l := node
  ELSE BEGIN
    n := l;
    WHILE n^.next <> NIL DO
      n := n^.next;
    n^.next := node;
  END;
END;

PROCEDURE PrependValue(VAR l: ListPtr; node: NodePtr);
BEGIN
  node^.next := l;
  l := node;
END;

PROCEDURE DisplayList
BEGIN
END;

FUNCTION ListContains
BEGIN
END;

PROCEDURE InvertList
BEGIN
END;









VAR
  listMain: ListPtr;
BEGIN
  InitList(listMain);
  AppendValue;
  PrependValue;
  DisposeList(listMain);
END.