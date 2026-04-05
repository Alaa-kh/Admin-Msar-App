import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_card_widget.dart';
import 'package:flutter/material.dart';

class UserPostsMainListWidget extends StatelessWidget {
  const UserPostsMainListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'إدارة المستخدمين',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return AppCardWidget();
              }, childCount: 5),
            ),
          ),
        ],
      ),
    );
  }
}
