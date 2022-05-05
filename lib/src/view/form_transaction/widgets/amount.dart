part of '../form_transaction_page.dart';

class _Amount extends ConsumerStatefulWidget {
  const _Amount({Key? key}) : super(key: key);

  @override
  _AmountState createState() => _AmountState();
}

class _AmountState extends ConsumerState<_Amount> {
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    final value = ref.read(formTransactionParameter).amount;
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
          onChanged: (val) => ref
              .read(formTransactionParameter.notifier)
              .update((state) => state.copyWith(amount: fn.unformatNumber(val))),
        ),
      ],
    );
  }
}
