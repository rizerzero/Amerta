part of '../form_transaction_page.dart';

class _Title extends ConsumerStatefulWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends ConsumerState<_Title> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final value = ref.read(formTransactionParameter).title;
    controller.text = value;
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
        Text('Judul', style: bodyFont),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: fn.defaultInputDecoration,
          validator: (val) {
            if (fn.isNullOrEmpty(val)) return "Judul tidak boleh kosong";
            return null;
          },
          onChanged: (val) => ref
              .read(formTransactionParameter.notifier)
              .update((state) => state.copyWith(title: val)),
        ),
      ],
    );
  }
}
