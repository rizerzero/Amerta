part of '../form_transaction_page.dart';

class _ButtonSubmit extends ConsumerWidget {
  const _ButtonSubmit({
    Key? key,
    // required this.formKey,
  }) : super(key: key);

  // final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () async {
          final validate = _formKey.currentState?.validate() ?? false;
          if (!validate) return;
          final form = ref.read(formTransactionParameter);
          await ref.read(transactionActionNotifier.notifier).insertOrUpdateTransaction(form);
        },
        style: ElevatedButton.styleFrom(
          primary: secondaryDark,
          padding: const EdgeInsets.all(24.0),
        ),
        child: Text(
          "Submit",
          style: bodyFontWhite.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
