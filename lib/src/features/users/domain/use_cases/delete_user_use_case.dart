import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/users/domain/repositories/users_repository.dart';

class DeleteUserUseCase {
  const DeleteUserUseCase(this._repository);
  final UsersRepository _repository;

  Future<ApiResult<void>> call(String id) => _repository.deleteUser(id);
}
