library machine;

import 'dart:async';
import 'package:tri/trisc/core.dart';
import 'package:logging/logging.dart';
import 'package:logging_handlers/logging_handlers_shared.dart';

void tuneLog(){
  startQuickLogging();
  fmt.level = Level.ALL;
}

void init(){
  RAM r = MemFactory.newRAM(9841);
  CPU p = ProcFactory.newCPU(r);
  p.reset();
  p.debug = true;
  Function step;
  step = (){
    if (p.next() != CPU.stop)
      new Future.delayed(new Duration(milliseconds: 50), step);
  };
  step();
}