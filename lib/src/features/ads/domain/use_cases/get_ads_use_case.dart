import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/ads/domain/entities/banner_ad.dart';
import 'package:admin_msar/src/features/ads/domain/repositories/ads_repository.dart';

class GetAdsUseCase {
  const GetAdsUseCase(this._repository);
  final AdsRepository _repository;

  Future<ApiResult<List<BannerAd>>> call() => _repository.getAds();
}
