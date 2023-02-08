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

PROCEDURE DisplayList(l: ListPtr);
VAR
  n: ListPtr;
BEGIN
  n := l;
  WHILE n <> NIL DO BEGIN
    Write(n^.data, ', ');
    n := n^.next;
  END;
END;

FUNCTION ListContains(l: ListPtr; x: INTEGER): BOOLEAN;
VAR
  n: NodePtr;
BEGIN
  n := l;
  WHILE (n <> NIL) AND (n^.data <> x) DO
    n := n^.next;
  ListContains := n <> NIL; 
END;

PROCEDURE InvertList(VAR l: ListPtr);
VAR
  prev, n, next: NodePtr;
BEGIN
  n := l;
  prev := NIL;
  WHILE n <> NIL DO BEGIN
    next := n^.next;
    n^.next := prev;
    prev := n;
    n := next;
  END;
  l := prev;
END;

FUNCTION IsSorted(l: ListPtr): BOOLEAN;
VAR
  n: NodePtr;
BEGIN
  n := l;
  IsSorted := TRUE;
  WHILE ((n <> NIL) AND (n^.next <> NIL)) AND IsSorted DO BEGIN
    IsSorted := n^.data < n^.next^.data;
    n := n^.next;
  END;
END;

PROCEDURE DisposeNodeAt(VAR l: ListPtr; x: INTEGER);
VAR
  prev, n: NodePtr;
  jumps: INTEGER;
BEGIN
  IF l <> NIL THEN BEGIN
    n := l;
    IF x = 1 THEN BEGIN
      l := n^.next;
      Dispose(n);
    END ELSE BEGIN
      jumps := x - 1;
      WHILE (n <> NIL) AND (jumps > 0) DO BEGIN
        prev := n;
        n := n^.next; 
        jumps := jumps - 1;
      END;
      IF (n <> NIL) AND (jumps = 0) THEN BEGIN
        prev^.next := n^.next;
        Dispose(n);
      END;
    END;
  END;
END;



PROCEDURE Split(VAR l: ListPtr; VAR evenList, oddList: ListPtr); // 19min
VAR
  n: NodePtr;
  oddRun, evenRun: NodePtr;
BEGIN
  n := l;
  WHILE n <> NIL DO BEGIN
    IF n^.data MOD 2 = 0 THEN BEGIN
      IF evenList = NIL THEN BEGIN
        evenList := n;
        n := n^.next;
        evenList^.next := NIL;
        END
      ELSE BEGIN
        evenRun := evenList;
        WHILE evenRun^.next <> NIL DO
          evenRun := evenRun^.next;
        evenRun^.next := n;
        n := n^.next;
        evenRun^.next^.next := NIL;
      END;
    END
    ELSE BEGIN
      IF oddList = NIL THEN BEGIN
        oddList := n;
        n := n^.next;
        oddList^.next := NIL;
        END
      ELSE BEGIN
        oddRun := oddList;
        WHILE oddRun^.next <> NIL DO
          oddRun := oddRun^.next;
        oddRun^.next := n;
        n := n^.next;
        oddRun^.next^.next := NIL;
      END;
    END;
  END;
  l := NIL;
END;




VAR
  mainList: ListPtr;
  mainNode: NodePtr;
  testPointer1, testPointer2: NodePtr;
  i: INTEGER;
BEGIN
  testPointer1 := NIL;
  testPointer2 := NIL;

  InitList(mainList);
  FOR i := 1 TO 10 DO BEGIN
    mainNode := NewNode(i);
    AppendValue(mainList, mainNode);
    //PrependValue(mainList, mainNode);
  END;
  DisplayList(mainList);
  // DisposeNodeAt(mainList, 10);
  // DisposeNodeAt(mainList, 10);
  // InvertList(mainList);
  Split(mainList, testPointer1, testPointer2);
  WriteLn;
  WriteLn('even');
  DisplayList(testPointer1);
  WriteLn;
  WriteLn('odd');
  DisplayList(testPointer2);
  WriteLn;
  WriteLn('Gone Girl');
  DisplayList(mainList);
  WriteLn;

  // WriteLn(ListContains(mainList, 11));
  // WriteLn(IsSorted(mainList));
  DisposeList(mainList);
END.