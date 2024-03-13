void main(){
  var car = Car();
  car.honk();
  print(car.color);
}

class Car{
  int id;
  String name;
  String color;
  String backColor;
  
  void honk(){
    print("$name is honking!");
  }
  
  Car():this.blue(id: 9999, name:"A good Car");
  Car.blue({required this.id, required this.name}):color='blue', backColor='dark blue';
  
  void tormoz(){ // break keyword e khode python hast nemishe gozasht.
    print("$name is breaking!"); 
  }
}