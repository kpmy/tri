part of machine;

class Module{
  String name;
  int size;
  int code;
  int entry;
  List<int> ent;
}

class Flasher{
  static const descSize = 15;
  static const firstJump = 1;

  RAM mem;
  int mt;
  int start;

  List<Module> ml = new List();

  flash (String name, {int adr: -1, bool boot: false, bool list: true}) async{

    Mapper mapper = new Mapper(mem);

    /* снизу вверх исправляем адреса */
    var fixD = (int adr, int fixorgD){
      int fadr = adr + fixorgD * 3;
      while(fadr != adr){
        int27 inst = mapper[fadr ~/ 3];
        int27 disp = (inst << 11) >> 11;
        int27 mno = (inst << 7) >> 23;
        if(mno == long(0)){
          int27 _new = ((inst >> 20) << 20) + (long(org.MT) << 16) + long(ml.length * 3);
          mapper[fadr ~/ 3] = _new;
        }
        fadr = fadr - disp.toInt() * 3;
      }
    };

    var fixP = (int adr, int fixorgP, List<String> imp){
      int fadr = adr + fixorgP * 3;
      while(fadr != adr){
        int27 inst = mapper[fadr ~/ 3];
        int27 mno = (inst << 9) >> 21;
        int27 pno = (inst << 15) >> 21;
        int27 disp = (inst << 21) >> 21;
        halt.on(condition: (mno.toInt() - 1) < imp.length);
        String im = imp[mno.toInt() - 1];
        Module impmod = ml.firstWhere((m){return m.name == im;});
        int dest = impmod.ent[pno.toInt() - 1] + impmod.code;
        int offset = (dest - fadr - 3) ~/ 3;
        int27 _new = ((inst >> 18) << 18) + long(offset);
        mapper[fadr ~/ 3]=_new;
        fadr = fadr - disp.toInt()*3;
      }
    };

    try{
      var code = await HttpRequest.getString("tc/$name.tc");
      Map tc;
       tc = JSON.decode(code);
       if (adr == -1){
         adr = start;
         ml.forEach((m){
           adr += m.size + descSize + 3;
         });
       }
       Module mod = new Module();
       mod.name = name;
       int entry = tc.containsKey("entry") ? tc["entry"] : 0;
       int _var = tc.containsKey("varsize") ? tc["varsize"] : 0;
       List<String> imp = tc.containsKey("imports") ? tc["imports"] : new List();
       mod.ent = tc.containsKey("entries") ? tc["entries"] : new List();
       int typ = 0;
       if(tc.containsKey("types")){
         List<String> types = tc["types"];
         for(int i = 0; i<types.length; i++){
           mapper[(adr ~/ 3) + i] = Nons.parse(types[i]);
           typ += 3;
         }
       }
       for(int i = 0; i<_var; i++){
         mem[adr + typ + i] = short(0);
       }
       int str = tc.containsKey("strings") ? (tc["strings"] as List).length : 0;
       if(tc.containsKey("strings")){
         List<int> strings = tc["strings"];
         for(int i=0; i<strings.length; i++){
           mem[adr + typ + _var + i] = short(strings[i]);
         }
       }
       int fixorgD = 0;
       int fixorgP = 0;
       if(tc.containsKey("code")){
         Map nons = tc["code"];
         fixorgD = nons.containsKey("fixorgD") ? nons["fixorgD"] : 0;
         fixorgP = nons.containsKey("fixorgP") ? nons["fixorgP"] : 0;
         List nonits = nons["nons"];
         int i = 0;
         int c = adr + _var + typ + str; mod.code = c;
         nonits.forEach((String n){
           mapper[(c ~/ 3) + i] = Nons.parse(n);
           i++;
         });

         if(list){
           ml.add(mod);
           mod.size = _var + str + typ + (nonits.length * 3);
           mapper[(adr - descSize + 3) ~/ 3] = long(mod.size);
           mapper[(adr - descSize + 6) ~/ 3] = long(mod.code);
           mapper[(adr - descSize + 9) ~/ 3] = long(mod.code + entry);
           /* значение SB каждый раз грузится из MT+mod.num ячейки памяти */
           mapper[(mt ~/ 3) + ml.length] = long(adr);
           for(int i=0; i<descSize; i++){
             mem[adr+mod.size+i] = short(0);
           }
         }
         fixD(mod.code, fixorgD);
         fixP(mod.code, fixorgP, imp);
       }
      if(boot){
        mapper[firstJump] = asg.imov(org.SB, long(adr));
        mapper[firstJump + 1] = asg.iadd(org.TMP, org.SB, long(_var + typ + str + entry));
        mapper[firstJump + 2] = asg.brr(org.TMP, new Condition(false, TRUE, NULL, NULL).compile(), long(0));
      }
    }catch(e){
      fmt.fine(e);
      return -1;
    }
  }

  Flasher(this.mem, this.mt, [int shift = 0]){
    this.start = mt + shift;
  }
}
