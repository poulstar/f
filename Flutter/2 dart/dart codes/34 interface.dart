void main(){
  Horse horse = Horse();
  horse.eat();
  horse.sleep();
  horse.run();
}

abstract class Animal{
  var name = 'animal';
  void eat();
  void sleep();
  void run(){
    print('Animal is running!');
  }
}

class Horse implements Animal{
  @override
  var name = 'horse';

  @override
  void run(){
    print('horse is running so fast!');
  }

  @override
  void eat(){
    print('horse is eating so fast!');
  }
  
  @override
  void sleep(){
    print('horse is sleeping for 6 hours!');
  }
}