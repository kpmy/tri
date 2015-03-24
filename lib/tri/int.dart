part of tri;

/*
 * трайт из девяти тритов
 * целое из 27 тритов
 * длинное целое из 81 трита, пока не реализуем
 */

const tryte_trit_num = 9;
final tryte_limit = pow(tryte_trit_num * 3, 3);

const int27_trit_num = 27;
final int27_limit = pow(pow(tryte_trit_num * 3, 3), 3);

abstract class tri_num {
  int toInt();
}

class tryte extends tri_num {
  static final tryte max = new tryte._new(tryte_limit ~/ 2);
  static final tryte min = new tryte._new(-(tryte_limit ~/ 2));
  static final _one = new tryte._new(1);
  static final _zero = new tryte._new(0);

  int _code = 0;

  factory tryte(int x) {
    if (x > max.toInt() || x < min.toInt()) throw new ArgumentError();
    switch (x) {
      case 0:
        return _zero;
      case 1:
        return _one;
      default:
        return new tryte._new(x);
    }
  }

  factory tryte.one() {
    return _one;
  }

  factory tryte.zero() {
    return _zero;
  }
  tryte._new(this._code);

  @override
  int toInt() => _code;

  bool operator ==(tryte that) {
    return this._code == that._code;
  }

  @override
  int get hashCode => _code;

  @override
  String toString() {
    return _code.toString();
  }

  tryte operator +(tryte that) {
    return new tryte(this._code + that._code);
  }

  tryte operator -(tryte that) {
    return new tryte(this._code - that._code);
  }

  bool operator >(tryte that) {
    return (this._code > that._code);
  }

  bool operator <(tryte that) {
    return (this._code < that._code);
  }

  bool operator <=(tryte that) {
    return (this._code <= that._code);
  }

  bool operator >=(tryte that) {
    return (this._code >= that._code);
  }

  tryte operator ~/(tryte that) {
    return new tryte(this._code ~/ that._code);
  }

  tryte operator *(tryte that) {
    return new tryte(this._code * that._code);
  }

  tryte operator %(tryte that) {
    return new tryte(this._code % that._code);
  }

  tryte operator -() {
    return new tryte(-this._code);
  }

  int27 operator <<(int x) {
    return (new Bits(this) << x).toInt27();
  }

  int27 operator >>(int x) {
    return (new Bits(this) >> x).toInt27();
  }
}

class int27 extends tri_num {
  static final int27 max = new int27._new(int27_limit ~/ 2);
  static final int27 min = new int27._new(-(int27_limit ~/ 2));
  static final _one = new int27._new(1);
  static final _zero = new int27._new(0);

  int _code = 0;

  factory int27(int x) {
    if (x > max.toInt() || x < min.toInt()) throw new ArgumentError();
    switch (x) {
      case 0:
        return _zero;
      case 1:
        return _one;
      default:
        return new int27._new(x);
    }
  }

  factory int27.one() {
    return _one;
  }

  factory int27.zero() {
    return _zero;
  }
  int27._new(this._code);

  @override
  int toInt() => _code;

  bool operator ==(int27 that) {
    return this._code == that._code;
  }

  @override
  int get hashCode => _code;

  @override
  String toString() {
    return _code.toString();
  }

  int27 operator +(int27 that) {
    return new int27(this._code + that._code);
  }

  int27 operator -(int27 that) {
    return new int27(this._code - that._code);
  }

  bool operator >(int27 that) {
    return (this._code > that._code);
  }

  bool operator <(int27 that) {
    return (this._code < that._code);
  }

  bool operator <=(int27 that) {
    return (this._code <= that._code);
  }

  bool operator >=(int27 that) {
    return (this._code >= that._code);
  }

  int27 operator ~/(int27 that) {
    return new int27(this._code ~/ that._code);
  }

  int27 operator *(int27 that) {
    return new int27(this._code * that._code);
  }

  int27 operator %(int27 that) {
    return new int27(this._code % that._code);
  }

  int27 operator -() {
    return new int27(-this._code);
  }

  int27 operator <<(int x) {
    return (new Bits(this) << x).toInt27();
  }

  int27 operator >>(int x) {
    return (new Bits(this) >> x).toInt27();
  }
}
