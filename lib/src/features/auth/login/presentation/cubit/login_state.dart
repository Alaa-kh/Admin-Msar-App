import 'package:admin_msar/src/features/auth/login/domain/entities/admin_user.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess(this.admin);
  final AdminUser admin;
}

class LoginError extends LoginState {
  const LoginError(this.message);
  final String message;
}
