import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class AppHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final VoidCallback onPressed;

  AppHeaderDelegate({required this.title, required this.onPressed});

  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 70;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: AppButton(title: title, onPressed: onPressed),
    );
  }

  @override
  bool shouldRebuild(covariant AppHeaderDelegate oldDelegate) => false;
}
