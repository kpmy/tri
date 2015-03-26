part of trisc;

abstract class Operation{
  int27 get raw;
}

abstract class MemoryOperation extends Operation{
  int27 _ir;

  tryte a;
  tryte b;
  int27 offset;

  @override
  int27 get raw => _ir;

  MemoryOperation(this._ir){
    a = short((_ir << 3) >> 23);
    b = short((_ir << 7) >> 23);
    offset = (_ir << -11) >> 11;
  }
}

class Condition{
  bool link;
  Tril jump;
  Tril nz;
  Tril eq;

  Condition(tryte c){
    Trits cond = new Trits(c);
    link = cond[asm.lnk.toInt()].True;
    jump = cond[asm.jmp.toInt()];
    nz = cond[asm.nz.toInt()];
    eq = cond[asm.eq.toInt()];
  }
}

abstract class BranchOperation extends Operation{

  int27 _ir;

  tryte c;
  int27 offset;
  int27 data;
  Condition cond;

  @override
  int27 get raw => _ir;

  BranchOperation(this._ir){
    c = short((_ir << 23) >>23);
    offset = (_ir << 9) >> 9;
    data = (_ir << 9) >> 13;
    tryte cnd = short((_ir << 3) >> 21);
    cond = new Condition(cnd);
  }
}

class GetWord extends MemoryOperation{
  GetWord(int27 ir) : super(ir);
}

class SetWord extends MemoryOperation{
    SetWord(int27 ir) : super(ir);
}

class BranchConst extends BranchOperation{
    BranchConst(int27 ir) : super(ir);
}

class BranchReg extends BranchOperation{
      BranchReg(int27 ir) : super(ir);
}

class GetTryte extends MemoryOperation{
      GetTryte(int27 ir) : super(ir);
}

class SetTryte extends MemoryOperation{
        SetTryte(int27 ir) : super(ir);
}

typedef Operation OperationFactory(int27 ir);

class Op{
  static Map<tryte, Operation> cache = _init();

  static Map _init(){
    Map<tryte, OperationFactory> ret = new Map();
    ret[asm.reg3] = (ir){return new Reg3(ir);};
    ret[asm.reg2] = (ir){return new Reg2(ir);};
    ret[asm.ldw] = (ir){return new GetWord(ir);};
    ret[asm.stw] = (ir){return new SetWord(ir);};
    ret[asm.ldt] = (ir){return new GetTryte(ir);};
    ret[asm.stt] = (ir){return new SetTryte(ir);};
    ret[asm.brr] = (ir){return new BranchReg(ir);};
    ret[asm.brc] = (ir){return new BranchConst(ir);};
    return ret;
  }

  static Operation parse(int27 ir){
    tryte format = short(ir >> 24);
    var op = cache[format];
    return op(ir);
  }
}