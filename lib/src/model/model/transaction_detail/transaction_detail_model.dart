import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../transaction/transaction_model.dart';

part 'transaction_detail_model.g.dart';

@HiveType(typeId: 5)
class TransactionDetailModel extends Equatable {
  const TransactionDetailModel({
    this.id = '',
    this.transaction = const TransactionModel(),
    this.amount = 0.0,
    this.description = '',
    this.attachment,
    this.createdAt,
    this.updatedAt,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final TransactionModel transaction;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final Uint8List? attachment;

  @HiveField(5)
  final DateTime? createdAt;

  @HiveField(6)
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      transaction,
      amount,
      description,
      attachment,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'TransactionDetailModel(id: $id, transaction: $transaction, amount: $amount, description: $description, attachment: $attachment, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  TransactionDetailModel copyWith({
    String? id,
    TransactionModel? transaction,
    double? amount,
    String? description,
    Uint8List? attachment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionDetailModel(
      id: id ?? this.id,
      transaction: transaction ?? this.transaction,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
