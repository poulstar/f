void main(){
  var car2 = Car.blue(id: 1002, name: 'vanet');
  var car3 = Car.red(id: 1003, name: 'peykan');
  car2.honk();
  print(car2.color);
  print(car3.color);
}

class Car{
  int id;
  String name;
  String color;
  String backColor;
  
  void honk(){
    print("$name is honking!");
  }
  
  Car.blue({required this.id, required this.name}):color='blue', backColor='dark blue';
  Car.red({required this.id, required this.name}):color='red', backColor='dark red'{
    print("Age lazem bashe chand ta kar tooye named constructor anjam bedim in sheklie.");
    print('kare dovvom');
    print("info: id=>$id\nname=>$name");
  }
  
  void tormoz(){ // break keyword e khode python hast nemishe gozasht.
    print("$name is breaking!"); 
  }
}