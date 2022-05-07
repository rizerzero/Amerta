import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../model/model/transaction/recent_transaction_parameter.dart';
import '../../utils/utils.dart';
import '../../view_model/people/people_latest_ten_notifier.dart';
import '../../view_model/transaction/people_summary_notifier.dart';
import '../../view_model/transaction/recent_transaction_notifier.dart';
import 'widgets/home_header_content.dart';
import 'widgets/home_tabbar_item.dart';
import 'widgets/home_tabbar_persistent_header.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarHeight = fn.vh(context) / 2;
    return DefaultTabController(
      length: TransactionType.values.length,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(getLatestTenPeople);

          ref.refresh(getPeopleSummaryTransaction(null));

          ref.refresh(
            getTransactions(const RecentTransactionParameter(type: TransactionType.hutang)),
          );

          ref.refresh(
            getTransactions(const RecentTransactionParameter(type: TransactionType.piutang)),
          );
        },
        notificationPredicate: (notification) {
          return true;
          // log("notification ${notification.depth}");
          // return notification.depth == 2;
        },
        child: NestedScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: MultiSliver(
                  pushPinnedChildren: false,
                  children: [
                    SliverAppBar(
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      pinned: true,
                      expandedHeight: appBarHeight,
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: const HomeHeaderContent(),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: HomeTabBarPersistentHeader(
                        tabbar: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white54,
                          onTap: (index) {},
                          indicator: const BoxDecoration(
                            color: primary,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
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
            ];
          },
          body: TabBarView(
            children: TransactionType.values
                .map((transactionType) => HomeTabBarItem(transactionType: transactionType))
                .toList(),
          ),
        ),
      ),
    );
  }
}
