void main(){
  String username = 'poul';
  String password = 'star';
  if (username == 'poul' && password=='star'){
    print('welcome1');
  }
  if (username == 'poul' || password=='star'){
    print('welcome2');
  }
  if (username == 'p' && password=='star'){
    print('welcome3');
  }
  if (username == 'p' || password=='star'){
    print('welcome4');
  }
  if (username == 'p' && password=='s'){
    print('welcome5');
  }
  if (username == 'p' || password=='s'){
    print('welcome6');
  }
  bool a=true;
  print(!a);
}
