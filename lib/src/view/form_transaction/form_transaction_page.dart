import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../injection.dart';
import '../../model/model/people/people_model.dart';
import '../../model/model/transaction/transaction_insertorupdate_response.dart';
import '../../model/model/transaction/transaction_model.dart';
import '../../utils/utils.dart';
import '../../view_model/global/global_notifier.dart';
import '../../view_model/people/people_dropdown_notifier.dart';
import '../form_people/form_people_modal.dart';
import '../widgets/modal_loading.dart';
import '../widgets/modal_success.dart';

part 'widgets/amount.dart';
part 'widgets/attachment.dart';
part 'widgets/description.dart';
part 'widgets/dropdown_people.dart';
part 'widgets/loan_date.dart';
part 'widgets/payment_status.dart';
part 'widgets/return_date.dart';
part 'widgets/title.dart';
part 'widgets/transaction_type.dart';
part 'widgets/button_submit.dart';

final _formKey = GlobalKey<FormState>();

class FormTransactionPage extends ConsumerStatefulWidget {
  const FormTransactionPage({
    Key? key,
    required this.transactionId,
  }) : super(key: key);

  final String? transactionId;

  @override
  _FormTransactionPageState createState() => _FormTransactionPageState();
}

class _FormTransactionPageState extends ConsumerState<FormTransactionPage> {
  @override
  Widget build(BuildContext context) {
    /// Listen [transactionNotifier]
    /// Ketika berhasil load [transactionNotifier]
    /// Set initial [formTransactionParameter]
    ref.listen<AsyncValue<TransactionModel?>>(
      transactionNotifier(widget.transactionId).select((value) => value.item),
      (_, state) {
        state.whenOrNull(
          data: (item) {
            /// Update [form transaction state]
            ref.watch(formTransactionParameter.notifier).update(
                  (state) => state.copyWith(
                    transactionId: fn.isNullOrEmpty(item?.id) ? const Uuid().v4() : item!.id,
                    title: item?.title,
                    amount: item?.amount ?? 0,
                    description: item?.description,
                    loanDate: item?.loanDate == null ? DateTime.now() : item!.loanDate,
                    returnDate: item?.returnDate,
                    selectedPeople: item?.people,
                    attachment: item?.attachmentPath == null ? null : File(item!.attachmentPath!),
                    createdAt: item?.createdAt,
                    paymentStatus: item?.status,
                    transactionType: item?.type,
                    updatedAt: item?.updatedAt,
                  ),
                );
          },
        );
      },
    );

    /// Listen [Save State]
    ref.listen<AsyncValue<TransactionInsertOrUpdateResponse?>>(
      transactionActionNotifier.select((value) => value.insertOrUpdate),
      (_, state) async {
        if (state is AsyncLoading) {
          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) => const ModalLoadingWidget(),
          );
        } else {
          Navigator.pop(context);

          state.whenOrNull(
            /// Ketika berhasil save transaction
            /// 1. Reset [formTransactionParameter]
            /// 2. Reset Textfield
            data: (response) async {
              if (response!.isNewTransaction) {
                /// Jika sukses reset [state,form] dan munculkan alert success
                _formKey.currentState?.reset();
                ref.invalidate(formTransactionParameter);
              }

              /// Show success modal
              showDialog(
                context: context,
                builder: (context) => ModalSuccessWidget(
                  message: response.message,
                ),
              );
            },
            error: (error, trace) => fn.showSnackbar(context, title: "$error", color: Colors.red),
          );
        }
      },
    );

    final _state = ref.watch(transactionNotifier(widget.transactionId));

    return _state.item.when(
      data: (data) {
        return GestureDetector(
          /// Jike menekan ke sembarang tempat, non-aktifkan focus input
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, color: secondaryDark),
              ),
              title: Text(
                data == null ? "Catat Hutang/Piutang" : "Edit Hutang/Piutang",
                style: headerFont.copyWith(
                  fontWeight: FontWeight.bold,
                  color: secondaryDark,
                ),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            SizedBox(height: 40.0),
                            _DropdownPeople(),
                            SizedBox(height: 16.0),
                            _Title(),
                            SizedBox(height: 16.0),
                            _Amount(),
                            SizedBox(height: 16.0),
                            _LoanDate(),
                            SizedBox(height: 16.0),
                            _ReturnDate(),
                            SizedBox(height: 16.0),
                            _Description(),
                            SizedBox(height: 16.0),
                            _TransactionType(),
                            SizedBox(height: 16.0),
                            _PaymentStatus(),
                            SizedBox(height: 16.0),
                            _Attachment(),
                            SizedBox(height: 40.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const _ButtonSubmit()
                ],
              ),
            ),
          ),
        );
      },
      error: (error, trace) => Scaffold(body: Center(child: Text("$error"))),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
