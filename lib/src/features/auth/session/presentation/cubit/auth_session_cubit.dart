import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_msar/src/features/auth/login/domain/repositories/auth_repository.dart';
import 'package:admin_msar/src/features/auth/login/domain/use_cases/sign_out_use_case.dart';
import 'package:admin_msar/src/features/auth/session/presentation/cubit/auth_session_state.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit({
    required AuthRepository repository,
    required SignOutUseCase signOut,
  }) : _repository = repository,
       _signOut = signOut,
       super(const AuthSessionInitial()) {
    _subscription = _repository.authStateChanges().listen((admin) {
      if (admin == null) {
        emit(const AuthSessionUnauthenticated());
      } else {
        emit(AuthSessionAuthenticated(admin));
      }
    });
  }

  final AuthRepository _repository;
  final SignOutUseCase _signOut;
  StreamSubscription? _subscription;

  Future<void> logout() async {
    await _signOut();
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
