import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../utils/utils.dart';
import 'widgets/home_header_content.dart';
import 'widgets/home_tabbar_persistent_header.dart';
import 'widgets/transaction_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarHeight = fn.vh(context) / 2;

    return DefaultTabController(
      length: TransactionType.values.length,
      child: NestedScrollView(
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
              .map(
                (e) => Builder(
                  builder: (context) {
                    return RefreshIndicator(
                      onRefresh: () async => log("tes"),
                      child: CustomScrollView(
                        /// Untuk menyimpan last scroll position
                        key: PageStorageKey(e),
                        primary: true,
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
                      ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
      // child: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       automaticallyImplyLeading: false,
      //       elevation: 0,
      //       pinned: true,
      //       expandedHeight: appBarHeight,
      //       flexibleSpace: const HomeHeaderContent(),
      //     ),
      //     SliverPersistentHeader(
      //       pinned: true,
      //       delegate: HomeTabBarPersistentHeader(
      //         tabbar: TabBar(
      //           labelColor: Colors.white,
      //           unselectedLabelColor: Colors.white54,
      //           onTap: (index) {},
      //           indicator: const BoxDecoration(
      //             color: primary,
      //             border: Border(
      //               bottom: BorderSide(
      //                 color: Colors.white,
      //                 width: 2,
      //               ),
      //             ),
      //           ),
      //           tabs: TransactionType.values
      //               .map(
      //                 (e) => Tab(text: e.name.toUpperCase()),
      //               )
      //               .toList(),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
