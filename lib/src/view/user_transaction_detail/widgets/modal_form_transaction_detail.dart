import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/utils.dart';

class ModalFormTransactionDetail extends StatefulWidget {
  const ModalFormTransactionDetail({Key? key}) : super(key: key);

  @override
  _ModalFormTransactionDetailState createState() => _ModalFormTransactionDetailState();
}

class _ModalFormTransactionDetailState extends State<ModalFormTransactionDetail> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

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
      title: const Text(
        "Edit Transaksi",
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...[
            Text('Nominal', style: bodyFont),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: inputDecoration.copyWith(
                hintText: "Nominal",
                prefix: const Text("Rp."),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 16.0),
          ],
          ...[
            Text('Deskripsi', style: bodyFont),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 3,
              keyboardType: TextInputType.text,
              decoration: inputDecoration.copyWith(
                hintText: "Deskripsi",
              ),
            ),
            const SizedBox(height: 16.0),
          ],
          ...[
            Text('Lampiran (optional)', style: bodyFont),
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
                label: Text(
                  "Tekan untuk menambahkan lampiran",
                  style: bodyFont.copyWith(
                    color: black,
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
          style: ElevatedButton.styleFrom(primary: primary),
          child: Text(
            "Submit",
            style: bodyFontWhite.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Batal",
            style: bodyFont.copyWith(color: grey),
          ),
        ),
      ],
    );
  }
}
