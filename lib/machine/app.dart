library machine;

import 'dart:async';
import 'package:tri/trisc/core.dart';

void init(){
  RAM r = MemFactory.newRAM(9841);
  CPU p = ProcFactory.newCPU(r);
  p.reset();
  Future.doWhile((){
    return (p.next() == CPU.ok);
  });
}