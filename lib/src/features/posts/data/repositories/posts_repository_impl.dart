import 'package:admin_msar/src/core/error/firebase_failure_mapper.dart';
import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:admin_msar/src/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  const PostsRepositoryImpl(this._remote);
  final PostsRemoteDataSource _remote;

  @override
  Future<ApiResult<List<Post>>> getPosts() async {
    try {
      final posts = await _remote.getPosts();
      return ApiSuccess(posts.map((m) => m.toEntity()).toList());
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Future<ApiResult<void>> deletePost(String id) async {
    try {
      await _remote.deletePost(id);
      return const ApiSuccess(null);
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Future<ApiResult<Post>> createPost(CreatePostParams params) async {
    try {
      final created = await _remote.createPost(params);
      return ApiSuccess(created.toEntity());
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Stream<int> postsCount() => _remote.postsCount();
}
