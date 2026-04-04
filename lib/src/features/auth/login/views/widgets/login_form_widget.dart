import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/constants/app_images.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:admin_msar/src/core/widgets/app_text_field.dart';
import 'package:svg_flutter/svg.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Image.asset(AppImages.logoColors).scaleIn(),
        const SizedBox(height: 12),
        Text(
          'مرحباً بك في مسار',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
          ),
        ).fadeUp(),
        const SizedBox(height: 6),
        Text(
          'أدخل المعلومات لتسجيل الدخول',
          style: const TextStyle(fontSize: 16, color: AppColors.dark),
        ).fadeUp(),
        const SizedBox(height: 24),
        AppTextField(
          hintTextDirection: TextDirection.rtl,
          label: 'البريد الإلكتروني',
          prefix: Padding(
            padding: const EdgeInsets.only(right: 13.0, top: 15, bottom: 15),
            child: SvgPicture.asset(AppIcons.email, width: 1, height: 1),
          ),
        ).fadeUp(),
        AppTextField(
          hintTextDirection: TextDirection.rtl,
          label: 'كلمة المرور',
          obscure: true,
          prefix: Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 14, bottom: 14),
            child: SvgPicture.asset(AppIcons.password, width: 1, height: 1),
          ),
          suffix: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppIcons.eye),
          ),
        ).fadeUp(),
        SizedBox(height: screenHeight * 0.2),
        AppButton(title: 'تسجيل الدخول', onPressed: () {}).scaleIn(),
        const SizedBox(height: 13),
      ],
    );
  }
}
