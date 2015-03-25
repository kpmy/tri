library halt;

class halt implements Exception{
  var msg;
  int code;
  halt._new(this.code, [this.msg]);

  @override
  String toString(){
    return "halt: $code $msg";
  }

  static on({bool condition: false, int code: 100, msg}){
    if(!condition){
      throw new halt._new(code, msg);
    }
  }
}