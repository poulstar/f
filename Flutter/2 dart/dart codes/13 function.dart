num add2(a, b, {c=0, d=0, e=0, f=0}){
  return a+b+c+d+e+f;
}

num add6(a, b, {required c,required d,required e,required f}){
  return a+b+c+d+e+f;
}

void main(){
  var a = add2(1, 2, d:3, f:4);
  var b = add6(1, 2, d:3, f:4, e: 0, c:9);
  print(a);
  print(b);
}
