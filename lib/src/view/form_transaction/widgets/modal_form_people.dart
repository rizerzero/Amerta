import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../injection.dart';
import '../../../model/model/people/people_form_parameter.dart';
import '../../../model/model/people/people_model.dart';
import '../../../utils/utils.dart';

class ModalFormPeople extends ConsumerStatefulWidget {
  const ModalFormPeople({
    Key? key,
    required this.peopleId,
  }) : super(key: key);

  final String peopleId;
  @override
  _ModalFormPeopleState createState() => _ModalFormPeopleState();
}

class _ModalFormPeopleState extends ConsumerState<ModalFormPeople> {
  final _nameController = TextEditingController();
  File? _selectedFile;
  Widget? errorWidget;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(peopleDetailNotifier.notifier).getById(widget.peopleId).then(
        (state) {
          state.item.when(
            data: (data) {
              setState(() {
                _nameController.text = data?.name ?? '';
                if (data?.imagePath != null) File(data!.imagePath!);
              });
            },
            error: (error, trace) {
              setState(() => errorWidget = _ErrorWidget(message: error.toString()));
            },
            loading: () {
              log('loading');
            },
          );
        },
      ),
    );
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
        "Form Orang",
        style: bodyFont.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (errorWidget != null) errorWidget!,
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
            final saveState =
                ref.watch(peopleActionNotifier.select((value) => value.insertOrUpdateAsync));

            ref.listen<AsyncValue<void>>(
                peopleActionNotifier.select((value) => value.insertOrUpdateAsync), (_, state) {
              state.whenOrNull(
                data: (_) => setState(() => errorWidget = null),
                error: (error, trace) =>
                    setState(() => errorWidget = _ErrorWidget(message: "$error")),
              );
            });

            if (saveState is AsyncLoading) {
              return const CircularProgressIndicator();
            }

            return ElevatedButton(
              onPressed: () async {
                final people = ref.read(peopleDetailNotifier).item.value;
                final form = PeopleFormParameter(
                  people: PeopleModel(
                    peopleId: people?.peopleId ?? const Uuid().v4(),
                    name: people?.name ?? '',
                    createdAt: people?.createdAt ?? DateTime.now(),
                    updatedAt: DateTime.now(),
                    imagePath: _selectedFile == null ? null : _selectedFile!.path,
                  ),
                );
                await ref.read(peopleActionNotifier.notifier).insertOrUpdate(form);
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
