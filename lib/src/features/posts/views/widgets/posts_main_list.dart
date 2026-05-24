import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_header_delegate.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:admin_msar/src/features/posts/presentation/cubit/posts_state.dart';
import 'package:admin_msar/src/features/posts/views/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostsMainListWidget extends StatelessWidget {
  const PostsMainListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        final lastError = context.read<PostsCubit>().lastError;
        if (state is PostsError) {
          AppSnackBar.error(context, state.message);
        } else if (state is PostsLoaded && lastError != null) {
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
                  children: const [
                    SizedBox(height: 20),
                    Text(
                      'إدارة المنشورات',
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: AppHeaderDelegate(
                  title: 'إضافة منشور جديد',
                  onPressed: () async {
                    final created = await context.push<bool>('/add_post');
                    if (created == true && context.mounted) {
                      context.read<PostsCubit>().load();
                    }
                  },
                ),
              ),
              switch (state) {
                PostsLoading() || PostsInitial() => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
                PostsError(message: final m) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: _ErrorBox(
                    message: m,
                    onRetry: () => context.read<PostsCubit>().load(),
                  ),
                ),
                PostsLoaded(posts: final list, deletingId: final deletingId) =>
                  list.isEmpty
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              'لا يوجد منشورات',
                              style: TextStyle(color: AppColors.grey),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final post = list[index];
                              return PostCardWidget(
                                post: post,
                                isDeleting: deletingId == post.id,
                              ).fadeUp();
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
