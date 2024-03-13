void main(){
  Car car = Car(1001, 'BMW530', 'Sport', 2017, 300);
  car.honk();
  SportCar scar = SportCar(1002, 'BMW531', 2018);
  scar.honk();
}

class Car{
  int id;
  String name;
  String type;
  int createdAt;
  int maxSpeed;
  
  Car(this.id, this.name, this.type, this.createdAt, this.maxSpeed){
    print('A new car created');
  }
  
  void honk(){
    print('$name is honking!');
  }
}

class SportCar extends Car{
  SportCar(id, name, createdAt):super(id, name, "Sport", createdAt, 300){
        print('A new Sport car is created!');
  }
}