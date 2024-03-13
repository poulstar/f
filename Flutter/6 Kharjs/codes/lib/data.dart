import 'package:hive_flutter/adapters.dart';
part 'data.g.dart';


@HiveType(typeId: 0)
class Kharj extends HiveObject{
  @HiveField(0)
  String title = '';
  @HiveField(1)
  int price = 0;
  @HiveField(2)
  DateTime dateTime = DateTime.now();
  @HiveField(3)
  String description = '';
  @HiveField(4)
  bool isReviewed=false;
}