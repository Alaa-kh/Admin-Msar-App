import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/auth/login/domain/entities/admin_user.dart';
import 'package:admin_msar/src/features/auth/login/domain/repositories/auth_repository.dart';

class SignInUseCase {
  const SignInUseCase(this._repository);
  final AuthRepository _repository;

  Future<ApiResult<AdminUser>> call({
    required String email,
    required String password,
  }) {
    return _repository.signIn(email: email, password: password);
  }
}
