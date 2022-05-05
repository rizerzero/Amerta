part of '../form_people_modal.dart';

class _InputImage extends ConsumerWidget {
  const _InputImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFile = ref.watch(formPeopleParameter.select((value) => value.image));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Gambar (optional)', style: bodyFont),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: grey),
          ),
          child: TextButton.icon(
            onPressed: () async {
              final image = await fn.takeImage();
              if (image != null) {
                ref
                    .read(formPeopleParameter.notifier)
                    .update((state) => state.copyWith(image: image));
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
