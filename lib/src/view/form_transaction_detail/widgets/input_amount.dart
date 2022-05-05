part of '../form_transaction_detail_modal.dart';

class _InputAmount extends ConsumerStatefulWidget {
  const _InputAmount({Key? key}) : super(key: key);

  @override
  __InputAmountState createState() => __InputAmountState();
}

class __InputAmountState extends ConsumerState<_InputAmount> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final value = ref.read(formTransactionDetailParameter).amount;
    controller.text = NumberFormat().format(value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Nominal', style: bodyFont),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: fn.defaultInputDecoration.copyWith(
            hintText: "Nominal",
            prefix: const Text("Rp."),
          ),
          inputFormatters: [
            FormatNumberTextField(),
          ],
          onChanged: (val) => ref.watch(formTransactionDetailParameter.notifier).update(
                (state) => state.copyWith(amount: fn.unformatNumber(val)),
              ),
        ),
      ],
    );
  }
}
