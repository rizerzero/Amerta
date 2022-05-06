import 'dart:io';

import 'package:equatable/equatable.dart';

class FormPaymentParameter extends Equatable {
  const FormPaymentParameter({
    required this.id,
    required this.transactionId,
    required this.peopleId,
    required this.amount,
    required this.date,
    this.description,
    this.attachment,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String transactionId;
  final String peopleId;
  final int amount;
  final DateTime date;
  final String? description;
  final File? attachment;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      transactionId,
      peopleId,
      amount,
      date,
      description,
      attachment,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'FormPaymentParameter(id: $id, transactionId: $transactionId, peopleId: $peopleId, amount: $amount, date: $date, description: $description, attachment: $attachment, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  FormPaymentParameter copyWith({
    String? id,
    String? transactionId,
    String? peopleId,
    int? amount,
    DateTime? date,
    String? description,
    File? attachment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FormPaymentParameter(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      peopleId: peopleId ?? this.peopleId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      attachment: attachment ?? this.attachment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
