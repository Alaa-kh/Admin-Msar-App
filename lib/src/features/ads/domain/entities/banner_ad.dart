class BannerAd {
  const BannerAd({
    required this.id,
    required this.imageUrl,
    required this.isActive,
    required this.order,
    this.storagePath,
  });

  final String id;
  final String imageUrl;
  final bool isActive;
  final int order;
  final String? storagePath;
}
