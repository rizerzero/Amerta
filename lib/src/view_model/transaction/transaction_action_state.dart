part of 'transaction_action_notifier.dart';

class TransactionActionState extends Equatable {
  const TransactionActionState({
    this.insertOrUpdate = const AsyncData(null),
    this.delete = const AsyncData(null),
  });

  final AsyncValue<void> insertOrUpdate;
  final AsyncValue<void> delete;

  @override
  List<Object> get props => [insertOrUpdate, delete];

  @override
  String toString() => 'TransactionActionState(insertOrUpdate: $insertOrUpdate, delete: $delete)';

  TransactionActionState copyWith({
    AsyncValue<void>? insertOrUpdate,
    AsyncValue<void>? delete,
  }) {
    return TransactionActionState(
      insertOrUpdate: insertOrUpdate ?? this.insertOrUpdate,
      delete: delete ?? this.delete,
    );
  }
}
