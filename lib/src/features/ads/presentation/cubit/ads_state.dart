import 'package:admin_msar/src/features/ads/domain/entities/banner_ad.dart';

sealed class AdsState {
  const AdsState();
}

class AdsInitial extends AdsState {
  const AdsInitial();
}

class AdsLoading extends AdsState {
  const AdsLoading();
}

class AdsLoaded extends AdsState {
  const AdsLoaded(this.ads, {this.deletingId});
  final List<BannerAd> ads;
  final String? deletingId;

  AdsLoaded copyWith({List<BannerAd>? ads, String? deletingId}) =>
      AdsLoaded(ads ?? this.ads, deletingId: deletingId);
}

class AdsError extends AdsState {
  const AdsError(this.message);
  final String message;
}
