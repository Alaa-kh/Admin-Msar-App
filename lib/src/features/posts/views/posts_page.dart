import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_bar.dart';
import 'package:admin_msar/src/core/widgets/app_drawer_widget.dart';
import 'package:admin_msar/src/features/posts/views/widgets/posts_main_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      drawerBarrierDismissible: false,
      drawer: appDrawer(context),
      backgroundColor: AppColors.primaryLight,
      appBar: AppBarWidget(
        action: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.arrow_forward_ios).fadeUp(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PostsMainListWidget(),
      ),
    );
  }
}
