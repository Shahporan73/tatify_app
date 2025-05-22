import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemStickyHeaderDelegateWidget extends SliverPersistentHeaderDelegate {
  final Widget child;

  ItemStickyHeaderDelegateWidget({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 2.0,
      child: child,
    );
  }

  @override
  double get maxExtent => Get.height / 12;

  @override
  double get minExtent => Get.height / 12;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
