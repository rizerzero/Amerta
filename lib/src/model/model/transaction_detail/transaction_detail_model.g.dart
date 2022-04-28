// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransacitonDetailModelAdapter
    extends TypeAdapter<TransacitonDetailModel> {
  @override
  final int typeId = 5;

  @override
  TransacitonDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransacitonDetailModel(
      id: fields[0] as String,
      transaction: fields[1] as TransactionModel,
      amount: fields[2] as double,
      description: fields[3] as String,
      attachment: fields[4] as Uint8List?,
      createdAt: fields[5] as DateTime?,
      updatedAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TransacitonDetailModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.transaction)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.attachment)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransacitonDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
