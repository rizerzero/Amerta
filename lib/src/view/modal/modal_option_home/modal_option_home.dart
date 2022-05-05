import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../../form_people/form_people_modal.dart';
import '../../welcome/widgets/option_tile.dart';

class ModalOptionHome extends ConsumerWidget {
  const ModalOptionHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OptionTile(
            onTap: () => context.pushNamed(transactionFormNewRouteNamed),
            title: "Catat Piutang / Hutang",
            subtitle: "Mencatat transaksi piutang / hutang kamu.",
            icon: Icons.add_outlined,
            sideColor: Colors.green,
            padding: const EdgeInsets.only(bottom: 16.0),
          ),
          OptionTile(
            title: "Tambah Orang",
            subtitle: "Menambahkan daftar orang yang ingin dipinjami atau meminjami",
            icon: Icons.people_outline,
            sideColor: Colors.teal,
            padding: const EdgeInsets.only(bottom: 16.0),
            onTap: () async {
              await showDialog<bool>(
                context: context,
                barrierDismissible: false,
                builder: (context) => const FormPeopleModal(id: null),
              );
            },
          ),
        ],
      ),
    );
  }
}
