import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_bar.dart';
import 'package:admin_msar/src/core/widgets/app_drawer_widget.dart';
import 'package:admin_msar/src/features/users/widgets/user_posts_main_list.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      drawerBarrierDismissible: false,
      drawer: appDrawer(context),
      backgroundColor: AppColors.primaryLight,
      appBar: const AppBarWidget(),
      body: UserPostsMainListWidget(),
    );
  }
}
