void main(){
  var car1 = Car(1001, 'pride', 'white');
  print(car1.color);
  car1.honk();
}

class Car{
  late int id;
  late String name;
  late String color;
  
  Car(int id, String name, String color){
    this.id=id;
    this.name=name;
    this.color=color;
  }
  void honk(){
    print("$name is honking!");
  }
  void tormoz(){ // break keyword e khode python hast nemishe gozasht.
    print("$name is breaking!"); 
  }
}