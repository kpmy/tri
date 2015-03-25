part of trisc;

abstract class RAM {
  tryte operator [](int adr);
  operator []=(int adr, tryte val);
  int get length;
}

abstract class MMU extends RAM {
  int get pos;
  int get neg;
}

class MemFactory {
  static RAM newRAM(int length) {
    return new _stdRam(length);
  }
}

class Mapper {
  static const int WORD = 3;
  RAM _ram;

  int27 operator [](int adr) {
    int a = adr * WORD;
    halt.on(condition: a >= 0 && a < _ram.length);
    List<tryte> x = new List(3);
    for (int i = 0; i < WORD; i++) {
      x[i] = _ram[a + i];
    }
    return mergeTryteList(x);
  }

  operator []=(int adr, int27 val) {
    int a = adr * WORD;
    halt.on(condition: a >= 0 && a < _ram.length);
    List<tryte> x = splitInt27(val);
    for (int i = 0; i < WORD; i++) {
      _ram[a + i] = x[i];
    }
  }

  Mapper(this._ram) {
    halt.on(condition: _ram != null);
  }
}

class _stdRam extends RAM {
  List<tryte> data;

  @override
  int get length => data.length;

  @override
  tryte operator [](int adr) {
    halt.on(condition: (adr >= 0 && adr < data.length), code: 20);
    return data[adr];
  }

  @override
  operator []=(int adr, tryte val) {
    halt.on(condition: (adr >= 0 && adr < data.length), code: 20);
    data[adr] = val;
  }

  _stdRam(int l) {
    this.data = new List(l);
    for (int i = 0; i < data.length; i++) data[i] = new tryte(0);
  }
}
