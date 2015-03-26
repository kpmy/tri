part of machine;

/* обслуживает служебные отрицательные адреса: (-∞..bootPC, -81 .. -1] */
class DebugMMU extends MMU {
  MMU _inner;

  int get pos => _inner.pos;
  int get neg => _inner.neg;
  int get length => _inner.length;

  operator []=(int idx, tryte val) {
    if (idx < 0 && idx >= -81) {

    } else {
      _inner[idx] = val;
    }
  }

  tryte operator [](int idx) {
    if (idx < 0 && idx >= -3) return tryte.min; else return _inner[idx];
  }

  DebugMMU(this._inner);
}

/* 0Z000N */
const bootPC = -729;
/* 0100N */
const mtOrg = 81;
/* 010XN */
const memLim = mtOrg - 3;
/* 01Z3N */
const heapOrg = memLim - 3;


class Host {
  static const memLength = 29524;
  static const heap = memLength ~/ 3;

  bool stop = false;
  MMU mem;
  CPU proc;

  Host() {
    mem = new DebugMMU(MemFactory.newMMU(bootPC, memLength));
    proc = ProcFactory.newCPU(mem, pc: i27(bootPC ~/ 3));
    /* инициализируем константы машины */
    new Mapper(mem)[memLim ~/ 3] = i27(mem.length);
    new Mapper(mem)[heapOrg ~/ 3] = i27(heap);
    proc.reset();
    proc.debug = true;
    Function step;
    step = () {
      if (proc.next() != CPU.stop && !stop) new Future.delayed(new Duration(milliseconds: 500), step);
    };
    step();
  }
}
