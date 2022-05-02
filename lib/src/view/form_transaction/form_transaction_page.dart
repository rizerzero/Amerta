import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';
import 'widgets/modal_form_people.dart';

class FormTransactionPage extends StatefulWidget {
  const FormTransactionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FormTransactionPage> createState() => _FormTransactionPageState();
}

class _FormTransactionPageState extends State<FormTransactionPage> {
  String? _selectedPerson;
  TransactionType _selectedTransactionType = TransactionType.piutang;
  PaymentStatus _selectedPaymentStatus = PaymentStatus.notPaidOff;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _loanDateController = TextEditingController();
  final _returnDateController = TextEditingController();
  final _descriptionController = TextEditingController();

  final inputDecoration = InputDecoration(
    hintText: "Judul",
    hintStyle: bodyFont.copyWith(color: grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// Jike menekan ke sembarang tempat, non-aktifkan focus input
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: secondaryDark,
            ),
          ),
          title: Text(
            "Catat Hutang/Piutang",
            style: headerFont.copyWith(
              fontWeight: FontWeight.bold,
              color: secondaryDark,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40.0),
                      ...[
                        Text('Orang', style: bodyFont),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: DropdownButton<String>(
                                  value: _selectedPerson,
                                  isDense: true,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  hint: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      "Pilih orang",
                                      style: bodyFont.copyWith(color: grey),
                                    ),
                                  ),
                                  items: ["Annisa Nakia", "Rifda", "Fani", "Icha", "Kurniati"]
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(e),
                                          ),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() => _selectedPerson = val);
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (ctx) => const ModalFormPeople(
                                      peopleId: "",
                                    ),
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
                        const SizedBox(height: 24.0),
                      ],
                      ...[
                        Text('Judul', style: bodyFont),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _titleController,
                          decoration: inputDecoration,
                        ),
                        const SizedBox(height: 24.0),
                      ],
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
                        const SizedBox(height: 24.0),
                      ],
                      ...[
                        Text('Tanggal Peminjaman', style: bodyFont),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _loanDateController,
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          decoration: inputDecoration.copyWith(
                            hintText: "Tanggal Peminjaman",
                            prefixIcon: const Icon(Icons.calendar_today_outlined),
                          ),
                          onTap: () async {
                            fn.showDateTimePicker(
                              context,
                              withTimePicker: false,
                            );
                          },
                        ),
                        const SizedBox(height: 24.0),
                      ],
                      ...[
                        Text('Tanggal Pengembalian (optional)', style: bodyFont),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _returnDateController,
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          decoration: inputDecoration.copyWith(
                            hintText: "Tanggal Pengembalian",
                            prefixIcon: const Icon(Icons.calendar_month_outlined),
                          ),
                          onTap: () async {
                            fn.showDateTimePicker(
                              context,
                              withTimePicker: false,
                            );
                          },
                        ),
                        const SizedBox(height: 24.0),
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
                        const SizedBox(height: 24.0),
                      ],
                      ...[
                        Text('Tipe Transaksi', style: bodyFont),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(
                                      () => _selectedTransactionType = TransactionType.piutang);
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  side: const BorderSide(color: secondaryDark),
                                  backgroundColor:
                                      _selectedTransactionType == TransactionType.piutang
                                          ? secondaryDark
                                          : null,
                                ),
                                child: Text(
                                  "Piutang",
                                  style: bodyFont.copyWith(
                                      color: _selectedTransactionType == TransactionType.piutang
                                          ? Colors.white
                                          : secondaryDark),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24.0),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() => _selectedTransactionType = TransactionType.hutang);
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  side: const BorderSide(color: secondaryDark),
                                  backgroundColor:
                                      _selectedTransactionType == TransactionType.hutang
                                          ? secondaryDark
                                          : null,
                                ),
                                child: Text(
                                  "Hutang",
                                  style: bodyFont.copyWith(
                                    color: _selectedTransactionType == TransactionType.hutang
                                        ? Colors.white
                                        : secondaryDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24.0),
                      ],
                      ...[
                        Text('Status', style: bodyFont),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() => _selectedPaymentStatus = PaymentStatus.paidOff);
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  side: const BorderSide(color: secondaryDark),
                                  backgroundColor: _selectedPaymentStatus == PaymentStatus.paidOff
                                      ? secondaryDark
                                      : null,
                                ),
                                child: Text(
                                  "Lunas",
                                  style: bodyFont.copyWith(
                                    color: _selectedPaymentStatus == PaymentStatus.paidOff
                                        ? Colors.white
                                        : secondaryDark,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24.0),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() => _selectedPaymentStatus = PaymentStatus.notPaidOff);
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  side: const BorderSide(color: secondaryDark),
                                  backgroundColor:
                                      _selectedPaymentStatus == PaymentStatus.notPaidOff
                                          ? secondaryDark
                                          : null,
                                ),
                                child: Text(
                                  "Belum Lunas",
                                  style: bodyFont.copyWith(
                                    color: _selectedPaymentStatus == PaymentStatus.notPaidOff
                                        ? Colors.white
                                        : secondaryDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24.0),
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
                      const SizedBox(height: 40.0),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: secondaryDark,
                  padding: const EdgeInsets.all(24.0),
                ),
                child: Text(
                  "Submit",
                  style: bodyFontWhite.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
