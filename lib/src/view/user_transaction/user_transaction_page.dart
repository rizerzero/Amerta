import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../utils/utils.dart';
import '../home/widgets/summary_amount.dart';
import '../home/widgets/transaction_tile.dart';
import 'widgets/modal_more_option_transaction.dart';
import 'widgets/sliver_tabbar_transaction_type.dart';

class UserTransactionPage extends StatelessWidget {
  const UserTransactionPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TransactionType.values.length,
      child: Scaffold(
        body: NestedScrollView(
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
                    flexibleSpace: LayoutBuilder(
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
                            builder: (context) => const ModalMoreOptionTransaction(),
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
                                            tag: userId,
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
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverTabBarTransactionType(
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
                  (e) => Builder(
                    builder: (context) {
                      return CustomScrollView(
                        key: PageStorageKey(e),
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
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
