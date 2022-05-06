part of '../form_payment_modal.dart';

class _InputDescription extends ConsumerStatefulWidget {
  const _InputDescription({Key? key}) : super(key: key);

  @override
  _InputDescriptionState createState() => _InputDescriptionState();
}

class _InputDescriptionState extends ConsumerState<_InputDescription> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final value = ref.read(formPaymentParameter).description;
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
              .watch(formPaymentParameter.notifier)
              .update((state) => state.copyWith(description: val)),
        ),
      ],
    );
  }
}
