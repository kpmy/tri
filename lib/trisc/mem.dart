part of trisc;

abstract class RAM {
  tryte operator [](int adr);
  operator []=(int adr, tryte val);
  int get length;
}

/* особенность MMU - симметричная адресация относительно нуля */
abstract class MMU extends RAM {
  int get pos;
  int get neg;
}

class MemFactory {
  static RAM newRAM(int length) {
    return new _stdRam(length);
  }

  static MMU newMMU(int neg, int pos){
    return new _stdMmu(neg, pos);
  }
}

class Mapper {
  static const int WORD = 3;
  RAM _ram;

  int get length => _ram.length ~/ 3;

  int27 operator [](int adr) {
    int a = adr * WORD;
    List<tryte> x = new List(3);
    for (int i = 0; i < WORD; i++) {
      x[i] = _ram[a + i];
    }
    return mergeTryteList(x);
  }

  operator []=(int adr, int27 val) {
    if(adr == 607)
      fmt.fine("word write [$adr]=$val");
    int a = adr * WORD;
    List<tryte> x = splitInt27(val);
    for (int i = 0; i < WORD; i++) {
      _ram[a + i] = x[i];
    }
  }

  Mapper(this._ram) {
    halt.on(condition: _ram != null);
  }
}

class _stdMmu extends MMU{

  RAM _n;
  RAM _p;

  int get neg => _n.length;
  int get pos => _p.length;
  int get length => _n.length + _p.length;

  tryte operator [](int adr){
    if (adr >= 0){
      halt.on(condition: adr<_p.length, msg: adr);
      return _p[adr];
    }else{
      halt.on(condition: adr.abs()-1<_n.length);
      return _n[adr.abs() - 1];
    }
  }

  operator []=(int adr, tryte val){
    if (adr >= 0){
      halt.on(condition: adr<_p.length);
      _p[adr] = val;
    }else{
      halt.on(condition: adr.abs()-1<_n.length);
      _n[adr.abs() - 1] = val;
    }
  }

  _stdMmu(int neg, int pos){
    halt.on(condition: neg<0);
    halt.on(condition: pos>0);
    this._n = new _stdRam(neg.abs());
    this._p = new _stdRam(pos+1);
  }
}

class _stdRam extends RAM {
  List<tryte> data;

  @override
  int get length => data.length;

  @override
  tryte operator [](int adr) {
    halt.on(condition: (adr >= 0 && adr < data.length), code: 20, msg: adr);
    return data[adr];
  }

  @override
  operator []=(int adr, tryte val) {
    halt.on(condition: (adr >= 0 && adr < data.length), code: 20, msg: adr);
    data[adr] = val;
  }

  _stdRam(int l) {
    this.data = new List(l);
    for (int i = 0; i < data.length; i++) data[i] = new tryte(0);
  }
}
