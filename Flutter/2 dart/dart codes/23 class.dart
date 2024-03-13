void main(){
  var car1 = Car(1001, 'pride', 'white');
  print(car1.color);
  car1.honk();
}

class Car{
  int id;
  String name;
  String color;
  
  Car(this.id, this.name, this.color);
  void honk(){
    print("$name is honking!");
  }
  void tormoz(){ // break keyword e khode python hast nemishe gozasht.
    print("$name is breaking!"); 
  }
}