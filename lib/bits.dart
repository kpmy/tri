part of tri;

class Bits {

  List<Tril> _trits;

  void clear() {
    _trits = new List(27);
    for (int i = 0; i < 27; i++) _trits[i] = NULL;
  }

  void _fill(int x, int mx){
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

  int _toInt(){
    int ret = _trits[0].toInt;
    for (int i=1; i<_trits.length; i++){
      ret = ret+(_trits[i].toInt*pow(3, i));
    }
    return ret;
  }

  int27 toInt27(){
    return new int27(_toInt());
  }

  Bits.fromTryte(tryte x) {
    _fill(x.toInt(), 9);
  }

  Bits.fromInt27(int27 x) {
    _fill(x.toInt(), 27);
  }

  @override
  String toString(){
    String ret = "]";
    _trits.forEach((t){
      if(t.True)
        ret = "+" + ret;
      else if(t.False)
        ret = "-" + ret;
      else
        ret = "0" + ret;
    });
    return '['+ret;
  }

  factory Bits(tri_num x) {
    if (x is tryte) return new Bits.fromTryte(x); else if (x is int27) return new Bits.fromInt27(x);
  }
}
