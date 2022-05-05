import 'package:equatable/equatable.dart';

class TransactionDetailInsertOrUpdateResponse extends Equatable {
  const TransactionDetailInsertOrUpdateResponse({
    this.message = '',
    this.isNewTransactionDetail = false,
  });

  final bool isNewTransactionDetail;
  final String message;

  @override
  List<Object> get props => [message, isNewTransactionDetail];

  @override
  String toString() =>
      'TransactionDetailInsertOrUpdateResponse(message: $message, isNewTransactionDetail: $isNewTransactionDetail)';

  TransactionDetailInsertOrUpdateResponse copyWith({
    String? message,
    bool? isNewTransactionDetail,
  }) {
    return TransactionDetailInsertOrUpdateResponse(
      message: message ?? this.message,
      isNewTransactionDetail: isNewTransactionDetail ?? this.isNewTransactionDetail,
    );
  }
}
