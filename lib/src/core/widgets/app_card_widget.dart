import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:svg_flutter/svg.dart';

class AppCardWidget extends StatelessWidget {
  const AppCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.border, blurRadius: 7)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(AppIcons.icon).fadeUp(),
              SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'مطلوب مهندس مدني للعمل في مشاريع كبرى',
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ).fadeUp(),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          backgroundColor: Colors.white,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(35),
                            ),
                          ),
                          isScrollControlled: true,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.delete),
                                    SizedBox(height: 27),
                                    Text(
                                      'هل أنت متأكد من حذف المنشور؟',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primaryDark,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'لا يمكن التراجع عن هذا الإجراء بمجرد تأكيده. سيتم حذف جميع البيانات المرتبطة بهذا المنشور.',
                                      style: TextStyle(color: AppColors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 16),
                                    AppButton(
                                      title: 'نعم، احذف المنشور',
                                      onPressed: () {},
                                      backgroundColor: AppColors.red,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'إلغاء',
                                      style: TextStyle(color: AppColors.grey),
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(Icons.delete, color: AppColors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 17),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.greenLight,
            ),
            child: FittedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppIcons.time),
                  SizedBox(width: 7),
                  Text(
                    'منذ ثانيتين',
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ).fadeUp(),
            ),
          ),
          SizedBox(height: 13),
          Text(
            'نبحث عن مهندس مدني ذو خبرة لا تقل عن خمس سنوات للعمل في مشاريع إنشائية ضخمة.يجب ان يكون لديه إلمام بأحدث التقنيات والمعايير الهندسية.',
            style: TextStyle(color: AppColors.grey, height: 1.5),
          ).fadeUp(),
          Align(
            alignment: AlignmentGeometry.bottomLeft,
            child: SvgPicture.asset(AppIcons.whatsapp, width: 30),
          ).fadeUp(),
        ],
      ),
    );
  }
}
