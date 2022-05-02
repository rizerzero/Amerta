import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/model/transaction/recent_transaction_parameter.dart';
import '../../../utils/utils.dart';
import '../../../view_model/transaction/future_provider.dart';
import 'transaction_tile.dart';

class HomeTabBarItem extends StatefulWidget {
  const HomeTabBarItem({
    Key? key,
    required this.transactionType,
  }) : super(key: key);

  final TransactionType transactionType;
  @override
  _HomeTabBarItemState createState() => _HomeTabBarItemState();
}

class _HomeTabBarItemState extends State<HomeTabBarItem> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    /// We use builder to get parent context of [nestedScrollView]
    /// The [context] will use for [sliverOverlapInjector]
    /// When we not do this, our [TabItem] will behind the [sliverAppBar]
    return Builder(
      builder: (context) {
        return Consumer(
          builder: (_, ref, __) {
            final _future = ref.watch(getRecentTransaction(
              RecentTransactionParameter(type: widget.transactionType),
            ));
            return _future.when(
              data: (data) {
                return CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),

                  /// Untuk menyimpan last scroll position
                  key: PageStorageKey(widget.transactionType),
                  slivers: [
                    /// Akumulasi jarak/space berdasarkan jumlah sliver yang berada didalam [SliverOverlapAbsorber]
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) => const TransactionTile(),
                          childCount: 20000,
                        ),
                      ),
                    )
                  ],
                );
              },
              error: (error, trace) => Center(child: Text(error.toString())),
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
