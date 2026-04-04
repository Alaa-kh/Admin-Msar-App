import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/features/auth/login/views/widgets/login_form_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: LoginFormWidget(),
      ),
    );
  }
}
