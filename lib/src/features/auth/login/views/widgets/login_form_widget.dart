import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/constants/app_images.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/core/widgets/app_text_field.dart';
import 'package:admin_msar/src/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:admin_msar/src/features/auth/login/presentation/cubit/login_state.dart';
import 'package:svg_flutter/svg.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          AppSnackBar.error(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset(AppImages.logoColors).scaleIn(),
            const SizedBox(height: 12),
            const Text(
              'مرحباً بك في مسار',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.dark,
              ),
            ).fadeUp(),
            const SizedBox(height: 6),
            const Text(
              'أدخل المعلومات لتسجيل الدخول',
              style: TextStyle(fontSize: 16, color: AppColors.dark),
            ).fadeUp(),
            const SizedBox(height: 24),
            AppTextField(
              controller: _emailController,
              hintTextDirection: TextDirection.ltr,
              textDirection: TextDirection.ltr,
              label: 'البريد الإلكتروني',
              keyboardType: TextInputType.emailAddress,
              prefix: Padding(
                padding: const EdgeInsets.only(right: 13.0, top: 15, bottom: 15),
                child: SvgPicture.asset(AppIcons.email, width: 1, height: 1),
              ),
            ).fadeUp(),
            AppTextField(
              controller: _passwordController,
              hintTextDirection: TextDirection.ltr,
              textDirection: TextDirection.ltr,
              label: 'كلمة المرور',
              obscure: _obscure,
              prefix: Padding(
                padding: const EdgeInsets.only(right: 12.0, top: 14, bottom: 14),
                child: SvgPicture.asset(AppIcons.password, width: 1, height: 1),
              ),
              suffix: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: SvgPicture.asset(AppIcons.eye),
              ),
            ).fadeUp(),
            SizedBox(height: screenHeight * 0.2),
            AppButton(
              title: 'تسجيل الدخول',
              loading: isLoading,
              onPressed: isLoading
                  ? null
                  : () => context.read<LoginCubit>().signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
            ).scaleIn(),
            const SizedBox(height: 13),
          ],
        );
      },
    );
  }
}
