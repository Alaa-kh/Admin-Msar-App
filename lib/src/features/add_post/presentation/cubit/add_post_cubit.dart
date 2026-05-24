import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_msar/src/features/add_post/presentation/cubit/add_post_state.dart';
import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:admin_msar/src/features/posts/domain/repositories/posts_repository.dart';
import 'package:admin_msar/src/features/posts/domain/use_cases/create_post_use_case.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this._createPost) : super(const AddPostInitial());
  final CreatePostUseCase _createPost;

  Future<void> submit({
    required String title,
    required String description,
    required String whatsapp,
    required PostAudience audience,
  }) async {
    if (title.trim().isEmpty ||
        description.trim().isEmpty ||
        whatsapp.trim().isEmpty) {
      emit(const AddPostError('الرجاء تعبئة جميع الحقول'));
      return;
    }
    emit(const AddPostSubmitting());
    final result = await _createPost(
      CreatePostParams(
        title: title.trim(),
        description: description.trim(),
        whatsapp: whatsapp.trim(),
        audience: audience,
      ),
    );
    emit(
      result.when(
        success: (post) => AddPostSuccess(post),
        failure: (f) => AddPostError(f.message),
      ),
    );
  }

  void reset() => emit(const AddPostInitial());
}
