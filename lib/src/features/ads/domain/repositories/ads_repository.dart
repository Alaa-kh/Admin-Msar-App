import 'dart:io';

import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/ads/domain/entities/banner_ad.dart';

abstract interface class AdsRepository {
  Future<ApiResult<List<BannerAd>>> getAds();

  Future<ApiResult<void>> deleteAd(String id);

  Future<ApiResult<BannerAd>> createAd({required File image});

  Stream<int> adsCount();
}
