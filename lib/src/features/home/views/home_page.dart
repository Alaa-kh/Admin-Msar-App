import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_bar.dart';
import 'package:admin_msar/src/features/home/views/widgets/home_card_widget.dart';
import 'package:admin_msar/src/features/home/views/widgets/home_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_drawer_widget.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      drawerBarrierDismissible: false,
      drawer: appDrawer(context),
      backgroundColor: AppColors.primaryLight,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'عدد المنشورات الكلي',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ).fadeUp(),
              const SizedBox(height: 24),
              HomeChartWidget().fadeUp(),
              const SizedBox(height: 24),
              HomeCardWidget(
                icon: AppIcons.users,
                number: 250,
                text: 'عدد المستخدمين الكلي',
                onTap: () => context.push('/users'),
              ).fadeUp(),
              HomeCardWidget(
                icon: AppIcons.posts,
                number: 50,
                text: 'المنشورات العادية',
                onTap: () => context.push('/posts'),
              ).fadeUp(),
              HomeCardWidget(
                icon: AppIcons.out,
                number: 70,
                text: 'العروض الخارجية',
                onTap: () {},
              ).fadeUp(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
