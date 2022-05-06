import 'package:equatable/equatable.dart';

class PaymentInsertOrUpdateResponse extends Equatable {
  const PaymentInsertOrUpdateResponse({
    this.message = '',
    this.isNewPayment = false,
  });

  final bool isNewPayment;
  final String message;

  @override
  List<Object> get props => [message, isNewPayment];

  @override
  String toString() =>
      'PaymentInsertOrUpdateResponse(message: $message, isNewPayment: $isNewPayment)';

  PaymentInsertOrUpdateResponse copyWith({
    String? message,
    bool? isNewPayment,
  }) {
    return PaymentInsertOrUpdateResponse(
      message: message ?? this.message,
      isNewPayment: isNewPayment ?? this.isNewPayment,
    );
  }
}
