import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/constants/app_images.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:admin_msar/src/features/auth/session/presentation/cubit/auth_session_cubit.dart';
import 'package:admin_msar/src/features/auth/session/presentation/cubit/auth_session_state.dart';
import 'package:svg_flutter/svg.dart';

Drawer appDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      color: Colors.white,
      child: Column(
        children: [
          ClipPath(
            clipper: DrawerClipper(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              color: AppColors.primary,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(AppImages.logo, width: 180),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<AuthSessionCubit, AuthSessionState>(
            builder: (context, state) {
              final email = state is AuthSessionAuthenticated
                  ? state.admin.email
                  : '';
              return ListTile(
                leading: const Icon(Icons.email, color: AppColors.primary),
                title: Text(
                  email,
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ListTile(
              leading: const Icon(Icons.logout, color: AppColors.red),
              title: const Text(
                'تسجيل الخروج',
                style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => _showLogoutSheet(context),
            ),
          ),
        ],
      ),
    ),
  );
}

void _showLogoutSheet(BuildContext context) {
  final sessionCubit = context.read<AuthSessionCubit>();
  Navigator.of(context).pop();
  Future.delayed(const Duration(milliseconds: 300), () {
    if (!context.mounted) return;
    showModalBottomSheet(
      isDismissible: false,
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
      ),
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(sheetContext),
                  ),
                ),
                SvgPicture.asset(AppIcons.logout),
                const SizedBox(height: 27),
                const Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
                  style: TextStyle(color: AppColors.grey),
                ),
                const SizedBox(height: 16),
                AppButton(
                  title: 'تسجيل الخروج',
                  onPressed: () async {
                    Navigator.pop(sheetContext);
                    await sessionCubit.logout();
                  },
                  backgroundColor: AppColors.red,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Navigator.pop(sheetContext),
                  child: const Text(
                    'إلغاء',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  });
}

class DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
