part of '../form_transaction_page.dart';

class _TransactionType extends ConsumerWidget {
  const _TransactionType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTransactionType = ref.watch(
      formTransactionParameter.select((value) => value.transactionType),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Tipe Transaksi', style: bodyFont),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  ref.read(formTransactionParameter.notifier).update(
                        (state) => state = state.copyWith(transactionType: TransactionType.hutang),
                      );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  side: const BorderSide(color: secondaryDark),
                  backgroundColor:
                      selectedTransactionType == TransactionType.hutang ? secondaryDark : null,
                ),
                child: Text(
                  "Hutang",
                  style: bodyFont.copyWith(
                    color: selectedTransactionType == TransactionType.hutang
                        ? Colors.white
                        : secondaryDark,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24.0),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  ref.read(formTransactionParameter.notifier).update(
                        (state) => state = state.copyWith(transactionType: TransactionType.piutang),
                      );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  side: const BorderSide(color: secondaryDark),
                  backgroundColor:
                      selectedTransactionType == TransactionType.piutang ? secondaryDark : null,
                ),
                child: Text(
                  "Piutang",
                  style: bodyFont.copyWith(
                      color: selectedTransactionType == TransactionType.piutang
                          ? Colors.white
                          : secondaryDark),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
