part of 'transaction_detail_action_notifier.dart';

class TransactionDetailActionState extends Equatable {
  const TransactionDetailActionState({
    this.insertOrUpdate = const AsyncData(null),
    this.delete = const AsyncData(null),
  });

  final AsyncValue<TransactionDetailInsertOrUpdateResponse?> insertOrUpdate;
  final AsyncValue<void> delete;

  @override
  List<Object> get props => [insertOrUpdate, delete];

  @override
  String toString() =>
      'TransactionDetailActionState(insertOrUpdate: $insertOrUpdate, delete: $delete)';

  TransactionDetailActionState copyWith({
    AsyncValue<TransactionDetailInsertOrUpdateResponse?>? insertOrUpdate,
    AsyncValue<void>? delete,
  }) {
    return TransactionDetailActionState(
      insertOrUpdate: insertOrUpdate ?? this.insertOrUpdate,
      delete: delete ?? this.delete,
    );
  }
}
