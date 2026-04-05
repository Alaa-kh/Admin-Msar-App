import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_text_field.dart';
import 'package:admin_msar/src/features/add_post/widgets/add_post_button_widget.dart';
import 'package:admin_msar/src/features/add_post/widgets/add_post_gender_widget.dart';

class AddPostFormWidget extends StatelessWidget {
  const AddPostFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(
            'عنوان المنشور',
            style: TextStyle(color: AppColors.primaryDark),
          ).fadeUp(),
          AppTextField(hint: 'أدخل عنواناً جذاباً...'),
          const SizedBox(height: 7),
          Text(
            'وصف المنشور',
            style: TextStyle(color: AppColors.primaryDark),
          ).fadeUp(),
          AppTextField(
            maxLines: 7,
            minLines: 1,
            hint: 'اكتب تفاصيل المنشور هنا...',
          ).fadeUp(),
          const SizedBox(height: 7),
          Text(
            'رقم الواتساب',
            style: TextStyle(color: AppColors.primaryDark),
          ).fadeUp(),
          AppTextField(
            hint: 'أدخل رقم الواتساب هنا...',
            keyboardType: TextInputType.phone,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp(r'^\+?[0-9]*$')),
            ],
          ).fadeUp(),
          const SizedBox(height: 10),
          Text(
            'الجنس المختار',
            style: TextStyle(color: AppColors.primaryDark),
          ).fadeUp(),
          const SizedBox(height: 7),
          AddPostGenderWidget().fadeUp(),
          const SizedBox(height: 10),
          SizedBox(height: screenHeight * 0.2),
          AddPostButtonWidget().fadeUp(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
