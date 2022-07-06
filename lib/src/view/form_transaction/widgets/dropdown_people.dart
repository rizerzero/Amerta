part of '../form_transaction_page.dart';

class _DropdownPeople extends ConsumerWidget {
  const _DropdownPeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeople = ref.watch(
      formTransactionParameter.select((value) => value.selectedPeople),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Orang', style: bodyFont),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Consumer(
                builder: (context, ref, child) {
                  final future = ref.watch(getDropdownPeoples);
                  return future.when(
                    data: (data) {
                      return DropdownButtonFormField<PeopleModel?>(
                        value: selectedPeople,
                        isDense: true,
                        isExpanded: true,
                        decoration: fn.defaultInputDecoration,
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Pilih orang",
                            style: bodyFont.copyWith(color: grey),
                          ),
                        ),
                        items: data
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(e.name),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          ref
                              .read(formTransactionParameter.notifier)
                              .update((state) => state = state.copyWith(selectedPeople: val));
                        },
                        validator: (val) {
                          if (val == null) return "Orang harus dipilih";
                          return null;
                        },
                      );
                    },
                    error: (error, trace) => Center(child: Text("$error")),
                    loading: () =>
                        const Center(child: CircularProgressIndicator(color: secondaryDark)),
                  );
                },
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () async {
                  await showDialog<bool>(
                    context: context,
                    builder: (ctx) => const FormPeopleModal(id: null),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: secondaryDark,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
