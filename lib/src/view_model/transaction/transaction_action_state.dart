part of 'transaction_action_notifier.dart';

class TransactionActionState extends Equatable {
  const TransactionActionState({
    this.insertOrUpdate = const AsyncData(null),
    this.delete = const AsyncData(null),
  });

  final AsyncValue<TransactionInsertOrUpdateResponse?> insertOrUpdate;
  final AsyncValue<int?> delete;

  @override
  List<Object> get props => [insertOrUpdate, delete];

  @override
  String toString() => 'TransactionActionState(insertOrUpdate: $insertOrUpdate, delete: $delete)';

  TransactionActionState copyWith({
    AsyncValue<TransactionInsertOrUpdateResponse?>? insertOrUpdate,
    AsyncValue<int?>? delete,
  }) {
    return TransactionActionState(
      insertOrUpdate: insertOrUpdate ?? this.insertOrUpdate,
      delete: delete ?? this.delete,
    );
  }
}
