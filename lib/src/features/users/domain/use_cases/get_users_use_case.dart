import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/users/domain/entities/app_user.dart';
import 'package:admin_msar/src/features/users/domain/repositories/users_repository.dart';

class GetUsersUseCase {
  const GetUsersUseCase(this._repository);
  final UsersRepository _repository;

  Future<ApiResult<List<AppUser>>> call() => _repository.getUsers();
}
