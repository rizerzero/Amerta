part of 'print_transaction_notifier.dart';

class PrintTransactionState extends Equatable {
  const PrintTransactionState({
    this.item = const AsyncData(null),
  });

  final AsyncValue<Uint8List?> item;

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'PrintTransactionState(item: $item)';

  PrintTransactionState copyWith({
    AsyncValue<Uint8List?>? item,
  }) {
    return PrintTransactionState(
      item: item ?? this.item,
    );
  }
}
