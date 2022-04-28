// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeopleModelAdapter extends TypeAdapter<PeopleModel> {
  @override
  final int typeId = 1;

  @override
  PeopleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeopleModel();
  }

  @override
  void write(BinaryWriter writer, PeopleModel obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeopleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
