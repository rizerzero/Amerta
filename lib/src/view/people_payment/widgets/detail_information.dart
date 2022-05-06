part of '../people_payment_page.dart';

class _DetailInformation extends StatelessWidget {
  const _DetailInformation({
    Key? key,
    required this.param,
  }) : super(key: key);

  final PaymentSummaryParameter param;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(8.0),
        ),
      ),
      margin: EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: fn.vh(context) / 3),
        child: Consumer(
          builder: (context, ref, child) {
            final _future = ref.watch(getPaymentSummary(param));

            return _future.when(
              data: (data) {
                final remainingPayment = data!.amount - (data.amountPayment ?? 0);
                final progressBar = data.amountPayment == null
                    ? 0.0
                    : fn.getPercentage(data.amountPayment!, data.amount);

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        data.people.name,
                        style: bodyFont.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(data.title, style: bodyFontWhite),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Text(
                            DateFormat.yMMMMEEEEd().format(data.loanDate),
                            style: bodyFontWhite.copyWith(fontSize: 12.0),
                          ),
                          Text(" - ", style: bodyFontWhite),
                          Text(
                            fn.isNullOrEmpty(data.returnDate)
                                ? "Tidak ditentukan"
                                : DateFormat.yMMMMEEEEd().format(data.returnDate!),
                            style: bodyFontWhite.copyWith(fontSize: 12.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Nominal",
                                  textAlign: TextAlign.center,
                                  style: bodyFontWhite.copyWith(
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    fn.rupiahCurrency(data.amount),
                                    style: bodyFontWhite.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Progress Pembayaran",
                                  textAlign: TextAlign.center,
                                  style: bodyFontWhite.copyWith(color: Colors.white54),
                                ),
                                const SizedBox(height: 8.0),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    fn.rupiahCurrency(data.amountPayment ?? 0),
                                    style: bodyFontWhite.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ...[
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          child: FractionallySizedBox(
                            heightFactor: 1,
                            widthFactor: progressBar / 100,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: secondaryLight,
                                borderRadius: BorderRadiusDirectional.circular(60.0),
                                border: Border.all(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text.rich(
                          TextSpan(
                            text: "Sisa pembayaran : ${fn.rupiahCurrency(remainingPayment)}",
                            children: [
                              TextSpan(
                                text:
                                    " (${fn.getPercentage(data.amountPayment ?? 0, data.amount)}%) ",
                                style: bodyFontWhite.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          style: bodyFontWhite.copyWith(fontSize: 8.0),
                          textAlign: TextAlign.right,
                        ),
                      ],
                      const SizedBox(height: 16.0),
                    ],
                  ),
                );
              },
              error: (error, trace) => Center(child: Text("$error", style: bodyFontWhite)),
              loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
            );
          },
        ),
      ),
    );
  }
}
