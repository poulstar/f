void main(){
  Car car1 = Car(1001, 'pride', 220000000);
  print(car1.name);
  car1.name = 'pejo';
  print(car1.name);
}


class Car{
  int _id;
  String _name;
  int _price;
  
  Car (this._id, this._name, this._price);
  
  set name(String value) => _name='the name of car is $value';
  String get name => 'Name: $_name';
}