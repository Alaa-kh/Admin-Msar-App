import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

Future<dynamic> appBottomSheet(
  BuildContext context,
  String text,
  String subTitle,
  String textButton,
  Function() onTap,
) {
  return showModalBottomSheet(
    isDismissible: false,
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                subTitle,
                style: TextStyle(color: AppColors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              AppButton(
                title: textButton,
                onPressed: onTap,
                backgroundColor: AppColors.red,
              ),
              SizedBox(height: 15),
              Text('إلغاء', style: TextStyle(color: AppColors.grey)),
              SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}
