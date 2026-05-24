import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/di/injector.dart';
import 'package:admin_msar/src/core/widgets/app_bar.dart';
import 'package:admin_msar/src/features/add_post/presentation/cubit/add_post_cubit.dart';
import 'package:admin_msar/src/features/add_post/widgets/add_post_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_drawer_widget.dart';
import 'package:go_router/go_router.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddPostCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.primaryLight,
        appBar: AppBarWidget(
          action: GestureDetector(
            onTap: () => context.pop(),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.arrow_forward_ios).fadeUp(),
            ),
          ),
        ),
        endDrawerEnableOpenDragGesture: false,
        drawerBarrierDismissible: false,
        drawer: appDrawer(context),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: AddPostFormWidget(),
          ),
        ),
      ),
    );
  }
}
