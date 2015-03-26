part of trisc;

abstract class Reg extends Operation{
  int27 _ir;

  @override
  int27 get raw => _ir;
  Reg(this._ir);
}

class Reg3 extends Reg{
  tryte a;
  tryte b;
  tryte c;
  tryte op;

  Reg3(int27 ir) : super(ir){
    a = short((ir << 3) >> 23);
    b = short((ir << 7) >> 23);
    op = short((ir << 11) >> 23);
    c = short((ir << 23) >> 23);
  }
}

class Reg2 extends Reg{
  tryte a;
  tryte b;
  int27 im;
  tryte op;

  Reg2(int27 ir) : super(ir){
    a = short((ir << 3) >> 23);
    b = short((ir << 7) >> 23);
    op = short((ir << 11) >> 23);
    im = (ir << 15) >> 15;
    }
}