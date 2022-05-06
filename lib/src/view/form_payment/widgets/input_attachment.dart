part of '../form_payment_modal.dart';

class _InputAttachment extends ConsumerWidget {
  const _InputAttachment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFile = ref.watch(formPaymentParameter.select((value) => value.attachment));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Lampiran (optional)', style: bodyFont),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: grey),
          ),
          child: TextButton.icon(
            onPressed: () async {
              final file = await fn.takeImage(source: ImageSource.gallery);
              if (file != null) {
                ref
                    .watch(formPaymentParameter.notifier)
                    .update((state) => state = state.copyWith(attachment: file));
              }
            },
            icon: const Icon(
              Icons.image,
              color: black,
            ),
            label: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "Tekan untuk menambahkan lampiran",
                style: bodyFont.copyWith(
                  color: black,
                ),
              ),
            ),
          ),
        ),
        if (selectedFile != null)
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                selectedFile,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
          )
      ],
    );
  }
}
