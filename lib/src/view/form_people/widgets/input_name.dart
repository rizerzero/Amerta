part of '../form_people_modal.dart';

class _InputName extends ConsumerStatefulWidget {
  const _InputName({Key? key}) : super(key: key);

  @override
  _InputNameState createState() => _InputNameState();
}

class _InputNameState extends ConsumerState<_InputName> {
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    final value = ref.read(formPeopleParameter).name;
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
        Text('Nama', style: bodyFont),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: fn.defaultInputDecoration,
          onChanged: (val) =>
              ref.read(formPeopleParameter.notifier).update((state) => state.copyWith(name: val)),
        ),
      ],
    );
  }
}
