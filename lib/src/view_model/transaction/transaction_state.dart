part of 'transaction_notifier.dart';

class TransactionState extends Equatable {
  const TransactionState({
    this.item = const AsyncData(null),
  });
  final AsyncValue<TransactionModel?> item;

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'TransactionState(item: $item)';

  TransactionState copyWith({
    AsyncValue<TransactionModel?>? item,
  }) {
    return TransactionState(
      item: item ?? this.item,
    );
  }
}
