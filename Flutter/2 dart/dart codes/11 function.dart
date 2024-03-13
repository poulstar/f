// function
num add2(a, b){
  return a+b;
}

void main(){
  var a = add2(5,6);
  var b = add3(5,6,7);
  print(a);
  print(b);
}

// arrow function
num add3(a, b, c) => a+b+c;
