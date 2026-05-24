class BannerAd {
  const BannerAd({
    required this.id,
    required this.imageUrl,
    required this.isActive,
    required this.order,
  });

  final String id;
  final String imageUrl;
  final bool isActive;
  final int order;
}
