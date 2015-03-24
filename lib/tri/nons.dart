part of tri;

/*
 * конвертер в девятиричную строку
 */
class Nons {
  static String intToString(int27 _x) {
    List<int> m = new List(27);
    int x = _x.toInt();
    int sign = x.sign;
    int r = x.abs();
    int i = 0;
    if (sign != 0) {
      do {
        int s = r % 9;
        r = r ~/ 9;
        if (s > 4) {
          r++;
          m[i] = s - 9;
        } else {
          m[i] = s;
        }
        i++;
      } while (!(r < 9));
      if (r > 4) {
        m[i] = r - 9;
        m[i + 1] = 1;
        i = i + 2;
      } else {
        m[i] = r;
        i++;
      }
    }  
    String ret = "";
    if(i==0) ret = "0";
    else{
      do {
            i--;
            switch(m[i]){
              case -4: ret = ret+"W"; break;
              case -3: ret = ret+"X"; break;
              case -2: ret = ret+"Y"; break;
              case -1: ret = ret+"Z"; break;
              case 0: ret = ret+"0"; break;
              case 1: ret = ret+"1"; break;
              case 2: ret = ret+"2"; break;
              case 3: ret = ret+"3"; break;
              case 4: ret = ret+"4"; break;
            }
          } while (i != 0);
    }
    return ret;
  }

  static int27 parse(String ls) {
    if(ls.length == 0) return new int27(0);
    List<int> m = new List();
    String s = ls.toUpperCase();
    for(int i = s.length-1; i>=0; i--){
      switch(s[i]){
        case "0": m.add(0); break;
        case "1": m.add(1); break;
        case "2": m.add(2); break;
        case "3": m.add(3); break;
        case "4": m.add(4); break;
        case "W": m.add(-4); break;
        case "X": m.add(-3); break;
        case "Y": m.add(-2); break;
        case "Z": m.add(-1); break;
      }
    }
    int ret = m[0];
    for(int i = 1; i<m.length; i++){
      ret = ret+(m[i]*pow(9, i));
    }
    return new int27(ret);
  }
}
