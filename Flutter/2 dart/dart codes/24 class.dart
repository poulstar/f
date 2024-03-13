void main(){
  var car1 = Car(id: 1001, name: 'pride', color: 'white');
  print(car1.color);
  car1.honk();
}

class Car{
  int id;
  String name;
  String color;
  
  Car({required this.id, required this.name,required  this.color});
  void honk(){
    print("$name is honking!");
  }
  void tormoz(){ // break keyword e khode python hast nemishe gozasht.
    print("$name is breaking!"); 
  }
}