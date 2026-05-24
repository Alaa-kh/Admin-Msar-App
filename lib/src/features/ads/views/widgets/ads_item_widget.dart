import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_bottom_sheet.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/features/ads/domain/entities/banner_ad.dart';
import 'package:admin_msar/src/features/ads/presentation/cubit/ads_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdsItemWidget extends StatelessWidget {
  const AdsItemWidget({
    super.key,
    required this.ad,
    this.isDeleting = false,
  });

  final BannerAd ad;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDeleting ? 0.5 : 1,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: ad.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey.shade300,
              ).fadeUp(),
              errorWidget: (_, __, ___) => Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey,
                child: const Icon(Icons.broken_image),
              ),
            ),
          ).fadeUp(),
          Positioned(
            left: 1,
            bottom: 1,
            child: GestureDetector(
              onTap: isDeleting
                  ? null
                  : () {
                      final cubit = context.read<AdsCubit>();
                      appBottomSheet(
                        context,
                        'هل أنت متأكد من حذف العرض؟',
                        'سيتم حذف الصورة نهائياً من التطبيق.',
                        'نعم، احذف العرض',
                        () async {
                          Navigator.of(context).pop();
                          final ok = await cubit.delete(ad.id);
                          if (ok && context.mounted) {
                            AppSnackBar.success(context, 'تم حذف العرض');
                          }
                        },
                      );
                    },
              child: Container(
                alignment: Alignment.center,
                width: 35,
                height: 33,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.delete,
                  color: AppColors.red,
                  size: 18,
                ).fadeUp(),
              ),
            ),
          ).fadeUp(),
        ],
      ),
    );
  }
}
