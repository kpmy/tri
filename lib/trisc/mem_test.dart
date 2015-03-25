library mem_test;
import 'package:unittest/unittest.dart';
import 'package:tri/trisc/core.dart';
import 'package:tri/tri/mathe.dart';

void testMem(){
  RAM r = MemFactory.newRAM(2*tryte.max.toInt()+1);
      tryte a = tryte.min; 
      int j = 0;
      test("set/get", (){
      do{
          r[j] = a; tryte b = r[j]; 
          expect(a, equals(b));
          a += new tryte.one(); j++;
      }while(a<tryte.max);
   });
   test("set word/get word", (){
      new Mapper(r)[4] = int27.max;
      expect(new Trits(new Mapper(r)[4]).toString(), equals(new Trits(int27.max).toString()));
   });
}