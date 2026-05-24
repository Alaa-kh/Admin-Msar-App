import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/di/injector.dart';
import 'package:admin_msar/src/core/widgets/app_bar.dart';
import 'package:admin_msar/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:admin_msar/src/features/home/presentation/cubit/home_state.dart';
import 'package:admin_msar/src/features/home/views/widgets/home_card_widget.dart';
import 'package:admin_msar/src/features/home/views/widgets/home_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_drawer_widget.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      drawerBarrierDismissible: false,
      drawer: appDrawer(context),
      backgroundColor: AppColors.primaryLight,
      appBar: const AppBarWidget(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final users = switch (state) {
            HomeLoaded(stats: final s) => s.usersCount,
            _ => 0,
          };
          final posts = switch (state) {
            HomeLoaded(stats: final s) => s.postsCount,
            _ => 0,
          };
          final ads = switch (state) {
            HomeLoaded(stats: final s) => s.adsCount,
            _ => 0,
          };

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'عدد المنشورات الكلي',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ).fadeUp(),
                  const SizedBox(height: 24),
                  HomeChartWidget(
                    postsCount: posts,
                    adsCount: ads,
                  ).fadeUp(),
                  const SizedBox(height: 24),
                  HomeCardWidget(
                    icon: AppIcons.users,
                    number: users,
                    text: 'عدد المستخدمين الكلي',
                    onTap: () => context.push('/users'),
                  ).fadeUp(),
                  HomeCardWidget(
                    icon: AppIcons.posts,
                    number: posts,
                    text: 'المنشورات العادية',
                    onTap: () => context.push('/posts'),
                  ).fadeUp(),
                  HomeCardWidget(
                    icon: AppIcons.out,
                    number: ads,
                    text: 'العروض الخارجية',
                    onTap: () => context.push('/ads'),
                  ).fadeUp(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
