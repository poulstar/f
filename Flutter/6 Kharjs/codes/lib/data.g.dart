// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KharjAdapter extends TypeAdapter<Kharj> {
  @override
  final int typeId = 0;

  @override
  Kharj read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kharj()
      ..title = fields[0] as String
      ..price = fields[1] as int
      ..dateTime = fields[2] as DateTime
      ..description = fields[3] as String
      ..isReviewed = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, Kharj obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.isReviewed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KharjAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}