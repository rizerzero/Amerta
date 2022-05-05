import 'package:equatable/equatable.dart';

class TransactionInsertOrUpdateResponse extends Equatable {
  const TransactionInsertOrUpdateResponse({
    this.message = '',
    this.isNewTransaction = false,
  });

  final String message;
  final bool isNewTransaction;

  @override
  List<Object> get props => [message, isNewTransaction];

  @override
  String toString() =>
      'TransactionInsertOrUpdateResponse(message: $message, isNewTransaction: $isNewTransaction)';

  TransactionInsertOrUpdateResponse copyWith({
    String? message,
    bool? isNewTransaction,
  }) {
    return TransactionInsertOrUpdateResponse(
      message: message ?? this.message,
      isNewTransaction: isNewTransaction ?? this.isNewTransaction,
    );
  }
}
