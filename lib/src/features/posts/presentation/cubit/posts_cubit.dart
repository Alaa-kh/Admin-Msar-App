import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:admin_msar/src/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:admin_msar/src/features/posts/domain/use_cases/get_posts_use_case.dart';
import 'package:admin_msar/src/features/posts/presentation/cubit/posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({
    required GetPostsUseCase getPosts,
    required DeletePostUseCase deletePost,
  }) : _getPosts = getPosts,
       _deletePost = deletePost,
       super(const PostsInitial());

  final GetPostsUseCase _getPosts;
  final DeletePostUseCase _deletePost;

  String? _lastError;
  String? get lastError => _lastError;

  Future<void> load() async {
    emit(const PostsLoading());
    final result = await _getPosts();
    emit(
      result.when(
        success: (posts) => PostsLoaded(posts),
        failure: (f) => PostsError(f.message),
      ),
    );
  }

  void prepend(Post post) {
    final current = state;
    if (current is PostsLoaded) {
      emit(PostsLoaded([post, ...current.posts]));
    }
  }

  Future<bool> delete(String id) async {
    final current = state;
    if (current is! PostsLoaded) return false;
    emit(current.copyWith(deletingId: id));
    final result = await _deletePost(id);
    return result.when(
      success: (_) {
        final updated = current.posts.where((p) => p.id != id).toList();
        emit(PostsLoaded(updated));
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
