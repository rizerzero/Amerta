import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/model/transaction/recent_transaction_parameter.dart';
import '../../../utils/utils.dart';
import '../../../view_model/transaction/future_provider.dart';
import '../../home/widgets/transaction_tile.dart';

class PeopleDetailTabBarItem extends StatefulWidget {
  const PeopleDetailTabBarItem({
    Key? key,
    required this.transactionType,
    required this.peopleId,
  }) : super(key: key);

  final TransactionType transactionType;
  final String peopleId;

  @override
  State<PeopleDetailTabBarItem> createState() => _PeopleDetailTabBarItemState();
}

class _PeopleDetailTabBarItemState extends State<PeopleDetailTabBarItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Builder(
      builder: (context) {
        return Consumer(
          builder: (_, ref, __) {
            final _future = ref.watch(
              getRecentTransaction(
                RecentTransactionParameter(
                  type: widget.transactionType,
                  peopleId: widget.peopleId,
                ),
              ),
            );

            return _future.when(
              data: (data) {
                return CustomScrollView(
                  key: PageStorageKey(widget.transactionType),
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) => const TransactionTile(),
                          childCount: 1000,
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, trace) => Center(child: Text("$error")),
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
