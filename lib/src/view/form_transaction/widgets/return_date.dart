part of '../form_transaction_page.dart';

class _ReturnDate extends ConsumerStatefulWidget {
  const _ReturnDate({Key? key}) : super(key: key);

  @override
  _ReturnDateState createState() => _ReturnDateState();
}

class _ReturnDateState extends ConsumerState<_ReturnDate> {
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    final value = ref.read(formTransactionParameter).returnDate;
    controller.text = fn.isNullOrEmpty(value) ? "" : DateFormat.yMMMMd().format(value!);
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
        Text('Tanggal Pengembalian (optional)', style: bodyFont),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          readOnly: true,
          keyboardType: TextInputType.text,
          decoration: fn.defaultInputDecoration.copyWith(
            hintText: "Tanggal Pengembalian",
            prefixIcon: const Icon(Icons.calendar_month_outlined),
          ),
          onTap: () async {
            final date = await fn.showDateTimePicker(context, withTimePicker: false);
            if (date != null) {
              ref
                  .read(formTransactionParameter.notifier)
                  .update((state) => state.copyWith(returnDate: date));
              controller.text = DateFormat.yMMMMd().format(date);
            }
          },
        ),
      ],
    );
  }
}
