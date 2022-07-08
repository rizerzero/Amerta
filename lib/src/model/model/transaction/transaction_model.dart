import 'package:equatable/equatable.dart';

import '../../../utils/enums.dart';
import '../people/people_model.dart';

class TransactionModel extends Equatable {
  const TransactionModel({
    this.id = '',
    this.peopleId = '',
    this.title = '',
    this.amount = 0,
    this.amountPayment,
    required this.loanDate,
    this.returnDate,
    this.description,
    this.attachmentPath,
    this.status = PaymentStatus.notPaidOff,
    this.type = TransactionType.piutang,
    required this.createdAt,
    this.updatedAt,
    this.people,
  });

  final String id;
  final String peopleId;
  final String title;
  final int amount;

  /// Total hutang yang sudah dibayarkan
  final int? amountPayment;
  final DateTime loanDate;
  final DateTime? returnDate;
  final String? description;
  final String? attachmentPath;
  final PaymentStatus status;
  final TransactionType type;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final PeopleModel? people;

  @override
  List<Object?> get props {
    return [
      id,
      peopleId,
      title,
      amount,
      amountPayment,
      loanDate,
      returnDate,
      description,
      attachmentPath,
      status,
      type,
      createdAt,
      updatedAt,
      people,
    ];
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, peopleId: $peopleId, title: $title, amount: $amount, amountPayment: $amountPayment, loanDate: $loanDate, returnDate: $returnDate, description: $description, attachmentPath: $attachmentPath, status: $status, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, people: $people)';
  }

  TransactionModel copyWith({
    String? id,
    String? peopleId,
    String? title,
    int? amount,
    int? amountPayment,
    DateTime? loanDate,
    DateTime? returnDate,
    String? description,
    String? attachmentPath,
    PaymentStatus? status,
    TransactionType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    PeopleModel? people,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      peopleId: peopleId ?? this.peopleId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      amountPayment: amountPayment ?? this.amountPayment,
      loanDate: loanDate ?? this.loanDate,
      returnDate: returnDate ?? this.returnDate,
      description: description ?? this.description,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      people: people ?? this.people,
    );
  }
}
