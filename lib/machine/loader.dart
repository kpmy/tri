part of machine;

class Module{
  
}

class Flasher{
  RAM mem;
  int mt;
  int start;
  
  List<Module> ml = new List();
  
  flash (String name, {int adr: -1, bool boot: false}) async{
    try{
      var code = await HttpRequest.getString("tc/$name.tc");
      Map tc;
       tc = JSON.decode(code);
       halt.on(condition: adr != -1); //куча модулей будет позже
       fmt.fine(tc);
       if(tc.containsKey("code")){
         Map nons = tc["code"];
         List nonits = nons["nons"];
         int i = 0;
         nonits.forEach((String n){
           new Mapper(mem)[(adr ~/ 3) + i] = Nons.parse(n);
           i++;
         });
       }
    }catch(e){
      return -1;
    }
  }
  
  Flasher(this.mem, this.mt, [int shift = 0]){
    this.start = mt + shift;
  }
}
