import 'package:equatable/equatable.dart';

class PaymentModel extends Equatable {
  const PaymentModel({
    this.id = '',
    this.transactionId = '',
    this.peopleId = '',
    this.amount = 0,
    required this.date,
    this.description,
    this.attachmentPath,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String transactionId;
  final String peopleId;
  final int amount;
  final DateTime date;
  final String? description;
  final String? attachmentPath;
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
      attachmentPath,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'PaymentModel(id: $id, transactionId: $transactionId, peopleId: $peopleId, amount: $amount, date: $date, description: $description, attachmentPath: $attachmentPath, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  PaymentModel copyWith({
    String? id,
    String? transactionId,
    String? peopleId,
    int? amount,
    DateTime? date,
    String? description,
    String? attachmentPath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      peopleId: peopleId ?? this.peopleId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
