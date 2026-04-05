import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_dashed_border.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:admin_msar/src/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svg_flutter/svg.dart';

class AddAdsFormWidget extends StatelessWidget {
  const AddAdsFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'إضافة عرض خارجي',
            style: TextStyle(
              color: AppColors.primaryDark,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ).fadeUp(),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'إضافة مرفق',
              style: TextStyle(color: AppColors.primaryDark),
            ).fadeUp(),
          ).fadeUp(),
          const SizedBox(height: 10),
          DashedBorder(
            child: Container(
              height: 188,
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xffF0F5F4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.upload),
                  const SizedBox(height: 10),
                  Text(
                    'اضغط هنا لرفع الملف',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ).fadeUp(),
                  const SizedBox(height: 10),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      '(JPG / PNG) الرجاء رفع المرفقات بصيغة',
                      style: TextStyle(
                        color: AppColors.dark.withValues(alpha: .5),
                      ),
                    ).fadeUp(),
                  ),
                ],
              ),
            ),
          ).fadeUp(),
          const SizedBox(height: 25),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'رقم الواتساب',
              style: TextStyle(color: AppColors.primaryDark),
            ),
          ).fadeUp(),
          AppTextField(
            keyboardType: TextInputType.phone,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp(r'^\+?[0-9]*$')),
            ],
            hint: '111212121',
            prefix: Padding(
              padding: const EdgeInsets.only(right: 13.0, top: 15, bottom: 15),
              child: SvgPicture.asset(
                AppIcons.phone,
                width: 1,
                height: 1,
              ).fadeUp(),
            ),
          ).fadeUp(),
          const SizedBox(height: 15),
          AppButton(title: 'إضافة', onPressed: () {}).fadeUp(),
        ],
      ),
    );
  }
}
