import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:admin_msar/src/features/add_ads/presentation/cubit/add_ads_state.dart';
import 'package:admin_msar/src/features/ads/domain/use_cases/create_ad_use_case.dart';

class AddAdsCubit extends Cubit<AddAdsState> {
  AddAdsCubit({required CreateAdUseCase createAd, ImagePicker? picker})
    : _createAd = createAd,
      _picker = picker ?? ImagePicker(),
      super(const AddAdsInitial());

  final CreateAdUseCase _createAd;
  final ImagePicker _picker;

  File? get _currentImage => switch (state) {
    AddAdsInitial(image: final img) => img,
    AddAdsError(image: final img) => img,
    AddAdsSubmitting(image: final img) => img,
    AddAdsSuccess() => null,
  };

  Future<void> pickImage() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (picked == null) return;
      emit(AddAdsInitial(image: File(picked.path)));
    } catch (_) {
      emit(const AddAdsError('تعذر اختيار الصورة'));
    }
  }

  Future<void> submit() async {
    final image = _currentImage;
    if (image == null) {
      emit(const AddAdsError('الرجاء اختيار صورة أولاً'));
      return;
    }
    emit(AddAdsSubmitting(image));
    final result = await _createAd(image: image);
    emit(
      result.when(
        success: (ad) => AddAdsSuccess(ad),
        failure: (f) => AddAdsError(f.message, image: image),
      ),
    );
  }

  void reset() => emit(const AddAdsInitial());
}
