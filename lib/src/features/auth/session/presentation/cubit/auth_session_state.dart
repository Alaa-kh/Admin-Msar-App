import 'package:admin_msar/src/features/auth/login/domain/entities/admin_user.dart';

sealed class AuthSessionState {
  const AuthSessionState();
}

class AuthSessionInitial extends AuthSessionState {
  const AuthSessionInitial();
}

class AuthSessionAuthenticated extends AuthSessionState {
  const AuthSessionAuthenticated(this.admin);
  final AdminUser admin;
}

class AuthSessionUnauthenticated extends AuthSessionState {
  const AuthSessionUnauthenticated();
}
