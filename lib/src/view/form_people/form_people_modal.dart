import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../injection.dart';
import '../../model/model/people/people_insertorupdate_response.dart';
import '../../model/model/people/people_model.dart';
import '../../utils/utils.dart';
import '../../view_model/global/global_notifier.dart';
import '../../view_model/people/people_notifier.dart';
import '../widgets/modal_error.dart';
import '../widgets/modal_loading.dart';
import '../widgets/modal_success.dart';

part 'widgets/input_name.dart';
part 'widgets/input_image.dart';

class FormPeopleModal extends ConsumerStatefulWidget {
  const FormPeopleModal({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String? id;

  @override
  createState() => _FormPeopleModalState();
}

class _FormPeopleModalState extends ConsumerState<FormPeopleModal> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /// Listen [People Detail Notifier]
    ref.listen<AsyncValue<PeopleModel?>>(
      getPeopleById(widget.id),
      (_, state) {
        state.whenData(
          (item) {
            /// Update [form state]
            ref.watch(formPeopleParameter.notifier).update(
                  (state) => state.copyWith(
                    id: fn.isNullOrEmpty(item?.peopleId) ? const Uuid().v4() : item!.peopleId,
                    image: item?.imagePath == null ? null : File(item!.imagePath!),
                    name: item?.name ?? "",
                    createdAt: item?.createdAt ?? DateTime.now(),
                    updatedAt: item?.updatedAt,
                  ),
                );
          },
        );
      },
    );

    /// Listen [People Action Notifier]
    ref.listen<AsyncValue<PeopleInsertOrUpdateResponse?>>(
        peopleActionNotifier.select((value) => value.insertOrUpdateAsync), (_, state) async {
      if (state is AsyncLoading) {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) => const ModalLoadingWidget(),
        );
      } else {
        Navigator.pop(context);
        state.whenOrNull(
          data: (response) {
            /// Jika success membuat people
            /// Reset [Form People Parameter] & [Textfield]
            if (response!.isNewPeople) {
              _key.currentState?.reset();
              ref.invalidate(formPeopleParameter);
            }

            showDialog(
              context: context,
              builder: (context) => ModalSuccessWidget(message: response.message),
            );
          },
          error: (error, trace) => showDialog(
            context: context,
            builder: (context) => ModalErrorWidget(message: "$error"),
          ),
        );
      }
    });

    final people = ref.watch(getPeopleById(widget.id));
    return people.when(
      data: (_) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            scrollable: true,
            title: Text(
              "Form Orang",
              style: bodyFont.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _InputName(),
                  SizedBox(height: 16.0),
                  _InputImage(),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  final form = ref.read(formPeopleParameter);
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
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Batal",
                  style: bodyFont.copyWith(color: black),
                ),
              )
            ],
          ),
        ),
      ),
      error: (error, trace) => AlertDialog(content: Text("$error")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
