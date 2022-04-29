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
    this.debtDate,
    this.estimateDebtRepayment,
    this.description,
    this.attachment,
    this.paymentStatus = PaymentStatus.unknown,
    this.transactionType = TransactionType.unknown,
    this.createdAt,
    this.updatedAt,
  });

  /// ID Transaksi == ID People
  @HiveField(0)
  final String id;

  @HiveField(1)
  final PeopleModel people;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final DateTime? debtDate;

  @HiveField(5)
  final DateTime? estimateDebtRepayment;

  @HiveField(6)
  final String? description;

  @HiveField(7)
  final Uint8List? attachment;

  @HiveField(8)
  final PaymentStatus paymentStatus;

  @HiveField(9)
  final TransactionType transactionType;

  @HiveField(10)
  final DateTime? createdAt;

  @HiveField(11)
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      people,
      title,
      amount,
      debtDate,
      estimateDebtRepayment,
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
    return 'TransactionModel(id: $id, people: $people, title: $title, amount: $amount, debtDate: $debtDate, estimateDebtRepayment: $estimateDebtRepayment, description: $description, attachment: $attachment, paymentStatus: $paymentStatus, transactionType: $transactionType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  TransactionModel copyWith({
    String? id,
    PeopleModel? people,
    String? title,
    double? amount,
    DateTime? debtDate,
    DateTime? estimateDebtRepayment,
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
      debtDate: debtDate ?? this.debtDate,
      estimateDebtRepayment: estimateDebtRepayment ?? this.estimateDebtRepayment,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      transactionType: transactionType ?? this.transactionType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
