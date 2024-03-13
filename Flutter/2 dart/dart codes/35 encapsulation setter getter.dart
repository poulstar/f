void main(){
  Car car1 = Car(1001, 'pride', 220000000);
  print(car1.getId());
  print(car1.getName());
  print(car1.getPrice());
}


class Car{
  int _id;
  String _name;
  int _price;
  
  Car (this._id, this._name, this._price);
  
  int getId() => _id;
  String getName() => _name;
  int getPrice() => _price;
  
  void setId(id) => _id=id;
  void setName(name) => _name=name;
  void setPrice(price) => _price=price;
}