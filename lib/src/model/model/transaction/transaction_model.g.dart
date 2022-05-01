// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 2;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      id: fields[0] as String,
      people: fields[1] as PeopleModel,
      title: fields[2] as String,
      amount: fields[3] as double,
      debtDate: fields[4] as DateTime?,
      estimateDebtRepayment: fields[5] as DateTime?,
      description: fields[6] as String?,
      attachment: (fields[7] as List?)?.cast<int>(),
      paymentStatus: fields[8] as PaymentStatus,
      transactionType: fields[9] as TransactionType,
      createdAt: fields[10] as DateTime?,
      updatedAt: fields[11] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.people)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.debtDate)
      ..writeByte(5)
      ..write(obj.estimateDebtRepayment)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.attachment)
      ..writeByte(8)
      ..write(obj.paymentStatus)
      ..writeByte(9)
      ..write(obj.transactionType)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as String? ?? '',
      people: json['people'] == null
          ? const PeopleModel()
          : PeopleModel.fromJson(json['people'] as Map<String, dynamic>),
      title: json['title'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      debtDate: json['debt_date'] == null
          ? null
          : DateTime.parse(json['debt_date'] as String),
      estimateDebtRepayment: json['estimate_debt_repayment'] == null
          ? null
          : DateTime.parse(json['estimate_debt_repayment'] as String),
      description: json['description'] as String?,
      attachment:
          (json['attachment'] as List<dynamic>?)?.map((e) => e as int).toList(),
      paymentStatus:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['payment_status']) ??
              PaymentStatus.unknown,
      transactionType: $enumDecodeNullable(
              _$TransactionTypeEnumMap, json['transaction_type']) ??
          TransactionType.hutang,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'people': instance.people,
      'title': instance.title,
      'amount': instance.amount,
      'debt_date': instance.debtDate?.toIso8601String(),
      'estimate_debt_repayment':
          instance.estimateDebtRepayment?.toIso8601String(),
      'description': instance.description,
      'attachment': instance.attachment,
      'payment_status': _$PaymentStatusEnumMap[instance.paymentStatus],
      'transaction_type': _$TransactionTypeEnumMap[instance.transactionType],
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.paidOff: 'paidOff',
  PaymentStatus.notPaidOff: 'notPaidOff',
  PaymentStatus.unknown: 'unknown',
};

const _$TransactionTypeEnumMap = {
  TransactionType.hutang: 'hutang',
  TransactionType.piutang: 'piutang',
};
