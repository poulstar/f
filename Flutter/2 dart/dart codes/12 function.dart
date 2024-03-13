num add2(a, b, [c=0, d=0, e=0, f=0]){
  return a+b+c+d+e+f;
}

void main(){
  var a = add2(1, 2, 3, 4);
  print(a);
}
