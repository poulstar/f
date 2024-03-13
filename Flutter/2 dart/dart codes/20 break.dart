void main(){
  var mokhtalef = ['a', 'ali', 3, true, '5', 5, 3.3];
  for(var item in mokhtalef){
    print(item);
    if (item == 3){
      print("3 ro peyda kardam");
      break;
    }
  }
}
