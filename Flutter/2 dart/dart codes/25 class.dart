void main(){
  var car1 = Car(id: 1001, name: 'pride', color: 'white');
  var car2 = Car.blue(id: 1002, name: 'vanet');
  var car3 = Car.red(id: 1003, name: 'peykan');
  print(car1.color);
  car1.honk();
  car2.honk();
  print(car2.color);
  print(car3.color);
}

class Car{
  int id;
  String name;
  String color;
  
  Car({required this.id, required this.name,required  this.color});
  void honk(){
    print("$name is honking!");
  }
  
  Car.blue({required this.id, required this.name}):color='blue';
  Car.red({required this.id, required this.name}):color='red';
  
  void tormoz(){ // break keyword e khode python hast nemishe gozasht.
    print("$name is breaking!"); 
  }
}