part of tri;

List<tryte>splitInt27(int27 x){
  List ret = new List(3);
  ret[0] = short((x << 18) >> 18);
  ret[1] = short((x << 9) >> 18);
  ret[2] = short(x >> 18);
  return ret;
}

int27 mergeTryteList(List<tryte> x){
  if(x.length!=3) throw new ArgumentError();
  return long(x[0]) + (x[1] << 9) + (x[2] << 18);
}