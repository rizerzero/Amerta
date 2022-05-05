part of '../form_transaction_page.dart';

class _LoanDate extends ConsumerStatefulWidget {
  const _LoanDate({Key? key}) : super(key: key);

  @override
  _LoanDateState createState() => _LoanDateState();
}

class _LoanDateState extends ConsumerState<_LoanDate> {
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();

    final value = ref.read(formTransactionParameter).loanDate;
    controller.text = DateFormat.yMMMMd().format(value);
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
        Text('Tanggal Peminjaman', style: bodyFont),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          readOnly: true,
          keyboardType: TextInputType.text,
          decoration: fn.defaultInputDecoration.copyWith(
            hintText: "Tanggal Peminjaman",
            prefixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          onTap: () async {
            final date = await fn.showDateTimePicker(context, withTimePicker: false);
            if (date != null) {
              ref
                  .read(formTransactionParameter.notifier)
                  .update((state) => state = state.copyWith(loanDate: date));
              controller.text = DateFormat.yMMMMd().format(date);
            }
          },
        ),
      ],
    );
  }
}
