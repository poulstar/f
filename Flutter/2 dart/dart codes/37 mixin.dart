void main(){
  Car car1 = Car(1001, 'pride');
  print(car1.name);
  Product product1 = Product(101, 'laptop');
  print(product1.name);
}


class Product{
  final int id;
  final String name;
  
  Product (this.id, this.name);
  
  void printName(){
    print(name);
  }
}

class Car{
  final int id;
  final String name;
  
  Car (this.id, this.name);
  
  void printName(){
    print(name);
  }
}