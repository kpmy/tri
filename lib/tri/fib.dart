part of tri;

/*
 * MODULE TRiscTernS;
  (* Троичная зеркально-симметричная арифметика на основании четных степеней золотого сечения ((1+sqrt(5))/2)^x, где x {.. -4, -2, 0, 2, 4 ...} соответственно разряды {-2, -1, 0, 1, 2} *)
  
  IMPORT
    Math, Log:=StdLog;
    
  VAR 
    cache: ARRAY 81 OF REAL;
  
  PROCEDURE Valid(IN s: ARRAY OF BYTE): BOOLEAN;
    VAR i, len, z: INTEGER; ok: BOOLEAN;
  BEGIN
    ASSERT(ODD(LEN(s)), 20);
    i:=0; len:=LEN(s); z:=len DIV 2; ok:=TRUE;
    WHILE (i<z) & ok DO 
      ok:=s[i]=s[len-1-i];
      INC(i);
    END;
  RETURN ok;
  END Valid;
  
  PROCEDURE Print(IN s: ARRAY OF BYTE);
    VAR i: INTEGER;
  BEGIN
    ASSERT(ODD(LEN(s)), 20);
    i:=0; 
    WHILE i<LEN(s) DO 
      IF i=(LEN(s) DIV 2) THEN Log.Char("'") END;
      CASE s[i] OF
        1: Log.Char('+') |
        0: Log.Char('0') |
        -1: Log.Char('-')
      ELSE HALT(0) END;
      IF i=(LEN(s) DIV 2) THEN Log.Char("'") END;
      INC(i)
    END;
  END Print;
  
  PROCEDURE Dump*(IN s: ARRAY OF BYTE; OUT vs: ARRAY OF CHAR);
    VAR i: INTEGER;
  BEGIN
    ASSERT(ODD(LEN(s)), 20);
    i:=0; vs:='';
    WHILE i<LEN(s) DO 
      IF i=(LEN(s) DIV 2) THEN vs:=vs+"'"+0X; END;
      CASE s[i] OF
        1: vs:=vs+'+'+0X |
        0: vs:=vs+'0'+0X |
        -1: vs:=vs+'-'+0X
      ELSE HALT(0) END;
      IF i=(LEN(s) DIV 2) THEN vs:=vs+"'"+0X END;
      INC(i)
    END;
  END Dump;
  
  PROCEDURE Fn(i: INTEGER): REAL;
  BEGIN
  RETURN Math.IntPower((1+Math.Sqrt(5))/2, 2*i);
  END Fn;
    
  PROCEDURE Fi(i: INTEGER): REAL;
    VAR z: INTEGER; res: REAL;
  BEGIN
    z:=LEN(cache) DIV 2;
    IF ABS(i)<=z THEN res:=cache[z+i] ELSE res:=Fn(i) END;
  RETURN res
  END Fi;
    
  PROCEDURE Ord(IN s: ARRAY OF BYTE): LONGINT;
    VAR i, len, z: INTEGER; res: REAL;    
  BEGIN
    ASSERT(ODD(LEN(s)), 20);
    len:=LEN(s); z:=len DIV 2; i:=0;
    res:=0;
    WHILE i<len DO
      res:=res+s[i]*Fi(z-i);
      INC(i);
    END;
  RETURN ENTIER(res)
  END Ord;
  
  PROCEDURE Sum(VAR s: ARRAY OF BYTE; z: INTEGER; x: BYTE);
  BEGIN
    ASSERT(ODD(LEN(s)), 20); ASSERT(ABS(x) IN {0, 1}, 21); ASSERT(z<LEN(s), 22);
    CASE s[z] OF
      0: s[z]:=x |
      1: IF x=-1 THEN s[z]:=0 ELSE s[z]:=-1; Sum(s, z+1, 1); Sum(s, z-1, 1) END |
      -1: IF x=1 THEN s[z]:=0 ELSE s[z]:=1; Sum(s, z+1, -1); Sum(s, z-1, -1) END
    ELSE HALT(0) END;
  END Sum;
  
  PROCEDURE Mul(VAR s: ARRAY OF BYTE; z: INTEGER; x: BYTE);
  BEGIN
    ASSERT(ABS(x) IN {0, 1}, 20); ASSERT(z<LEN(s), 21);
    s[z]:=SHORT(SHORT(s[z]*x));
  END Mul;
  
  PROCEDURE Inc(VAR s: ARRAY OF BYTE);    
  BEGIN
    ASSERT(ODD(LEN(s)), 20);
    Sum(s, LEN(s) DIV 2, 1);
  END Inc;
  
  PROCEDURE Dec(VAR s: ARRAY OF BYTE);    
  BEGIN
    ASSERT(ODD(LEN(s)), 20);
    Sum(s, LEN(s) DIV 2, -1);
  END Dec;
  
  PROCEDURE Bits*(x: LONGINT; OUT s: ARRAY OF BYTE);
    VAR i, len, z: INTEGER; r, b1, b0: REAL; sign: BYTE;
    
    PROCEDURE IsLesser(a, b: REAL): BOOLEAN;
      CONST C = 1000000;
    BEGIN
    RETURN (ENTIER(a*C)) < (ENTIER(b*C))
    END IsLesser;
    
    PROCEDURE Equal(a, b: REAL): BOOLEAN;
      CONST C = 1000000;
    BEGIN
    RETURN (ENTIER(a*C)) = (ENTIER(b*C))
    END Equal;
    
  BEGIN
    ASSERT(ODD(LEN(s)), 20);
    len:=LEN(s); z:=len DIV 2; 
    i:=0; WHILE i<len DO s[i]:=0; INC(i) END;
    i:=0; r:=ABS(x); b1:=Fi(z+1);
    WHILE (i<len) & ~Equal(r, 0) DO
      b0:=Fi(z-i);
      IF IsLesser(b1, r+b0) OR Equal(b1, r+b0) THEN 
        Sum(s, i-1, 1); s[i]:=-1; r:=r-b1+b0;
      ELSIF IsLesser(b0, r) OR Equal(b0, r) THEN
        s[i]:=1; r:=r-b0;
      END;
      INC(i);
      b1:=b0;
    END;
    sign:=SHORT(SHORT(SHORT(ENTIER(Math.Sign(x)))));
    i:=0; WHILE i<len DO s[i]:=SHORT(SHORT(sign*s[i])); INC(i) END;
    ASSERT(Valid(s), 60);
  END Bits;
  
  PROCEDURE Add(IN s, t: ARRAY OF BYTE; OUT res: ARRAY OF BYTE);
  BEGIN
    
  END Add;
  
  PROCEDURE Do*;
    VAR s, t: ARRAY 7 OF BYTE; i, max: LONGINT;
  BEGIN
    i:=0; WHILE i<LEN(s) DO s[i]:=1; INC(i) END;
    max:=Ord(s);
    i:=-max; Bits(i, s);
    REPEAT
      Bits(i, t);
      Log.Int(i); Log.Tab; Bits(i, t);  Print(t); Log.Ln;
      IF i<max THEN Inc(s) END; INC(i);
    UNTIL i>max;
  END Do;
  
  PROCEDURE Do2*;
    VAR s: POINTER TO ARRAY OF BYTE; i, j: INTEGER;
  BEGIN
    i:=1;
    REPEAT
      NEW(s, i);
      FOR j:=0 TO i-1 DO s[j]:=1 END;
      Log.Int(i); Log.Int(Ord(s)); Print(s); Log.Ln;
      INC(i, 2);
    UNTIL i=91; (* дальше LONGINT заканчивается *)
  END Do2;
  
  PROCEDURE Init;
    VAR i, z, len: INTEGER;
  BEGIN
    i:=0; len:=LEN(cache); z:=len DIV 2;
    WHILE i<len DO 
      cache[i]:=Fn(i-z); 
      INC(i)
    END;
  END Init;
  
BEGIN
  Init
END TRiscTernS.
*/
