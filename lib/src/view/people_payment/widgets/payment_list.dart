part of '../people_payment_page.dart';

class _DetailTransactionList extends StatelessWidget {
  const _DetailTransactionList({
    Key? key,
    required this.transactionId,
  }) : super(key: key);

  final String transactionId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final future = ref.watch(getPayments(PaymentsParameter(transactionId: transactionId)));
        return future.when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: data.entries.map((e) {
                final date = e.key;
                final items = e.value;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Header(date: date),
                      const Divider(height: 0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: ListTile.divideTiles(
                          context: context,
                          color: grey,
                          tiles: List.generate(
                            items.length,
                            (index) {
                              final item = items[index];
                              return ListTile(
                                isThreeLine: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: secondaryLight,
                                      foregroundColor: Colors.white,
                                      radius: 15.0,
                                      child: Text("${index + 1}"),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  "#${item.id}",
                                  style: bodyFont.copyWith(
                                    fontSize: 10.0,
                                    color: primary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 8.0),
                                    Text(
                                      fn.rupiahCurrency(item.amount),
                                      style: bodyFont.copyWith(
                                        color: secondaryDark,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    if (item.description != null ||
                                        (item.description?.isNotEmpty ?? true)) ...[
                                      Text(
                                        "${item.description}",
                                        style: bodyFont.copyWith(
                                          color: grey,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                    _ButtonAction(item: item),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
          error: (error, trace) => Center(
            child: Text(
              "$error",
              style: bodyFont.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class _ButtonAction extends StatelessWidget {
  const _ButtonAction({
    Key? key,
    required this.item,
  }) : super(key: key);

  final PaymentModel item;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      children: [
        OutlinedButton(
          onPressed: () async {
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => FormPaymentModal(
                id: item.id,
                peopleId: item.peopleId,
                transactionId: item.transactionId,
              ),
            );
          },
          style: TextButton.styleFrom(side: const BorderSide(color: primary)),
          child: Text("Edit", style: bodyFont.copyWith(color: primary)),
        ),
        OutlinedButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => ModalRemovePayment(id: item.id),
            );
          },
          style: TextButton.styleFrom(side: const BorderSide(color: Colors.red)),
          child: Text("Hapus", style: bodyFont.copyWith(color: Colors.red)),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: secondaryDark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat.yMMMMEEEEd().format(date),
            style: bodyFontWhite.copyWith(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
