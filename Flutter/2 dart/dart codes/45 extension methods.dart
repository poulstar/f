void main(){
  String myString='101';
  int m=myString.toInt();
  print(m);
}

extension NumberParsing on String{
  int toInt()=>int.parse(this);
  double toDouble()=>double.parse(this);
}