part of tri;
/*
 * пример троичной логики
 */
final Tril TRUE = new Tril._constant(true);
final Tril FALSE = new Tril._constant(false);
final Tril NULL = new Tril._constant(null);


/*
 * аксиома лукасевича про импликацию
 */
Tril impl(Tril x, Tril y) {
  if (x.False && y.False) return TRUE; else if (x.False && y.True) return TRUE; else if (x.True && y.False) return FALSE; else if (x.True && y.True) return TRUE; else if (x.True && y.Null) return NULL; else if (x.Null && y.False) return NULL; else if (x.False && y.Null) return TRUE; else if (x.Null && y.Null) return TRUE; else if (x.Null && y.True) return TRUE;
  throw new Exception("unexpected :(");
}

Tril eq(Tril x, Tril y) {
  return impl(x, y) & impl(y, x);
}

class Tril {
  bool _code;

  static final Tril _true = new Tril._constant(true);
  static final Tril _false = new Tril._constant(false);
  static final Tril _null = new Tril._constant(null);

  Tril._constant(this._code);

  factory Tril(bool code) {
    if (code == null) return _null; else if (code) return _true; else return _false;
  }

  factory Tril.fromInt(int code) {
    switch (code) {
      case 0:
        return _null;
      case 1:
        return _true;
      case -1:
        return _false;
      default:
        throw new ArgumentError();
    }
  }

  bool operator ==(Tril that) {
    return this._code == that._code;
  }

  @override
  int get hashCode {
    if (_code == null) return 0; else if (_code) return 1; else return -1;
  }

  int get toInt => hashCode;

  bool get Null => (_code == null);

  bool get True {
    if (_code == null) return false;
    return _code;
  }

  bool get False {
    if (_code == null) return false;
    return _code;
  }

  @override
  String toString() {
    if (_code == null) return "null"; else if (_code) return "true"; else return "false";
  }

  /*
   * аксиома лукасевича про отрицание
   */
  Tril operator ~() {
    if (_code == null) return NULL; else if (_code) return FALSE; else return TRUE;
  }

  /*
   * OR
   */
  Tril operator |(Tril that) {
    return impl(impl(this, that), that);
  }

  /*
   * AND
   */
  Tril operator &(Tril that) {
    return ~(~this | ~that);
  }

}
