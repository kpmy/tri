//import 'package:tri/tri/test.dart';
//import 'package:tri/trisc/mem_test.dart';
import 'package:tri/machine/app.dart' as machine;
import 'package:libpen/libpen.dart' as libpen;
import 'dart:html';
import 'dart:async';

void main() {
  //testTri();
  //testMem();
  machine.tuneLog();
  machine.init();

//create the Console.
libpen.Console console = new libpen.Console(40, 25);
document.body.append(console.container);
bool show = true;
var blink;
blink = (){
  console.clear();
  console.setChar(0, 0, '\$');
  console.setChar(1, 0, '>');
  if(show)
    console.setChar(2, 0, '_');
  show = !show;
  console.flush();
  new Future.delayed(new Duration(milliseconds: 500), blink);
};
blink();

}
