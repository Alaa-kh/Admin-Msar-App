import 'dart:io';

import 'package:admin_msar/src/features/ads/domain/entities/banner_ad.dart';

sealed class AddAdsState {
  const AddAdsState();
}

class AddAdsInitial extends AddAdsState {
  const AddAdsInitial({this.image});
  final File? image;

  AddAdsInitial copyWith({File? image}) => AddAdsInitial(image: image);
}

class AddAdsSubmitting extends AddAdsState {
  const AddAdsSubmitting(this.image);
  final File image;
}

class AddAdsSuccess extends AddAdsState {
  const AddAdsSuccess(this.ad);
  final BannerAd ad;
}

class AddAdsError extends AddAdsState {
  const AddAdsError(this.message, {this.image});
  final String message;
  final File? image;
}
