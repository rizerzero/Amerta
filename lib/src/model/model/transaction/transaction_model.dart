import 'package:equatable/equatable.dart';

import '../../../utils/enums.dart';

class TransactionModel extends Equatable {
  const TransactionModel({
    this.id = '',
    this.peopleId = '',
    this.title = '',
    this.amount = 0,
    required this.loanDate,
    this.returnDate,
    this.description,
    this.attachmentPath,
    this.status = PaymentStatus.notPaidOff,
    this.type = TransactionType.piutang,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String peopleId;
  final String title;
  final int amount;
  final DateTime loanDate;
  final DateTime? returnDate;
  final String? description;
  final String? attachmentPath;
  final PaymentStatus status;
  final TransactionType type;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      peopleId,
      title,
      amount,
      loanDate,
      returnDate,
      description,
      attachmentPath,
      status,
      type,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, peopleId: $peopleId, title: $title, amount: $amount, loanDate: $loanDate, returnDate: $returnDate, description: $description, attachmentPath: $attachmentPath, status: $status, type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  TransactionModel copyWith({
    String? id,
    String? peopleId,
    String? title,
    int? amount,
    DateTime? loanDate,
    DateTime? returnDate,
    String? description,
    String? attachmentPath,
    PaymentStatus? status,
    TransactionType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      peopleId: peopleId ?? this.peopleId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      loanDate: loanDate ?? this.loanDate,
      returnDate: returnDate ?? this.returnDate,
      description: description ?? this.description,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
