import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/ads/domain/repositories/ads_repository.dart';

class DeleteAdUseCase {
  const DeleteAdUseCase(this._repository);
  final AdsRepository _repository;

  Future<ApiResult<void>> call(String id) => _repository.deleteAd(id);
}
