import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class HomeTabBarPersistentHeader extends SliverPersistentHeaderDelegate {
  final TabBar tabbar;
  const HomeTabBarPersistentHeader({
    required this.tabbar,
  });

  @override
  double get maxExtent => tabbar.preferredSize.height;

  @override
  double get minExtent => tabbar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: primary,
      child: tabbar,
    );
  }
}
