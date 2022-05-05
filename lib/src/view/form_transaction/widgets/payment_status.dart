part of '../form_transaction_page.dart';

class _PaymentStatus extends ConsumerWidget {
  const _PaymentStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPayment = ref.watch(
      formTransactionParameter.select((value) => value.paymentStatus),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Status', style: bodyFont),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  ref.read(formTransactionParameter.notifier).update(
                        (state) => state = state.copyWith(paymentStatus: PaymentStatus.paidOff),
                      );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  side: const BorderSide(color: secondaryDark),
                  backgroundColor: selectedPayment == PaymentStatus.paidOff ? secondaryDark : null,
                ),
                child: Text(
                  "Lunas",
                  style: bodyFont.copyWith(
                    color: selectedPayment == PaymentStatus.paidOff ? Colors.white : secondaryDark,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24.0),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  ref.read(formTransactionParameter.notifier).update(
                        (state) => state = state.copyWith(paymentStatus: PaymentStatus.notPaidOff),
                      );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  side: const BorderSide(color: secondaryDark),
                  backgroundColor:
                      selectedPayment == PaymentStatus.notPaidOff ? secondaryDark : null,
                ),
                child: Text(
                  "Belum Lunas",
                  style: bodyFont.copyWith(
                    color:
                        selectedPayment == PaymentStatus.notPaidOff ? Colors.white : secondaryDark,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
