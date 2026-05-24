import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/users/domain/entities/app_user.dart';

abstract interface class UsersRepository {
  Future<ApiResult<List<AppUser>>> getUsers();

  Future<ApiResult<void>> deleteUser(String id);

  Stream<int> usersCount();
}
