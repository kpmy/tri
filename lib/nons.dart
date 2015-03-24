part of tri;

class Nons {
  /*
   *  
  PROCEDURE NonsW (x: Word; OUT n: INTEGER; VAR m: ARRAY OF LONGINT);
    VAR i: INTEGER; sign, r, s: LONGINT;
  BEGIN
    ASSERT((x<=maxWord) & (x>=minWord), 20); 
    sign:=ENTIER(Math.Sign(x));
    r:=ABS(x); i:=0;
    IF sign#0 THEN
      REPEAT
        s:=r MOD 9;
        r:=r DIV 9;
        IF s > 4 THEN 
          INC(r);
          m[i]:=s-9;
        ELSE m[i]:=s END;
        INC(i);
      UNTIL r<9;
      IF r>4 THEN 
        m[i]:=r-9; m[i+1]:=1; INC(i, 2)
      ELSE m[i]:=r; INC(i) END;
    END;
    n:=i;
    WHILE i>0 DO
      DEC(i);
      m[i]:=sign*m[i]
    END;
  END NonsW;
  
  PROCEDURE Dump9*(x: Word; OUT vs: ARRAY OF CHAR);
    VAR i: INTEGER; n: INTEGER; m: ARRAY 14 OF LONGINT;
  BEGIN
    i:=0; WHILE i<LEN(m) DO m[i]:=0; INC(i) END;
    NonsW(x, n, m);
    i:=n; IF i>0 THEN vs:='' ELSE vs:='0' END;
    WHILE i>0 DO
      DEC(i);
      CASE SHORT(m[i]) OF
        -4: vs:=vs$ + 'W' + 0X|
        -3: vs:=vs$ + 'X' + 0X|
        -2: vs:=vs$ + 'Y' + 0X|
        -1: vs:=vs$ + 'Z' + 0X|
        0: vs:=vs$ + '0' + 0X|
        1: vs:=vs$ + '1' + 0X|
        2: vs:=vs$ + '2' + 0X|
        3: vs:=vs$ + '3' + 0X|
        4: vs:=vs$ + '4' + 0X|
      ELSE HALT(0) END;
    END;
  END Dump9;
  
  PROCEDURE Ord9(IN nons: ARRAY OF LONGINT): Word;
    VAR i: INTEGER; x: REAL; res: Word;
  BEGIN
    x:=nons[0];
    FOR i:=1 TO LEN(nons)-1 DO
      x:=x+(nons[i]*ENTIER(Math.IntPower(9, i)));
    END;
    res:=ENTIER(x);
  RETURN res
  END Ord9;
  
  PROCEDURE Load9* (IN vs: ARRAY OF CHAR): Word;
    VAR i, j: INTEGER; m: ARRAY 14 OF LONGINT;
  BEGIN
    i:=LEN(vs$); j:=0;
    WHILE i>0 DO
      DEC(i); 
      CASE CAP(vs[i]) OF
        'Z': m[j]:=-1 |
        'Y': m[j]:=-2 |
        'X': m[j]:=-3 |
        'W': m[j]:=-4
      ELSE 
        CASE vs[i] OF
          '0': m[j]:=0 |
          '1': m[j]:=1 |
          '2': m[j]:=2 |
          '3': m[j]:=3 |
          '4': m[j]:=4 
        ELSE HALT(0) END;
      END;
      INC(j)
    END;
    WHILE j<LEN(m) DO m[j]:=0; INC(j) END;
  RETURN Ord9(m)
  END Load9;
  
   */
  static String intToString(int27 i){
    
  }
  
  static int27 parse(String s){
    
  }
}