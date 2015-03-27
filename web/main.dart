//import 'package:tri/tri/test.dart';
//import 'package:tri/trisc/mem_test.dart';
import 'package:tri/machine/app.dart' as machine;
import 'package:malison/malison.dart';
import 'dart:html';
import 'dart:async';

void main() {
  //testTri();
  //testMem();
  machine.tuneLog();
  StringBuffer buffer = new StringBuffer("TRI machine\n");
//create the Console.
  var canvas = new CanvasElement();
  document.body.children.add(canvas);
  var terminal = new RetroTerminal.dos(80, 40, canvas);

  bool show = true;
  var blink;
  blink = () {
    //console.clear();
    List<String> data = buffer.toString().split("\n");
    int row = 0;
    data.forEach((s){
      terminal.writeAt(0, row, s);
      row++;
    });
    if (show)
      terminal.writeAt(0, row, "_");
    show = !show;
    terminal.render();
    new Future.delayed(new Duration(milliseconds: 500), blink);
  };
  blink();

  machine.bus.on().listen((e) {
    if(e is machine.WriteCharEvent){
      if(e.char == 0x0D)
        buffer.writeln();
      else
        buffer.writeCharCode(e.char);
    }else if(e is machine.WriteIntEvent){
      buffer.write(" ");
      buffer.write(e.value);
    }
  });
  machine.init();
}
