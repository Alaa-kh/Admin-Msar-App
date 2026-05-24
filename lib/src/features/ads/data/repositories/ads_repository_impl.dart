import 'dart:io';

import 'package:admin_msar/src/core/error/firebase_failure_mapper.dart';
import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/ads/data/datasources/ads_remote_data_source.dart';
import 'package:admin_msar/src/features/ads/domain/entities/banner_ad.dart';
import 'package:admin_msar/src/features/ads/domain/repositories/ads_repository.dart';

class AdsRepositoryImpl implements AdsRepository {
  const AdsRepositoryImpl(this._remote);
  final AdsRemoteDataSource _remote;

  @override
  Future<ApiResult<List<BannerAd>>> getAds() async {
    try {
      final ads = await _remote.getAds();
      return ApiSuccess(ads.map((m) => m.toEntity()).toList());
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteAd(String id) async {
    try {
      await _remote.deleteAd(id);
      return const ApiSuccess(null);
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Future<ApiResult<BannerAd>> createAd({required File image}) async {
    try {
      final ad = await _remote.createAd(image: image);
      return ApiSuccess(ad.toEntity());
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Stream<int> adsCount() => _remote.adsCount();
}
