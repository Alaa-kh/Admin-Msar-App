import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_images.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.action});
  final Widget? action;
  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [action ?? SizedBox()],
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.settings, color: Colors.white, size: 30),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ).fadeUp(),
      backgroundColor: AppColors.primary,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Image.asset(AppImages.logo, width: 117).fadeUp(),
      ),
      centerTitle: true,
    );
  }
}
