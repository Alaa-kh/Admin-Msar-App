import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_bottom_sheet.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:admin_msar/src/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppIcons.whatsapp, width: 50),

                            const SizedBox(height: 18),

                            const Text(
                              'رقم الواتساب',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryDark,
                              ),
                            ),

                            const SizedBox(height: 16),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    post.whatsapp.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.green,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () async {
                                  await Clipboard.setData(
                                    ClipboardData(
                                      text: post.whatsapp.toString(),
                                    ),
                                  );

                                  if (context.mounted) {
                                    Navigator.pop(context);

                                    AppSnackBar.success(
                                      context,
                                      'تم نسخ الرقم',
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'نسخ الرقم',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(AppIcons.whatsapp, width: 30),
              ).fadeUp(),
            ),
          ],
        ),
      ),
    );
  }
}
