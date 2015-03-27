part of trisc;

class internal{
  static final haltMe = new tryte(-13);
  static final nop = new tryte.zero();
}

enum CPUresult{
  ok,
  stop,
  skip
}

abstract class CPU{

  bool get debug;
  set debug(bool);

  void reset();
  CPUresult next();
}

class ProcFactory{
  static CPU newCPU(RAM mem, {int27 pc: null}){
    if(pc==null)
      pc = new int27.zero();
    halt.on(condition: mem != null);
    return new _cpu(mem, pc);
  }
}

typedef CPUresult IRhandler(Operation op);

class _cpu extends CPU{

  Registers reg;
  RAM mem;

  int27 ir;
  int27 pc;

  int step = 0;

  bool _debug = false;

  int27 start = new int27.zero();

  @override
  bool get debug => _debug;

  @override
  set debug(bool x){
    this._debug = x;
  }

  IRhandler handler(){
    var rh = reg.handler();

    var jump = (int27 to, bool link){
      if(link)
        reg[short(reg.length-1)] = pc * long(3); /* регистры запоминают адрес в трайтах */
      pc = to; /* сдвиг в словах */
    };

    var calc = (BranchOperation op, int27 adr){
      if(op.cond.jump.True){
        jump(adr, op.cond.link);
      }else if(op.cond.jump.Null){
        var nz = op.cond.nz;
        var eq = op.cond.eq;
        if(nz == TRUE && eq == NULL){
          if(reg.nz == TRUE) jump(adr, op.cond.link); /* > */
        }else if(nz == NULL && eq == NULL){
          if(reg.nz == NULL) jump(adr, op.cond.link); /* = */
        }else if(nz == FALSE && eq == NULL){
          if(reg.nz == FALSE) jump(adr, op.cond.link); /* < */
        }else if(nz == TRUE && eq == TRUE){
          if(reg.nz != FALSE) jump(adr, op.cond.link); /* >= */
        }else if(nz == NULL && eq == FALSE){
          if(reg.nz != NULL) jump(adr, op.cond.link); /* # */
        }else if(nz == FALSE && eq == NULL){
          if(reg.nz != TRUE) jump(adr, op.cond.link); /* <= */
        }else halt.on(code: 215);
      }
    };

    var def = (Operation op){
      if(op is Reg){
        return rh(op);
      }else if(op is BranchReg){
        calc(op, reg[op.c] ~/ long(3));
        return CPUresult.ok;
      }else if(op is BranchConst){
        calc(op, pc + op.offset);
        return CPUresult.ok;
      }else if (op is GetWord){
        reg[op.a] = new Mapper(mem)[(reg[op.b] + op.offset).toInt()];
        reg.updateNZ(op.a);
        return CPUresult.ok;
      }else if (op is SetWord){
        new Mapper(mem)[(reg[op.b] + op.offset).toInt()] = reg[op.a];
        return CPUresult.ok;
      }else if(op is GetTryte){
        reg[op.a] = long(mem[(reg[op.b] + op.offset).toInt()]);
        reg.updateNZ(op.a);
        return CPUresult.ok;
      }else if(op is SetTryte){
        mem[(reg[op.b] + op.offset).toInt()] = short(reg[op.a]);
        return CPUresult.ok;
      }else halt.on(msg: op.runtimeType);
    };
    return def;
  }

  CPUresult parse(int27 ir, IRhandler h){
    tryte format = short(ir >> 24);
    if(format == internal.nop){
      return CPUresult.skip;
    }else if(format == internal.haltMe){
      halt.on(condition: !debug, code: 146);
      return CPUresult.stop;
    }else{
      var ret = h(Op.parse(ir));
      halt.on(condition: ret!=null);
      return ret;
    }
  }

  @override
  void reset(){
    ir = new int27.zero();
    reg = new Registers();
    pc = start;
  }

  @override
  CPUresult next(){
    step++;
    ir = new Mapper(mem)[pc.toInt()];
    fmt.fine("step $step: [$pc]");
    pc += new int27.one();
    if(pc.toInt() == new Mapper(mem).length)
      pc = new int27.zero();
    fmt.fine(new Trits(ir));

    CPUresult ret = parse(ir, handler());
    fmt.fine(reg);
    fmt.fine("");
    return ret;
  }

  _cpu(this.mem, this.start){
      reset();
  }
}