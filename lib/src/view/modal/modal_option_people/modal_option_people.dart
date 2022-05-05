import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/model/transaction/summary_transaction_model.dart';
import '../../../utils/utils.dart';
import '../../form_people/form_people_modal.dart';
import '../../welcome/widgets/option_tile.dart';
import '../modal_remove_people/modal_remove_people.dart';

class ModalOptionPeople extends ConsumerWidget {
  const ModalOptionPeople({
    Key? key,
    required this.data,
  }) : super(key: key);

  final SummaryTransactionModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OptionTile(
            title: "Edit Profile",
            subtitle: "Mengkoreksi profile kamu jika terjadi kesalahan.",
            icon: Icons.edit_outlined,
            sideColor: primary,
            padding: const EdgeInsets.only(bottom: 16.0),
            onTap: () async {
              final successSavePeople = await showDialog<bool>(
                context: context,
                barrierDismissible: false,
                builder: (context) => FormPeopleModal(id: data.people.peopleId),
              );

              if (successSavePeople ?? false) {}
            },
          ),
          OptionTile(
            title: "Hapus Profile",
            subtitle: "Menghapus profile akan menghapus semua transaksi dan detailnya !",
            icon: Icons.delete_outline,
            sideColor: Colors.red,
            onTap: () async {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => ModalRemovePeople(data: data),
              );
            },
          )
        ],
      ),
    );
  }
}
