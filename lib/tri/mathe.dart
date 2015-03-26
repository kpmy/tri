library tri;

import 'dart:math';

part 'tri.dart';
part 'int.dart';
part 'trits.dart';
part 'nons.dart';
part 'fib.dart';
part 'conv.dart';

/*
 * циклическое отрицание x + 1 (по модулю 3)
 */
Tril cnot(Tril x) {
  if (x.True) return FALSE; else if (x.False) return NULL; else return TRUE;
}

/*
 * сложение по модулю 3 в абсолютной системе
 */
Tril sum3(Tril p, Tril q) {
  if (p.False) return q; else if (p.Null) return q.False ? NULL : (q.Null ? TRUE : FALSE); else if (p.True) return q.False ? TRUE : (q.Null ? FALSE : NULL);
  throw new ArgumentError();
}

/*
 * сложение по модулю 3 в относительной системе
 */
Tril sum3r(Tril p, Tril q) {
  return cnot(cnot(sum3(p, q)));
}

/*
 * перенос при сложении в абсолютной системе
 */
Tril scarry3(Tril p, Tril q) {
  if (p.False) return FALSE; else if (p.Null) return q.True ? NULL : FALSE; else if (p.True) return q.False ? FALSE : NULL;
  throw new ArgumentError();
}

/*
 * перенос при сложении в относительной системе
 */
Tril scarry3r(Tril p, Tril q) {
  if (p.False && q.False) return FALSE; else if (p.True && q.True) return TRUE; else return NULL;
}

/*
 * умножение по модулю 3 в абсолютной системе
 */
Tril mul3(Tril p, Tril q) {
  if (p.False) return FALSE; else if (p.Null) return q; else if (p.True) return q.False ? FALSE : (q.Null ? TRUE : NULL);
  throw new ArgumentError();
}

/*
 * умножение по модулю 3 в относительной системе
 */
Tril mul3r(Tril p, Tril q) {
  if (p.Null || q.Null) return NULL; else return p == q ? TRUE : FALSE;
}

/*
 * перенос при умножении в абсолютной системе, при умножении в относительной системе переноса нет
 */
Tril mcarry(Tril p, Tril q) {
  if (p.True && q.True) return NULL; else return FALSE;
}

/*
 * функция вебба
 */
Tril webb(Tril p, Tril q) {
  return cnot(p | q);
}

/*
 * модуль
 */
Tril mod(Tril x) {
  return x | ~x;
}

tryte short(int27 i) {
  Trits from = new Trits(i).extract(0, 9);
  return new tryte(from.toInt27().toInt());
}

int27 long(tryte t) {
  return new int27(t.toInt());
}

int27 i27(int x){
  return new int27(x);
}

tryte i9(int x){
  return new tryte(x);
}
