import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../injection.dart';
import '../../model/model/payment/payment_insertorupdate_response.dart';
import '../../model/model/payment/payment_model.dart';
import '../../utils/utils.dart';
import '../../view_model/global/global_notifier.dart';
import '../../view_model/payment/payment_notifier.dart';
import '../widgets/modal_loading.dart';

part 'widgets/input_description.dart';
part 'widgets/input_attachment.dart';
part 'widgets/input_amount.dart';

class FormPaymentModal extends ConsumerWidget {
  const FormPaymentModal({
    Key? key,
    required this.id,
    required this.transactionId,
    required this.peopleId,
  }) : super(key: key);

  final String? id;
  final String transactionId;
  final String peopleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Listen [paymentNotifier]
    ref.listen<AsyncValue<PaymentModel?>>(
      getPaymentById(id),
      (_, state) {
        /// Ketika berhasil load detail transaksi
        /// Setup [form transaction detail parameter]
        state.whenOrNull(
          data: (item) {
            ref.watch(formPaymentParameter.notifier).update(
                  (state) => state.copyWith(
                    id: item?.id ?? const Uuid().v4(),
                    transactionId: transactionId,
                    peopleId: peopleId,
                    amount: item?.amount ?? 0,
                    attachment: item?.attachmentPath == null ? null : File(item!.attachmentPath!),
                    description: item?.description ?? '',
                    date: item?.date ?? DateTime.now(),
                    createdAt: item?.createdAt,
                    updatedAt: item?.updatedAt,
                  ),
                );
          },
        );
      },
    );

    ref.listen<AsyncValue<PaymentInsertOrUpdateResponse?>>(
      paymentActionNotifier.select((value) => value.insertOrUpdate),
      (_, state) {
        if (state is AsyncLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ModalLoadingWidget(),
          );
          return;
        }

        state.whenOrNull(
          /// When success create transaction detail
          /// Reset [TextField, Form Transaction Detail Parameter]
          data: (response) =>
              fn.showSnackbar(context, title: "${response?.message}", color: Colors.green),
          error: (error, trace) => fn.showSnackbar(context, title: "$error", color: Colors.red),
        );

        /// Tutup Modal Form & Loading
        int count = 0;
        Navigator.popUntil(context, (route) => count++ == 2);
      },
    );
    final future = ref.watch(getPaymentById(id));
    return future.when(
      data: (item) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            id == null ? "Form Pembayaran" : "Form Edit Pembayaran",
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const [
              _InputAmount(),
              SizedBox(height: 16.0),
              _InputDescription(),
              SizedBox(height: 16.0),
              _InputAttachment(),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final form = ref.read(formPaymentParameter);
                await ref.read(paymentActionNotifier.notifier).insertOrUpdatePayment(form);
              },
              style: ElevatedButton.styleFrom(primary: secondaryDark),
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
      },
      error: (error, trace) => AlertDialog(content: Text("$error")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
