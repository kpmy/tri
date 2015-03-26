part of trisc;

abstract class Reg extends Operation{
  int27 _ir;
  
  @override
  int27 get raw => _ir;
  Reg(this._ir);
}

class Reg3 extends Reg{
  
  Reg3(int27 ir):super(ir){
    
  }
}

class Reg2 extends Reg{
  
  Reg2(int27 ir):super(ir){
      
    }
}