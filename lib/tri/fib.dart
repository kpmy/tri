part of tri;

double fn(int i) {
  return pow((1 + sqrt(5)) / 2, 2 * i);
}

double fi(int i) {
  int z = cache.length ~/ 2;
  if (i.abs() <= z) return cache[z + i]; else return fn(i);
}

List<double> init_fib() {
  List ret = new List(81);
  int z = ret.length ~/ 2;
  for (int i = 0; i < ret.length; i++) {
    ret[i] = fn(i - z);
  }
  return ret;
}

final List<double> cache = init_fib();

class Fib {
  List<Tril> _trits;

  void _clear([int n = 15]) {
    _trits = new List(n);
    for (int i = 0; i < n; i++) {
      _trits[i] = NULL;
    }
  }

  void _sum(int z, Tril x) {
    if (z >= _trits.length || z < 0) throw new ArgumentError();
    if (_trits[z] == NULL) {
      _trits[z] = x;
    } else if (_trits[z] == TRUE) {
      if (x == FALSE) {
        _trits[z] = NULL;
      } else {
        _trits[z] = FALSE;
        _sum(z + 1, TRUE);
        _sum(z - 1, TRUE);
      }
    } else if (_trits[z] == FALSE) {
      if (x == TRUE) {
        _trits[z] = NULL;
      } else {
        _trits[z] = TRUE;
        _sum(z + 1, FALSE);
        _sum(z - 1, FALSE);
      }
    }
  }

  void _mul(int z, Tril x) {
    _trits[z] = new Tril.fromInt(_trits[z].toInt * x.toInt);
  }

  factory Fib(int x) {
    const c = 1000000;

    Function lesser = (double a, double b) {
      return (a * c).round() < (b * c).round();
    };

    Function equal = (double a, double b) {
      return (a * c).round() == (b * c).round();
    };

    Fib ret = new Fib._new();
    ret._clear();
    int z = ret._trits.length ~/ 2;
    double r = x.abs().toDouble();
    double b1 = fi(z + 1);
    int i = 0;
    while ((i < ret._trits.length) && !equal(r, .0)) {
      double b0 = fi(z - i);
      if (lesser(b1, r + b0) || equal(b1, r + b0)) {
        ret._sum(i - 1, TRUE);
        ret._trits[i] = FALSE;
        r = r - b1 + b0;
      } else if (lesser(b0, r) || equal(b0, r)) {
        ret._trits[i] = TRUE;
        r = r - b0;
      }
      i++;
      b1 = b0;
    }
    i = 0;
    while (i < ret._trits.length) {
      ret._trits[i] = new Tril.fromInt(x.sign * ret._trits[i].toInt);
      i++;
    }
    return ret;
  }

  factory Fib.parse(String ls) {
    if (ls.length == 0) return new Fib(0);
    if (!ls.length.isOdd) throw new ArgumentError();

    Fib ret = new Fib._new();
    ret._clear(ls.length);
    String s = ls.toUpperCase();
    for (int i = s.length - 1; i >= 0; i--) {
      switch (s[i]) {
        case "+":
          ret._trits[i] = TRUE;
          break;
        case "-":
          ret._trits[i] = FALSE;
          break;
        case "0":
          ret._trits[i] = NULL;
          break;
      }
    }
    return ret;
  }

  Fib._new([Fib old]) {
    if (old != null) {
      _clear(old._trits.length);
      for (int i = 0; i < _trits.length; i++) {
        _trits[i] = old._trits[i];
      }
    }
  }

  @override
  String toString() {
    String ret = "";
    for (int i = 0; i < _trits.length; i++) {
      //if(i == _trits.length ~/ 2) ret = ret+"'";
      Tril t = _trits[i];
      if (t == TRUE) ret = ret + "+"; else if (t == NULL) ret = ret + "0"; else ret = ret + "-";
      //if(i == _trits.length ~/ 2) ret = ret+"'";
    }
    return ret;
  }

  int toInt() {
    double ret = .0;
    int z = _trits.length ~/ 2;
    int i = 0;
    _trits.forEach((t) {
      ret = ret + t.toInt * fi(z - i);
      i++;
    });
    return ret.round();
  }

  Fib inc() {
    Fib ret = new Fib._new(this);
    ret._sum(ret._trits.length ~/ 2, TRUE);
    return ret;
  }

  Fib dec() {
    Fib ret = new Fib._new(this);
    ret._sum(ret._trits.length ~/ 2, FALSE);
    return ret;
  }
}
