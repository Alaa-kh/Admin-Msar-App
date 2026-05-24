import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/di/injector.dart';
import 'package:admin_msar/src/core/widgets/app_bar.dart';
import 'package:admin_msar/src/core/widgets/app_drawer_widget.dart';
import 'package:admin_msar/src/features/ads/presentation/cubit/ads_cubit.dart';
import 'package:admin_msar/src/features/ads/views/widgets/ads_cards_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdsCubit>()..load(),
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
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AdsCardsWidget(),
        ),
      ),
    );
  }
}
