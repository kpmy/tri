part of trisc;

abstract class CPU{
  static const int ok = 0;
  static const int stop = 1;
  static const int skip = 2;
  
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

class _cpu extends CPU{
  int27 ir;
  int27 pc;
  int step = 0;
  
  int27 start = new int27.zero();
  RAM mem;
  
  Function handler(){
    
  }
  
  void parse(int27 ir, Function(e)){
    
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
    pc += new int27.one();
    return parse(ir, handler());
  }
  
  _cpu(this.mem, this.start){
      reset();
  }
}