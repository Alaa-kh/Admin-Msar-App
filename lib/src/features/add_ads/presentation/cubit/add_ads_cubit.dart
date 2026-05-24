import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_msar/src/features/add_ads/presentation/cubit/add_ads_state.dart';
import 'package:admin_msar/src/features/ads/domain/use_cases/create_ad_use_case.dart';

class AddAdsCubit extends Cubit<AddAdsState> {
  AddAdsCubit(this._createAd) : super(const AddAdsInitial());
  final CreateAdUseCase _createAd;

  Future<void> submit(String imageUrl) async {
    final url = imageUrl.trim();
    if (url.isEmpty) {
      emit(const AddAdsError('الرجاء إدخال رابط الصورة'));
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.isAbsolute || !(uri.scheme == 'http' || uri.scheme == 'https')) {
      emit(const AddAdsError('الرابط غير صالح — يجب أن يبدأ بـ http أو https'));
      return;
    }
    emit(const AddAdsSubmitting());
    final result = await _createAd(imageUrl: url);
    emit(
      result.when(
        success: (ad) => AddAdsSuccess(ad),
        failure: (f) => AddAdsError(f.message),
      ),
    );
  }

  void reset() => emit(const AddAdsInitial());
}
