import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_bottom_sheet.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/features/users/domain/entities/app_user.dart';
import 'package:admin_msar/src/features/users/presentation/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

class UsersCardsWidget extends StatelessWidget {
  const UsersCardsWidget({
    super.key,
    required this.user,
    this.isDeleting = false,
  });

  final AppUser user;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: AppColors.border, blurRadius: 7)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(radius: 30).fadeUp(),
            title: const Text(
              'اسم المستخدم',
              style: TextStyle(fontSize: 12, color: AppColors.dark),
            ).fadeUp(),
            subtitle: Text(
              user.name.isEmpty ? '—' : user.name,
              style: const TextStyle(
                fontSize: 17,
                color: AppColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ).fadeUp(),
          ),
          ListTile(
            leading: SvgPicture.asset(
              AppIcons.email,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
              width: 17,
            ).fadeUp(),
            title: const Text(
              'البريد الإلكتروني',
              style: TextStyle(fontSize: 12, color: AppColors.dark),
            ).fadeUp(),
            subtitle: Text(
              user.email.isEmpty ? '—' : user.email,
              style: const TextStyle(
                color: AppColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ).fadeUp(),
          ),
          ListTile(
            leading: SvgPicture.asset(
              AppIcons.phone,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
              width: 17,
            ).fadeUp(),
            title: const Text(
              'رقم الهاتف',
              style: TextStyle(fontSize: 12, color: AppColors.dark),
            ).fadeUp(),
            subtitle: Text(
              user.phone.isEmpty ? '—' : user.phone,
              style: const TextStyle(
                color: AppColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ).fadeUp(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 11),
            child: AppButton(
              title: 'حذف المستخدم',
              loading: isDeleting,
              onPressed: isDeleting
                  ? null
                  : () {
                      final cubit = context.read<UsersCubit>();
                      appBottomSheet(
                        context,
                        'هل أنت متأكد من حذف المستخدم؟',
                        'سيتم حذف كافة البيانات المتعلقة بهذا المستخدم نهائياً. لا يمكن التراجع عن هذا الإجراء.',
                        'نعم، احذف المستخدم',
                        () async {
                          Navigator.of(context).pop();
                          final ok = await cubit.delete(user.id);
                          if (ok && context.mounted) {
                            AppSnackBar.success(context, 'تم حذف المستخدم');
                          }
                        },
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
