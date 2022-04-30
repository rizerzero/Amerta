import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'widgets/home_header_content.dart';
import 'widgets/home_tabbar_persistent_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarHeight = fn.vh(context) / 2;

    return DefaultTabController(
      length: TransactionType.values.length,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: appBarHeight,
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
          const SliverToBoxAdapter(
            child: SizedBox(height: 20000),
          )
        ],
      ),
    );
  }
}
