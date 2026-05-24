import 'package:admin_msar/src/features/users/domain/entities/app_user.dart';

sealed class UsersState {
  const UsersState();
}

class UsersInitial extends UsersState {
  const UsersInitial();
}

class UsersLoading extends UsersState {
  const UsersLoading();
}

class UsersLoaded extends UsersState {
  const UsersLoaded(this.users, {this.deletingId});
  final List<AppUser> users;
  final String? deletingId;

  UsersLoaded copyWith({List<AppUser>? users, String? deletingId}) {
    return UsersLoaded(users ?? this.users, deletingId: deletingId);
  }
}

class UsersError extends UsersState {
  const UsersError(this.message);
  final String message;
}
