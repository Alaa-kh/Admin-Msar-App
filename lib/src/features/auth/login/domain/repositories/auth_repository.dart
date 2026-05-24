import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/auth/login/domain/entities/admin_user.dart';

abstract interface class AuthRepository {
  Future<ApiResult<AdminUser>> signIn({
    required String email,
    required String password,
  });

  Future<ApiResult<void>> signOut();

  Future<ApiResult<AdminUser?>> getCurrentAdmin();

  Stream<AdminUser?> authStateChanges();
}
