part of '../form_transaction_page.dart';

class _Description extends ConsumerStatefulWidget {
  const _Description({Key? key}) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends ConsumerState<_Description> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final value = ref.read(formTransactionParameter).description;
    controller.text = value ?? '';
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
        Text('Deskripsi', style: bodyFont),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          minLines: 3,
          maxLines: 3,
          keyboardType: TextInputType.text,
          decoration: fn.defaultInputDecoration.copyWith(
            hintText: "Deskripsi",
          ),
          onChanged: (val) => ref
              .read(formTransactionParameter.notifier)
              .update((state) => state.copyWith(description: val)),
        ),
      ],
    );
  }
}
