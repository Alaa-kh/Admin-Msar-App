import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_msar/src/features/users/domain/use_cases/delete_user_use_case.dart';
import 'package:admin_msar/src/features/users/domain/use_cases/get_users_use_case.dart';
import 'package:admin_msar/src/features/users/presentation/cubit/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({
    required GetUsersUseCase getUsers,
    required DeleteUserUseCase deleteUser,
  }) : _getUsers = getUsers,
       _deleteUser = deleteUser,
       super(const UsersInitial());

  final GetUsersUseCase _getUsers;
  final DeleteUserUseCase _deleteUser;

  String? _lastError;
  String? get lastError => _lastError;

  Future<void> load() async {
    emit(const UsersLoading());
    final result = await _getUsers();
    emit(
      result.when(
        success: (users) => UsersLoaded(users),
        failure: (f) => UsersError(f.message),
      ),
    );
  }

  Future<bool> delete(String id) async {
    final current = state;
    if (current is! UsersLoaded) return false;
    emit(current.copyWith(deletingId: id));
    final result = await _deleteUser(id);
    return result.when(
      success: (_) {
        final updated = current.users.where((u) => u.id != id).toList();
        emit(UsersLoaded(updated));
        return true;
      },
      failure: (f) {
        _lastError = f.message;
        emit(current);
        return false;
      },
    );
  }
}
