import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:admin_msar/src/features/ads/domain/entities/banner_ad.dart';

class BannerAdModel {
  const BannerAdModel({
    required this.id,
    required this.imageUrl,
    required this.isActive,
    required this.order,
  });

  final String id;
  final String imageUrl;
  final bool isActive;
  final int order;

  factory BannerAdModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const {};
    return BannerAdModel(
      id: doc.id,
      imageUrl: (data['imageUrl'] ?? '') as String,
      isActive: (data['isActive'] ?? true) as bool,
      order: (data['order'] ?? 0) as int,
    );
  }

  BannerAd toEntity() => BannerAd(
    id: id,
    imageUrl: imageUrl,
    isActive: isActive,
    order: order,
  );
}
