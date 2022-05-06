part of 'payment_action_notifier.dart';

class PaymentActionState extends Equatable {
  const PaymentActionState({
    this.insertOrUpdate = const AsyncData(null),
    this.delete = const AsyncData(null),
  });

  final AsyncValue<PaymentInsertOrUpdateResponse?> insertOrUpdate;
  final AsyncValue<void> delete;

  @override
  List<Object> get props => [insertOrUpdate, delete];

  @override
  String toString() => 'PaymentActionState(insertOrUpdate: $insertOrUpdate, delete: $delete)';

  PaymentActionState copyWith({
    AsyncValue<PaymentInsertOrUpdateResponse?>? insertOrUpdate,
    AsyncValue<void>? delete,
  }) {
    return PaymentActionState(
      insertOrUpdate: insertOrUpdate ?? this.insertOrUpdate,
      delete: delete ?? this.delete,
    );
  }
}
