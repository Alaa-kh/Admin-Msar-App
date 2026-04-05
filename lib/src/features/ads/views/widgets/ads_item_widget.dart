import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdsItemWidget extends StatelessWidget {
  final String image;
  const AdsItemWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: image,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              height: 180,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            errorWidget: (_, __, ___) => Container(
              height: 180,
              width: double.infinity,
              color: Colors.grey,
              child: const Icon(Icons.broken_image),
            ),
          ),
        ),
        Positioned(
          left: 1,
          bottom: 1,
          child: Container(
            alignment: Alignment.center,
            width: 35,
            height: 33,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.delete, color: AppColors.red, size: 18),
          ),
        ),
      ],
    );
  }
}
