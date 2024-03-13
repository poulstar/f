void main(){
  Car car1 = Car(1001, 'pride');
  print(car1.name);
  Product product1 = Product(101, 'laptop');
  print(product1.name);
}


class Product with Name{
  final int id;
  Product (this.id, String pname){
    name=pname;
  }  
}

class Car with Name{
  final int id;  
  Car (this.id, String cname){
    name=cname;
  }  
}

mixin Name{
  late String name;
  void printName(){
    print(name);
  }
}