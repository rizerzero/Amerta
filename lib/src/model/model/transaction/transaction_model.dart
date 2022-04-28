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

  final String id;
  final PeopleModel people;
  final String title;
  final double amount;
  final DateTime? date;
  final String? description;
  final Uint8List? attachment;
  final PaymentStatus paymentStatus;
  final TransactionType transactionType;
  final DateTime? createdAt;
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
