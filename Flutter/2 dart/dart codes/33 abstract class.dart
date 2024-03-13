void main(){
  Horse horse = Horse();
  horse.eat();
  horse.sleep();
  horse.run();
}

abstract class Animal{
  void eat();
  void sleep();
  void run(){
    print('Animal is running!');
  }
}

class Horse extends Animal{
  
  @override
  void eat(){
    print('horse is eating so fast!');
  }
  
  @override
  void sleep(){
    print('horse is sleeping for 6 hours!');
  }
}