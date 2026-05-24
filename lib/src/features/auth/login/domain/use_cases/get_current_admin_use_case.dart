import 'package:admin_msar/src/core/network/api_result.dart';
import 'package:admin_msar/src/features/auth/login/domain/entities/admin_user.dart';
import 'package:admin_msar/src/features/auth/login/domain/repositories/auth_repository.dart';

class GetCurrentAdminUseCase {
  const GetCurrentAdminUseCase(this._repository);
  final AuthRepository _repository;

  Future<ApiResult<AdminUser?>> call() => _repository.getCurrentAdmin();
}
