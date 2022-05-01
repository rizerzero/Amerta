import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ModalFormPerson extends StatefulWidget {
  const ModalFormPerson({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  @override
  State<ModalFormPerson> createState() => _ModalFormPersonState();
}

class _ModalFormPersonState extends State<ModalFormPerson> {
  final _nameController = TextEditingController();

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
                onPressed: () {},
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
          ],
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: secondaryDark,
          ),
          child: Text(
            "Submit",
            style: bodyFontWhite.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
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
