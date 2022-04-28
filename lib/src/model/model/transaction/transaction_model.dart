import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../utils/utils.dart';
import '../people/people_model.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel extends Equatable {
  const TransactionModel({
    this.id = '',
    this.people = const PeopleModel(),
    this.title = '',
    this.amount = 0.0,
    this.date,
    this.description,
    this.attachment,
    this.paymentStatus = PaymentStatus.unknown,
    this.transactionType = TransactionType.unknown,
    this.createdAt,
    this.updatedAt,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final PeopleModel people;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final DateTime? date;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final Uint8List? attachment;

  @HiveField(7)
  final PaymentStatus paymentStatus;

  @HiveField(8)
  final TransactionType transactionType;

  @HiveField(9)
  final DateTime? createdAt;

  @HiveField(10)
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      people,
      title,
      amount,
      date,
      description,
      attachment,
      paymentStatus,
      transactionType,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, people: $people, title: $title, amount: $amount, date: $date, description: $description, attachment: $attachment, paymentStatus: $paymentStatus, transactionType: $transactionType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  TransactionModel copyWith({
    String? id,
    PeopleModel? people,
    String? title,
    double? amount,
    DateTime? date,
    String? description,
    Uint8List? attachment,
    PaymentStatus? paymentStatus,
    TransactionType? transactionType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      people: people ?? this.people,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      transactionType: transactionType ?? this.transactionType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
