import 'dart:io';

import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_dashed_border.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/features/add_ads/presentation/cubit/add_ads_cubit.dart';
import 'package:admin_msar/src/features/add_ads/presentation/cubit/add_ads_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';

class AddAdsFormWidget extends StatelessWidget {
  const AddAdsFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAdsCubit, AddAdsState>(
      listener: (context, state) {
        if (state is AddAdsError) {
          AppSnackBar.error(context, state.message);
        }
        if (state is AddAdsSuccess) {
          AppSnackBar.success(context, 'تمت إضافة العرض بنجاح');
          context.pop(true);
        }
      },
      builder: (context, state) {
        final File? image = switch (state) {
          AddAdsInitial(image: final i) => i,
          AddAdsSubmitting(image: final i) => i,
          AddAdsError(image: final i) => i,
          AddAdsSuccess() => null,
        };
        final submitting = state is AddAdsSubmitting;

        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'إضافة عرض خارجي',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ).fadeUp(),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'إضافة مرفق',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ).fadeUp(),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: submitting
                    ? null
                    : () => context.read<AddAdsCubit>().pickImage(),
                child: DashedBorder(
                  child: Container(
                    height: 188,
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F5F4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: image == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.upload),
                              const SizedBox(height: 10),
                              const Text(
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
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                  ),
                ),
              ).fadeUp(),
              const SizedBox(height: 25),
              AppButton(
                title: 'إضافة',
                loading: submitting,
                onPressed: submitting
                    ? null
                    : () => context.read<AddAdsCubit>().submit(),
              ).fadeUp(),
            ],
          ),
        );
      },
    );
  }
}
