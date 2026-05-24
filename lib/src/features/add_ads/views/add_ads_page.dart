import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/di/injector.dart';
import 'package:admin_msar/src/core/widgets/app_bar.dart';
import 'package:admin_msar/src/core/widgets/app_drawer_widget.dart';
import 'package:admin_msar/src/features/add_ads/presentation/cubit/add_ads_cubit.dart';
import 'package:admin_msar/src/features/add_ads/views/widgets/add_ads_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddAdsPage extends StatelessWidget {
  const AddAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddAdsCubit>(),
      child: Scaffold(
        endDrawerEnableOpenDragGesture: false,
        drawerBarrierDismissible: false,
        drawer: appDrawer(context),
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
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: AddAdsFormWidget(),
          ),
        ),
      ),
    );
  }
}
