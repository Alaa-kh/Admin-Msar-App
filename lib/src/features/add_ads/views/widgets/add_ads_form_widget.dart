import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_dashed_border.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/core/widgets/app_text_field.dart';
import 'package:admin_msar/src/features/add_ads/presentation/cubit/add_ads_cubit.dart';
import 'package:admin_msar/src/features/add_ads/presentation/cubit/add_ads_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';

class AddAdsFormWidget extends StatefulWidget {
  const AddAdsFormWidget({super.key});

  @override
  State<AddAdsFormWidget> createState() => _AddAdsFormWidgetState();
}

class _AddAdsFormWidgetState extends State<AddAdsFormWidget> {
  final _urlController = TextEditingController();
  String _previewUrl = '';

  @override
  void initState() {
    super.initState();
    _urlController.addListener(() {
      final value = _urlController.text.trim();
      if (value != _previewUrl) {
        setState(() => _previewUrl = value);
      }
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  bool get _isValidUrl {
    if (_previewUrl.isEmpty) return false;
    final uri = Uri.tryParse(_previewUrl);
    return uri != null &&
        uri.isAbsolute &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

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
                  'معاينة الصورة',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ).fadeUp(),
              const SizedBox(height: 10),
              DashedBorder(
                child: Container(
                  height: 188,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xffF0F5F4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _isValidUrl
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: _previewUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 188,
                            placeholder: (_, _) => const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                            errorWidget: (_, _, _) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.broken_image,
                                  color: AppColors.grey,
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'تعذر تحميل الصورة',
                                  style: TextStyle(
                                    color: AppColors.dark.withValues(
                                      alpha: .6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.upload),
                              const SizedBox(height: 10),
                              const Text(
                                'ضع رابط صورة العرض في الأسفل',
                                style: TextStyle(
                                  color: AppColors.primaryDark,
                                  fontWeight: FontWeight.w800,
                                ),
                              ).fadeUp(),
                              const SizedBox(height: 10),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  'الرابط يجب أن يبدأ بـ http أو https',
                                  style: TextStyle(
                                    color: AppColors.dark.withValues(alpha: .5),
                                  ),
                                ).fadeUp(),
                              ),
                            ],
                          ),
                        ),
                ),
              ).fadeUp(),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'رابط الصورة',
                  style: TextStyle(color: AppColors.primaryDark),
                ),
              ).fadeUp(),
              AppTextField(
                controller: _urlController,
                hint: 'https://example.com/image.jpg',
                keyboardType: TextInputType.url,
                textDirection: TextDirection.ltr,
                hintTextDirection: TextDirection.ltr,
              ).fadeUp(),
              const SizedBox(height: 25),
              AppButton(
                title: 'إضافة',
                loading: submitting,
                onPressed: submitting
                    ? null
                    : () => context
                          .read<AddAdsCubit>()
                          .submit(_urlController.text),
              ).fadeUp(),
            ],
          ),
        );
      },
    );
  }
}
