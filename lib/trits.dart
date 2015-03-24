part of tri;

class Bits {

  List<Tril> _trits;

  void clear() {
    _trits = new List(27);
    for (int i = 0; i < 27; i++) _trits[i] = NULL;
  }

  @override
  int get hashCode => _toInt();

  bool operator ==(Bits that) {
    return this._toInt() == that._toInt();
  }

  Bits operator <<(int x) {
    Bits ret = new Bits._new();
    for (int i = x; i < _trits.length; i++) {
      ret._trits[i] = this._trits[i - x];
    }
    return ret;
  }

  Bits operator >>(int _x) {
    Bits ret = new Bits._new();
    int x = -_x;
    for (int i = _trits.length - 2 + x; i >= 0; i--) {
      ret._trits[i] = this._trits[i + x.abs()];
    }
    return ret;
  }

  /*
   *  PROCEDURE (VAR s: Set) And* (t: Set), NEW;
    VAR i: Tryte; z: Set; a, b: TRiscTern.Trilean;
  BEGIN
    i:=1; z.Reset;
    WHILE i<28 DO
      a:=s.In(i); b:=t.In(i);
      a:=TRiscTern.And(a, b);
      IF TRiscTern.True(a) THEN z.Incl(i)
      ELSIF TRiscTern.False(a) THEN z.Incl(SHORT(-i))
      END;
      INC(i);
    END;
    s.neg:=z.neg;
    s.pos:=z.pos;
  END And;
  
  PROCEDURE (VAR s: Set) Or* (t: Set), NEW;
    VAR i: Tryte; z: Set; a, b: TRiscTern.Trilean;
  BEGIN
    i:=1; z.Reset;
    WHILE i<28 DO
      a:=s.In(i); b:=t.In(i);
      a:=TRiscTern.Or(a, b);
      IF TRiscTern.True(a) THEN z.Incl(i)
      ELSIF TRiscTern.False(a) THEN z.Incl(SHORT(-i))
      END;
      INC(i);
    END;
    s.neg:=z.neg;
    s.pos:=z.pos;
  END Or;
  
  PROCEDURE (VAR s: Set) Sub* (t: Set), NEW;
    VAR i: Tryte; z: Set; a, b: TRiscTern.Trilean;
  BEGIN
    i:=1; z.Reset;
    WHILE i<28 DO
      a:=s.In(i); b:=t.In(i);
      a:=TRiscTern.And(a, TRiscTern.Not(b));
      IF TRiscTern.True(a) THEN z.Incl(i)
      ELSIF TRiscTern.False(a) THEN z.Incl(SHORT(-i))
      END;
      INC(i);
    END;
    s.neg:=z.neg;
    s.pos:=z.pos;
  END Sub;
  
  PROCEDURE (VAR s: Set) Div* (t: Set), NEW;
    VAR i: Tryte; z: Set; a, b: TRiscTern.Trilean;
  BEGIN
    i:=1; z.Reset;
    WHILE i<28 DO
      a:=s.In(i); b:=t.In(i);
      a:=TRiscTern.Not(TRiscTern.Eq(a, b));
      IF TRiscTern.True(a) THEN z.Incl(i)
      ELSIF TRiscTern.False(a) THEN z.Incl(SHORT(-i))
      END;
      INC(i);
    END;
    s.neg:=z.neg;
    s.pos:=z.pos;
  END Div;
   */
  Bits operator +(Bits that) {

  }

  Bits operator *(Bits that) {

  }

  Bits operator -(Bits that) {

  }

  Bits operator /(Bits that) {

  }

  Bits extract(int from, int to) {
    Bits ret = new Bits._new();
    if (from >= _trits.length || to > _trits.length) throw new ArgumentError("$from, $to");
    for (int i = from; i < to; i++) {
      ret._trits[i] = this._trits[i];
    }
    return ret;
  }

  Bits join(Bits that) {
    Bits ret = new Bits._new();
    for (int i = 1; i < 28; i++) {
      if (this[i] != NULL) ret = ret.incl(i * this[i].toInt);
      if (that[i] != NULL) ret = ret.incl(i * that[i].toInt);
    }
    return ret;
  }

  Bits incl(int x) {
    if (x == 0 || x.abs() > 27) throw new ArgumentError("$x");
    Bits ret = this.extract(0, 27);
    ret._trits[x.abs() - 1] = new Tril.fromInt(x.sign);
    return ret;
  }

  Bits excl(int x) {
    if (x == 0 || x.abs() > 27) throw new ArgumentError("$x");
    Bits ret = this.extract(0, 27);
    ret._trits[x.abs() - 1] = NULL;
    return ret;
  }

  Tril operator [](int x) {
    if (x == 0 || x.abs() > 27) throw new ArgumentError("$x");
    Tril ret = _trits[x.abs() - 1];
    if (x < 0) ret = ~ret;
    return ret;
  }

  void _fill(int x, int mx) {
    clear();
    List<int> m = new List(mx);
    int sign = x.toInt().sign;
    int r = x.abs();
    int i = 0;
    if (sign != 0) {
      do {
        int s = r % 3;
        r = r ~/ 3;
        if (s > 1) {
          r++;
          m[i] = s - 3;
        } else {
          m[i] = s;
        }
        i++;
      } while (!(r < 3));
      if (r > 1) {
        m[i] = r - 3;
        m[i + 1] = 1;
        i = i + 2;
      } else {
        m[i] = r;
        i++;
      }
      do {
        i--;
        _trits[i] = new Tril.fromInt(sign * m[i]);
      } while (i != 0);
    }
  }

  int _toInt() {
    int ret = _trits[0].toInt;
    for (int i = 1; i < _trits.length; i++) {
      ret = ret + (_trits[i].toInt * pow(3, i));
    }
    return ret;
  }

  int27 toInt27() {
    return new int27(_toInt());
  }

  Bits.fromTryte(tryte x) {
    _fill(x.toInt(), 9);
  }

  Bits.fromInt27(int27 x) {
    _fill(x.toInt(), 27);
  }

  @override
  String toString() {
    String ret = "";
    _trits.forEach((t) {
      switch (t.toInt) {
        case 0:
          ret = "0" + ret;
          break;
        case -1:
          ret = "-" + ret;
          break;
        case 1:
          ret = "+" + ret;
          break;
      }
    });
    return ret;
  }

  factory Bits(tri_num x) {
    if (x is tryte) return new Bits.fromTryte(x); else if (x is int27) return new Bits.fromInt27(x);
  }

  Bits._new() {
    this.clear();
  }

}
