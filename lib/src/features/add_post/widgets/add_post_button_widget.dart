import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:svg_flutter/svg.dart';

class AddPostButtonWidget extends StatelessWidget {
  const AddPostButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      title: 'إضافة',
      onPressed: () {
        showModalBottomSheet(
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
                    SvgPicture.asset(AppIcons.done),
                    SizedBox(height: 20),
                    Text(
                      'تمت إضافة منشورك بنجاح!',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
