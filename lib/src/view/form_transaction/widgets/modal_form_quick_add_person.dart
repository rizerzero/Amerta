import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ModalFormQuickAddPerson extends StatefulWidget {
  const ModalFormQuickAddPerson({
    Key? key,
  }) : super(key: key);

  @override
  State<ModalFormQuickAddPerson> createState() => _ModalFormQuickAddPersonState();
}

class _ModalFormQuickAddPersonState extends State<ModalFormQuickAddPerson> {
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
