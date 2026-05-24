import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/di/injector.dart';
import 'package:admin_msar/src/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:admin_msar/src/features/auth/login/views/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const Scaffold(
        backgroundColor: AppColors.primaryLight,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: LoginFormWidget(),
        ),
      ),
    );
  }
}
