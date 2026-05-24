import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/features/users/presentation/cubit/users_cubit.dart';
import 'package:admin_msar/src/features/users/presentation/cubit/users_state.dart';
import 'package:admin_msar/src/features/users/widgets/users_cards_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPostsMainListWidget extends StatelessWidget {
  const UsersPostsMainListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {
        final lastError = context.read<UsersCubit>().lastError;
        if (state is UsersError) {
          AppSnackBar.error(context, state.message);
        } else if (state is UsersLoaded && lastError != null) {
          AppSnackBar.error(context, lastError);
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'إدارة المستخدمين',
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ).fadeUp(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              switch (state) {
                UsersLoading() || UsersInitial() => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
                UsersError(message: final m) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: _ErrorBox(
                    message: m,
                    onRetry: () => context.read<UsersCubit>().load(),
                  ),
                ),
                UsersLoaded(users: final list, deletingId: final deletingId) =>
                  list.isEmpty
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              'لا يوجد مستخدمون',
                              style: TextStyle(color: AppColors.grey),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final user = list[index];
                              return UsersCardsWidget(
                                user: user,
                                isDeleting: deletingId == user.id,
                              );
                            },
                            childCount: list.length,
                          ),
                        ),
              },
            ],
          ),
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
