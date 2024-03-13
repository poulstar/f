void main(){
  Human h=Human(101, 'Sara');
  print(h.name);
  print(Human.numberOfEyes);
  // Human.numberOfHands=4; // Error
  // Human.numberOfHead=2; // Error
  Human.numberOfEyes=1;
  print(Human.numberOfEyes);
}

class Human{
  static const numberOfHands=2;
  static final numberOfHead=1;
  static int? numberOfEyes;

  int id;
  String name;
  Human(this.id, this.name);
}