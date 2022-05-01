import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';

class ModalFormPeople extends ConsumerStatefulWidget {
  const ModalFormPeople({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  @override
  _ModalFormPeopleState createState() => _ModalFormPeopleState();
}

class _ModalFormPeopleState extends ConsumerState<ModalFormPeople> {
  final _nameController = TextEditingController();
  File? _selectedFile;
  Widget errorWidget = const SizedBox();

  @override
  void initState() {
    super.initState();

    Future.microtask(() => _initPeople());
  }

  Future<void> _initPeople() async {
    final people = (await ref.read(peopleDetailNotifier.notifier).getById(widget.userId)).people;
    setState(() {
      _nameController.text = people.name;
      if (people.imagePath != null) {
        _selectedFile = File(people.imagePath!);
      }
    });
  }

  final inputDecoration = InputDecoration(
    hintText: "Name",
    hintStyle: bodyFont.copyWith(color: grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        "Tambah Orang",
        style: bodyFont.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          errorWidget,
          ...[
            Text('Nama', style: bodyFont),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _nameController,
              decoration: inputDecoration,
            ),
            const SizedBox(height: 16.0),
          ],
          ...[
            Text('Gambar (optional)', style: bodyFont),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: grey),
              ),
              child: TextButton.icon(
                onPressed: () async {
                  final image = await fn.takeImage();
                  if (image != null) setState(() => _selectedFile = image);
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
            if (_selectedFile != null)
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    _selectedFile!,
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
              )
          ],
        ],
      ),
      actions: [
        Consumer(
          builder: (_, ref, child) {
            final peopleState = ref.watch(
              peoplesNotifier.select((value) => value.createOrUpdate),
            );

            ref.listen<AsyncValue>(
              peoplesNotifier.select((value) => value.createOrUpdate),
              (_, state) {
                state.whenOrNull(
                  data: (_) {
                    setState(() {
                      errorWidget = const SizedBox();
                      _nameController.clear();
                      _selectedFile = null;
                    });
                  },
                  error: (error, stackTrace) {
                    setState(() => errorWidget = _ErrorWidget(message: error.toString()));
                  },
                );
              },
            );

            if (peopleState is AsyncLoading) {
              return const CircularProgressIndicator();
            }

            return ElevatedButton(
              onPressed: () async {
                final people = ref.read(peopleDetailNotifier).people.copyWith(
                      name: _nameController.text,
                      imagePath: _selectedFile?.path,
                    );

                await ref.read(peoplesNotifier.notifier).createOrUpdate(
                      people,
                    );
              },
              style: ElevatedButton.styleFrom(
                primary: secondaryDark,
              ),
              child: Text(
                "Submit",
                style: bodyFontWhite.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Batal",
            style: bodyFont.copyWith(color: black),
          ),
        )
      ],
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    Key? key,
    this.message = '',
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        color: Colors.red,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: bodyFontWhite,
          ),
        ),
      ),
    );
  }
}
