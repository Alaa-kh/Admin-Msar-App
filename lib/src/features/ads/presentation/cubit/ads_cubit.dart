import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_msar/src/features/ads/domain/entities/banner_ad.dart';
import 'package:admin_msar/src/features/ads/domain/use_cases/delete_ad_use_case.dart';
import 'package:admin_msar/src/features/ads/domain/use_cases/get_ads_use_case.dart';
import 'package:admin_msar/src/features/ads/presentation/cubit/ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit({
    required GetAdsUseCase getAds,
    required DeleteAdUseCase deleteAd,
  }) : _getAds = getAds,
       _deleteAd = deleteAd,
       super(const AdsInitial());

  final GetAdsUseCase _getAds;
  final DeleteAdUseCase _deleteAd;

  String? _lastError;
  String? get lastError => _lastError;

  Future<void> load() async {
    emit(const AdsLoading());
    final result = await _getAds();
    emit(
      result.when(
        success: (ads) => AdsLoaded(ads),
        failure: (f) => AdsError(f.message),
      ),
    );
  }

  void append(BannerAd ad) {
    final current = state;
    if (current is AdsLoaded) {
      emit(AdsLoaded([...current.ads, ad]));
    }
  }

  Future<bool> delete(String id) async {
    final current = state;
    if (current is! AdsLoaded) return false;
    emit(current.copyWith(deletingId: id));
    final result = await _deleteAd(id);
    return result.when(
      success: (_) {
        final updated = current.ads.where((a) => a.id != id).toList();
        emit(AdsLoaded(updated));
        return true;
      },
      failure: (f) {
        _lastError = f.message;
        emit(current);
        return false;
      },
    );
  }
}
