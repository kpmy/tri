part of trisc;

class internal{
  static final haltMe = new tryte(-13);
  static final nop = new tryte.zero();
}

abstract class CPU{
  static const int ok = 0;
  static const int stop = 1;
  static const int skip = 2;

  bool get debug;
  set debug(bool);

  void reset();
  int next();
}

class ProcFactory{
  static CPU newCPU(RAM mem, {int27 pc: null}){
    if(pc==null)
      pc = new int27.zero();
    halt.on(condition: mem != null);
    return new _cpu(mem, pc);
  }
}

typedef int IRhandler(Operation op);

class _cpu extends CPU{
  int27 ir;
  int27 pc;
  int step = 0;
  bool _debug = false;

  int27 start = new int27.zero();
  RAM mem;

  @override
  bool get debug => _debug;

  @override
  set debug(bool x){
    this._debug = x;
  }

  IRhandler handler(){
    var def = (Operation op){
      
    };
    return def;
  }

  int parse(int27 ir, IRhandler h){
    tryte format = short(ir >> 24);
    if(format == internal.nop){
      return CPU.skip;
    }else if(format == internal.haltMe){
      halt.on(condition: !debug, code: 146);
      return CPU.stop;
    }else{
      return h(Op.parse(ir));
    }
  }

  @override
  void reset(){
    ir = new int27.zero();
    pc = start;
  }

  @override
  int next(){
    step++;
    ir = new Mapper(mem)[pc.toInt()];
    fmt.fine("step $step: [$pc]");
    pc += new int27.one();
    if(pc.toInt() == new Mapper(mem).length)
      pc = new int27.zero();
    fmt.fine(new Trits(ir));

    int ret = parse(ir, handler());
    fmt.fine("step $step: $ret");
    return ret;
  }

  _cpu(this.mem, this.start){
      reset();
  }
}