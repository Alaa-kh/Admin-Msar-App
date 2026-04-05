import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:admin_msar/src/features/ads/views/widgets/ads_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdsCardsWidget extends StatelessWidget {
  const AdsCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://picsum.photos/800/400?1',
      'https://picsum.photos/800/400?2',
      'https://picsum.photos/800/400?3',
      'https://picsum.photos/800/400?4',
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'العروض الخارجية',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              AppButton(
                title: 'إضافة عرض خارجي جديد',
                onPressed: () => context.push('/add_ads'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        SliverList.separated(
          itemCount: images.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (_, index) {
            return AdsItemWidget(image: images[index]);
          },
        ),
      ],
    );
  }
}
