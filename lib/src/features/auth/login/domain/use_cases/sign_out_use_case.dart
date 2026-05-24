import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/auth/login/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  const SignOutUseCase(this._repository);
  final AuthRepository _repository;

  Future<ApiResult<void>> call() => _repository.signOut();
}
