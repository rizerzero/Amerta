import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../model/model/transaction/summary_transaction_model.dart';
import '../../../utils/utils.dart';
import '../../../view_model/transaction/people_summary_notifier.dart';
import '../../home/widgets/summary_amount.dart';
import '../../modal/modal_option_people/modal_option_people.dart';

part 'image_flexible_appbar.dart';
part 'title_flexible_appbar.dart';

class PeopleDetailSliverAppbar extends ConsumerWidget {
  const PeopleDetailSliverAppbar({
    Key? key,
    required this.peopleId,
  }) : super(key: key);

  final String peopleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final _future = ref.watch(getPeopleSummaryTransaction(peopleId));
        return _future.when(
          data: (data) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxHeight;
                final isCollapse = height <= kToolbarHeight + fn.notchTop(context);

                final iconBackButton = IconButton(
                  onPressed: () => context.goNamed(appRouteNamed),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                );

                final iconMoreButton = IconButton(
                  onPressed: () async => await showModalBottomSheet(
                    context: context,
                    builder: (context) => ModalOptionPeople(data: data),
                  ),
                  icon: const Icon(Icons.more_vert_outlined, color: Colors.white),
                );

                return FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(bottom: 8.0),
                  centerTitle: true,
                  title: _TitleFlexibleSpaceBar(
                    item: data,
                    isCollapse: isCollapse,
                    iconBackButton: iconBackButton,
                    iconMoreButton: iconMoreButton,
                  ),
                  background: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppBar(
                          elevation: 0,
                          leading: iconBackButton,
                          actions: [
                            iconMoreButton,
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0).copyWith(top: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ...[
                                  _ImageFlexibleAppBar(item: data),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    data.people.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: bodyFontWhite.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                ],
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SummaryAmount(
                                          title: "Hutang",
                                          amount: data.totalHutang,
                                        ),
                                      ),
                                      Expanded(
                                        child: SummaryAmount(
                                          title: "Piutang",
                                          amount: data.totalPiutang,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          error: (error, trace) {
            return Center(child: Text("$error", style: bodyFontWhite));
          },
          loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        );
      },
    );
  }
}
