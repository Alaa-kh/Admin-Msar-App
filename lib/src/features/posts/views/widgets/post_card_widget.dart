import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_bottom_sheet.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:admin_msar/src/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({
    super.key,
    required this.post,
    this.isDeleting = false,
  });

  final Post post;
  final bool isDeleting;

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) return 'منذ ${diff.inSeconds} ثانية';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
    if (diff.inDays < 30) return 'منذ ${diff.inDays} يوم';
    return 'منذ ${(diff.inDays / 30).floor()} شهر';
  }

  @override
  Widget build(BuildContext context) {
    final createdAt = post.createdAt;
    final timeLabel = createdAt != null ? _timeAgo(createdAt) : 'حديث';

    return Opacity(
      opacity: isDeleting ? 0.5 : 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: AppColors.border, blurRadius: 7)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppIcons.icon).fadeUp(),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          post.title,
                          style: const TextStyle(
                            color: AppColors.primaryDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ).fadeUp(),
                      ),
                      GestureDetector(
                        onTap: isDeleting
                            ? null
                            : () {
                                final cubit = context.read<PostsCubit>();
                                appBottomSheet(
                                  context,
                                  'هل أنت متأكد من حذف المنشور؟',
                                  'لا يمكن التراجع عن هذا الإجراء بمجرد تأكيده. سيتم حذف جميع البيانات المرتبطة بهذا المنشور.',
                                  'نعم، احذف المنشور',
                                  () async {
                                    Navigator.of(context).pop();
                                    final ok = await cubit.delete(post.id);
                                    if (ok && context.mounted) {
                                      AppSnackBar.success(
                                        context,
                                        'تم حذف المنشور',
                                      );
                                    }
                                  },
                                );
                              },
                        child: const Icon(Icons.delete, color: AppColors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.greenLight,
              ),
              child: FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppIcons.time),
                    const SizedBox(width: 7),
                    Text(
                      timeLabel,
                      style: const TextStyle(
                        color: AppColors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ).fadeUp(),
              ),
            ),
            const SizedBox(height: 13),
            Text(
              post.description,
              style: const TextStyle(color: AppColors.grey, height: 1.5),
            ).fadeUp(),
            Align(
              alignment: AlignmentGeometry.bottomLeft,
              child: SvgPicture.asset(AppIcons.whatsapp, width: 30),
            ).fadeUp(),
          ],
        ),
      ),
    );
  }
}
