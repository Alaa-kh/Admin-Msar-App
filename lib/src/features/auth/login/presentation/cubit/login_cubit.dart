import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_msar/src/features/auth/login/domain/use_cases/sign_in_use_case.dart';
import 'package:admin_msar/src/features/auth/login/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._signIn) : super(const LoginInitial());
  final SignInUseCase _signIn;

  Future<void> signIn({required String email, required String password}) async {
    if (email.trim().isEmpty || password.isEmpty) {
      emit(const LoginError('الرجاء إدخال البريد وكلمة المرور'));
      return;
    }
    emit(const LoginLoading());
    final result = await _signIn(email: email.trim(), password: password);
    emit(
      result.when(
        success: (admin) => LoginSuccess(admin),
        failure: (f) => LoginError(f.message),
      ),
    );
  }

  void reset() => emit(const LoginInitial());
}
