part of 'people_summary_transaction_notifier.dart';

class PeopleSummaryTransactionState extends Equatable {
  const PeopleSummaryTransactionState({
    this.items = const AsyncData([]),
  });

  final AsyncValue<List<SummaryTransactionModel>> items;

  int balance(TransactionType type) {
    final _items = items.value ?? [];
    final transaction = _items.where((element) => element.transactionType == type).toList();
    return transaction.fold<int>(
      0,
      (previousValue, element) {
        final amount = element.totalAmount ?? 0;
        final amountPayment = element.totalAmountPayment ?? 0;
        return previousValue + (amount - amountPayment);
      },
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'PeopleSummaryTransactionState(items: $items)';

  PeopleSummaryTransactionState copyWith({
    AsyncValue<List<SummaryTransactionModel>>? items,
  }) {
    return PeopleSummaryTransactionState(
      items: items ?? this.items,
    );
  }
}
