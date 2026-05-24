import 'package:admin_msar/src/core/error/firebase_failure_mapper.dart';
import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/users/data/datasources/users_remote_data_source.dart';
import 'package:admin_msar/src/features/users/domain/entities/app_user.dart';
import 'package:admin_msar/src/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  const UsersRepositoryImpl(this._remote);
  final UsersRemoteDataSource _remote;

  @override
  Future<ApiResult<List<AppUser>>> getUsers() async {
    try {
      final users = await _remote.getUsers();
      return ApiSuccess(users.map((m) => m.toEntity()).toList());
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteUser(String id) async {
    try {
      await _remote.deleteUser(id);
      return const ApiSuccess(null);
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Stream<int> usersCount() => _remote.usersCount();
}
