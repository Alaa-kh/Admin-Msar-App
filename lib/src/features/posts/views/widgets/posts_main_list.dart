import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_card_widget.dart';
import 'package:admin_msar/src/core/widgets/app_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostsMainListWidget extends StatelessWidget {
  const PostsMainListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 20),
                Text(
                  'إدارة المنشورات',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: AppHeaderDelegate(
              title: 'إضافة منشور جديد',
              onPressed: () => context.push('/add_post'),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const AppCardWidget(),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
