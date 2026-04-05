import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_bottom_sheet.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class UsersCardsWidget extends StatelessWidget {
  const UsersCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.border, blurRadius: 7)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(radius: 30).fadeUp(),
            title: Text(
              'اسم المستخدم',
              style: TextStyle(fontSize: 12, color: AppColors.dark),
            ).fadeUp(),
            subtitle: Text(
              'كريستينا جرجس',
              style: TextStyle(
                fontSize: 17,
                color: AppColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ).fadeUp(),
          ).fadeUp(),
          ListTile(
            leading: SvgPicture.asset(
              AppIcons.email,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              width: 17,
            ).fadeUp(),
            title: Text(
              'البريد الإلكتروني',
              style: TextStyle(fontSize: 12, color: AppColors.dark),
            ).fadeUp(),
            subtitle: Text(
              'christina@example.com',
              style: TextStyle(
                color: AppColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ).fadeUp(),
          ).fadeUp(),
          ListTile(
            leading: SvgPicture.asset(
              AppIcons.phone,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              width: 17,
            ).fadeUp(),
            title: Text(
              'رقم الهاتف',
              style: TextStyle(fontSize: 12, color: AppColors.dark),
            ).fadeUp(),
            subtitle: Text(
              '+963 933 112 233',
              style: TextStyle(
                color: AppColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ).fadeUp(),
          ).fadeUp(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 11),
            child: AppButton(
              title: 'حذف المستخدم',
              onPressed: () {
                appBottomSheet(
                  context,
                  'هل أنت متأكد من حذف المستخدم؟',
                  'سيتم حذف كافة البيانات المتعلقة بهذا المستخدم نهائياً. لا يمكن التراجع عن هذا الإجراء.',
                  'نعم، احذف المستخدم',
                  () {},
                );
              },
              backgroundColor: AppColors.red.withValues(alpha: .2),
              colorText: AppColors.red,
            ).fadeUp(),
          ),
        ],
      ),
    );
  }
}
