void main(){
  int a = 25;
  int b = 4;
  print(isGreaterThan10(a));
  print(isGreaterThan10(b));
  print(isGreaterThan10_2(a));
  print(isGreaterThan10_2(b));
}

bool isGreaterThan10(a){
  if (a>10){
    return true;
  }
  else{
    return false;
  }
}

bool isGreaterThan10_2(a){
  return a>10?true:false;
}
