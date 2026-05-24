import 'package:admin_msar/src/features/ads/domain/entities/banner_ad.dart';

sealed class AddAdsState {
  const AddAdsState();
}

class AddAdsInitial extends AddAdsState {
  const AddAdsInitial();
}

class AddAdsSubmitting extends AddAdsState {
  const AddAdsSubmitting();
}

class AddAdsSuccess extends AddAdsState {
  const AddAdsSuccess(this.ad);
  final BannerAd ad;
}

class AddAdsError extends AddAdsState {
  const AddAdsError(this.message);
  final String message;
}
