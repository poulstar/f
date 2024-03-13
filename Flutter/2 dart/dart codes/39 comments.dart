void main(){
  // in comment addi ast.
  SportCar car1 = SportCar(1001, 'Skyline', 350);
  print(car1.maxSpeed);
  /* comment e chand khatte
   * dar zabane dar
   * be in soortat hast.
   */
  print(car1.name);
}

/// This is docString in Dart And here is the class Car
/// the docString uses three slashes and will be known by
/// IDEs like dartpad. you can see examples (links) which
/// are written in square brackets [SportCar]
class Car{
  int id;
  String name;
  Car (this.id, this.name);
}

class SportCar extends Car{
  int maxSpeed;
  SportCar(id, name, this.maxSpeed):super(id, name);
}