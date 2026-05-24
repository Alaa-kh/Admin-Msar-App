import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/posts/domain/repositories/posts_repository.dart';

class DeletePostUseCase {
  const DeletePostUseCase(this._repository);
  final PostsRepository _repository;

  Future<ApiResult<void>> call(String id) => _repository.deletePost(id);
}
