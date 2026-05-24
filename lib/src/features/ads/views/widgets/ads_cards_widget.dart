import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_header_delegate.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/features/ads/presentation/cubit/ads_cubit.dart';
import 'package:admin_msar/src/features/ads/presentation/cubit/ads_state.dart';
import 'package:admin_msar/src/features/ads/views/widgets/ads_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdsCardsWidget extends StatelessWidget {
  const AdsCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsCubit, AdsState>(
      listener: (context, state) {
        final lastError = context.read<AdsCubit>().lastError;
        if (state is AdsError) {
          AppSnackBar.error(context, state.message);
        } else if (state is AdsLoaded && lastError != null) {
          AppSnackBar.error(context, lastError);
        }
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'العروض الخارجية',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ).fadeUp(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: AppHeaderDelegate(
                title: 'إضافة عرض خارجي جديد',
                onPressed: () async {
                  final created = await context.push<bool>('/add_ads');
                  if (created == true && context.mounted) {
                    context.read<AdsCubit>().load();
                  }
                },
              ),
            ),
            switch (state) {
              AdsLoading() || AdsInitial() => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
              AdsError(message: final m) => SliverFillRemaining(
                hasScrollBody: false,
                child: _ErrorBox(
                  message: m,
                  onRetry: () => context.read<AdsCubit>().load(),
                ),
              ),
              AdsLoaded(ads: final list, deletingId: final deletingId) =>
                list.isEmpty
                    ? const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'لا يوجد عروض',
                            style: TextStyle(color: AppColors.grey),
                          ),
                        ),
                      )
                    : SliverList.separated(
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (_, index) {
                          final ad = list[index];
                          return AdsItemWidget(
                            ad: ad,
                            isDeleting: deletingId == ad.id,
                          );
                        },
                      ),
            },
          ],
        );
      },
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: const TextStyle(color: AppColors.dark)),
          const SizedBox(height: 12),
          TextButton(onPressed: onRetry, child: const Text('إعادة المحاولة')),
        ],
      ),
    );
  }
}
