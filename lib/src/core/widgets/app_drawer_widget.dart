import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/constants/app_images.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
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
                        child: Icon(Icons.close, color: Colors.white),
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
          ListTile(
            leading: Icon(Icons.person, color: AppColors.primary),
            title: Text(
              'مستخدم جديد',
              style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone, color: AppColors.primary),
            title: Text(
              '01212134567',
              style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.email, color: AppColors.primary),
            title: Text(
              'testtest@gmail.com',
              style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ListTile(
              leading: Icon(Icons.logout, color: AppColors.red),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Future.delayed(Duration(milliseconds: 300), () {
                  showModalBottomSheet(
                    isDismissible: false,
                    backgroundColor: Colors.white,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              SvgPicture.asset(AppIcons.logout),
                              SizedBox(height: 27),
                              Text(
                                'تسجيل الخروج',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.primaryDark,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              SizedBox(height: 16),
                              AppButton(
                                title: 'تسجيل الخروج',
                                onPressed: () {},
                                backgroundColor: AppColors.red,
                              ),
                              SizedBox(height: 15),
                              Text(
                                'إلغاء',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                });
              },
            ),
          ),
        ],
      ),
    ),
  );
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
