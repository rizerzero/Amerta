import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../model/model/transaction/recent_transaction_parameter.dart';
import '../../utils/utils.dart';
import '../../view_model/transaction/future_provider.dart';
import 'widgets/people_detail_sliver_appbar.dart';
import 'widgets/people_detail_sliver_tabbar.dart';
import 'widgets/people_detail_tabbar_item.dart';

class PeopleDetailPage extends ConsumerWidget {
  const PeopleDetailPage({
    Key? key,
    required this.peopleId,
  }) : super(key: key);

  final String peopleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: TransactionType.values.length,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(getPeopleSummaryTransaction(peopleId));

            final param = RecentTransactionParameter(
              type: TransactionType.hutang,
              peopleId: peopleId,
            );

            ref.refresh(getRecentTransaction(param));
            ref.refresh(getRecentTransaction(param.copyWith(type: TransactionType.piutang)));
          },
          notificationPredicate: (notification) => notification.depth == 2,
          child: NestedScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: MultiSliver(
                  pushPinnedChildren: false,
                  children: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      expandedHeight: fn.vh(context) / 2.5,
                      backgroundColor: primary,
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: PeopleDetailSliverAppbar(peopleId: peopleId),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: PeopleDetailSliverTabBar(
                        tabBar: TabBar(
                          unselectedLabelStyle: bodyFont.copyWith(color: black),
                          unselectedLabelColor: black,
                          indicator: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          tabs: TransactionType.values
                              .map(
                                (e) => Tab(text: e.name.toUpperCase()),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              children: TransactionType.values
                  .map(
                    (transactionType) => PeopleDetailTabBarItem(
                      transactionType: transactionType,
                      peopleId: peopleId,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
