import 'package:admin_msar/src/features/ads/views/widgets/ads_item_widget.dart';
import 'package:flutter/material.dart';

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
