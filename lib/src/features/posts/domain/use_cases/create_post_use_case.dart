import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:admin_msar/src/features/posts/domain/repositories/posts_repository.dart';

class CreatePostUseCase {
  const CreatePostUseCase(this._repository);
  final PostsRepository _repository;

  Future<ApiResult<Post>> call(CreatePostParams params) =>
      _repository.createPost(params);
}
