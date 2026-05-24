import 'package:admin_msar/src/core/error/failures.dart';
import 'package:admin_msar/src/core/error/firebase_failure_mapper.dart';
import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/auth/login/data/datasources/auth_remote_data_source.dart';
import 'package:admin_msar/src/features/auth/login/domain/entities/admin_user.dart';
import 'package:admin_msar/src/features/auth/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  @override
  Future<ApiResult<AdminUser>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _remote.signIn(email: email, password: password);
      final entity = model.toEntity();
      if (!entity.isAdmin) {
        await _remote.signOut();
        return const ApiFailure(NotAdminFailure());
      }
      return ApiSuccess(entity);
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Future<ApiResult<void>> signOut() async {
    try {
      await _remote.signOut();
      return const ApiSuccess(null);
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Future<ApiResult<AdminUser?>> getCurrentAdmin() async {
    try {
      final model = await _remote.getCurrentAdmin();
      final entity = model?.toEntity();
      if (entity != null && !entity.isAdmin) {
        return const ApiSuccess(null);
      }
      return ApiSuccess(entity);
    } catch (e) {
      return ApiFailure(mapFirebaseException(e));
    }
  }

  @override
  Stream<AdminUser?> authStateChanges() {
    return _remote.authStateChanges().map((m) {
      final e = m?.toEntity();
      if (e == null || !e.isAdmin) return null;
      return e;
    });
  }
}
