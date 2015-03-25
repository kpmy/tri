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