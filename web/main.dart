import 'package:unittest/unittest.dart';
import 'package:tri/mathe.dart';

void main() {
  print("$TRUE, $NULL, $FALSE");

  test("basics", () {
    expect(TRUE, equals(TRUE));
    expect(FALSE, equals(FALSE));
    expect(NULL, isNot(equals(TRUE)));
    expect(~NULL, equals(NULL));
    expect(~TRUE, equals(FALSE));
    expect(~FALSE, equals(TRUE));
    expect(new Tril.fromInt(0), equals(NULL));
  });

  test("logic", () {
    expect(TRUE | TRUE, equals(TRUE));
    expect(FALSE & FALSE, equals(FALSE));
  });

  print(tryte.min);
  print(tryte.max);
  print(int27.min);
  print(int27.max);

  test("arithmetics", () {
    expect(new tryte(5) + new tryte.one(), equals(new tryte(6)));
    expect(short(new int27(40)), equals(new tryte(40)));
  });

  test("bits", () {
    expect(new Bits(int27.max).toString(), equals("+++++++++++++++++++++++++++"));
    expect(new Bits(tryte.max).toString(), equals("000000000000000000+++++++++"));
    expect(tryte.max, equals(short(new Bits(tryte.max).toInt27())));
    expect(int27.max, equals(new Bits(int27.max).toInt27()));
    expect(new Bits(new tryte(1)) << 5, equals((new Bits(new tryte(1)) << 18) >> 13));
    expect(new int27(1) << 5, equals((new int27(1) << 18) >> 13));
    expect(new tryte(1) << 5, isNot(equals((new tryte(1) << 18) >> 13)));
    expect(new Bits(new tryte(5))[1], equals(~(new Bits(new tryte(-5))[1])));
    expect(new Bits(new tryte(0)).incl(5).incl(8).incl(-1).excl(-1), equals(new Bits(new tryte(0)).incl(5).join(new Bits(new tryte(0)).incl(8))));
  });
}
