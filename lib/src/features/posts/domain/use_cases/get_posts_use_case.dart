import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:admin_msar/src/features/posts/domain/repositories/posts_repository.dart';

class GetPostsUseCase {
  const GetPostsUseCase(this._repository);
  final PostsRepository _repository;

  Future<ApiResult<List<Post>>> call() => _repository.getPosts();
}
