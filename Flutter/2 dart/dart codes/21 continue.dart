void main(){
  var names = ['ahmad', 'neda', 'rastin', 'negar', 'ali'];
  for(var name in names){
    if (name == 'rastin' || name == 'neda'){
      continue; // اگه اینا بودن نمیخوام بهشون سلام کنم. اما نمیخوام حلقه هم تموم بشه و میخوام ادامه داشته باشه.
    }
    print("Salam $name");
  }
}
