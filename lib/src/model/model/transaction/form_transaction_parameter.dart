import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../utils/enums.dart';
import '../people/people_model.dart';

class FormTransactionParameter extends Equatable {
  const FormTransactionParameter({
    this.transactionId,
    this.selectedPeople,
    this.title = '',
    this.amount = 0,
    required this.loanDate,
    this.returnDate,
    this.description,
    this.paymentStatus = PaymentStatus.notPaidOff,
    this.transactionType = TransactionType.piutang,
    this.attachment,
    required this.createdAt,
    this.updatedAt,
  });

  final String? transactionId;
  final PeopleModel? selectedPeople;
  final String title;
  final int amount;
  final DateTime loanDate;
  final DateTime? returnDate;
  final String? description;
  final PaymentStatus paymentStatus;
  final TransactionType transactionType;
  final File? attachment;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      transactionId,
      selectedPeople,
      title,
      amount,
      loanDate,
      returnDate,
      description,
      paymentStatus,
      transactionType,
      attachment,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'FormTransactionParameter(transactionId: $transactionId, selectedPeople: $selectedPeople, title: $title, amount: $amount, loanDate: $loanDate, returnDate: $returnDate, description: $description, paymentStatus: $paymentStatus, transactionType: $transactionType, attachment: $attachment, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  FormTransactionParameter copyWith({
    String? transactionId,
    PeopleModel? selectedPeople,
    String? title,
    int? amount,
    DateTime? loanDate,
    DateTime? returnDate,
    String? description,
    PaymentStatus? paymentStatus,
    TransactionType? transactionType,
    File? attachment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FormTransactionParameter(
      transactionId: transactionId ?? this.transactionId,
      selectedPeople: selectedPeople ?? this.selectedPeople,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      loanDate: loanDate ?? this.loanDate,
      returnDate: returnDate ?? this.returnDate,
      description: description ?? this.description,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      transactionType: transactionType ?? this.transactionType,
      attachment: attachment ?? this.attachment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
