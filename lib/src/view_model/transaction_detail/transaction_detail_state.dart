part of 'transaction_detail_notifier.dart';

class TransactionDetailState extends Equatable {
  final AsyncValue<TransactionDetailModel?> item;
  const TransactionDetailState({
    this.item = const AsyncData(null),
  });

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'TransactionDetailState(item: $item)';

  TransactionDetailState copyWith({
    AsyncValue<TransactionDetailModel?>? item,
  }) {
    return TransactionDetailState(
      item: item ?? this.item,
    );
  }
}
