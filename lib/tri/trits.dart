part of tri;

class Trits {

  List<Tril> _trits;

  void clear() {
    _trits = new List(27);
    for (int i = 0; i < 27; i++) _trits[i] = NULL;
  }

  @override
  int get hashCode => _toInt();

  bool operator ==(Trits that) {
    return this._toInt() == that._toInt();
  }

  Trits operator <<(int x) {
    Trits ret = new Trits._new();
    for (int i = x; i < _trits.length; i++) {
      ret._trits[i] = this._trits[i - x];
    }
    return ret;
  }

  Trits operator >>(int _x) {
    Trits ret = new Trits._new();
    int x = -_x;
    for (int i = _trits.length - 1 + x; i >= 0; i--) {
      ret._trits[i] = this._trits[i + x.abs()];
    }
    return ret;
  }

  Trits operator +(Trits that) {
    Trits ret = new Trits._new();
    for (int i = 1; i < 28; i++) {
      Tril x = this[i] | that[i];
      if (x != NULL) {
        ret = ret.incl(x.toInt * i);
      }
    }
    return ret;
  }

  Trits operator *(Trits that) {
    Trits ret = new Trits._new();
    for (int i = 1; i < 28; i++) {
      Tril x = this[i] & that[i];
      if (x != NULL) {
        ret = ret.incl(x.toInt * i);
      }
    }
    return ret;
  }

  Trits operator -(Trits that) {
    Trits ret = new Trits._new();
    for (int i = 1; i < 28; i++) {
      Tril x = this[i] & ~that[i];
      if (x != NULL) {
        ret = ret.incl(x.toInt * i);
      }
    }
    return ret;
  }

  Trits operator /(Trits that) {
    Trits ret = new Trits._new();
    for (int i = 1; i < 28; i++) {
      Tril x = ~eq(this[i], that[i]);
      if (x != NULL) {
        ret = ret.incl(x.toInt * i);
      }
    }
    return ret;
  }

  Trits extract(int from, int to) {
    Trits ret = new Trits._new();
    if (from >= _trits.length || to > _trits.length) throw new ArgumentError("$from, $to");
    for (int i = from; i < to; i++) {
      ret._trits[i] = this._trits[i];
    }
    return ret;
  }

  Trits join(Trits that) {
    Trits ret = new Trits._new();
    for (int i = 1; i < 28; i++) {
      if (this[i] != NULL) ret = ret.incl(i * this[i].toInt);
      if (that[i] != NULL) ret = ret.incl(i * that[i].toInt);
    }
    return ret;
  }

  Trits incl(int x) {
    if (x == 0 || x.abs() > 27) throw new ArgumentError("$x");
    Trits ret = this.extract(0, 27);
    ret._trits[x.abs() - 1] = new Tril.fromInt(x.sign);
    return ret;
  }

  Trits excl(int x) {
    if (x == 0 || x.abs() > 27) throw new ArgumentError("$x");
    Trits ret = this.extract(0, 27);
    ret._trits[x.abs() - 1] = NULL;
    return ret;
  }

  Tril operator [](int x) {
    if (x == 0 || x.abs() > 27) throw new ArgumentError("$x");
    Tril ret = _trits[x.abs() - 1];
    if (x < 0) ret = ~ret;
    return ret;
  }
  
  operator []=(int i, Tril x){
    if (i == 0 || i.abs() > 27) throw new ArgumentError("$i");
    _trits[i.abs() - 1] = i > 0 ? x : ~x;
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

  Trits.fromTryte(tryte x) {
    _fill(x.toInt(), 9);
  }

  Trits.fromInt27(int27 x) {
    _fill(x.toInt(), 27);
  }

  List<Tril> toList() {
    return _trits.toList();
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

  factory Trits(tri_num x) {
    if (x is tryte) return new Trits.fromTryte(x); else if (x is int27) return new Trits.fromInt27(x);
  }

  Trits._new() {
    this.clear();
  }

}
