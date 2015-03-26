part of trisc;

abstract class Operation{
  int27 get raw;
  Operation parse(int27 ir);
}

abstract class MemoryOperation extends Operation{}

abstract class BranchOperation extends Operation{}

class GetWord extends MemoryOperation{
  
}

class SetWord extends MemoryOperation{
  
}

class BranchConst extends BranchOperation{
  
}

class BranchReg extends BranchOperation{
  
}

class GetTryte extends MemoryOperation{
  
}

class SetTryte extends MemoryOperation{
  
}


class Op{
  static Map<tryte, Operation> cache = _init();
  
  static Map _init(){
    
  }
  
  static Operation parse(int27 ir){
    tryte format = short(ir >> 24);
  }
}