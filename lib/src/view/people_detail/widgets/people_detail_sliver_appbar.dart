import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';
import '../../../view_model/transaction/future_provider.dart';
import '../../home/widgets/summary_amount.dart';
import 'modal_more_option_people.dart';

class PeopleDetailSliverAppbar extends StatelessWidget {
  const PeopleDetailSliverAppbar({
    Key? key,
    required this.peopleId,
  }) : super(key: key);

  final String peopleId;

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                );

                final iconMoreButton = IconButton(
                  onPressed: () async => await showModalBottomSheet(
                    context: context,
                    builder: (context) => const ModalMoreOptionPeople(),
                  ),
                  icon: const Icon(
                    Icons.more_vert_outlined,
                    color: Colors.white,
                  ),
                );

                return FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(bottom: 8.0),
                  title: Builder(
                    builder: (context) {
                      if (!isCollapse) return const SizedBox();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconBackButton,
                          Expanded(
                            child: Text(
                              "Zeffry Reynando",
                              style: bodyFontWhite.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          iconMoreButton,
                        ],
                      );
                    },
                  ),
                  centerTitle: true,
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
                                  Hero(
                                    tag: peopleId,
                                    child: const Center(
                                      child: CircleAvatar(radius: 40.0),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    "Zeffry Reynando",
                                    style: bodyFontWhite.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16.0),
                                ],
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      Expanded(
                                        child: SummaryAmount(),
                                      ),
                                      Expanded(
                                        child: SummaryAmount(title: "Piutang"),
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
