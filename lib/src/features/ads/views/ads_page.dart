import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_bar.dart';
import 'package:admin_msar/src/core/widgets/app_drawer_widget.dart';
import 'package:admin_msar/src/features/ads/views/widgets/ads_cards_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      drawerBarrierDismissible: false,
      drawer: appDrawer(context),
      backgroundColor: AppColors.primaryLight,
      appBar: AppBarWidget(
        action: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.arrow_forward_ios).fadeUp(),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all( 20),
        child: AdsCardsWidget(),
      ),
    );
  }
}
