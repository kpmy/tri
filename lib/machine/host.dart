part of machine;

/* обслуживает служебные отрицательные адреса: (-∞..bootPC, -81 .. -1] */
class DebugMMU extends MMU {
  MMU _inner;
  Host _host;

  int get pos => _inner.pos;
  int get neg => _inner.neg;
  int get length => _inner.length;

  operator []=(int idx, tryte val) {
    if (idx < 0 && idx >= -81) {
      switch(idx){
        case -1:
        switch(val.toInt()){
          case 0x1b:
            _host.stop = true;
            fmt.shout("internal panic");
            break;
          default:
            bus.fire(new WriteCharEvent(val.toInt()));
        }
        break;
        case -2: break;
        case -3: bus.fire(new WriteIntEvent(val.toInt())); break;
      }
    } else {
      _inner[idx] = val;
    }
  }

  tryte operator [](int idx) {
    if (idx < 0 && idx >= -3) return tryte.min; else return _inner[idx];
  }

  DebugMMU(this._host, this._inner);
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

  void run(){
    Function step;
    var boost = 1000;
    step = () {
      CPUresult res = CPUresult.ok;
      int i = 0;
      while(res == CPUresult.ok && i<boost && !stop){
        res = proc.next();
        i++;
      }
      if (res != CPUresult.stop && !stop) new Future.delayed(new Duration(milliseconds: 200), step);
    };
    step();
  }

  Host() {
    mem = new DebugMMU(this, MemFactory.newMMU(bootPC, memLength));
    proc = ProcFactory.newCPU(mem, pc: long(bootPC ~/ 3));
    /* инициализируем константы машины */
    new Mapper(mem)[memLim ~/ 3] = long(memLength);
    new Mapper(mem)[heapOrg ~/ 3] = long(heap);
    proc.reset();
  }
}
