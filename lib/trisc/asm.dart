part of trisc;

class asm{
  static final tryte reg3 = new tryte(1);
  static final tryte reg2 = -reg3;

  static final tryte mov = new tryte(0);
  static final tryte lsl = new tryte(1);
  static final tryte ror = new tryte(2);
  static final tryte and = new tryte(3);
  static final tryte ann = new tryte(4);
  static final tryte ior = new tryte(5);
  static final tryte xor = new tryte(6);
  static final tryte add = new tryte(7);
  static final tryte sub = -add;
  static final tryte mul = new tryte(9);
  static final tryte div = new tryte(10);
  static final tryte mod = -div;

  static final tryte mem = new tryte(2);
  static final tryte stw = new tryte(3);
  static final tryte ldw = -stw;
  static final tryte stt = new tryte(5);
  static final tryte ldt = -stt;

  static final tryte br = new tryte(3);
  static final tryte brr = new tryte(7);
  static final tryte brc = -brr;
  static final tryte lnk = new tryte(6);
  static final tryte jmp = new tryte(5);
  static final tryte nz = new tryte(4);
  static final tryte eq = new tryte(3);
}

/* предопределенные регистры */
class org{
  static final tryte MT = short(23); 
  static final tryte SB = short(24); 
  static final tryte SP = short(25); 
  static final tryte LNK = short(26);
  static final tryte TMP = short(8);   
}

class asg{

  static int27 _reg2(tryte op, tryte ra, tryte rb, int27 im){
    int27 max = (int27.max << 15) >> 15;
    int27 min = (int27.min << 15) >> 15;
    if(im > max || im < min){
      halt.on(code: 126);
    }else{
      return (asm.reg2 << 24) + (ra << 20) + (rb << 16) + (op << 12) + ((im << 15) >> 15);
    }
  }
  
  static int27 brr(tryte rc, tryte cond, int27 data){
    return (asm.brr << 24) + (cond << 18) + ((data << 13) >> 9) + long(rc);
  }
  
  static int27 imov(tryte ra, int27 im){
    return _reg2(asm.mov, ra, short(0), im);
  }
  
  static int27 iadd(tryte ra, tryte rb, int27 im){
     return _reg2(asm.add, ra, rb, im);
   }
}