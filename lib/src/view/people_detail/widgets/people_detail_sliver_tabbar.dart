import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class PeopleDetailSliverTabBar extends SliverPersistentHeaderDelegate {
  const PeopleDetailSliverTabBar({
    required this.tabBar,
  });
  final TabBar tabBar;
  @override
  Widget build(BuildContext context, shrinkOffset, overlapsContent) {
    return Container(
      color: scaffoldColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        margin: const EdgeInsets.only(top: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: tabBar,
      ),
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height + 16.0;

  @override
  double get minExtent => tabBar.preferredSize.height + 16.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
