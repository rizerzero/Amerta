part of 'payment_notifier.dart';

class PaymentState extends Equatable {
  final AsyncValue<PaymentModel?> item;
  const PaymentState({
    this.item = const AsyncData(null),
  });

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'PaymentState(item: $item)';

  PaymentState copyWith({
    AsyncValue<PaymentModel?>? item,
  }) {
    return PaymentState(
      item: item ?? this.item,
    );
  }
}
